<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Diary</title>
<style type="text/css">
/* ul{
padding: 0;}
ol{
padding:0;}
ol li{
display: inline-block;
} */
.home_a {
	display: block;
	text-decoration: none;
	color: #01CD88;
	border: 1px solid #01CD88;
}

body {
	width: 1200px;
	height: 1200px;
}

h1 {
	color: #A4A4A4;
	font-weight: 800;
	font-size: 30pt;
}

#enroll_form {
	text-align: center;
	font-size: 15pt;
	font-style: inherit;
	color: #5f5f5f;
}

#join_box {
	display: flex;
	align-items: center;
	border: 3px solid #D1D1D1;
	width: 600px;
	height: 560px;
	border-radius: 30px;
	display: inline-block;
	margin: 0;
}

#enroll_form #text {
	display: flex;
	color: #D96969;
}

.join_e {
	border-bottom: 2px solid #D1D1D1;
	height: 110px;
	width: 600px;
	display: flex;
}
.join_e2 {
	border-top: 0px solid #D1D1D1;
	height: 110px;
	width: 600px;
	display: flex;
}

.join_item {
	line-height: 100px;
	margin: 0;
	height: 110px;
	width: 200px;
	border-right: 2px solid #D1D1D1;
}

.join_item2 {
	display: flex;
	padding: 30px;
}
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
</head>
<body>
<%-- <c:import url="/WEB-INF/views/common/menubar.jsp" /> <!--메인 메뉴바-->
<br>
<c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp" /> <!--다이어리 메뉴바-->
<hr>

<h2> diary_showGoalView.do : showGoalView-> goalView : 목표관리 화면</h2>
보낼값 : diary
받은값 : goal

<div>
	private Date goal_date;			// 등록날짜(매일)
	private Date goal_end_date;		// 목표 종료일
	private int goal_activity;		// 에너지 요구량
	private int goal_height;		// 키(cm)
	private int goal_current_weight;// 현재 체중(kg)
	private int goal_standard_weight;// 표준 체중(kg)
	private int goal_target_weight;	// 목표체중(kg)
</div>
<hr>
<pre>
값 바로 수정가능
값 변경 -> 저장 안누르고 나가면 팝업창뜨기
저장버튼 -> diary_insertAct.do ->insertDiary, insertOneAct * n -> diary_showAct.do
</pre>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" /> --%>
<hr>
	<div id="enroll_form">
		<br>
		<div align="left"
			style="color: #D96969; font-size: x-large; margin-bottom: 20px; margin-left: 320px;">선택사항</div>
		<div id="join_box" align="center">
			<div class="join_e">
				<div class="join_item">키</div>
				<div class="join_item2">
					<label style="font-weight: bold; font-family: Copperplate, Papyrus, fantasy;">158cm</label>
				</div>
			</div>
			<div class="join_e">
				<div class="join_item">몸무게</div>
				<div class="join_item2">
					<label style="font-weight: bold; font-family: Copperplate, Papyrus, fantasy;">49kg</label>
				</div>
			</div>
			<div class="join_e">
				<div class="join_item">활동량</div>
				<div style="font-size: 10pt; text-align: left;">
					<input type="radio"> 활동이 적거나 운동을 하지 않는다. <br> <input
						type="radio"> 가벼운 활동 및 운동(주 1~3회)을 한다. <br> <input
						type="radio"> 보통의 활동 및 운동(주 3~5회)을 한다. <br> <input
						type="radio"> 적극적인 활동 및 운동(주 6~7회)을 한다. <br> <input
						type="radio"> 아주 적극적인 활동 또는 운동선수 (하루 2번, 고중량 운동 등)
				</div>
			</div>
			<div class="join_e">
				<div class="join_item">목표 체중</div>
				<div class="join_item2">
					<label style="font-weight: bold; font-family: Copperplate, Papyrus, fantasy;">44kg</label>
				</div>
			</div>
			<div class="join_e2">
				<div class="join_item">목표 기간</div>
				<div class="join_item2">
					<label>오늘 ~</label> &nbsp; <label style="font-weight: bold; font-family: Copperplate, Papyrus, fantasy;"> 2023.09.31</label>
				</div>
			</div>
		</div>
	</div>
</body>
</html>