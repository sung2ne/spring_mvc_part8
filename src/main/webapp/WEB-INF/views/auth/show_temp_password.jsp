<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/top.jsp" />

<div class="container">
    <!-- 메시지 -->
    <jsp:include page="../common/message.jsp" />
    <!--// 메시지 -->
        
    <h1 class="text-center my-4">임시 비밀번호 발급</h1>
    
    <div class="card">
        <div class="card-body text-center">
            <p class="mb-4">아래의 임시 비밀번호를 사용하여 로그인하세요.</p>
            <div class="user-id mb-4">
                <h3 class="text-primary">${tempPassword}</h3>
            </div>
            <p class="text-danger">로그인 후 반드시 비밀번호를 변경하시기 바랍니다.</p>
            <div class="mt-4">
                <a href="/auth/login" class="btn btn-primary">로그인 하러가기</a>
            </div>
        </div>
    </div>
</div>

<!-- 스크립트 -->
<jsp:include page="../common/script.jsp" />
<!--// 스크립트 -->

<jsp:include page="../common/bottom.jsp" />
