<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
body {
	 	width:1200px;
    	height:1200px;
}
#findcontainer{
width: 800px;
height: 100px;
margin: 0 auto;
}

#findcontainer > * {
border: 1px solid black;
margin: 0 auto;

}

#findEvBox{
	margin-top: 100px;
	margin-bottom: 50px;
	width: 600px;
	height: 100px;
	border: 1px solid black;
	border-radius: 30px;
	display: flex;
	justify-content: center;
	align-items: center;
}

#findEvBox div {
	width: 280px;
	height: 90px;
	border: 1px solid black;
	border-radius: 30px;
	margin: 0 10px;
	text-align: center;
	line-height: 90px;
	font-size: xx-large;
}

.label {
	text-align: center;
	width: 400px;
	height: 50px;
	line-height: 50px;
	font-size: x-large;
	border-radius: 15px;
}

.formBox {
 	width: 650px;
 	height: 300px;
 	border-radius: 20px;
}

.formBox > form {
	justify-content: center;
}

.formBox > form > div > input{
	height: 80px;
	width: 400px;
}


</style>

<script type="text/javascript"
   src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<hr>
<div id="findcontainer">
<div id="findEvBox">
<div onclick="clickID();">Find ID</div>
<div onclick="clickPW();">Find PW</div>
</div>
<div class="label">핸드폰으로 본인인증</div>
<div class="formBox">
<form action="findIdPhone.do">
<div><input type="text" id="user_name" value="이름" onfocus="this.value=''" /></div>
<div><input type="tel" id="phone" value="휴대폰번호('-'없이 입력)" onfocus="this.value=''" /></div>
<div id="sumbitBtn" onclick="sumbitBtn();">확인</div>
</form>
</div>

<div class="label">이메일으로 본인인증</div>
<div class="formBox">
<form action="findIdPhone.do">
<input type="text" id="user_name" value="이름" onfocus="this.value=''" />
<input type="email" id="email" value="이메일" onfocus="this.value=''" />
<div id="sumbitBtn2" onclick="sumbitBtn2();">확인</div>
</form>
</div>
</div>
</body>
</html>