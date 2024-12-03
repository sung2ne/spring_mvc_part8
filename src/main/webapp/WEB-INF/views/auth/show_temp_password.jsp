<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>임시 비밀번호</title>
    <!-- Bootstrap v5.3.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .temp-password-container {
            max-width: 500px;
            margin: 50px auto;
            text-align: center;
        }
        .temp-password {
            font-size: 1.5rem;
            font-weight: bold;
            color: #dc3545;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="container temp-password-container">
        <h2 class="mb-4">임시 비밀번호 발급</h2>
        <p>아래 임시 비밀번호를 사용하여 로그인하세요.</p>
        <div class="temp-password">
            ${tempPassword}
        </div>
        <p>로그인 후 반드시 비밀번호를 변경하시기 바랍니다.</p>
        <a href="/auth/login" class="btn btn-primary mt-3">로그인 하러가기</a>
    </div>

    <!-- Bootstrap v5.3.3 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
