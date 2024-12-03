<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경</title>
    <!-- Bootstrap v5.3.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .password-container {
            max-width: 500px;
            margin: 50px auto;
        }
        .password-rules {
            font-size: 0.875rem;
            color: #6c757d;
        }
        .password-strength {
            height: 5px;
            margin-top: 5px;
            transition: all 0.3s ease;
        }
    </style>
</head>
<body>
    <div class="container password-container">
        <!-- 메시지 -->
        <jsp:include page="../common/message.jsp" />
        <!--// 메시지 -->

        <h2 class="text-center mb-4">비밀번호 변경</h2>
        
        <c:if test="${not empty sessionScope.user}">
            <div class="card">
                <div class="card-body">
                    <form id="passwordForm" action="/auth/password/change" method="POST">
                        <div class="mb-4">
                            <label for="currentPassword" class="form-label">현재 비밀번호</label>
                            <input type="password" class="form-control" id="currentPassword" 
                                   name="currentPassword" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">새 비밀번호</label>
                            <input type="password" class="form-control" id="newPassword" 
                                   name="newPassword" required>
                            <div class="password-strength bg-secondary"></div>
                            <div class="password-rules mt-2">
                                <p class="mb-1">비밀번호 규칙:</p>
                                <ul class="list-unstyled">
                                    <li id="lengthRule">✓ 8자 이상</li>
                                    <li id="upperRule">✓ 대문자 포함</li>
                                    <li id="lowerRule">✓ 소문자 포함</li>
                                    <li id="numberRule">✓ 숫자 포함</li>
                                    <li id="specialRule">✓ 특수문자 포함</li>
                                </ul>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <label for="confirmPassword" class="form-label">새 비밀번호 확인</label>
                            <input type="password" class="form-control" id="confirmPassword" 
                                   name="confirmPassword" required>
                            <div id="passwordMatch" class="form-text"></div>
                        </div>
                        
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary" id="submitBtn" disabled>
                                비밀번호 변경
                            </button>
                            <a href="/auth/profile" class="btn btn-secondary">취소</a>
                        </div>
                    </form>
                </div>
            </div>
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
    
    <!-- 비밀번호 유효성 검사 스크립트 -->
    <script>
        const passwordForm = document.getElementById('passwordForm');
        const newPassword = document.getElementById('newPassword');
        const confirmPassword = document.getElementById('confirmPassword');
        const submitBtn = document.getElementById('submitBtn');
        const passwordStrength = document.querySelector('.password-strength');
        
        // 비밀번호 규칙 검사
        function checkPasswordRules(password) {
            const rules = {
                length: password.length >= 8,
                upper: /[A-Z]/.test(password),
                lower: /[a-z]/.test(password),
                number: /[0-9]/.test(password),
                special: /[!@#$%^&*]/.test(password)
            };
            
            document.getElementById('lengthRule').style.color = rules.length ? 'green' : '#6c757d';
            document.getElementById('upperRule').style.color = rules.upper ? 'green' : '#6c757d';
            document.getElementById('lowerRule').style.color = rules.lower ? 'green' : '#6c757d';
            document.getElementById('numberRule').style.color = rules.number ? 'green' : '#6c757d';
            document.getElementById('specialRule').style.color = rules.special ? 'green' : '#6c757d';
            
            return Object.values(rules).every(rule => rule);
        }
        
        // 비밀번호 강도 표시
        function updatePasswordStrength(password) {
            let strength = 0;
            if (password.length >= 8) strength++;
            if (/[A-Z]/.test(password)) strength++;
            if (/[a-z]/.test(password)) strength++;
            if (/[0-9]/.test(password)) strength++;
            if (/[!@#$%^&*]/.test(password)) strength++;
            
            const colors = ['#dc3545', '#ffc107', '#28a745'];
            const width = (strength / 5) * 100;
            const colorIndex = strength <= 2 ? 0 : strength <= 3 ? 1 : 2;
            
            passwordStrength.style.width = `${width}%`;
            passwordStrength.style.backgroundColor = colors[colorIndex];
        }
        
        // 비밀번호 일치 여부 확인
        function checkPasswordMatch() {
            const matchDiv = document.getElementById('passwordMatch');
            if (confirmPassword.value === '') {
                matchDiv.textContent = '';
                matchDiv.className = 'form-text';
            } else if (newPassword.value === confirmPassword.value) {
                matchDiv.textContent = '비밀번호가 일치합니다.';
                matchDiv.className = 'form-text text-success';
            } else {
                matchDiv.textContent = '비밀번호가 일치하지 않습니다.';
                matchDiv.className = 'form-text text-danger';
            }
        }
        
        // 입력값 변경 감지
        newPassword.addEventListener('input', function() {
            const isValid = checkPasswordRules(this.value);
            updatePasswordStrength(this.value);
            checkPasswordMatch();
            submitBtn.disabled = !isValid || this.value !== confirmPassword.value;
        });
        
        confirmPassword.addEventListener('input', function() {
            checkPasswordMatch();
            const isValid = checkPasswordRules(newPassword.value);
            submitBtn.disabled = !isValid || this.value !== newPassword.value;
        });
        
        // 폼 제출 전 최종 확인
        passwordForm.addEventListener('submit', function(e) {
            if (newPassword.value !== confirmPassword.value) {
                e.preventDefault();
                alert('새 비밀번호가 일치하지 않습니다.');
            }
        });
    </script>
</body>
</html>
