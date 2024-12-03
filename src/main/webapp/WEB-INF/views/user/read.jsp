<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사용자 정보</title>
    <!-- Bootstrap v5.3.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <!-- 메시지 -->
        <jsp:include page="../common/message.jsp" />
        <!--// 메시지 -->

        <div class="card">
            <div class="card-header">
                <h3>사용자 정보</h3>
            </div>
            <div class="card-body">
                <table class="table table-bordered">
                    <tbody>
                        <tr>
                            <th scope="row" style="width: 20%;">아이디</th>
                            <td>${userVo.userId}</td>
                        </tr>
                        <tr>
                            <th scope="row">이름</th>
                            <td>${userVo.name}</td>
                        </tr>
                        <tr>
                            <th scope="row">연락처</th>
                            <td>${userVo.phone}</td>
                        </tr>
                        <tr>
                            <th scope="row">이메일</th>
                            <td>${userVo.email}</td>
                        </tr>
                        <tr>
                            <th scope="row">상태</th>
                            <td>
                                <span class="badge ${userVo.status == 'ACTIVE' ? 'bg-success' : 'bg-danger'}">
                                    ${userVo.status}
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">마지막 로그인</th>
                            <td>${userVo.lastLoginAt}</td>
                        </tr>
                        <tr>
                            <th scope="row">가입일</th>
                            <td>${userVo.createdAt}</td>
                        </tr>
                        <tr>
                            <th scope="row">수정일</th>
                            <td>${userVo.updatedAt}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="card-footer text-end">
                <a href="/user/" class="btn btn-secondary">목록으로</a>
                <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">
                    삭제
                </button>
            </div>
        </div>
    </div>

    <!-- 삭제 모달 -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">사용자 삭제</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="/user/delete" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="userId" value="${userVo.userId}">
                        <div class="mb-3">
                            <label for="password" class="form-label">관리자 비밀번호</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <p class="text-danger">
                            * 사용자를 삭제하면 복구할 수 없습니다.<br>
                            * 삭제하시려면 관리자 비밀번호를 입력하세요.
                        </p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-danger">삭제</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap v5.3.3 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
