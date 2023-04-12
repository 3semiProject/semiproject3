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
<h2 align="center">${ requestScope.event.event_no } 번 EVENT 수정 페이지</h2>
<br>
<!-- 원글 수정 폼 -->
<form action="eupdate.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="event_no" value="${ event.event_no }">
	<input type="hidden" name="page" value="${ currentPage }">
	<!-- 첨부파일이 있는 게시글이라면 -->
	<c:if test="${ !empty event.event_originfile }">
		<input type="hidden" name="event_originfile" value="${ event.event_originfile }">
		<input type="hidden" name="event_renamefile" value="${ event.event_renamefile }">
	</c:if>
<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr><th>제목</th><td><input type="text" name="event_title" value="${ event.event_title }"></td></tr>
	<tr><th>작성자</th><td><input type="text" name="user_id" readonly value="${ event.user_id }"></td></tr>
	<tr><th>첨부파일</th>
		<td>
			<!-- 첨부파일이 있는 경우, 파일삭제 기능 추가-->
			<c:if test="${ !empty event.event_originfile }">
				${ event.event_originfile } &nbsp;
				<input type="checkbox" name="delflag" value="yes"> 파일삭제
				<br>
			</c:if>
			새로첨부 : <input type="file" name="upfile">
		</td>
	</tr>
	<tr><th>내용</th><td><textarea name="event_content" rows="5" cols="50">${ event.event_content }</textarea></td></tr>
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