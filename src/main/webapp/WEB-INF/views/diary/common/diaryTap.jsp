<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css"
 href="${ pageContext.servletContext.contextPath }/resources/css/diarytab.css" >
</head>
<body>
	<div class="tabs">
		<c:url var="moveeat" value="/diary_showEatDiary.do">
			<c:param name="movedate" value="${param.diary_post_date}"/>
		</c:url>
		<a href="${moveeat}" class="tabs left">식단</a>
		<a href="${ pageContext.servletContext.contextPath }/diary_showActDiary.do?diary_no=${param.moveno}" class="tabs center">운동</a>
		<a href="${ pageContext.servletContext.contextPath }/diary_showBodyDiary.do?diary_no=${param.moveno}" class="tabs right">체형</a>
	</div>
</body>
</html>