<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/top.jsp" />

<div class="container">
    <!-- 메시지 -->
    <jsp:include page="../common/message.jsp" />
    <!--// 메시지 -->
        
    <h1 class="text-center my-4">아이디 찾기</h1>

    <div class="alert alert-info">
        가입시 입력한 정보를 모두 입력하시면 아이디가 화면에 표시됩니다.
    </div>
    
    <div class="card">
        <div class="card-body">
            <form id="findUserIdForm" action="/auth/find-user-id" method="POST">
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
                    <button type="submit" class="btn btn-primary">아이디 찾기</button>
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
        $('#findUserIdForm').validate({
            rules: {
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
                form.submit();
            }
        });
    });
</script>

<jsp:include page="../common/bottom.jsp" />