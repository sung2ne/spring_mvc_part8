package com.example.spring.config;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class AuthInterceptor implements HandlerInterceptor {
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);

        System.out.println("session: " + session);
        
        if (session == null || session.getAttribute("isLoggedIn") == null) {
            response.sendRedirect("/auth/login?error=auth");
            return false;
        }
        
        return true;
    }
}
