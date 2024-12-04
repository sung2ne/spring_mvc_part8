<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/top.jsp" />

<div class="container">
    <!-- 메시지 -->
    <jsp:include page="../common/message.jsp" />
    <!--// 메시지 -->
        
    <h1 class="text-center my-4">로그인</h1>
        
    <div class="card">
        <div class="card-body">
            <form id="loginForm" action="/auth/login" method="POST">
                <div class="mb-3">
                    <label for="userId" class="form-label">아이디</label>
                    <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디" required>
                </div>
                
                <div class="mb-3">
                    <label for="passwd" class="form-label">비밀번호</label>
                    <input type="password" class="form-control" id="passwd" name="passwd" placeholder="비밀번호" required>
                </div>
                
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">로그인</button>
                </div>
            </form>
        </div>
    </div>
    <div class="mt-3">
        <a href="/auth/register" class="btn btn-outline-secondary">회원가입</a>
        <a href="/auth/find-user-id" class="btn btn-outline-secondary">아이디 찾기</a>
        <a href="/auth/reset-password" class="btn btn-outline-secondary">비밀번호 찾기</a>
    </div>
</div>

<!-- 스크립트 -->
<jsp:include page="../common/script.jsp" />
<!--// 스크립트 -->

<script>
    $(document).ready(function() {
        // 로그인 폼 검증
        $('#loginForm').validate({
            rules: {
                userId: {
                    required: true,
                },
                passwd: {
                    required: true,
                },
            },
            messages: {
                userId: {
                    required: '아이디를 입력하세요.',
                },
                passwd: {
                    required: '비밀번호를 입력하세요.',
                },
            },
            errorClass: 'is-invalid',
            validClass: 'is-valid',
            errorPlacement: function(error, element) {
                error.addClass('invalid-feedback');
                element.closest('.mb-3').append(error);
            },
            submitHandler: function(form) {
                form.submit();
            }
        });
    });
</script>

<jsp:include page="../common/bottom.jsp" />