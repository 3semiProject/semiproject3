<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>

    <style>
        table th {
            background: #99ffff;
        }

        table th {
            border: 1px solid black;
        }

        table tr td {
            border: 1px solid black;
        }

        table#tbl {
            border: 2px solid black;

        }
    </style>
    <script src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>

    <c:url var="moveup" value="/moveup.do">
        <c:param name="userid" value="${ member.user_id }"/>
    </c:url>

    <c:url var="mdel" value="/mdel.do">
        <c:param name="userid" value="${ member.user_id }"/>
    </c:url>

</head>
<body>
<h1 align="center">회원정보 보기</h1>
<hr>
<div>
	<div>기본정보</div>
	<div>
	<c:url var="updateMove" value="/updateMove.do">
		<c:param name="user_id" value="${ member.user_id }"></c:param>
	</c:url>
	<a href="${ updateMove }">수정하기</a>
</div>
<table id="tbl" align="center" width="500" cellspacing="5" cellpadding="0">

    <%--
        <%@ page import="org.ict.first.member.model.vo.Member" %>
        <% Member member = (Member)request.getAttribute("member);
        <td><%- member.getUsername() %></td>
                                                            --%>
    <tr>
        <th width="120">아이디</th>
        <td>${ requestScope.member.user_id}</td>
    </tr>
    <tr>
        <th width="120">패스워드</th>
        <td hidden="true">${member.user_pw}</td>
    </tr>
    <tr>
        <th width="120">이름</th>
        <td>${member.user_name}</td>
    </tr>
    <tr>
        <th width="120">닉네임</th>
        <td>${member.user_nickname}</td>
    </tr>
    <tr>
        <th width="120">전화번호</th>
        <td>${member.phone}</td>
    </tr>
    <tr>
        <th width="120">생일</th>
        <td>${member.birth}</td>
    </tr>
    <tr>
        <th width="120">성 별</th>

        <c:if test="${member.gender eq 'M'}">
            <td>
                남자
            </td>
        </c:if>

        <c:if test="${member.gender eq 'F'}">
            <td>
                여자
            </td>
        </c:if>
    </tr>
    <tr>
        <th width="120">이메일</th>
        <td>${member.email}</td>
    </tr>

<%--     <tr>
        <th colspan="2">
            <a href="${ moveup }">수정페이지로 이동</a> &nbsp;
            <a href="main.do">시작페이지로 이동</a>&nbsp;
            <a href="${ mdel }">탈퇴하기..</a>
        </th>
    </tr> --%>

</table>
</body>
</html>
