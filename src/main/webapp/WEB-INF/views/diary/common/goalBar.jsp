<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import = "org.sixpack.semi.goal.model.vo.Goal" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<style type="text/css">
div.target{
	margin: auto;
	position: relative
}
div.target img{
height: 123px;
width: 934px;
position: absolute;
}
div.target table {
margin: 0px;
padding: 0px;
width: 934px;
transform: translate( 0%, 0% );
text-align: center;
}
div.target td{
height: 55px;
width: 270px;
color: #39464e;
vertical-align: bottom;	
}
div.target td.dday{
height: 55px;
width: 120px;
	color: #5c940d;
	text-shadow: 1px 1px #82c912;
	font-weight: bold;
	font-size: 40px;
	vertical-align: middle;	
}
</style>
</head>
<body>
<div class="target">
<img alt="목표체중 표시바" src="${ pageContext.servletContext.contextPath }/resources/images/diary/goalLine.png">
<table>
	<tr>
		<td>목표체중 ${param.target_weight}kg</td>
 		<td>현재체중 ${param.current_weight}kg</td>
		
		<td>목표까지 <fmt:formatNumber value="${param.target_weight - param.current_weight}" pattern="0.0#"/>kg</td>
		<td rowspan="2" class="dday">d${param.dday}</td>
	</tr>
	<tr>
	<td></td>
	<td></td>
	<td></td>
	</tr>
</table>
</div>
</body>
</html>