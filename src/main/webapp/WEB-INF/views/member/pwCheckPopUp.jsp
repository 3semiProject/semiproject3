<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Password PopUp</title>
<style type="text/css">
body {
	width: 1200px;
	height: 1200px;
	display: flex;
}
#popup_Box {
	margin:auto;
	border: 5px solid #D1D1D1; 
	width: 600px;
	height: 400px;
	border-radius: 35px;
	text-align: center;
	font-size: 15pt;
	color: #01CD88;
	
}

#popup_Box h1{
	margin-bottom: 100px;
}

#popup_Box input {
	font-size: xx-large;
}

</style>
<script src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
</head>
<body onLoad=document.popup_box_form.user_pw.focus()>
	<div id="popup_Box">
	<h1>${user_nickname}님<br>비밀번호를 입력해주세요.</h1>
	<form action="selectPw.do" method="post" name="popup_box_form">
		<input type="hidden" name="user_id" id="user_id" value="${ user_id }" />
		<input type="password" name="user_pw" id="user_pw" />
		<input type="button" name="button" value="확인" /> 
	</form>
	</div>
</body>
</html>