<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="listCount" value="${ requestScope.paging.listCount }" />
<c:set var="currentPage" value="${ requestScope.paging.currentPage }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
body {
	line-height: 2em;
	font-family: "맑은 고딕";
}

ul, li {
	list-style: none;
	text-align: center;
	padding: 0;
	margin: 0;
}

#mainWrapper {
	width: 800px;
	margin: 0 auto; /*가운데 정렬*/
}

#mainWrapper>ul>li:first-child {
	text-align: center;
	font-size: 14pt;
	height: 40px;
	vertical-align: middle;
	line-height: 30px;
}

#ulTable {
	margin-top: 10px;
}

#ulTable>li:first-child>ul>li {
	background-color: #01CD88;
	font-weight: bold;
	text-align: center;
}

#ulTable>li>ul {
	clear: both;
	padding: 0px auto;
	position: relative;
	min-width: 40px;
}

#ulTable>li>ul>li {
	float: left;
	font-size: 10pt;
	border-bottom: 1px solid silver;
	vertical-align: baseline;
}

#ulTable>li>ul>li:first-child {
	width: 10%;
} /*No 열 크기*/
#ulTable>li>ul>li:first-child+li {
	width: 35%;
} /*제목 열 크기*/
#ulTable>li>ul>li:first-child+li+li {
	width: 10%;
} /*첨부파일 열 크기*/
#ulTable>li>ul>li:first-child+li+li+li {
	width: 20%;
} /*작성일 열 크기*/
#ulTable>li>ul>li:first-child+li+li+li+li {
	width: 15%;
} /*작성자 열 크기*/
#ulTable>li>ul>li:first-child+li+li+li+li {
	width: 10%;
} /*조회수 열 크기*/
#divPaging {
	clear: both;
	margin: 0 auto;
	width: 220px;
	height: 50px;
}

#divPaging>div {
	float: left;
	width: 30px;
	margin: 0 auto;
	text-align: center;
}

#liSearchOption {
	clear: both;
}

#liSearchOption>div {
	margin: 0 auto;
	margin-top: 30px;
	width: auto;
	height: 100px;
}

.left {
	text-align: left;
}

#title {
	text-decoration: none;
	width: 200px;
	height: 200px;
	display: block;
	background-color: white;
	text-align: center;
	color: #01CD88;
	font-weight: bold;
	text-shadow: 1px 1px 2px #D1D1D1;
	font-size: 20pt;
	border: 1px solid;
}
</style>
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">

$(function(){
	
	location.href='${ pageContext.servletContext.contextPath }/qnalist.do;
});


</script>
<title></title>
</head>
<body>
	<div id="mainWrapper">

		<ul>
			<!-- 게시판 제목 -->
			<li id="title"> Q & A </li>

			<!-- 게시판 목록  -->
			<li>
				<ul id="ulTable">
					<li>
						<ul>
							<li>No</li>
							<li class="left">제목</li>
							<li>첨부파일</li>
							<li>작성일</li>
							<li>작성자</li>
							<li>조회수</li>
						</ul>
					</li>
					<!-- 게시물이 출력될 영역 -->
					<c:forEach items="${ list }" var="q">
						<li>
							<ul>
								<li>${ q.qna_no }</li>
								<c:url var="qdt" value="/qdetail.do">
									<c:param name="qna_no" value="${ q.qna_no }" />
									<c:param name="page" value="${ currentPage }" />
								</c:url>
								<li class="left">
									<c:if test="${ !empty sessionScope.loginMember }">
										<a href="${ qdt }">${ q.qna_title }</a>
									</c:if> 
									<c:if test="${ empty sessionScope.loginMember }">
										${ q.qna_title }
									</c:if>
								</li>
								<li>
									<c:if test="${ !empty q.qna_originfile }">◎</c:if>
									<c:if test="${ empty q.qna_originfile }">Empty</c:if>
								</li>
								<li>${q.qna_post_date}</li>
								<li>${q.user_id}</li>
								<li>${q.qna_views}</li>
							</ul>
						</li>
					</c:forEach>
				</ul>
			</li>

			<!-- 검색 폼 영역 -->
			<li id='liSearchOption'>
				<div>
					<form action="fsearch.do" method="post">


						<select name="searchtype">
							<option value="fname">제목</option>
							<option value="fvalue">내용</option>
							<option value="fid">작성자</option>
						</select> <input type="search" name="keyword"> <input type="submit"
							value="검색">
					</form>
				</div>
			</li>

		</ul>
	</div>
	<br>
	<!-- 페이징 처리 -->
	<c:import url="/WEB-INF/views/common/paging.jsp" />
</body>
</html>