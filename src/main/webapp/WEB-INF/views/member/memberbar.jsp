<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
body {
	width: 1200px;
	height: 100px;
	text-align: center;
}

#tab2 {
	width: 1000px;
	height: 100px;
	margin: auto;
	padding: 0;
	list-style: none;
	border: 1px solid #D1D1D1;
	border-radius: 35px;
}

#tab2 div {
	float: left;
	width: 200px;
	height: 100px;
	margin: 0px;
	padding: 0;
}

#tab2 div a {
	text-decoration: none;
	width: 200px;
	height: 100px;
	display: block;
	background-color: white;
	text-align: center;
	line-height: 100px;
	color: #01CD88;
	font-weight: bold;
	margin: 0;
	text-shadow: 1px 1px 2px #D1D1D1;
	font-size: 20pt;
	border: 1px solid #D1D1D1;
}

#tab2 div a:hover {
	text-decoration: none;
	width: 200px;
	height: 100px;
	line-height: 100px;
	display: block;
	background-color: #01CD88;
	font-size: 25pt;
	text-align: center;
	color: white;
	font-weight: bold;
	margin: 0;
	text-shadow: 1px 1px 2px #D1D1D1;
	padding-top: 5px;
}
</style>
</head>
<body>
<hr>
<div id="tab2">
	<div class="round"><a style="border-bottom-left-radius: 35px; border-top-left-radius: 35px;" href="${ pageContext.servletContext.contextPath }/myinfo.do">회원정보보기</a></div>
	<div><a href="${ pageContext.servletContext.contextPath }/pwCheckPopUp.do">회원정보수정</a></div>
	<div><a href="${ pageContext.servletContext.contextPath }//diary.do">다이어리보기</a></div>
	<div><a href="${ pageContext.servletContext.contextPath }/tiplist.do?page=1">다이어리작성</a></div>
	<div class="round"><a style="border-bottom-right-radius: 35px; border-top-right-radius: 35px;" href="${ pageContext.servletContext.contextPath }/bfaflist.do?page=1">통계보기</a></div>
</div>
</body>
</html>