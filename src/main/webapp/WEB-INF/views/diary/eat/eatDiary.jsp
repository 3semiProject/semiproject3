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
#mainContain {
	width: 1200px;
    height: 1200px;
    min-height: 100%;
    position: relative;
    padding-bottom: 60px;
}
#footer {
    position: relative;
    transform: translateY(-100%);
}      
      
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
</head>
<body>
<div id="mainContain">
<br><c:import url="/WEB-INF/views/common/menubar.jsp" /> <!--메인 메뉴바-->
<br><c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp" /> <!--다이어리 메뉴바-->
<br><c:import url="/WEB-INF/views/diary/common/weekBar.jsp">
		<c:param name="week0" value="${week[0]}"/>
		<c:param name="week1" value="${week[1]}"/>
		<c:param name="week2" value="${week[2]}"/>
		<c:param name="week3" value="${week[3]}"/>
		<c:param name="week4" value="${week[4]}"/>
		<c:param name="week5" value="${week[5]}"/>
		<c:param name="week6" value="${week[6]}"/>
</c:import>		<!--날짜이동바-->
<br><c:import url="/WEB-INF/views/diary/common/diaryTap.jsp" >
		<c:param name="id" value="${diary.user_id}"/>
		<c:param name="date" value="${diary.diary_post_date}"/>
</c:import>		<!--식단/운동/식단 탭-->
<br><c:import url="/WEB-INF/views/diary/common/goalBar.jsp" >
		<c:param name="current_weight" value="${goal.current_weight}"/>
		<c:param name="standard_weight" value="${goal.standard_weight}"/>
		<c:param name="target_weight" value="${goal.target_weight}"/>
		<c:param name="dday" value="${goal.dday}"/>
</c:import>	<!--목표 표시-->
<hr>

<h2> diary_showEat -> eatView : 식단다이어리 보기</h2>
<pre>
보낼값----
메뉴바 : ${diary}
네비게이터 : ${week}
목표바 : ${goal}
받을값----
이미지,메모 : ${diarys}
음식정보 : ${eats}
식단별 소계 및 총합계 : ${sums}
</pre>
<div>
<div id="eatDiarys">
		<p>식사 일지:</p>
</div>
<script type="text/javascript">
//모든 코드를 작성해두고 값이 있을때만 보이게 하자.

//eatDiarys에 식단내용을 추가하는 메소드 
/* (function(){
	document.getElementById("eatDiarys").insertAdjacentHTML("afterend", 
			"<br><ol><li>식사시간 </li>	<li>음식이름</li><li>섭취 kcal :</li><li>탄수화물 섭취량g " +
			":</li><li>단백질 섭취량g :</li><li>지방 섭취량g :</li></ol>");
})(); //자동으로 실행되는 함수 */
</script>
	<c:forEach var="D" items="${diarys}">
		<table>
			<tr>
			<td>
		<img alt="${D.diary_no}의 이미지" src="${D.diary_image}">			
			</td>
			<td>
				<p>식사시간 &nbsp; ${D.diary_post_date }</p>
			</td>
			
			</tr>
		</table>
		<c:forEach var="eat" items="${eats}">
			<c:if test="${eat.diary_no eq D.diary_no}">
				<div id="${eat.eat_seq}" style="border: 1px solid green;">
					${eat.food_code} &nbsp; ${eat.eat_g} &nbsp; &nbsp; =>
					${eat.eat_kcal} kcal <br> => 탄수화물 ${eat.eat_carbohydrate}g
					&nbsp; 단백질 ${eat.eat_protein}g &nbsp; 지방 ${eat.eat_fat}g
					&nbsp;&nbsp;
				</div>
			</c:if>
		</c:forEach>
			<c:forEach var="sum" items="${sums}" varStatus="status">
				<c:if test="${status.last}">
					<b>총 탄수화물 ${sum.eat_carbohydrate}g&nbsp;
					총 단백질 ${sum.eat_protein}g&nbsp;
					총 지방 ${sum.eat_fat}g &nbsp;&nbsp; => 
					${sum.eat_kcal}kcal</b><br>
				</c:if>
			</c:forEach>
		<textarea rows="5" cols="150">${D.diary_memo}</textarea>
	</c:forEach>
	<hr>
	<br>
			<c:forEach var="sum" items="${sums}" varStatus="status">
				<c:if test="${status.last}">
					<b>총 탄수화물 ${sum.eat_carbohydrate}g&nbsp;
					총 단백질 ${sum.eat_protein}g&nbsp;
					총 지방 ${sum.eat_fat}g &nbsp;&nbsp; => 
					${sum.eat_kcal}kcal</b><br>
				</c:if>
			</c:forEach>
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