<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DAMUNITY</title>
<style type="text/css">


body {
	height: 1200px;
	width: 1200px;
	position: relative;
}

#loginForm .img1 {
	width: 600px;
	height: 100px;
	margin: 20px 0;
	border-radius: 30px;
}

body #loginForm {
	text-align: center;
	width: 800px;
	height: 600px;
	border: 5px solid #A4A4A4;
	position: absolute;
	border-radius: 30px;
	top: 200px;
	left: 400px;
	
}


#loginForm form{
	font-size: 16pt;
	font-weight: bold;
	margin: 10px;
	padding: 10px;
	display: flex;
	justify-content: center;

	
}

.login_box {
	padding: 0 30px;
}
.login_box input.pos {
	display: block;
	margin : 10px 0;
	width: 250px;
	height: 50px;
	border: 1px solid #A4A4A4;
	border-radius: 10px;
	font-size: 20pt;
	text-align: center;
	
}

#loginForm form input[type=submit] {
	margin: 10px;
	width: 100px;
	height: 150px;
	border: 2px solid #01CD88;
	border-radius: 10px;
	left: 120px;
	background: white;
	color: #01CD88;
	font-size: 20pt;
	font-weight: bold;
	margin: auto;
}



#loginForm.login_other{
	width: 300px;
	height: 100px;
	align-items: center;
}


.login_other > div > div {
	height: 50px;
	border: 1px solid black;
	border-radius: 10px;
	line-height: 50px;
}

.login_other > #login_find {
	display: flex;
}

.login_other > #login_find > div {
	width: 120px;
	position: relative;
	left: 210px;
	margin: 10px;

}

.login_other > #login_join > div {
	width: 250px;
	position: relative;
	left: 225px;
}

</style>
<!-- 카카오 로그인 -->
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">

function submitBtn() {
	document.getElementById('login_submit').style.color = 'white';
	document.getElementById('login_submit').style.backgroundColor = '#BEE9C6';
}

function findId() {
	document.getElementById('findId').style.backgroundColor = '#BEE9C6';
	location.href="${ pageContext.servletContext.contextPath }/findId.do"
}

function findPw() {
	document.getElementById('findPw').style.backgroundColor = '#BEE9C6';
	location.href="${ pageContext.servletContext.contextPath }/findPw.do"
}

function joinBtn() {
	document.getElementById('joinBtn').style.backgroundColor = '#BEE9C6';
	location.href="${ pageContext.servletContext.contextPath }/enrollPage.do"
}

</script>
</head>
<body>
<!-- <h1 align="center">다뮤니티 로그인</h1> -->
<div id="loginForm">
<img class="img1" alt="logo" src="${ pageContext.servletContext.contextPath }/resources/images/mainLogo.jpg" />
 <form action="login.do" method="post">
 	<div class="login_box">
      <input type="text" name="user_id" class="pos" placeholder="아이디" />
      <input type="password" name="user_pw" class="pos" placeholder="비밀번호" />
 	</div>
 	<div>
      <input id="login_submit" onclick="submitBtn();" type="submit" value="로그인">
 	</div>
  </form>

<hr>
	<div class="login_other">
		<div id="login_find">
			<div id="findId" onclick="findId();">ID찾기</div>
			<div id="findPw" onclick="findPw();">PW찾기</div>
		</div>
		<div id="login_join">
			<div id="joinBtn" onclick="joinBtn();">회원가입</div>
		</div>
	</div>
</div>

</body>
</html>