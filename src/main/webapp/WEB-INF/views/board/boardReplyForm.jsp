<%--
  Created by IntelliJ IDEA.
  Date: 2023/03/23
  Time: 11:52 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="board_num" value="${requestScope.board_num}"/>
<c:set var="current_page" value="${requestScope.page}"/>

<html>
<head>
    <title>Title</title>
</head>
<body>
<c:import url="../common/menubar.jsp"/>
<hr>
<h2 align="center">${current_page} 번 게시글의 댓글 등록 페이지</h2>
<form action="/breply.do" method="post">
    <input type="hidden" name="board_ref" value="${board_num}">
    <input type="hidden" name="page" value="${current_page}">

    <table cellpadding="5" cellspacing="0" align="center" border="1" style="text-align: center; width: 500px;">
        <tr style="height: 30px">
            <th>제목</th>
            <td><input type="text" name="board_title" size="50" style="border: 1px solid gray;height: 20px"></td>
        </tr>

        <tr>
            <th>작성자</th>
            <td><input type="text" name="board_writer" value="${sessionScope.loginMember.userid}" readonly></td>
        </tr>

        <tr>
            <th>내용</th>
            <td><textarea name="board_content" cols="50" rows="5"></textarea></td>
        </tr>
        <tr>
            <th colspan="2">
                <input type="submit" value="댓글등록"> &nbsp;
                <input type="reset" value="취소"> &nbsp;
                <button onclick="history.go(-1); return false;">이전 페이지로 이동</button>
            </th>
        </tr>

    </table>

</form>
<hr>
<c:import url="../common/footer.jsp"/>

</body>
</html>
