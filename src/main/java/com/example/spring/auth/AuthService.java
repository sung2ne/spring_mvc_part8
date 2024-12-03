package com.example.spring.auth;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.spring.user.UserDao;
import com.example.spring.user.UserVo;

@Service
public class AuthService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // 비밀번호 초기화
    public String resetPassword(UserVo userVo) {
        // 랜덤 비밀번호 생성
        String rndPassword = UUID.randomUUID().toString().substring(0, 8);
        // 비밀번호 인코딩
        String encodedPassword = passwordEncoder.encode(rndPassword);
        // 비밀번호 설정
        userVo.setPassword(encodedPassword);

        int updated = userDao.update(userVo);

        if (updated > 0) {
            return rndPassword;
        } else {
            return null;
        }
    }
}