<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
div.tabs{
	margin: auto;
	background-color: white;
	border-radius: 4px; 
	width: 500px;
	height: 40px;
	text-align: center;
}
div a.tab{
	display: inline-block;
	margin: -1px;
	padding: 0px;
	width:150px;
	height:40px;
	border: 1px solid #868e96;
	border-bottom: 3px solid rgba(134, 142, 150,0.5);
	border-radius: 4px;

	line-height: 40px;
	color: black;
	text-align: center;
	text-decoration: none;
	font-size: large;
	font-weight: 600;
	text-shadow: 2px 1px 3px rgba(0,0,0,0.3);	
}

div a.tab:hover{
	border-radius: 4px;
	border: 1px solid rgba(130, 201, 18, 0.5);
	background-color: rgba(130, 201, 18, 0.5);
	border-bottom: 3px solid rgba(86,140,8,0.2);
	box-shadow: 4px, 4px, 6px, gray;
}

</style>
</head>
<body id="taps">
	<div class="tabs">
		<a href="#" class="tab">식단</a>
		<a href="#" class="tab">운동</a>
		<a href="#" class="tab">체형</a>
	</div>
</body>
</html>