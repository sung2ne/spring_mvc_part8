<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사용자 목록</title>
    <!-- Bootstrap v5.3.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <!-- 메시지 -->
        <jsp:include page="../common/message.jsp" />
        <!--// 메시지 -->

        <!-- 검색 폼 -->
        <form class="row g-3 mb-4" method="get" action="/user/">
            <div class="col-md-2">
                <select class="form-select" name="searchType">
                    <option value="all" ${searchType == 'all' ? 'selected' : ''}>전체</option>
                    <option value="userId" ${searchType == 'userId' ? 'selected' : ''}>아이디</option>
                    <option value="name" ${searchType == 'name' ? 'selected' : ''}>이름</option>
                    <option value="phone" ${searchType == 'phone' ? 'selected' : ''}>연락처</option>
                    <option value="email" ${searchType == 'email' ? 'selected' : ''}>이메일</option>
                </select>
            </div>
            <div class="col-md-8">
                <input type="text" class="form-control" name="searchKeyword" 
                       placeholder="검색어를 입력하세요" value="${searchKeyword}">
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100">검색</button>
            </div>
        </form>

        <!-- 사용자 목록 테이블 -->
        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead class="table-light">
                    <tr>
                        <th>아이디</th>
                        <th>이름</th>
                        <th>연락처</th>
                        <th>이메일</th>
                        <th>상태</th>
                        <th>가입일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty userVoList}">
                            <tr>
                                <td colspan="6" class="text-center">등록된 사용자가 없습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="user" items="${userVoList}">
                                <tr>
                                    <td>${user.userId}</td>
                                    <td>${user.name}</td>
                                    <td>${user.phone}</td>
                                    <td>${user.email}</td>
                                    <td>
                                        <span class="badge ${user.status == 'ACTIVE' ? 'bg-success' : 'bg-danger'}">
                                            ${user.status}
                                        </span>
                                    </td>
                                    <td>${user.createdAt}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <!-- 페이지네이션 -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <c:if test="${pagination.startPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="?page=1&searchType=${searchType}&searchKeyword=${searchKeyword}">
                            &laquo;
                        </a>
                    </li>
                </c:if>
                
                <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
                    <li class="page-item ${i == pagination.page ? 'active' : ''}">
                        <a class="page-link" href="?page=${i}&searchType=${searchType}&searchKeyword=${searchKeyword}">
                            ${i}
                        </a>
                    </li>
                </c:forEach>

                <c:if test="${pagination.endPage < pagination.totalPages}">
                    <li class="page-item">
                        <a class="page-link" href="?page=${pagination.totalPages}&searchType=${searchType}&searchKeyword=${searchKeyword}">
                            &raquo;
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>

    <!-- Bootstrap v5.3.3 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
