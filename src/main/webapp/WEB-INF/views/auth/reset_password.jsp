<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 초기화</title>
    <!-- Bootstrap v5.3.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .reset-container {
            max-width: 500px;
            margin: 50px auto;
        }
        .form-label {
            font-weight: 500;
        }
        .info-text {
            font-size: 0.875rem;
            color: #6c757d;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container reset-container">
        <!-- 메시지 -->
        <jsp:include page="../common/message.jsp" />
        <!--// 메시지 -->

        <h2 class="text-center mb-3">비밀번호 초기화</h2>
        <p class="info-text text-center">
            가입시 입력한 정보를 모두 입력하시면,<br>
            임시 비밀번호가 화면에 표시됩니다.
        </p>
        
        <div class="card">
            <div class="card-body">
                <form id="resetForm" action="/auth/reset-password" method="POST">
                    <div class="mb-3">
                        <label for="userId" class="form-label">아이디</label>
                        <input type="text" class="form-control" id="userId" name="userId" 
                               placeholder="아이디를 입력하세요" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="name" class="form-label">이름</label>
                        <input type="text" class="form-control" id="name" name="name" 
                               placeholder="이름을 입력하세요" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="phone" class="form-label">연락처</label>
                        <input type="tel" class="form-control" id="phone" name="phone" 
                               placeholder="연락처를 입력하세요 (예: 010-1234-5678)" 
                               pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" required>
                    </div>
                    
                    <div class="mb-4">
                        <label for="email" class="form-label">이메일</label>
                        <input type="email" class="form-control" id="email" name="email" 
                               placeholder="이메일을 입력하세요" required>
                    </div>
                    
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">비밀번호 초기화 요청</button>
                        <a href="/auth/login" class="btn btn-secondary">취소</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap v5.3.3 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // 전화번호 형식 자동 포맷팅
        document.getElementById('phone').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, ''); // 숫자만 남기기
            if (value.length >= 4 && value.length <= 7) {
                value = value.slice(0,3) + '-' + value.slice(3);
            } else if (value.length > 7) {
                value = value.slice(0,3) + '-' + value.slice(3,7) + '-' + value.slice(7,11);
            }
            e.target.value = value;
        });

        // 폼 제출 전 확인
        document.getElementById('resetForm').addEventListener('submit', function(e) {
            if (!confirm('입력하신 정보로 임시 비밀번호를 발급하시겠습니까?')) {
                e.preventDefault();
            }
        });
    </script>
</body>
</html>
