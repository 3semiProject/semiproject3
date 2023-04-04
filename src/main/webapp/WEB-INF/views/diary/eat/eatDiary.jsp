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
<link rel="stylesheet" type="text/css"
 href="${ pageContext.servletContext.contextPath }/resources/css/diarytab2.css" >
<style type="text/css">
/* 다이어리출력용 */
#mainContain {
	margin: auto;
	width: 1200px;
	height: 80%;
	min-height: 100%;
	position: relative;
	padding-bottom: 60px;
	font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Oxygen,
		Ubuntu, Cantarell, Fira Sans, Droid Sans, Helvetica Neue, sans-serif;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	font-size: 16px;
}

#footer {
	position: relative;
	transform: translateY(-100%);
}

#E_ {
	color: inherit;
	font-weight: 400;
	box-sizing: border-box;
}

#modifybtn {
	width: 55px;
	height: 30px;
	border: 1px solid #827482;
	background-color: white;
	color: #827482;
	border-radius: 7px;
}

div.D {
	width: 900px;
	border-radius: 34px 34px 34px 34px;
	-moz-border-radius: 34px 34px 34px 34px;
	-webkit-border-radius: 34px 34px 34px 34px;
	border: 1px solid #827482;
	padding: 20px;
	margin: auto;
	justify-content: center;
	-webkit-box-shadow: 3px 4px 3px -2px gray;
	-moz-box-shadow: 3px 4px 3px -2px gray;
	box-shadow: 3px 4px 3px -2px gray;
}

table.D {
	border-collapse: collapse;
	margin: auto;
}

tr.dbtn td{
	text-align: right;
	padding: 0px 30px 0px 0px;
}

th#dtime {
	text-align: left;
	padding: 0px  0px 0px 35px;
	height: 20px;
	
}
tr.dimg{
width: 500px;
border-bottom: 2px solid rgba(92, 148, 13, 0.5);
}

img{
	width: 350px;
	height: 350px;
	border-radius: 27px;
}

tr.etotal {
	border-top: 2px solid rgba(92, 148, 13, 0.5);
	height: 50px;	
	text-align: left;
	font-size:9pt;
}
tr.etotal td{
	padding: 0px 35px;
}
span#sum{
	font-size: 17pt;
	font-weight: bold;
	
}
tr.dmemo {
	text-align: center;
	height: 150px;
}

table.E {
	text-align: left;
	width: 500px;
	padding: 25px 35px;
}

table.E td.even-row {
	font-size: 8px;
	padding-bottom: 20px;
}

table.dtotal {
	margin: auto;
	width: 900px;
	font-size: 15pt;
	text-align: center;
	border-bottom: 2px solid rgba(92, 148, 13, 0.5);
}

table.T img {
	width: 200px;
	height: 200px;
	border-radius: 7px;
}

table.T {
	width: 750px;
	text-align: center;
	margin: auto;
}

table.T th {
	width: 250px;
}
</style>
<style>
/* 네비게이터 출력용 */
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
    div.navigation a{
        color: #797979;
        padding: 20px;

        vertical-align: middle;
        text-decoration: none;
        font-size: 40px;
        text-align: center;
        font-weight: bold;
    }
    a.today {
        display: inline-block;
        width:50px;
        height:50px;
        border: 1px solid rgba(86,140,8,0.5);
        border-radius: 50%;
        background-color: rgba(130, 201, 18, 0.5);
        text-align: center;
    }
</style>
<style type="text/css">
/* 목표바 출력용 */
div.target{
	width: 900px;
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
<style type="text/css">
form.tabs{
	display: inline;
	padding: 0px;
	margin: 0px;
}
</style>

<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
</head>
<body>

<div id="mainContain">
<br><c:import url="/WEB-INF/views/common/menubar.jsp" /> <!--메인 메뉴바-->
<br><c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp"/> <!--다이어리 메뉴바-->
<br>
<div class="calendar">
    <a href=""> ${week[3].post_date}</a>
    <br>
</div>
<div class="navigation">
    <a>
        <!-- <이전 --> &lt; &nbsp;
    </a>
    <a class="three" href="diary_moveWeekDiary.do?week=${diary.diary_post_date}&ago=-3">
        <!-- 삼일전 --> 
        <fmt:formatDate value="${week[0].post_date}" pattern="d"/>
        <c:if test="${week[0].ago >0}">◆</c:if>
    </a>
    <a class="two" href="diary_moveWeekDiary.do?week=${diary.diary_post_date}&ago=-2">
        <!-- 이틀전 --> 
        <fmt:formatDate value="${week[1].post_date}" pattern="d"/>
        <c:if test="${week[1].ago >0}">◆</c:if>
    </a>
    <a class="one" href="diary_moveWeekDiary.do?week=${diary.diary_post_date}&ago=-1">
        <!-- 전날 --> 
        <fmt:formatDate value="${week[2].post_date}" pattern="d"/>
        <c:if test="${week[2].ago >0}">◆</c:if>
    </a>

    <a class="today"> <fmt:formatDate value="${week[3].post_date}" pattern="d"/>&nbsp; </a>
        

    <a class="one" href="diary_moveWeekDiary.do?week=${diary.diary_post_date}&ago=1">
        <!-- 다음날 -->  
        <fmt:formatDate type="date" value="${week[4].post_date}" pattern="d"/>
        <c:if test="${week[4].ago >0}">◆</c:if>
    </a>
    <a class="two" href="diary_moveWeekDiary.do?week=${diary.diary_post_date}&ago=2">
        <!-- 이틀 뒤 -->  
        <fmt:formatDate value="${week[5].post_date}" pattern="d"/>
        <c:if test="${week[5].ago >0}">◆</c:if>
        
    </a>
    <a class="three" href="diary_moveWeekDiary.do?week=${diary.diary_post_date}&ago=3">
        <!-- 삼일 뒤 --> 
        <fmt:formatDate value="${week[6].post_date}" pattern="d"/>
        <c:if test="${week[6].ago >0}">◆</c:if>
        
    </a>
    <a>
        <!-- 이후> --> &nbsp; &gt;
    </a>
</div><br>
<div class="target">
<img alt="목표체중 표시바" src="${ pageContext.servletContext.contextPath }/resources/images/diary/goalLine.png">
<table>
	<tr>
		<td>목표체중 ${goal.target_weight}kg</td>
 		<td>현재체중 ${goal.current_weight}kg</td>
		
		<td>목표까지 <fmt:formatNumber value="${goal.target_weight - goal.current_weight}" pattern="0.0#"/>kg</td>
		<td rowspan="2" class="dday">d${goal.dday}</td>
	</tr>
	<tr>
	<td></td>
	<td></td>
	<td></td>
	</tr>
</table>
</div>
<br>
 	<div class="tabs">
<form class="tabs" method="get" name="diary" action="diary_showEatDiary.do">
	<input type="hidden" name="user_id" value="${sessionScope.loginMember.user_id}">
 	<input type="hidden" name="diary_post_date" value="${diary.diary_post_date}">	
 	<input class="tabs" id="left" type="submit" value="식단" />
</form>
<form class="tabs" method="get" name="diary" action="diary_showActDiary.do">
	<input type="hidden" name="user_id" value="${sessionScope.loginMember.user_id}">
 	<input type="hidden" name="diary_post_date" value="${diary.diary_post_date}">	
    <input class="tabs" id="center" type="submit" value="운동"/>
</form>
<form class="tabs" method="get" name="diary" action="diary_showBodyDiary.do">
	<input type="hidden" name="user_id" value="${sessionScope.loginMember.user_id}">
 	<input type="hidden" name="diary_post_date" value="${diary.diary_post_date}">	
    <input class="tabs" id="right" type="submit" value="체형"/>
</form>
	</div>
<%-- <c:import url="/WEB-INF/views/diary/common/diaryTap.jsp" /><!--식단/운동/식단 탭-->--%>

<%--  <pre>보낼값----
메뉴바 : ${diary}
네비게이터 : ${week}
목표바 : ${goal}
받을값----
이미지,메모 : ${diarys}
음식정보 : ${eats}
식단별 소계 및 총합계 : ${sums}
 </pre> --%>
<c:set var="recommandKcal" value="${(goal.standard_weight * goal.energy_demand)+(goal.current_weight - goal.standard_weight)*7000/goal.dday * 3/5}"/>
<c:forEach var="sum" items="${sums}" varStatus="status">
<c:if test="${status.last}"><c:set var="currentKcal" value="${sum.eat_kcal}"/>
</c:if></c:forEach>
<br><br>
<table class="dtotal"><tr>
			<td>일일 권장 칼로리 <fmt:formatNumber value="${recommandKcal}" pattern="0"/>kcal &nbsp;</td> 
			<td>현재 섭취 칼로리 <fmt:formatNumber value="${currentKcal}" pattern="0"/>kcal &nbsp;</td>
			<td>&nbsp; ⇒ &nbsp; 잔여 <fmt:formatNumber value="${recommandKcal-currentKcal}" pattern="0.#"/>kcal</td>
</tr></table>
<br>
<c:forEach var="D" items="${diarys}" varStatus="status">
	<div class="D">
		<table class="D">
		<tr class="dbtn"><td colspan="3"><button id="modifybtn">수정</button></td></tr>			
		<tr class="dimg"><td rowspan="3">
			<c:if test="${empty D.diary_image}">
			<img alt="${D.diary_no}의 이미지" src="${ pageContext.servletContext.contextPath }/resources/images/diary/noimage.jpg">
			</c:if>
			<c:if test="${!empty D.diary_image}">
			<img alt="${D.diary_no}의 이미지" src="${ pageContext.servletContext.contextPath }/resources/diary_upfile/${D.diary_image}">
			</c:if>
			</td>
		<th id="dtime"><h3> 🍴 &nbsp;<fmt:formatDate value="${D.diary_post_date}" type="date" pattern="a HH:mm" /></h3>
		</th></tr>
			<tr><td><table class="E">
					<c:forEach var="eat" items="${eats}"><c:if test="${eat.diary_no eq D.diary_no}">
				<tr><td><b>${eat.food_code}</b> &nbsp; ${eat.eat_g}g &nbsp; &nbsp; &nbsp; &nbsp;</td>
					<td>⇒ ${eat.eat_kcal} kcal </td></tr>
				<tr><td colspan="2" class="even-row">↳ 탄수화물 ${eat.eat_carbohydrate}g &nbsp; 단백질 ${eat.eat_protein}g &nbsp; 지방 ${eat.eat_fat}g &nbsp;&nbsp;</td></tr>
					</c:if></c:forEach>
				</table>
			</td>
		</tr>
		<tr class="etotal"><c:forEach var="sum" items="${sums}"><c:if test="${sum.diary_no eq D.diary_no}">
									<td>총 탄수화물 ${sum.eat_carbohydrate}g &nbsp; 총 단백질
										${sum.eat_protein}g &nbsp; 총 지방 ${sum.eat_fat}g &nbsp; &nbsp;
									<span id="sum"> &nbsp; &nbsp; ⇒ ${sum.eat_kcal}kcal</span></td>
							</c:if></c:forEach>
		</tr>
		<tr class="dmemo"><td colspan="2"><textarea rows="5" cols="100">${D.diary_memo}</textarea>
			</td>
		</tr>
	</table>
	</div>
	<br><br>
</c:forEach>
		
			<br>
			<c:forEach var="sum" items="${sums}" varStatus="status">
				<c:if test="${status.last}">
					<table class="dtotal"><tr>
					<td>총 섭취량 / 권장 섭취칼로리 &nbsp;</td> 
					<td> &nbsp;  &nbsp; ⇒ &nbsp; ${sum.eat_kcal} / <fmt:formatNumber value="${recommandKcal}" pattern="0"/> kcal</td></tr></table>
					<br>
				<table class="T">
				<tr>
					<th>탄수화물 &nbsp; &nbsp;  ${sum.eat_carbohydrate} / 324g</th>
					<th>단백질 &nbsp; &nbsp; ${sum.eat_protein} / 55g</th>
					<th>지방 &nbsp; &nbsp; ${sum.eat_fat} / 54g</th>
				</tr>
				<tr>
					<th><img alt="탄수화물관련 이미지" src="${ pageContext.servletContext.contextPath }/resources/images/diary/noimage.jpg"></th>
					<th><img alt="단백질관련 이미지" src="${ pageContext.servletContext.contextPath }/resources/images/diary/noimage.jpg"></th>
					<th><img alt="단백질관련 이미지" src="${ pageContext.servletContext.contextPath }/resources/images/diary/noimage.jpg"></th>
				</tr>			
				</table>
				</c:if>
			
			</c:forEach>
<pre>
<!-- 총 섭취량 / 권장 섭취칼로리 : 
top3------------------------------var url if문으로 출력
하루 총 탄수화물 섭취량g : 
미달/초과 이미지, 링크
하루 총 단백질 섭취량g : 
미달/초과 이미지, 링크
하루 총 지방 섭취량g : 
미달/초과 이미지, 링크

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
	
추천없음 -->
</pre>
</div>

<div id="footer">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</div>
</body>
</html>