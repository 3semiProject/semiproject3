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
<style type="text/css">
.page{
  text-align: center;
  }

.pagination {
  list-style: none;
  display: inline-block;
  padding: 0;
  margin-top:0;
  }

.pagination li {
  display: inline;
  text-align: center;
  }

.pagination a {
  float: left;
  display: block;
  font-size: 14px;
  text-decoration: none;
  padding: 5px 12px;
  color: #96a0ad;
  line-height: 1.5;
  }

.first{
  margin-right: 1px;
  }

.last{
  margin-left: 1px;
  }

.first:hover, .last:hover, .left:hover, .right:hover{
  color: #01CD88;
  }

.pagination a.active {
  cursor: default;
  color: #ffffff;
  }

.pagination a:active {
  outline: none;
  }

.modal .num {
  margin-left: 3px;
  padding: 0;
  width: 30px;
  height: 30px;
  line-height: 30px;
  }

.modal .num:hover {
  background-color: #01CD88;
  color: #ffffff;
  }

.modal .num.active, .modal .num:active {
  background-color: #01CD88;
  cursor: pointer;
  }

.arrow-left {
  width: 0;
  height: 0;
  border-top: 10px solid transparent;
  border-bottom: 10px solid transparent;
  border-right:10px solid #01CD88;
  }
</style>
<title></title>
</head>
<body>
<!-- 페이징 처리 -->
<div class="page" style="text-align:center;"> <!-- 페이지 표시 영역 -->
<ul class="pagination modal">
	<!-- 1페이지로 이동하는 버튼 -->
	<c:if test="${ currentPage eq 1 }">
		<li><a class="first">첫 페이지</a></li>
	</c:if>
	<c:if test="${ currentPage > 1 }">
		<c:url var="p1" value="/nsearch.do">
			<c:param name="page" value="1" />
			<c:param name="searchtype" value="${ requestScope.searchs.searchtype }" />
			<c:param name="keyword" value="${ requestScope.searchs.keyword }" />
		</c:url>
		<li><a href="${ p1 }" class="first">첫 페이지</a></li>
	</c:if>
	<!-- 이전 페이지그룹으로 이동하는 버튼 -->
	<c:if test="${ !((currentPage - 9.9) < startPage and (currentPage - 9.9) > 1) }">
		<li><a class="arrow left"><<</a></li>
	</c:if>
	<c:if test="${ (currentPage - 9.9) < startPage and (currentPage - 9.9) > 1 }">
		<c:url var="pbefore" value="/nsearch.do">
			<c:param name="page" value="${ startPage - 10 }" />
			<c:param name="searchtype" value="${ requestScope.searchs.searchtype }" />
			<c:param name="keyword" value="${ requestScope.searchs.keyword }" />
		</c:url>
		<li><a href="${ pbefore }" class="arrow left"><<</a></li>
	</c:if>
	
	<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
	<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
		<c:if test="${ p eq currentPage }">
			<li><a class="active num">${ p }</a></li>
		</c:if>
		<c:if test="${ p ne currentPage }">
			<c:url var="pp" value="/nsearch.do">
				<c:param name="page" value="${ p }" />
				<c:param name="searchtype" value="${ requestScope.searchs.searchtype }" />
			<c:param name="keyword" value="${ requestScope.searchs.keyword }" />
			</c:url>
			<li><a href="${ pp }" class="num">${ p }</a></li>
		</c:if>
	</c:forEach>
	
	<!-- 다음 페이지그룹으로 이동하는 버튼 -->
	<c:if test="${ !((currentPage + 10) > endPage && maxPage - (endPage + 1) >= 0) }">
		<li><a class="arrow right">>></a></li>
	</c:if>
	<c:if test="${ (currentPage + 10) > endPage && maxPage - (endPage + 1) >= 0 }">
		<c:url var="pafter" value="/nsearch.do">
			<c:param name="page" value="${ endPage + 1 }" />
			<c:param name="searchtype" value="${ requestScope.searchs.searchtype }" />
			<c:param name="keyword" value="${ requestScope.searchs.keyword }" />
		</c:url>
		<li><a href="${ pafter }" class="arrow right">>></a></li>
	</c:if>
	
	<!-- 끝 페이지로 이동하는 버튼 -->
	<c:if test="${ currentPage eq maxPage }">
	<li><a class="last">끝 페이지</a></li>
		[맨끝]
	</c:if>
	<c:if test="${ currentPage < maxPage }">
		<c:url var="pmax" value="/nsearch.do">
			<c:param name="page" value="${ maxPage }" />
			<c:param name="searchtype" value="${ requestScope.searchs.searchtype }" />
			<c:param name="keyword" value="${ requestScope.searchs.keyword }" />
		</c:url>
		<li><a href="${ pmax }" class="last">끝 페이지</a></li>
	</c:if>
	</ul>
</div>

</body>
</html>