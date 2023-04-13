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
}

#popup_Box > div {
	height: 100px;
	width: 500px;
	border-bottom: 1px solid #D1D1D1;
	color: black;
	position: relative;
	left: 50px;
}
#popup_Box {
	margin:auto;
	border: 5px solid #D1D1D1; 
	width: 600px;
	height: 400px;
	border-radius: 35px;
	text-align: center;
	font-size: 15pt;
}

#popup_Box h2:nth-of-type(1){
	
	color: #01CD88;	
}

#popup_Box input {
	font-size: xx-large;
}

</style>
<script src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
</head>
<body onLoad=document.popup_box_form.user_pw.focus()>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<hr>
<br><br><br><br>
	<div id="popup_Box">
	<div><h1>비밀번호 재확인</h1></div>
	<h2>${user_nickname} 님</h2>
	<h2>본인확인을 위해 비밀번호를 확인해주세요.</h2>
	<form action="selectPw.do" method="post" name="popup_box_form">
		<input type="hidden" name="user_id" id="user_id" value="${ user_id }" />
		<input type="password" name="user_pw" id="user_pw" />
		<input type="button" name="button" value="확인" /> 
	</form>
	</div>
</body>
<c:import url="/WEB-INF/views/common/footer.jsp" />

</html>