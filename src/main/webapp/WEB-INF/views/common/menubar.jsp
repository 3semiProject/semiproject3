<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ page import="org.ict.first.member.model.vo.Member" %> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <% 
	Member loginMember = (Member)session.getAttribute("loginMember");
%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
div#logo {
	width: 300px;
	height: 100px;

}
div#logo img {
	margin: 0px;
	padding: 0px;
	width: 300px;
	height: 100px;
	border-radius: 30px;
	border: 1px solid #D1D1D1;
}
header ul#menubar {
	list-style: none;
	position: absolute;
	left: 400px;
	top: -5px;
	
}
header ul#menubar li {
	float: left;
	width: 200px;
	height: 100px;
	margin-right: 5px;
	padding: 0;
}
header ul#menubar li a {
	text-decoration: none;
	width: 200px;
	height: 100px;
	display: block;
	background-color: white;
	text-align: center;
	line-height: 100px;
	color: #01CD88;
	font-weight: bold;
	margin: 0;
	text-shadow: 1px 1px 2px #D1D1D1;
	font-size: 20pt;
	border-radius: 30px;
	border: 1px solid #D1D1D1;
}
header ul#menubar li a:hover{
	text-decoration: none;
	width: 200px;
	height: 100px;
	line-height: 100px;
	display: block;
	background-color: #01CD88;
	font-size: 25pt;
	text-align: center;
	color: white;
	font-weight: bold;
	margin: 0;
	text-shadow: 1px 1px 2px #D1D1D1;
	padding-top: 5px;
}
hr { clear: both;}
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
	function movePage() {
		//버튼 클릭시, 로그인 페이지로 이동하는 controller 요청
		location.href = "main.do";
	}
</script>
</head>
<body>
<header>
	<div id="logo" ><img alt="logo" onclick="movePage()" src="${ pageContext.servletContext.contextPath }/resources/images/mainLogo.jpg"></div>
	<!-- non-login -->
	<c:if test="${ empty sessionScope.loginMember }">
		<ul id="menubar">
			<li><a href="${ pageContext.servletContext.contextPath }/test.do">다이어리</a></li>
			<li><a href="${ pageContext.servletContext.contextPath }/commu.do">커뮤니티</a></li>
			<!-- cs.do = customer service center -->
			<li><a href="${ pageContext.servletContext.contextPath }/customer.do">고객센터</a></li>
		</ul>
	</c:if>
	
	<!-- login : admin -->
	<c:if test="${ !empty sessionScope.loginMember and loginMember.admin_ck eq 'Y' }">
		<ul id="menubar">
			<li><a href="${ pageContext.servletContext.contextPath }/diary.do">게시판관리</a></li>
			<li><a href="${ pageContext.servletContext.contextPath }/commu.do">회원관리</a></li>
			<!-- cs.do = customer service center -->
			<li><a href="${ pageContext.servletContext.contextPath }/cs.do">배너관리</a></li>
		</ul>
	</c:if>
	
	<!-- login : member -->
	<c:if test="${ !empty sessionScope.loginMember and loginMember.admin_ck ne 'Y'}">
		<ul id="menubar">
			<li><a href="${ pageContext.servletContext.contextPath }/diary.do">다이어리</a></li>
			<li><a href="${ pageContext.servletContext.contextPath }/commu.do">커뮤니티</a></li>
			<!-- cs.do = customer service center -->
			<li><a href="${ pageContext.servletContext.contextPath }/customer.do">고객센터</a></li>
		</ul>
	</c:if>
</header>
</body>
</html>