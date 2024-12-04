package com.example.spring.auth;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.spring.user.UserService;
import com.example.spring.user.UserVo;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private AuthService authService;

    // 회원가입
    @GetMapping("/register")
    public ModelAndView register() {
        return new ModelAndView("auth/register");
    }

    // 회원가입
    @PostMapping("/register")
    public ModelAndView register(UserVo userVo, RedirectAttributes redirectAttributes) {
        ModelAndView mav = new ModelAndView();

        boolean created = userService.create(userVo);
        
        if (created) {
            redirectAttributes.addFlashAttribute("successMessage", "회원가입이 완료되었습니다.");
            mav.setViewName("redirect:/auth/login");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "회원가입에 실패하였습니다.");
            mav.setViewName("redirect:/auth/register");
        }
        
        return mav;
    }    

    // 로그인
    @GetMapping("/login")
    public ModelAndView login(@RequestParam(required = false) String error) {
        ModelAndView mav = new ModelAndView();
        if (error != null && error.equals("auth")) {
            mav.addObject("errorMessage", "로그인이 필요합니다.");
        }
        mav.setViewName("auth/login");
        return mav;
    }

    // 로그인
    @PostMapping("/login")
    public ModelAndView login(UserVo userVo, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        ModelAndView mav = new ModelAndView();

        try {
            userVo = authService.login(userVo);
            
            if (userVo != null) {
                // 세션 생성
                HttpSession session = request.getSession(true);
                session.setAttribute("user", userVo);
                session.setAttribute("isLoggedIn", true);

                // 로그인 시간 업데이트
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                userVo.setLastLoginAt(sdf.format(new Date()));
                userService.update(userVo);

                mav.setViewName("redirect:/auth/profile");
                return mav;
            }
            
            redirectAttributes.addFlashAttribute("errorMessage", "아이디 또는 비밀번호가 일치하지 않습니다.");
            mav.setViewName("redirect:/auth/login");
            
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession(false);
            session.invalidate();
            redirectAttributes.addFlashAttribute("errorMessage", "로그인 처리 중 오류가 발생했습니다.");
            mav.setViewName("redirect:/auth/login");
        }

        return mav;
    }

    // 로그아웃
    @GetMapping("/logout")
    public ModelAndView logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        session.invalidate();
        return new ModelAndView("redirect:/auth/login");
    }

    // 프로필
    @GetMapping("/profile")
    public ModelAndView profile() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("auth/profile");
        return mav;
    }

    // 프로필 수정
    @GetMapping("/update")
    public ModelAndView update() {
        return new ModelAndView("auth/update");
    }

    // 프로필 수정
    @PostMapping("/update")
    public ModelAndView update(UserVo userVo, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        ModelAndView mav = new ModelAndView();

        boolean updated = userService.update(userVo);
        if (updated) {
            redirectAttributes.addFlashAttribute("successMessage", "프로필이 수정되었습니다.");
            mav.setViewName("redirect:/auth/profile");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "프로필이 수정되지 않았습니다.");
            mav.setViewName("redirect:/auth/update");
        }
        return mav;
    }

    // 비밀번호 수정
    @GetMapping("/password")
    public ModelAndView password() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("auth/password");
        return mav;
    }

    // 비밀번호 수정
    @PostMapping("/password")
    public ModelAndView password(UserVo userVo, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        ModelAndView mav = new ModelAndView();

        boolean updated = userService.updatePassword(userVo);
        if (updated) {
            redirectAttributes.addFlashAttribute("successMessage", "비밀번호가 수정되었습니다.");
            mav.setViewName("redirect:/auth/profile");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "비밀번호가 수정되지 않았습니다.");
            mav.setViewName("redirect:/auth/password");
        }

        return mav;
    }

    // 아이디 찾기
    @GetMapping("/find-user-id")
    public ModelAndView findUserId() {
        return new ModelAndView("auth/find_user_id");
    }

    // 아이디 찾기
    @PostMapping("/find-user-id")
    public ModelAndView findUserId(UserVo userVo, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        ModelAndView mav = new ModelAndView();

        UserVo user = userService.read(userVo);        

        if (user != null) {
            mav.addObject("userId", user.getUserId());
            redirectAttributes.addFlashAttribute("userId", user.getUserId());
            mav.setViewName("redirect:/auth/show-user-id");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "아이디를 찾을 수 없습니다.");
            mav.setViewName("redirect:/auth/find-user-id");
        }

        return mav;
    }

    // 아이디 찾기 결과
    @GetMapping("/show-user-id")
    public ModelAndView showUserId() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("auth/show_user_id");
        return mav;
    }

    // 비밀번호 초기화
    @GetMapping("/reset-password")
    public ModelAndView resetPassword() {
        return new ModelAndView("auth/reset_password");
    }

    // 비밀번호 초기화
    @PostMapping("/reset-password")
    public ModelAndView resetPassword(UserVo userVo, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        ModelAndView mav = new ModelAndView();

        UserVo user = userService.read(userVo);        

        if (user != null) {
            String rndPassword = authService.resetPassword(userVo);

            mav.addObject("rndPassword", rndPassword);
            redirectAttributes.addFlashAttribute("rndPassword", rndPassword);
            mav.setViewName("redirect:/auth/show-reset-password");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "아이디를 찾을 수 없습니다.");
            mav.setViewName("redirect:/auth/reset_password");
        }

        return mav;
    }

    // 비밀번호 초기화 결과
    @GetMapping("/show-reset-password")
    public ModelAndView showResetPassword() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("auth/show_reset_password");
        return mav;
    }
}