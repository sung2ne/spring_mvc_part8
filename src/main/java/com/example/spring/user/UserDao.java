package com.example.spring.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao {
    
    @Autowired
    private SqlSession sqlSession;
    
    // 사용자 등록
    public int create(UserVo userVo) {
        return sqlSession.insert("userMapper.create", userVo);
    }

    // 사용자 정보
    public UserVo read(UserVo userVo) {
        return sqlSession.selectOne("userMapper.read", userVo);
    }

    // 사용자 수정
    public int update(UserVo userVo) {
        return sqlSession.update("userMapper.update", userVo);
    }

    // 사용자 목록
    public List<UserVo> list(int offset, int pageSize, String searchType, String searchKeyword) {
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("pageSize", pageSize);
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);
        return sqlSession.selectList("userMapper.list", params);
    }

    // 사용자 전체 수
    public int getTotalCount(String searchType, String searchKeyword) {
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);
        return sqlSession.selectOne("userMapper.getTotalCount", params);
    }

    // 사용자 삭제
    public int delete(String userId) {
        return sqlSession.delete("userMapper.delete", userId);
    }
}