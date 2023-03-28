<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
div.diarymenu{
	text-align: center;
	margin: auto;
	padding: 0px;
	height: 40px;
	font-size:0;
}
a.diarymenu{
	display: inline-block;
	margin: 0px;
	padding: 0px;
	width:170px;
	height:40px;
	border: 2px solid #868e96;
	background-color: white;
	border-bottom: 3px solid rgba(134, 142, 150,0.5);

	color: #087f5b;
	line-height: 40px;
	text-align: center;
	text-decoration: none;
	font-size: large;
	font-weight: 600;
	text-shadow: 1px 1px 2px rgba(0,0,0,0.3);	
}
a.diarymenu.left{
	border-radius: 10px 0px 0px 10px;	
}
a.diarymenu.right{
	border-radius: 0px 10px 10px 0px;	
}
a.diarymenu.center{
	border-radius: 0px;
	border-left: 1px solid #868e96;
	border-right: 1px solid #868e96;
}
a.diarymenu:hover{
	background-color: rgba(15, 123, 90, 0.2);
	border-bottom: 3px solid rgba(86,140,8,0.2);
	box-shadow: 4px, 4px, 6px, gray;
}
</style>
</head>
<body>
	<div class="diarymenu">
		<a href="${ pageContext.servletContext.contextPath }/diary_showEatDiary.do" class="diarymenu left">다이어리</a>
		<a href="${ pageContext.servletContext.contextPath }/diary_showEatWrite.do" class="diarymenu center">다이어리 작성</a>
		<a href="${ pageContext.servletContext.contextPath }/diary_showGoalView.do" class="diarymenu center">목표관리</a>
		<a href="${ pageContext.servletContext.contextPath }/diary_showEatStats.do" class="diarymenu right">통계화면</a>
	</div>
</body>

</html>