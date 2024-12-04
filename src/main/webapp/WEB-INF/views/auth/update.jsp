<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/top.jsp" />

<div class="container">
    <!-- 메시지 -->
    <jsp:include page="../common/message.jsp" />
    <!--// 메시지 -->
        
    <h1 class="text-center my-4">프로필 수정</h1>
    
    <div class="card">
        <div class="card-body">
            <form id="updateForm" action="/auth/profile/update" method="POST" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="name" class="form-label">이름</label>
                    <input type="text" class="form-control" id="name" name="name" value="${sessionScope.user.name}" required>
                </div>                
                <div class="mb-3">
                    <label for="email" class="form-label">이메일</label>
                    <input type="email" class="form-control" id="email" name="email" value="${sessionScope.user.email}" required>
                </div>                
                <div class="mb-3">
                    <label for="tel" class="form-label">연락처</label>
                    <input type="tel" class="form-control" id="tel" name="tel" value="${sessionScope.user.tel}" required>
                </div>
                <div>
                    <button type="submit" class="btn btn-primary">수정하기</button>
                    <a href="/auth/profile" class="btn btn-secondary">취소</a>
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
        $('#updateForm').validate({
            rules: {
                name: {
                    required: true,
                    maxlength: 50
                },
                email: {
                    required: true,
                    email: true,
                    maxlength: 50
                },
                phone: {
                    required: true,
                    maxlength: 20
                }
            },
            messages: {
                name: {
                    required: '이름을 입력하세요.',
                    maxlength: '이름은 최대 50자까지 가능합니다.'
                },
                email: {
                    required: '이메일을 입력하세요.',
                    email: '올바른 이메일 형식이 아닙니다.',
                    maxlength: '이메일은 최대 50자까지 가능합니다.'
                },
                phone: {
                    required: '연락처를 입력하세요.',
                    maxlength: '연락처는 최대 20자까지 가능합니다.'
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
