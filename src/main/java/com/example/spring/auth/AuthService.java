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

    // 로그인
    public UserVo login(UserVo userVo) {
        UserVo existUserVo = userDao.read(userVo);
        
        if (existUserVo != null && passwordEncoder.matches(userVo.getPasswd(), existUserVo.getPasswd())) {
            return existUserVo;
        }

        return null;
    }

    // 비밀번호 초기화
    public String resetPassword(UserVo userVo) {
        // 랜덤 비밀번호 생성
        String rndPassword = UUID.randomUUID().toString().substring(0, 8);
        String encodedPassword = passwordEncoder.encode(rndPassword);
        userVo.setPasswd(encodedPassword);

        int updated = userDao.update(userVo);

        if (updated > 0) {
            return rndPassword;
        } else {
            return null;
        }
    }
}