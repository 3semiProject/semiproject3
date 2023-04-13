<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
.errorpageout {
	margin: 0px;
	padding: 10px;
	width: 300px;
	height: 200px;
	border-radius: 20px;
	border: 3px solid #1C1C1C;
	text-align: center;
	position: absolute;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	background-color: #E2E2E2;
	font-family: Copperplate, Papyrus, fantasy;
	border-style: dashed;
}

.errortitle {
	margin: 0px;
	padding: 10px;
	width: 279px;
	height: 50px;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	border-bottom-left-radius: 0px;
	border-bottom-right-radius: 0px;
	border: 1px solid #A5FFC9;
	background-color: #A5FFC9;
}

.errorpagein {
	margin: 0px;
	padding: 10px;
	width: 279px;
	height: 100px;
	border-top-left-radius: 0px;
	border-top-right-radius: 0px;
	border-bottom-left-radius: 10px;
	border-bottom-right-radius: 10px;
	border: 1px solid #A5C9FF;
	background-color: #A5C9FF;
	font-color: #A5C9FF;
}

#goTo{
	display: flex;
}

#goTo button {
	width: 100px;
	height: 30px;
	background: #A5FFC9;
	position:relative;
	top: 30px;
	left: 20px;
	margin: 10px;
	 
}

</style>
</head>
<body>
	<div class="errorpageout">
		<h1 class="errortitle">ERROR!</h1>
		<%-- 다른 jsp 페이지에서 발생된 에러가 넘어오는 경우 --%>
		<div class="errorpagein">
	<c:set var="e" value="<%= exception %>" />
	<c:if test="${ !empty e }" > <!-- e가 존재한다면, -->
		<h3>jsp Page Error : ${ message }</h3>
	</c:if>
			<%-- 컨트롤러에서 에러 메세지와 내보낼 페이지로 리턴한 경우 --%>
			<c:if test="${ empty e }">
				<h4>${ message }</h4>
			</c:if>
		</div>
	
		<div id="goTo">
		<c:url var="movemain" value="/main.do" />
		<br> <button type="button"  onclick = "location.href = 'main.do'">홈으로</button>
		<c:url var="movelogin" value="/loginPage.do" />
		<br> <button type="button"  onclick = "location.href = 'loginPage.do'">login</button>
		</div>

	</div>
</body>
</html>



