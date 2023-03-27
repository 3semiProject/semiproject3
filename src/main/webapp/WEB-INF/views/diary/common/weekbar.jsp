<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<style>
.navigation {
	margin-top: 100px;
	margin-bottom: 30px;
	text-align: center;
	font-size: 25px;
	vertical-align: middle;
}
.one {
	margin: 10px;
	font-weight: bold;
}
.two {
	font-weight: bold;
}

.three {
	font-weight: bold;
}

.today {
	margin: 10px;
	position: relative;
	border: 0;
	padding: 15px 25px;
	display: inline-block;
	text-align: center;
	color: white;
	font-size : larger;
}
</style>
<body>
<h2>
diary_showWeekVar.do -> diary/common/weekbar : 날짜 이동바
</h2>
<pre>받을값 : ArrayList DateData "week"</pre>
<script>
	var 1 = 
</script>
<!-- 정수를 저장하는 Arraylist를 생성하고 데이터 추가 -->
	<!--날짜 네비게이션  -->
	<div class="navigation">
	  <c:forEach items="${week}" var="DateData">
    <a href="/diary_showWeekVar.do?week=${DateData}">${DateData.day}</a> &nbsp; . &nbsp;
  </c:forEach>
  <br>
	
		<a class="three" href="/diary_showWeekVar.do?week=${week[0]}">
			&lt; &nbsp; 18 = ${week[0].day}
		<!-- 삼일전 -->
		</a> . 
		<a class="two" href="/calendar.do?year="> 
			19 = ${week[1].day}
		<!-- 이틀전 -->		 
		</a> . 
		<a class="one" href="./calendar.do?year=">
			20 = ${week[2].day}
		<!-- 전날 -->
		</a> .
		<span class="today">
			21 = ${week[3].day} &nbsp;
		</span>
		<a class="one" href="/calendar.do?year=">
		<!-- 다음날 -->
			22 = ${week[4].day}
		</a> . 
		<a class="two" href="/calendar.do?year=">
			<!-- 이틀 뒤 -->
			23= ${week[5].day}
		</a> . 
		<a class="three" href="/calendar.do?year=">
			<!-- 삼일 뒤 -->
			24 = ${week[6].day} &nbsp; &gt;
		</a>
	</div>
<pre>
<h4 align="center">2023. 03</h4>
<h4 align="center">18		19		20		[21] 		22		23		24</h4>
<h4 align="center">*				*		 						</h4>
</pre>
</body>
</html>