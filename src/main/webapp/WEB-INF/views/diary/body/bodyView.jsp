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
<c:import url="/WEB-INF/views/diary/common/menubar.jsp" /> <!--메인 메뉴바-->
<c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp" /> <!--다이어리 메뉴바-->

<c:import url="/WEB-INF/views/diary/common/weekbar.jsp" />		<!--날짜이동바-->

<c:import url="/WEB-INF/views/diary/common/tap.jsp" />			<!--식단/운동/체형 탭-->
<c:import url="/WEB-INF/views/diary/common/target.jsp" />		<!--목표 표시-->
<hr>

<h2> diary_showBody.do -> bodyView : 운동다이어리 보기</h2>
보낼값 : diary

받을값 : body

<div>
<lable>체형다이어리</lable>
<ol>
	<li>체중 : </li>
	<li>체중 평가 : </li>
	<li>체지방량 :</li>
	<li>지방 평가 :</li>
	<li>골격근량 :</li>
	<li>골격근량 평가 :</li>
	<li>허리둘레(cm) :</li>
	<li>허리둘레 평가 :</li>
	<li>계산된 bmi :</li>
	<li>허리둘레(cm) :</li>
	<li>bmi 평가 :</li>
	<li>계산된 bmr(kcal) :</li>
</ol>
</div>
<hr>

<pre>


글쓰기버튼 -> diary_showBodyWrite.do -> bodyWrite : 체형다이어리 작성화면
	이미지입력
	메모입력
	체형값 4가지 입력 : 체중, 체지방량, 골격근량, 허리둘레
	저장버튼 -> diary_insertBody.do ->insertDiary, insertOneBody -> diary_showBody.do
	 
수정버튼 ->diary_showBodyModify -> bodyModify : 체형다이어리 수정화면
	시간수정
	이미지수정
	메모수정
	체형수정
	저장버튼 -> diary_modifyBody.do 
		-> updateOneDiary, insertBody, updateBody
		-> diary_showBody.do -> bodyView : 체형 다이어리 보기
		
삭제버튼 -> diary_delBody.do -> deleteOneDiary, deleteBody ->
	-> diary_showBody.do -> bodyView :체형 다이어리 보기
	
추천없음
</pre>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>