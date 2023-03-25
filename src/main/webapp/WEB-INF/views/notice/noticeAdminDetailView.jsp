<%--
  Created by IntelliJ IDEA.
  User: lav
  Date: 2023/03/20
  Time: 5:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<hr>
<h2 align="center">
    ${notice.noticeno}번 공지글 상세보기
</h2>
<br>
<table align="center" width="500" border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>제 목</th>
        <td>${notice.noticetitle}</td>
    </tr>
    <tr>
        <th>작성자</th>
        <td>${notice.noticewriter}</td>
    </tr>
    <tr>
        <th>날 짜</th>
        <td>${notice.noticedate}</td>
    </tr>
    <tr>
        <th>첨부파일</th>
        <td>
            <%-- 첨부파일이 있다면 --%>
            <c:if test="${ !empty notice.original_filepath}">
                <c:url var="nfd" value="/nfdown.do">
                    <c:param name="ofile" value="${notice.original_filepath}"/>
                    <c:param name="rfile" value="${notice.rename_filepath}"/>
                </c:url>
                <a href="${nfd}">${notice.original_filepath}</a>
            </c:if>
            <c:if test="${empty notice.original_filepath}">
                &nbsp;
            </c:if>
        </td>
    </tr>
    <tr>
        <th>내 용</th>
        <td>${notice.noticecontent}</td>
    </tr>
    <tr>
        <th colspan="2">
            <button onclick="history.go(-1);">목록</button>
            <%-- 수정페이지로 이동 버튼 --%>
            <c:url var="moveup" value="/nmoveup.do">
                <c:param name="noticeno" value="${notice.noticeno}"/>
            </c:url>
            <button onclick="location.href='${moveup}';">수정페이지로 이동</button>
            <%-- 삭제하기 버튼 --%>
            <c:url var="delete" value="/ndelete.do">
                <c:param name="noticeno" value="${notice.noticeno}"/>
                <c:param name="rfile" value="${notice.rename_filepath}"/>
            </c:url>
            <button onclick="location.href='${delete}';">공지 삭제하기</button>
        </th>
    </tr>


</table>

<hr>
<c:import url="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
