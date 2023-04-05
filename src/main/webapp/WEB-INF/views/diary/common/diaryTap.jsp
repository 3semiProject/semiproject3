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
 href="${ pageContext.servletContext.contextPath }/resources/css/diarytab2.css" >
<script type="text/javascript">
var today = new Date(); 
</script>
</head>
<body>
<form method="post" name="diary">
	<input type="hidden" name="user_id" value="${sessionScope.loginMember.user_id}">
 	<input type="hidden" name="diary_post_date" value="${today}">	
 	<div class="tabs">
    <input class="tabs" id="left" type="submit" value="식단" onclick="javascript: form.action='${ pageContext.servletContext.contextPath }/diary_showEatDiary.do';"/>
    <input class="tabs" id="center" type="submit" value="운동" onclick="javascript: form.action='${ pageContext.servletContext.contextPath }/diary_moveTabEat.do';"/>
    <input class="tabs" id="right" type="submit" value="체형" onclick="javascript: form.action='${ pageContext.servletContext.contextPath }/diary_showBodyDiary.do';"/>
	</div>
</form>
</body>
</html>