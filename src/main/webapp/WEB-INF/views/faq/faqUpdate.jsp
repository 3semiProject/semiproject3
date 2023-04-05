<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:set var="currentPage" value="${ requestScope.currentPage }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:import url="/WEB-INF/views/common/csbar.jsp" />
<hr>
<h2 align="center">${ requestScope.faq.faq_no } 번 FAQ 수정 페이지</h2>
<br>
<!-- 원글 수정 폼 -->
<form action="faqup.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="faq_no" value="${ faq.faq_no }">
	<input type="hidden" name="page" value="${ currentPage }">
<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr><th>제목</th><td><input type="text" name="faq_title" value="${ faq.faq_title }"></td></tr>
	<tr><th>작성자</th><td><input type="text" name="user_id" readonly value="${ faq.user_id }"></td></tr>
	<tr><th>내용</th><td><textarea name="faq_content" rows="5" cols="50">${ faq.faq_content }</textarea></td></tr>
	<tr><th colspan="2">
		<button onclick="javascript: history.go(-1); return false;">이전 페이지로 이동</button>
		&nbsp;
		<input type="submit" value="수정하기"> &nbsp;
		<input type="reset" value="수정취소">
	</th></tr>
</table>
</form>
<hr>


<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>