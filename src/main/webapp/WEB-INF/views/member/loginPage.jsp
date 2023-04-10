<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DAMUNITY</title>
<style type="text/css">
/*    h1 {
      font-size: 36pt;
      color: #01CD88;
      
   } */
   
   a{
   text-decoration: none;
   
   }
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


.social_login{
	display: flex;
	justify-content: center;
	margin: 20px 0;
	
}


.social_login div a .img2 {
	width: 65px;
	height: 55px;
	padding: 0 10px;
}

#loginForm.login_other{
	width: 300px;
	height: 100px;
	align-items: center;
}

/* 



#loginForm form input[type=text] {
	width: 270px;
	height: 25px;
	left: 120px;
	border: 2px solid #01CD88;
	font-size: 14pt;
	margin: auto;
}

#loginForm form input[type=password] {
	width: 270px;
	height: 25px;
	left: 120px;
	border: 2px solid #01CD88;
	font-size: 14pt;
	margin: auto;
} */
</style>
<!-- 카카오 로그인 -->
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">

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
 	<div class="login_submit">
      <input type="submit" value="로그인">
 	</div>
  </form>

<div class="social_login">
<!-- 카카오 로그인 창으로 이동 -->
<div id="kakao_login" style="text-align: center;">
	<a href="https://kauth.kakao.com/oauth/authorize?client_id=3205654a3e1700ef0d67201d929a9c56&redirect_uri=http://localhost:8889/semi/kakao_callback.do&response_type=code">
		<img class="img2"  alt="카카오 로그인" src="${ pageContext.servletContext.contextPath }/resources/images/kakao_login.png" onclick="kakaoLogin();"/>
	</a>
</div>
<!-- 네이버 로그인 창으로 이동 -->
<div id="naver_login" style="text-align: center;">
	<a href="<c:url value="${ requestScope.kakaourl }"/>" class="cp" >
		<img class="img2" alt="네이버 로그인" src="${ pageContext.servletContext.contextPath }/resources/images/kakao_login.png" />
	</a>
</div>
<!-- 구글 로그인 창으로 이동 -->
<div id="google_login" style="text-align: center;">
	<a href="<c:url value="${ requestScope.kakaourl }"/>" class="cp" >
		<img class="img2"  alt="구글 로그인" src="${ pageContext.servletContext.contextPath }/resources/images/kakao_login.png" />
	</a>
</div>
</div>
<hr>
	<div class="login_other">
		<div id="login_find">
			<a href="${ pageContext.servletContext.contextPath }/findId.do">ID찾기</a>
			<a href="${ pageContext.servletContext.contextPath }/findPw.do">PW찾기</a>
		</div>
		<div id="login_join">
			<a href="${ pageContext.servletContext.contextPath }/enrollPage.do">회원가입</a>
		</div>
	</div>
</div>

</body>
</html>