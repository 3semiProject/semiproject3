<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<c:set var="startPage" value="${ requestScope.searchs.startPage }" />
<c:set var="endPage" value="${ requestScope.searchs.endPage }" />
<c:set var="maxPage" value="${ requestScope.searchs.maxPage }" />
<c:set var="listCount" value="${ requestScope.searchs.listCount }" />
<c:set var="currentPage" value="${ requestScope.searchs.currentPage }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!-- 페이징 처리 -->
<div style="text-align:center;"> <!-- 페이지 표시 영역 -->
	<!-- 1페이지로 이동하는 버튼 -->
	<c:if test="${ currentPage eq 1 }">
		[맨처음] &nbsp;
	</c:if>
	<c:if test="${ currentPage > 1 }">
		<c:url var="p1" value="/nsearch.do">
			<c:param name="page" value="1" />
			<c:param name="searchtype" value="${ requestScope.searchs.searchtype }" />
			<c:param name="keyword" value="${ requestScope.searchs.keyword }" />
		</c:url>
		<a href="${ p1 }">[맨처음]</a> &nbsp;
	</c:if>
	<!-- 이전 페이지그룹으로 이동하는 버튼 -->
	<c:if test="${ !((currentPage - 9.9) < startPage and (currentPage - 9.9) > 1) }">
		[이전그룹] &nbsp;
	</c:if>
	<c:if test="${ (currentPage - 9.9) < startPage and (currentPage - 9.9) > 1 }">
		<c:url var="pbefore" value="/nsearch.do">
			<c:param name="page" value="${ startPage - 10 }" />
			<c:param name="searchtype" value="${ requestScope.searchs.searchtype }" />
			<c:param name="keyword" value="${ requestScope.searchs.keyword }" />
		</c:url>
		<a href="${ pbefore }">[이전그룹]</a> &nbsp;
	</c:if>
	
	<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
	<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
		<c:if test="${ p eq currentPage }">
			<font size="4" color="red">[${ p }]</font>
		</c:if>
		<c:if test="${ p ne currentPage }">
			<c:url var="pp" value="/nsearch.do">
				<c:param name="page" value="${ p }" />
				<c:param name="searchtype" value="${ requestScope.searchs.searchtype }" />
			<c:param name="keyword" value="${ requestScope.searchs.keyword }" />
			</c:url>
			<a href="${ pp }">${ p }</a>
		</c:if>
	</c:forEach>
	
	<!-- 다음 페이지그룹으로 이동하는 버튼 -->
	<c:if test="${ !((currentPage + 10) > endPage && maxPage - (endPage + 1) >= 0) }">
		[다음그룹] &nbsp;
	</c:if>
	<c:if test="${ (currentPage + 10) > endPage && maxPage - (endPage + 1) >= 0 }">
		<c:url var="pafter" value="/nsearch.do">
			<c:param name="page" value="${ endPage + 1 }" />
			<c:param name="searchtype" value="${ requestScope.searchs.searchtype }" />
			<c:param name="keyword" value="${ requestScope.searchs.keyword }" />
		</c:url>
		<a href="${ pafter }">[다음그룹]</a> &nbsp;
	</c:if>
	
	<!-- 끝 페이지로 이동하는 버튼 -->
	<c:if test="${ currentPage eq maxPage }">
		[맨끝]
	</c:if>
	<c:if test="${ currentPage < maxPage }">
		<c:url var="pmax" value="/nsearch.do">
			<c:param name="page" value="${ maxPage }" />
			<c:param name="searchtype" value="${ requestScope.searchs.searchtype }" />
			<c:param name="keyword" value="${ requestScope.searchs.keyword }" />
		</c:url>
		<a href="${ pmax }">[맨끝]</a>
	</c:if>
</div>

</body>
</html>