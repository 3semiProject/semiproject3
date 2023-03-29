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
		<a href="${ pageContext.servletContext.contextPath }/diary_showEatDiary.do" class="tabs left">식단</a>
		<a href="${ pageContext.servletContext.contextPath }/diary_showActDiary.do" class="tabs center">운동</a>
		<a href="${ pageContext.servletContext.contextPath }/diary_showBodyDiary.do" class="tabs right">체형</a>
	</div>
</body>
</html>