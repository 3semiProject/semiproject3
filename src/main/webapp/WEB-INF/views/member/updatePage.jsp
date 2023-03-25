<%--
  Created by IntelliJ IDEA.
  Date: 2023/03/17
  Time: 9:53 AM
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

    <c:url var="moveup" value="/moveup.do">
        <c:param name="userid" value="${ member.userid }"/>
    </c:url>

    <c:url var="mdel" value="/mdel.do">
        <c:param name="userid" value="${ member.userid }"/>
    </c:url>

    <script type="text/javascript">
        function validate() {
            // 유효성 검사

            // 암호확인
            var pwd1 = document.getElementById("userpwd1").value;
            var pwd2 = $('#userpwd2').val();

            if (pwd1 !== pwd2) {
                alert("암호 확인이 일치하지 않습니다.");
                $('#userpwd2').select();
            }
        }
    </script>
</head>
<body>
<h1 align="center">마이 페이지</h1>
<br>

<form action="mupdate.do" method="post">

    <table id="tbl" align="center" width="500" cellspacing="5" cellpadding="0">

        <%--
            <%@ page import="org.ict.first.member.model.vo.Member" %>
            <% Member member = (Member)request.getAttribute("member);
            <td><%- member.getUsername() %></td>
                                                             --%>
        <tr>
            <th width="120">아이디</th>
            <td><input type="text" name="userid" value="${member.userid}" readonly></td>
        </tr>

        <tr>
            <th width="120">이 름</th>
            <td><input type="text" name="username" value="${member.username}" readonly></td>
        </tr>
        <tr>
            <th width="120">비밀번호</th>
            <td><input type="password" name="userpwd" id="userpwd1" ></td>
        </tr>
        <tr>
            <th width="120">비밀번호 확인</th>
            <td><input type="password" id="userpwd2" onblur="validate();"></td>
        </tr>
        <tr>
            <th width="120">나 이</th>
            <td><input type="number" name="age" value="${ member.age }" min="19"></td>
        </tr>
        <tr>
            <th width="120">성 별</th>

            <c:if test="${member.gender eq 'M'}">
                <td>
                    <input type="radio" name="gender" value="M" checked>남자 &nbsp;
                    <input type="radio" name="gender" value="F">여자 &nbsp;
                </td>
            </c:if>

            <c:if test="${member.gender eq 'F'}">

                <td>
                    <input type="radio" name="gender" value="M">남자 &nbsp;
                    <input type="radio" name="gender" value="F" checked>여자 &nbsp;
                </td>
            </c:if>
        </tr>
        <tr>
            <th width="120">전화번호</th>
            <td><input type="text" name="phone" value="${member.phone}"></td>

        </tr>
        <tr>
            <th width="120">이메일</th>
            <td><input type="text" name="email" value="${member.email}"></td>

        </tr>

        <tr>
            <th colspan="2">
                <input type="submit" value="수정하기"> &nbsp;
                <input type="reset" value="수정취소"> &nbsp;
                <a href="javascript:history.go(-1);">이전 페이지로 이동</a>
                <a href="main.do">시작페이지로 이동</a>&nbsp;
            </th>
        </tr>
    </table>
</form>
