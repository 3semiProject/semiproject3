<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<style>
.calendar {
	margin: auto;
	text-align: center;
}
.calendar a{
	text-decoration: none;
	color: black;
}
.navigation{
	margin: auto;
	text-align: center;
}
.navigation a{
	color: #797979;
	padding: 20px;

	vertical-align: middle;
	text-decoration: none;
	font-size: 40px;
	text-align: center;
	font-weight: bold;
}
.today {
	display: inline-block;
	width:50px;
	height:50px;
	border: 1px solid rgba(86,140,8,0.5);
	border-radius: 50%;
	background-color: rgba(130, 201, 18, 0.5);
	text-align: center;
}
</style>
<body>
<pre>
diary_showWeekBar.do -> diary/common/weekBar : 날짜 네비게이션
받을값 : ArrayList DateData "week"</pre>
	<div class="calendar">
		<a href="">2023.3.28 ${week[3].date}</a>
		<br>
	</div>
	<div class="navigation">
		<a>
		<!-- <이전 --> &lt; &nbsp; 
		</a>
		<a class="three" href="/diary_showWeekDiary.do?date=${week[0].date}">
		<!-- 삼일전 --> 18 ${week[0].day}
		</a> 
		<a class="two" href="/diary_showWeekDiary.do?date=${week[1].date}">
		<!-- 이틀전 --> 19 ${week[1].day} 
		</a> 
		<a class="one" href="diary_showWeekDiary.do?date=${week[2].date}">
		<!-- 전날 --> 20 ${week[2].day} 
		</a>
		
		<a class="today"> 21 ${week[3].day} &nbsp; </a>
		
		 
		<a class="one" href="diary_showWeekDiary.do?date=${week[4].date}">
		 <!-- 다음날 --> 22 ${week[4].day}
		</a> 
		<a class="two" href="diary_showWeekDiary.do?date=${week[5].date}">
		 <!-- 이틀 뒤 --> 23 ${week[5].day}
		</a> 
		<a class="three" href="diary_showWeekDiary.do?date=${week[6].date}">
		 <!-- 삼일 뒤 --> 24 ${week[6].day} 
		</a>
		<a>
		<!-- 이후> --> &nbsp; &gt;
		</a>
	</div>

</body>
</html>