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
<hr>
<h2 align="center">${ requestScope.banner.banner_no } 번 배너페이지 수정 페이지</h2>
<br>
<!-- 원글 수정 폼 -->
<form action="bannerUpdate.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="banner_no" value="${ banner.banner_no }">
	<input type="hidden" name="page" value="${ currentPage }">
<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr><th>제 목</th><td><input type="text" name="banner_title" value="${ banner.banner_title }"></td></tr>
	<tr>
		<th width="120">아이디</th>
		<td><input type="text" name="userid" value="${ banner.user_id }" readonly></td>
	</tr>
	<tr>
		<th width="120">배너항목</th>
		<td>
		<c:if test="${ banner.banner_item eq 'Y' }">		
			<input type="radio" name="banner_item" value="Y" checked>유튜브
		&nbsp; <input type="radio" name="banner_item" value="A">기사
		</c:if>	
		<c:if test="${ banner.banner_item eq 'A' }">		
			<input type="radio" name="banner_item" value="Y">유튜브
		&nbsp; <input type="radio" name="banner_item" value="A" checked>기사
		</c:if>
		</td>
	</tr>
	<tr><th>링 크</th><td><textarea name="banner_link_adrress" rows="5" cols="50">${ banner.banner_link_adrress }</textarea></td></tr>
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