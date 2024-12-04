<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/top.jsp" />

<div class="container">
    <!-- 메시지 -->
    <jsp:include page="../common/message.jsp" />
    <!--// 메시지 -->
        
    <h1 class="text-center my-4">프로필</h1>

    <table class="table table-bordered">
        <tbody>
            <tr>
                <th class="col-md-2">아이디</th>
                <td class="col-md-10">${sessionScope.user.userId}</td>
            </tr>
            <tr>
                <th class="col-md-2">이름</th>
                <td class="col-md-10">${sessionScope.user.name}</td>
            </tr>
            <tr>
                <th class="col-md-2">이메일</th>
                <td class="col-md-10">${sessionScope.user.email}</td>
            </tr>
            <tr>
                <th class="col-md-2">연락처</th>
                <td class="col-md-10">${sessionScope.user.tel}</td>
            </tr>
            <tr>
                <th class="col-md-2">마지막 로그인</th>
                <td class="col-md-10">${sessionScope.user.lastLoginAt}</td>
            </tr>
            <tr>
                <th class="col-md-2">가입일</th>
                <td class="col-md-10">${sessionScope.user.createdAt.substring(0, 16)}</td>
            </tr>
        </tbody>
    </table>

    <div class="mt-3">
        <a href="/auth/update" class="btn btn-primary">프로필 수정</a>
        <a href="/auth/password" class="btn btn-warning">비밀번호 수정</a>
        <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">
            로그아웃
        </button>
    </div>

    <!-- 로그아웃 확인 모달 -->
    <div class="modal fade" id="logoutModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">로그아웃 확인</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    로그아웃 하시겠습니까?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <a href="/auth/logout" class="btn btn-danger">로그아웃</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 스크립트 -->
<jsp:include page="../common/script.jsp" />
<!--// 스크립트 -->

<jsp:include page="../common/bottom.jsp" />