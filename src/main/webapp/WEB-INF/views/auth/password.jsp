<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/top.jsp" />

<div class="container">
    <!-- 메시지 -->
    <jsp:include page="../common/message.jsp" />
    <!--// 메시지 -->
        
    <h1 class="text-center my-4">비밀번호 변경</h1>
    
    <div class="card">
        <div class="card-body">
            <form id="passwordForm" action="/auth/password/change" method="POST">                    
                <div class="mb-3">
                    <label for="passwd" class="form-label">새 비밀번호</label>
                    <input type="password" class="form-control" id="passwd" name="passwd" placeholder="새 비밀번호" required>
                </div>
                
                <div class="mb-3">
                    <label for="passwd2" class="form-label">비밀번호 확인</label>
                    <input type="password" class="form-control" id="passwd2" name="passwd2" placeholder="비밀번호 확인" required>
                </div>
                
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">비밀번호 변경</button>
                    <a href="/auth/profile" class="btn btn-outline-secondary">취소</a>
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
        $('#passwordForm').validate({
            rules: {
                passwd: {
                    required: true,
                    minlength: 8,
                    maxlength: 20
                },
                passwd2: {
                    required: true,
                    equalTo: '#passwd'
                }
            },
            messages: {
                passwd: {
                    required: '비밀번호를 입력하세요.',
                    minlength: '비밀번호는 최소 8자 이상이어야 합니다.',
                    maxlength: '비밀번호는 최대 20자까지 가능합니다.'
                },
                passwd2: {
                    required: '비밀번호 확인을 입력하세요.',
                    equalTo: '비밀번호가 일치하지 않습니다.'
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
