<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로필 수정</title>
    <!-- Bootstrap v5.3.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .update-container {
            max-width: 600px;
            margin: 50px auto;
        }
        .form-label {
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="container update-container">
        <!-- 메시지 -->
        <jsp:include page="../common/message.jsp" />
        <!--// 메시지 -->

        <h2 class="text-center mb-4">프로필 수정</h2>
        
        <c:if test="${not empty sessionScope.user}">
            <form id="updateForm" action="/auth/profile/update" method="POST" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="userId" class="form-label">아이디</label>
                    <input type="text" class="form-control" id="userId" name="userId" 
                           value="${sessionScope.user.userId}" readonly>
                </div>
                
                <div class="mb-3">
                    <label for="name" class="form-label">이름</label>
                    <input type="text" class="form-control" id="name" name="name" 
                           value="${sessionScope.user.name}" required>
                </div>
                
                <div class="mb-3">
                    <label for="email" class="form-label">이메일</label>
                    <input type="email" class="form-control" id="email" name="email" 
                           value="${sessionScope.user.email}" required>
                </div>
                
                <div class="mb-3">
                    <label for="phone" class="form-label">연락처</label>
                    <input type="tel" class="form-control" id="phone" name="phone" 
                           value="${sessionScope.user.phone}" required>
                </div>
                
                <div class="mb-3">
                    <label for="profileImage" class="form-label">프로필 이미지</label>
                    <input type="file" class="form-control" id="profileImage" name="profileImage" accept="image/*">
                    <small class="form-text text-muted">이미지를 선택하지 않으면 기존 이미지가 유지됩니다.</small>
                </div>
                
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">수정하기</button>
                    <a href="/auth/profile" class="btn btn-secondary">취소</a>
                </div>
            </form>
        </c:if>
        
        <c:if test="${empty sessionScope.user}">
            <div class="alert alert-warning text-center">
                <p>로그인이 필요합니다.</p>
                <a href="/auth/login" class="btn btn-primary">로그인 하러가기</a>
            </div>
        </c:if>
    </div>

    <!-- Bootstrap v5.3.3 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
