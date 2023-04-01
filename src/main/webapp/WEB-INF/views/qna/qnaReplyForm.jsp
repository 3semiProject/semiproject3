<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="qna_no" value="${ requestScope.qna_no }"/>
<c:set var="currentPage" value="${ requestScope.currentPage }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!-- 상대경로로 대상 파일의 위치를 지정한 경우 -->
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<c:import url="/WEB-INF/views/common/csbar.jsp" />
<hr>
<h2 align="center">${ qna_no } 번 게시글의 답글 등록 페이지</h2>

<form action="qreply.do" method="post">
	<!-- 원글 번호도 함께 숨겨서 전송 -->
	<input type="hidden" name="qna_ref" value="${ qna_no }">
	<input type="hidden" name="page" value="${ currentPage }">
	
	<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
		<tr>
			<th>제 목</th>
			<td><input type="text" name="qna_title" size="50"></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><input type="text" name="user_id" value="${ loginMember.user_id }" readonly></td>
		</tr>
		<tr>
			<th>내 용</th>
			<td><textarea name="qna_content" rows="5" cols="50"></textarea></td>
		</tr>
		<tr>
			<th colspan="2">
				<input type="submit" value="답글등록"> &nbsp;
				<input type="reset" value="작성취소"> &nbsp;
				<button onclick="javascript:history.go(-1); return false;">이전 페이지로 이동</button>
			</th>
		</tr>
	</table>
</form>

<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>