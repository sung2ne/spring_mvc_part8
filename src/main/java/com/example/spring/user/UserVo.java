package com.example.spring.user;

import lombok.Data;

@Data
public class UserVo {
    private String userId;
    private String passwd;
    private String name;
    private String tel;
    private String email;
    private String status;
    private String lastLoginAt;
    private String createdAt;
    private String updatedAt;
}