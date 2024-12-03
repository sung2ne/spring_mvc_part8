<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기 결과</title>
    <!-- Bootstrap v5.3.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .user-id-container {
            max-width: 500px;
            margin: 50px auto;
            text-align: center;
        }
        .user-id {
            font-size: 1.5rem;
            font-weight: bold;
            color: #0d6efd;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="container user-id-container">
        <h2 class="mb-4">아이디 찾기 결과</h2>
        <p>아래는 입력하신 정보로 찾은 아이디입니다.</p>
        <div class="user-id">
            ${userId}
        </div>
        <p>로그인 후 비밀번호를 변경하시기 바랍니다.</p>
        <a href="/auth/login" class="btn btn-primary mt-3">로그인 하러가기</a>
    </div>

    <!-- Bootstrap v5.3.3 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
