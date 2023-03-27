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
ul{padding: 0;}
ol{padding:0;}
ol li{display: inline-block;}
#mainContain {
 	
            width: 1200px;
            height: 1200px;
    min-height: 100%;
    position: relative;
    padding-bottom: 60px;
}
#footer {
    position: relative;
    transform: translatY(-100%);
}   
        
        
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
</head>
<body>
<div id="mainContain">
<br><c:import url="/WEB-INF/views/common/menubar.jsp" /> <!--메인 메뉴바-->
<br><c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp" /> <!--다이어리 메뉴바-->
<br><c:import url="/WEB-INF/views/diary/common/weekbar.jsp" />		<!--날짜이동바-->
<br><c:import url="/WEB-INF/views/diary/common/tap.jsp" />		<!--식단/운동/식단 탭-->
<br><c:import url="/WEB-INF/views/diary/common/target.jsp" />		<!--목표 표시-->
<hr>

<h2> diary_showEat -> eatView : 운동다이어리 보기</h2>
<pre>
보낼값 : diary
받을값 : diarys, eats, sums, total

식단 다이어리
</pre>
<div>
<h4>1번식단_음식2개, 이미지, 메모</h4>

<ol>
	<li>음식이름 : </li>
	<li>음식  : </li>
	<li>섭취 kcal :</li>
	<li>탄수화물 섭취량g :</li>
	<li>단백질 섭취량g :</li>
	<li>지방 섭취량g :</li>
</ol>
<ol>
	<li>음식이름 : </li>
	<li>음식  : </li>
	<li>섭취 kcal :</li>
	<li>탄수화물 섭취량g :</li>
	<li>단백질 섭취량g :</li>
	<li>지방 섭취량g :</li>
</ol>
<ol>
	<li>총 섭취 kcal :</li>
	<li>총 탄수화물 섭취량g :</li>
	<li>총 단백질 섭취량g :</li>
	<li>총 지방 섭취량g :</li>
</ol>
이미지
메모
</div>
<div>
<h4>2번식단_음식1개,이미지,메모</h4>
<ol>
	<li>음식이름 : </li>
	<li>음식  : </li>
	<li>섭취 kcal :</li>
	<li>탄수화물 섭취량g :</li>
	<li>단백질 섭취량g :</li>
	<li>지방 섭취량g :</li>
</ol>
<ol>
	<li>총 섭취 kcal :</li>
	<li>총 탄수화물 섭취량g :</li>
	<li>총 단백질 섭취량g :</li>
	<li>총 지방 섭취량g :</li>
</ol>
이미지
메모
</div>
<hr>
<pre>
총 섭취량 / 권장 섭취칼로리 : 
top3------------------------------var url if문으로 출력
하루 총 탄수화물 섭취량g : 
미달/초과 이미지, 링크
하루 총 단백질 섭취량g : 
미달/초과 이미지, 링크
하루 총 지방 섭취량g : 
미달/초과 이미지, 링크
</pre>

<pre>
작성버튼 -> diary_showEatWrite.do -> eatWrite : 식단다이어리 작성화면
	받은값 diary : 어떤날짜에 누가 작성하는건지
	시간입력
	이미지입력
	메모입력
	먹은양g 입력
	식단삭제
	식단추가 ; ajax 음식검색용기능 음식이름-> diary_serarchFood.do
			-> ajax : food -> 음식 추가, kcal계산시 사용
			
	보낼값 diary, eats
	저장버튼 -> diary_insertEat.do 
			->insertDiary, selectOneDiary, 
			insertOneEat -> diary_showEat.do -> eatView
	 
수정버튼 ->diary_showEatModify -> eatModify : 식단다이어리 수정화면
	받은값 diary : 어떤날짜에 누구의 어떤 다이어리를 수정하는건지
	eat : 화면에 띄울 기존 다이어리 정보

	시간수정
	이미지수정
	메모수정
	식단 g 변경
	식단 삭제 : 화면의 총합계값이 줄어야함.
	식단추가 ; ajax 음식검색용기능 음식이름-> diary_serarchFood.do
			-> ajax : food -> 음식 추가, kcal계산시 사용
			
	보낼값 diary, eat
	저장버튼 -> diary_modifyEat.do 
		-> updateOneDiary, insertEat, updateEat
		-> diary_showEat.do -> eatView : 식단 다이어리 보기
		
보낼값 diary
삭제버튼 -> diary_delEat.do -> deleteOneDiary, deleteAllEat ->
	-> diary_showEat.do -> eatView :식단 다이어리 보기
	
추천없음
</pre>
<hr><br>
</div>
<div id="footer">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</div>
</body>
</html>