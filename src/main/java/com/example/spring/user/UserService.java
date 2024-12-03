package com.example.spring.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.spring.common.Pagination;

@Service
public class UserService {
    
    @Autowired
    private UserDao userDao;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // 사용자 등록
    public boolean create(UserVo userVo) {
        // 비밀번호 암호화
        String encodedPassword = passwordEncoder.encode(userVo.getPassword());
        userVo.setPassword(encodedPassword);

        int result = userDao.create(userVo);
        return result > 0;
    }

    // 사용자 정보
    public UserVo read(UserVo userVo) {
        return userDao.read(userVo);
    }

    // 사용자 수정
    public boolean update(UserVo userVo) {
        int result = userDao.update(userVo);
        return result > 0;
    }

    // 비밀번호 수정
    public boolean updatePassword(UserVo userVo) {
        // 비밀번호 암호화
        String encodedPassword = passwordEncoder.encode(userVo.getPassword());
        userVo.setPassword(encodedPassword);

        int result = userDao.update(userVo);
        return result > 0;
    }

    // 사용자 목록
    public Map<String, Object> list(int page, String searchType, String searchKeyword) {
        int pageSize = 10; // 페이지당 사용자 수

        // 전체 사용자 수 조회
        int totalCount = userDao.getTotalCount(searchType, searchKeyword);

        // 페이지네이션 정보 생성
        Pagination pagination = new Pagination(page, pageSize, totalCount);

        // 페이징된 사용자 목록 조회
        List<UserVo> userVoList = userDao.list(pagination.getOffset(), pageSize, searchType, searchKeyword);

        // 결과 맵 생성
        Map<String, Object> result = new HashMap<>();
        result.put("userVoList", userVoList);
        result.put("pagination", pagination);
        result.put("searchType", searchType);
        result.put("searchKeyword", searchKeyword);

        return result;
    }

    // 사용자 삭제
    public boolean delete(UserVo userVo, String password) {
        // 비밀번호 검증
        if (!passwordEncoder.matches(password, userVo.getPassword())) {
            return false;
        }

        int result = userDao.delete(userVo.getUserId());
        return result > 0;
    }
}