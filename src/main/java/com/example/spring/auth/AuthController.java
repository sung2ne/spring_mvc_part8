package com.example.spring.auth;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.spring.user.UserService;
import com.example.spring.user.UserVo;

public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private AuthService authService;

    // 사용자 등록
    @GetMapping("/auth/register")
    public ModelAndView register() {
        return new ModelAndView("auth/register");
    }

    // 사용자 등록
    @PostMapping("/auth/register")
    public ModelAndView register(@RequestBody UserVo userVo, RedirectAttributes redirectAttributes) {
        ModelAndView mav = new ModelAndView();

        boolean created = userService.create(userVo);
        
        if (created) {
            redirectAttributes.addFlashAttribute("successMessage", "게시글이 등록되었습니다.");
            mav.setViewName("redirect:/auth/login");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "게시글이 등록되지 않았습니다.");
            mav.setViewName("redirect:/auth/register");
        }
        
        return mav;
    }    

    // 로그인
    @GetMapping("/auth/login")
    public ModelAndView login() {
        return new ModelAndView("auth/login");
    }

    // 로그인
    @PostMapping("/auth/login")
    public ModelAndView login(@RequestBody UserVo userVo, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        ModelAndView mav = new ModelAndView();

        UserVo user = userService.read(userVo);
        
        if (user != null) {
            // 세션 생성
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);

            redirectAttributes.addFlashAttribute("successMessage", "로그인되었습니다.");
            mav.setViewName("redirect:/auth/profile");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "로그인에 실패하였습니다.");
            mav.setViewName("redirect:/auth/login");
        }

        return mav;
    }

    // 로그아웃
    @GetMapping("/auth/logout")
    public ModelAndView logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        session.invalidate();
        return new ModelAndView("redirect:/auth/login");
    }

    // 프로필
    @GetMapping("/auth/profile")
    public ModelAndView profile() {
        return new ModelAndView("auth/profile");
    }

    // 프로필
    @PostMapping("/auth/profile")
    public ModelAndView profile(@RequestBody UserVo userVo, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        ModelAndView mav = new ModelAndView();
        return mav;
    }

    // 프로필 수정
    @GetMapping("/auth/update")
    public ModelAndView update() {
        return new ModelAndView("auth/update");
    }

    // 프로필 수정
    @PostMapping("/auth/update")
    public ModelAndView update(@RequestBody UserVo userVo, HttpServletRequest request, RedirectAttributes redirectAttributes) {
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
    @GetMapping("/auth/password")
    public ModelAndView password() {
        return new ModelAndView("auth/password");
    }

    // 비밀번호 수정
    @PostMapping("/auth/password")
    public ModelAndView password(@RequestBody UserVo userVo, HttpServletRequest request, RedirectAttributes redirectAttributes) {
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
    @GetMapping("/auth/findUserId")
    public ModelAndView findUserId() {
        return new ModelAndView("auth/find_user_id");
    }

    // 아이디 찾기
    @PostMapping("/auth/findUserId")
    public ModelAndView findUserId(@RequestBody UserVo userVo, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        ModelAndView mav = new ModelAndView();

        UserVo user = userService.read(userVo);        

        if (user != null) {
            mav.addObject("userId", user.getUserId());
            redirectAttributes.addFlashAttribute("successMessage", "아이디가 찾았습니다.");
            mav.setViewName("redirect:/auth/showUserId");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "아이디를 찾을 수 없습니다.");
            mav.setViewName("redirect:/auth/find_user_id");
        }

        return mav;
    }

    // 아이디 찾기 결과
    @GetMapping("/auth/showUserId")
    public ModelAndView showUserId() {
        return new ModelAndView("auth/show_user_id");
    }

    // 비밀번호 초기화
    @GetMapping("/auth/resetPassword")
    public ModelAndView resetPassword() {
        return new ModelAndView("auth/reset_password");
    }

    // 비밀번호 초기화
    @PostMapping("/auth/resetPassword")
    public ModelAndView resetPassword(@RequestBody UserVo userVo, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        ModelAndView mav = new ModelAndView();

        UserVo user = userService.read(userVo);        

        if (user != null) {
            String rndPassword = authService.resetPassword(userVo);

            mav.addObject("rndPassword", rndPassword);
            redirectAttributes.addFlashAttribute("successMessage", "비밀번호가 초기화되었습니다.");
            mav.setViewName("redirect:/auth/showResetPassword");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "아이디를 찾을 수 없습니다.");
            mav.setViewName("redirect:/auth/reset_password");
        }

        return mav;
    }

    // 비밀번호 초기화 결과
    @GetMapping("/auth/showResetPassword")
    public ModelAndView showResetPassword() {
        return new ModelAndView("auth/show_reset_password");
    }
}