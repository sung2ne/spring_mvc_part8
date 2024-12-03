<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로필</title>
    <!-- Bootstrap v5.3.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .profile-container {
            max-width: 700px;
            margin: 50px auto;
        }
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .profile-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            margin-bottom: 20px;
            object-fit: cover;
            border: 3px solid #e9ecef;
        }
        .status-badge {
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
        }
        .status-active {
            background-color: #d4edda;
            color: #155724;
        }
        .status-inactive {
            background-color: #f8d7da;
            color: #721c24;
        }
        .info-label {
            font-weight: 500;
            color: #495057;
        }
    </style>
</head>
<body>
    <div class="container profile-container">
        <!-- 메시지 -->
        <jsp:include page="../common/message.jsp" />
        <!--// 메시지 -->

        <c:if test="${not empty sessionScope.user}">
            <div class="profile-header">
                <img src="${empty sessionScope.user.profileImage ? '/resources/images/default-profile.png' : sessionScope.user.profileImage}" 
                     alt="프로필 이미지" class="profile-image">
                <h2>${sessionScope.user.name}</h2>
                <span class="status-badge ${sessionScope.user.status == 'ACTIVE' ? 'status-active' : 'status-inactive'}">
                    ${sessionScope.user.status == 'ACTIVE' ? '활성' : '비활성'}
                </span>
            </div>

            <div class="card">
                <div class="card-body">
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <span class="info-label">아이디</span>
                        </div>
                        <div class="col-md-8">
                            ${sessionScope.user.userId}
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <span class="info-label">이메일</span>
                        </div>
                        <div class="col-md-8">
                            ${sessionScope.user.email}
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <span class="info-label">연락처</span>
                        </div>
                        <div class="col-md-8">
                            ${sessionScope.user.phone}
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <span class="info-label">마지막 로그인</span>
                        </div>
                        <div class="col-md-8">
                            ${sessionScope.user.lastLoginAt}
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <span class="info-label">가입일</span>
                        </div>
                        <div class="col-md-8">
                            ${sessionScope.user.createdAt}
                        </div>
                    </div>
                </div>
            </div>

            <div class="d-grid gap-2 mt-4">
                <a href="/auth/profile/edit" class="btn btn-primary">프로필 수정</a>
                <a href="/auth/password/change" class="btn btn-outline-primary">비밀번호 변경</a>
                <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">
                    로그아웃
                </button>
            </div>
        </c:if>
        
        <c:if test="${empty sessionScope.user}">
            <div class="alert alert-warning text-center">
                <p>로그인이 필요합니다.</p>
                <a href="/auth/login" class="btn btn-primary">로그인 하러가기</a>
            </div>
        </c:if>
    </div>

    <!-- 로그아웃 확인 모달 -->
    <div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="logoutModalLabel">로그아웃 확인</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    정말 로그아웃 하시겠습니까?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <a href="/auth/logout" class="btn btn-danger">로그아웃</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap v5.3.3 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
