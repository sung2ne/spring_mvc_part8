<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/top.jsp" />

<div class="container">
    <!-- 메시지 -->
    <jsp:include page="../common/message.jsp" />
    <!--// 메시지 -->
        
    <h1 class="text-center my-4">비밀번호 초기화</h1>

    <div class="alert alert-info"></div>
        가입시 입력한 정보를 모두 입력하시면 임시 비밀번호가 화면에 표시됩니다.
    </div>
    
    <div class="card">
        <div class="card-body">
            <form id="resetPasswordForm" action="/auth/reset-password" method="POST">
                <div class="mb-3">
                    <label for="userId" class="form-label">아이디</label>
                    <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디" required>
                </div>                
                <div class="mb-3">
                    <label for="name" class="form-label">이름</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="이름" required>
                </div>                
                <div class="mb-3">
                    <label for="tel" class="form-label">연락처</label>
                    <input type="text" class="form-control" id="tel" name="tel" placeholder="연락처" required>
                </div>                
                <div class="mb-3">
                    <label for="email" class="form-label">이메일</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="이메일" required>
                </div>                
                <div>
                    <button type="submit" class="btn btn-primary">비밀번호 초기화 요청</button>
                    <a href="/auth/login" class="btn btn-outline-secondary">취소</a>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 스크립트 -->
<jsp:include page="../common/script.jsp" />
<!--// 스크립트 -->

<script>
    $(document).ready(function() {
        $('#resetForm').validate({
            rules: {
                userId: {
                    required: true,
                },
                name: {
                    required: true,
                },
                tel: {
                    required: true,
                },
                email: {
                    required: true,
                }
            },
            messages: {
                userId: {
                    required: '아이디를 입력하세요.',
                },
                name: {
                    required: '이름을 입력하세요.',
                },
                tel: {
                    required: '연락처를 입력하세요.',
                },
                email: {
                    required: '이메일을 입력하세요.',
                }
            },
            errorClass: 'is-invalid',
            validClass: 'is-valid',
            errorPlacement: function(error, element) {
                error.addClass('invalid-feedback');
                element.closest('.mb-3').append(error);
            },
            submitHandler: function(form) {
                if (confirm('입력하신 정보로 임시 비밀번호를 발급하시겠습니까?')) {
                    form.submit();
                }
            }
        });
    });
</script>

<jsp:include page="../common/bottom.jsp" />
