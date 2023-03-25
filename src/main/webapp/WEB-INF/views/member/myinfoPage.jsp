<%--
  Created by IntelliJ IDEA.
  Date: 2023/03/16
  Time: 3:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>first</title>

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
        <c:param name="userid" value="${ member.userid }"/>
    </c:url>

    <c:url var="mdel" value="/mdel.do">
        <c:param name="userid" value="${ member.userid }"/>
    </c:url>

</head>
<body>
<h1 align="center">마이 페이지</h1>


<table id="tbl" align="center" width="500" cellspacing="5" cellpadding="0">

    <%--
        <%@ page import="org.ict.first.member.model.vo.Member" %>
        <% Member member = (Member)request.getAttribute("member);
        <td><%- member.getUsername() %></td>
                                                            --%>
    <tr>
        <th width="120">아이디</th>
        <td>${member.userid}</td>
    </tr>

    <tr>
        <th width="120">이 름</th>
        <td>${member.username}</td>
    </tr>
    <tr>
        <th width="120">나 이</th>
        <td>${member.age}</td>
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
        <th width="120">전화번호</th>
        <td>${member.phone}</td>
    </tr>
    <tr>
        <th width="120">이메일</th>
        <td>${member.email}</td>
    </tr>

    <tr>
        <th colspan="2">
            <a href="${ moveup }">수정페이지로 이동</a> &nbsp;
            <a href="main.do">시작페이지로 이동</a>&nbsp;
            <a href="${ mdel }">탈퇴하기..</a>
        </th>
    </tr>

</table>
</body>
</html>
