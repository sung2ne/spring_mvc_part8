package com.example.spring.user;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    // 사용자 목록
    @GetMapping("/")
    public ModelAndView listGet(
        @RequestParam(defaultValue = "1") int page,
        @RequestParam(required = false) String searchType,
        @RequestParam(required = false) String searchKeyword
    ) {
        ModelAndView mav = new ModelAndView();
        Map<String, Object> result = userService.list(page, searchType, searchKeyword);
        mav.addObject("userVoList", result.get("userVoList"));
        mav.addObject("pagination", result.get("pagination"));
        mav.setViewName("user/list");
        return mav;
    }      

    // 사용자 정보
    @GetMapping("/{userId}")
    public ModelAndView readGet(@PathVariable("userId") String userId) {
        ModelAndView mav = new ModelAndView();
        UserVo userVo = new UserVo();
        userVo.setUserId(userId);
        userVo = userService.read(userVo);
        mav.addObject("userVo", userVo);
        mav.setViewName("user/read");
        return mav;
    }

    // 사용자 삭제
    @PostMapping("/{userId}/delete")
    public ModelAndView deletePost(UserVo userVo, String password, RedirectAttributes redirectAttributes) {
        ModelAndView mav = new ModelAndView();
        boolean result = userService.delete(userVo, password);
        if (result) {
            redirectAttributes.addFlashAttribute("successMessage", "사용자가 삭제되었습니다.");
            mav.setViewName("redirect:/user/");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "사용자 삭제에 실패하였습니다.");
            mav.setViewName("redirect:/user/read?userId=" + userVo.getUserId());
        }
        return mav;
    }
}