<%--
  Created by IntelliJ IDEA.
  Date: 2023/03/21
  Time: 11:51 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<hr>

<h2 align="center">${notice.noticeno}번 공지글 수정 페이지</h2>
<br>
<%-- form 태그에서 input 에 입력된 값들과 첨부파일을 같이 전송하려면,
     enctype 속성을 form 태그에 추가 --%>

<form action="nupdate.do" method="post" enctype="multipart/form-data">
    <input type="hidden" name="noticeno" value="${notice.noticeno}">
    <%--   첨부 파일이 있다면 수정 전 파일도 함께 전송  --%>
    <c:if test="${!empty notice.original_filepath}">
        <input type="hidden" name="original_filepath" value="${notice.original_filepath}">
    </c:if>
    <table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
        <tr>
            <th>제 목</th>
            <td><input type="text" name="noticetitle" value="${notice.noticetitle}"></td>
        </tr>
        <tr>
            <th>작성자</th>
            <td><input type="text" name="noticewriter" value="${notice.noticewriter}" readonly></td>
        </tr>
        <tr>
            <th>날 짜</th>
            <td>${notice.noticedate}</td>
        </tr>
        <tr>
            <th>첨부파일</th>
            <td>
                <%--  첨부파일이 있는 경우, 파일삭제 기능 추가--%>
                <c:if test="${ !empty notice.original_filepath}">
                    ${notice.original_filepath} &nbsp;
                    <input type="checkbox" name="delflag" value="yes">
                    <br>
                </c:if>
                새로 첨부 : <input type="file" name="upfile">
            </td>
        </tr>
        <tr>
            <th>내 용</th>
            <td>
                <textarea name="noticecontent" rows="5" cols="50">${notice.noticecontent}</textarea>
            </td>
        </tr>
        <tr>
            <th colspan="2">
                <button onclick=" history.go(-1); return false">이전 페이지로 이동</button>
                &nbsp;
                <input type="submit" value="수정하기"> &nbsp;
                <input type="reset" value="취소하기">
            </th>
        </tr>


    </table>
</form>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
