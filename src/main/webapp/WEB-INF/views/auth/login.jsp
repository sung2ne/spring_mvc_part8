<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <!-- Bootstrap v5.3.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .login-container {
            max-width: 400px;
            margin: 50px auto;
        }
        .additional-links {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
        }
        .additional-links a {
            color: #6c757d;
            text-decoration: none;
            font-size: 0.9rem;
        }
        .additional-links a:hover {
            color: #0d6efd;
            text-decoration: underline;
        }
        .divider {
            color: #dee2e6;
        }
    </style>
</head>
<body>
    <div class="container login-container">
        <!-- 메시지 -->
        <jsp:include page="../common/message.jsp" />
        <!--// 메시지 -->
        
        <div class="text-center mb-4">
            <h1 class="h3">로그인</h1>
        </div>
        
        <div class="card">
            <div class="card-body">
                <form id="loginForm" action="/auth/login" method="POST">
                    <div class="mb-3">
                        <label for="userId" class="form-label">아이디</label>
                        <input type="text" class="form-control" id="userId" name="userId" 
                               placeholder="아이디를 입력하세요" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="password" class="form-label">비밀번호</label>
                        <input type="password" class="form-control" id="password" name="password" 
                               placeholder="비밀번호를 입력하세요" required>
                    </div>
                    
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                        <label class="form-check-label" for="rememberMe">아이디 저장</label>
                    </div>
                    
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">로그인</button>
                    </div>
                </form>
                
                <div class="additional-links">
                    <a href="/auth/register">회원가입</a>
                    <span class="divider">|</span>
                    <a href="/auth/find-id">아이디 찾기</a>
                    <span class="divider">|</span>
                    <a href="/auth/find-password">비밀번호 찾기</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap v5.3.3 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- 아이디 저장 기능 -->
    <script>
        // 저장된 아이디가 있으면 불러오기
        window.onload = function() {
            const savedUserId = localStorage.getItem('savedUserId');
            if (savedUserId) {
                document.getElementById('userId').value = savedUserId;
                document.getElementById('rememberMe').checked = true;
            }
        }

        // 로그인 폼 제출 시 아이디 저장
        document.getElementById('loginForm').addEventListener('submit', function() {
            const rememberMe = document.getElementById('rememberMe').checked;
            const userId = document.getElementById('userId').value;
            
            if (rememberMe) {
                localStorage.setItem('savedUserId', userId);
            } else {
                localStorage.removeItem('savedUserId');
            }
        });
    </script>
</body>
</html>
