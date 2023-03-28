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
ul{
padding: 0;}
ol{
padding:0;}
ol li{
display: inline-block;
}
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
</head>
<body>
<c:import url="/WEB-INF/views/common/diary/menubar.jsp" /> <!--메인 메뉴바-->
<br><c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp" /> <!--메인 메뉴바-->
<hr>

<h2> diary_showGoalModify.do : showGoalModify -> goalModify : 목표관리 수정화면</h2>
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
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>