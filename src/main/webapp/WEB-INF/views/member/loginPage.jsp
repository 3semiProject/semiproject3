<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp"%>
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
        
        div#loginForm img {
            width: 300px;
            height: 100px;
            margin: auto;
        }

   div {
      width: 320px;
      height: 280px;
      border: 2px solid #D2D2D2;
      position: relative;
      left: 300px;
   }

   div form {
      font-size: 16pt;
      color: navy;
      font-weight: bold;
      margin: 10px;
      padding: 10px;
   }

   div#loginForm form label input.pos {
      width: 250px;
      height: 20px;
      position: absolute;
      left: 120px;
      border: 1px solid #E5E5E5;
   }

   div#loginForm form input[type=submit] {
      margin: 10px;
      width: 280px;
      height: 40px;
      border: 2px solid #01CD88;
      left: 120px;
      background: white;
      color: #01CD88;
      font-size: 16pt;
      font-weight: bold;
      margin: auto;

   }
   
   div#loginForm form input[type=text] {
      width: 270px;
      height: 25px;
      left: 120px;
      border: 2px solid #01CD88;
      font-size: 14pt;
      margin: auto;

   }

   div#loginForm form input[type=password] {
      width: 270px;
      height: 25px;
      left: 120px;
      border: 2px solid #01CD88;
      font-size: 14pt;
      margin: auto;

   }

</style>
</head>
<body>
<!-- <h1 align="center">다뮤니티 로그인</h1> -->
<div id="loginForm">
<img alt="logo" src="${ pageContext.servletContext.contextPath }/resources/images/mainLogo.jpg">
   <form action="login.do" method="post">
      <input type="text" name="user_id" class="pos" placeholder="아이디">
      <br>
      <input type="password" name="user_pw" class="pos" placeholder="비밀번호">
      <br><br>
      <input type="submit" value="로그인">
   </form>
</div>
<hr>
<!-- 카카오 로그인 창으로 이동 -->

<!-- 네이버 로그인 창으로 이동 -->

<!-- 구글 로그인 창으로 이동 -->

</body>
</html>