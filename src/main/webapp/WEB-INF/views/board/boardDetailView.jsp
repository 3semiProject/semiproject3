<%--
  Created by IntelliJ IDEA.
  Date: 2023/03/23
  Time: 10:07 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentPage" value="${requestScope.currentPage}"></c:set>
<html>
<head>
    <title>게시글 보기</title>
</head>
<body>
<c:import url="../common/menubar.jsp"/>
<hr>
<h2 align="center">${board.board_num} 번 게시글 상세보기</h2>

<table align="center" width="500" border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>제 목</th>
        <td>${board.board_title}</td>
    </tr>
    <tr>
        <th>작성자</th>
        <td>${board.board_writer}</td>
    </tr>
    <tr>
        <th>날 짜</th>
        <td>${board.board_date}</td>
    </tr>
    <tr>
        <th>첨부파일</th>
        <td>
            <%-- 첨부파일이 있다면 --%>
            <c:if test="${ !empty board.board_original_filename}">
                <c:url var="nfd" value="/nfdown.do">
                    <c:param name="ofile" value="${board.board_original_filename}"/>
                    <c:param name="rfile" value="${board.board_rename_filename}"/>
                </c:url>
                <a href="${nfd}">${board.board_original_filename}</a>
            </c:if>
            <c:if test="${empty board.board_original_filename}">
                &nbsp;
            </c:if>
        </td>
    </tr>
    <tr>
        <th>내 용</th>
        <td>${board.board_content}</td>
    </tr>


<c:if test="${requestScope.board.board_writer ne sessionScope.loginMember.userid}">
    <c:url var="bup" value="/breplyform.do">
        <c:param name="board_num" value="${board.board_num}"/>
        <c:param name="page" value="${currentPage}"/>
    </c:url>
    <tr><td colspan="2" style="text-align: center;"><a href="${bup}">[댓글쓰기]</a> &nbsp;
            <c:url var="bdl" value="/bdel.do">
                <c:param name="board_num" value="${board.board_num}"/>
                <c:param name="board_lev" value="${board.board_lev}"/>
                <c:param name="board_rename_filename" value="${board.board_rename_filename}"/>
            </c:url>
            <a href="${bdl}">[글삭제]</a>
    </td></tr>
</c:if>


<c:if test="${requestScope.board.board_writer eq sessionScope.loginMember.userid}">
    <c:url var="bup" value="/bupdate.do">
        <c:param name="board_num" value="${board.board_num}"/>
        <c:param name="page" value="${currentPage}"/>
    </c:url>
    <tr><td colspan="2" style="text-align: center;">
        <a href="${bup}">[수정페이지로 이동]</a> &nbsp;
        <c:url var="bdl" value="/bdelete.do">
            <c:param name="board_num" value="${board.board_num}"/>
            <c:param name="board_lev" value="${board.board_lev}"/>
            <c:param name="board_rename_filename" value="${board.board_rename_filename}"/>
        </c:url>
        <a href="${bdl}">[글삭제]</a></td></tr>
</c:if>


</table>

<br>

<hr>
<c:import url="../common/footer.jsp"/>
</body>
</html>
