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
 href="${ pageContext.servletContext.contextPath }/resources/css/vars.css" >
<link rel="stylesheet" type="text/css"
 href="${ pageContext.servletContext.contextPath }/resources/css/diarytab.css" >
 <link rel="stylesheet" type="text/css"
 href="${ pageContext.servletContext.contextPath }/resources/css/button_div.css" >

<style type="text/css">
<link rel="preload" href="https://cdn.dribbble.com/assets/neue-haas-grotesk/NeueHaasGrotTextRound-75Bold-Web-f2ff2f34217e3fdab82c30ef689f5be3fb86a8e4218a1906a9399d0354a95d45.woff2" as="font" crossorigin="anonymous">
@font-face{
	font-family: 'dfont';
	src: url("${ pageContext.servletContext.contextPath }/resources/fonts/NimbusSansNovusT-UltraLight.woff");
}
div#diaryPart{
font-family: dfont;
}
/* 다이어리출력용 */
#mainContain{
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

#E_ {
	color: inherit;
	font-weight: 400;
	box-sizing: border-box;
}

button{
	height: 40px;
    padding: 10px 16px;
	border: none;
	background: #f3f3f4;
    color: #0d0c22;
	border-radius: 8px;
	text-align: center;
	font-size: 14px;
    font-weight: 500;
    line-height: 20px;
    box-sizing: border-box;
}
button:hover, button:focus {
    background-color: #e7e7e9;
}

div.noneD {
	margin: 40px auto 40px auto;
	width: 900px;
	height: 150px;
	padding: 50px;
	border-radius: 34px 34px 34px 34px;
	-moz-border-radius: 34px 34px 34px 34px;
	-webkit-border-radius: 34px 34px 34px 34px;
	border: 1px solid #827482;
	justify-content: center;
	box-shadow: 3px 4px 3px -2px gray;
	text-align: center;
	Vertical-align: middle
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

.dimg img{
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
span#kcal{
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

table.dtotal{
	margin: auto;
	width: 900px;
	height: 50px;
	font-size: 15pt;
	text-align: center;
	border-bottom: 2px solid rgba(92, 148, 13, 0.5);
}

table.T img {
	width: 200px;
	height: 200px;
	border-radius: 7px;
}
table.T{
	width: 750px;
	text-align: center;
	margin: auto;
}
table.T th{
	height: 40px;
	vertical-align: bottom;
}
table.T td{
	height: 240px;
	vertical-align: top;
	padding: 0px 0px 20px 0px;
}
</style>
<style type="text/css">
   .vars {
   		display: flex;
   		flex-direction: column;
   		justify-content: center;
   }
form.tabs {
	display: block;
	padding: 0px;
	margin: 0px;
}
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<!--1. 버튼 이벤트 -->
<script type="text/javascript">
$(function(){
	$('.writebtn').on('click', function (){
		window.location.href = 'diary_showEatWrite.do';
		
	});//writebtn
	
	$('#eatPart').on('click', '.modifyBtn',function (){
		 var dn = $(this).attr('id');
		window.location.href = 'diary_showEatModify.do?diary_no='+dn;
		
	});//modifyBtn
	
	$('#eatPart').on('click', '.deleteBtn',function (){
		 var dn = $(this).attr('id');
		window.location.href = 'diary_deleteEatDiary.do?diary_no='+dn;
		
	});//deleteBtn
	
	$('#calendarDate').on('change', function(event){
		var movedate = $(this).val();
		window.location.href = 'diary_eatCalendar.do?no='+dn +'&movedate='+movedate;
	});//calendarDate
	
});//document.ready
</script>

<!--3.현재시간 -->
<script type="text/javascript">
//3. 현재 날짜와 시간입력 : 
//yyyy-MM-ddTHH:mm 형식
//yyyy-MM-dd 형식

$(function getCurrentDateTime() {
	var now = new Date();
  var year = now.getFullYear();
  var month = (now.getMonth() + 1).toString().padStart(2, "0");
  var day = now.getDate().toString().padStart(2, "0");
  var hour = now.getHours().toString().padStart(2, "0");
  var minute = now.getMinutes().toString().padStart(2, "0");
  var datetimeString = year + "-" + month + "-" + day + "T" + hour + ":" + minute;
  var calendarString = year + "-" + month + "-" + day;
//  요소에 시간적용
  $("#calendarDate").val(calendarString);
});

</script>

</head>
<body>

<div id="mainContain">
<br><c:import url="/WEB-INF/views/common/menubar.jsp" /> <!--메인 메뉴바-->
<br><c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp"/> <!--다이어리 메뉴바-->
<br>


<div class="vars">
<div class="calendar">
	<input type="date" id="calendarDate" name="diary_post_date" value="${diary.diary_post_date}">
    <br>
</div>
<div class="navigation">
	<div>
		<img id="img_today"alt="today 강조" src="${ pageContext.servletContext.contextPath }/resources/images/diary/today.jpg">
	</div>
	<!-- 이전 -->
	<div class="date">
		<a class="one" href="diary_moveDiary.do?week=${diary.diary_post_date}&ago=-1">
		         &lt; &nbsp;
	    </a>
    </div>
    
    <c:forEach var="w" items="${week}" varStatus="status" >
		<div>
			<div class="date">
 				<a href="diary_moveDiary.do?user_id=${w.user_id}&diary_post_date=${w.diary_post_date}&diary_category=${w.diary_category}">
					<fmt:formatDate value="${w.diary_post_date}" pattern="d" />
				</a>
			</div>
			<c:if test="${!empty w.diary_category}">
				<div class="dia1"><img id="weekDia"alt="해당일 diary 존재" src="${ pageContext.servletContext.contextPath }/resources/images/diary/weekDia.jpg"></div>
			</c:if>
			<c:if test="${empty w.diary_category}">
				<div class="dia2"><img id="weekDia"src=""/></div>
			</c:if>
		</div>
	</c:forEach>
	<div class="date">
    <a href="diary_moveWeekDiary.do?week=${diary.diary_post_date}&ago=1">
        <!-- 이후> --> &nbsp; &gt;
    </a>
	</div>
    
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
<c:set var="moveURL" value="diary_moveDiary.do?user_id=${sessionScope.loginMember.user_id}&diary_post_date=${diary.diary_post_date}&diary_category="/>
 		<a class="tabs left" href="${moveURL}eat">식단</a>
 		<a class="tabs center" href="${moveURL}act">운동</a>
 		<a class="tabs right" href="${moveURL}body">체형</a>
	</div>
</div>

<div id="diaryPart">
	<c:if test="${diary.diary_no ne 0}">
		<c:set var="recommandKcal" value="${(goal.standard_weight * goal.energy_demand)+(goal.current_weight - goal.standard_weight)*7000/goal.dday * 3/5}"/>
			<c:forEach var="sum" items="${sums}" varStatus="status">
				<c:if test="${status.last}"><c:set var="currentKcal" value="${sum.eat_kcal}"/>
				</c:if>
			</c:forEach>
		<br><br>
		<table class="dtotal">
			<tr>
				<td>일일 권장 칼로리 <fmt:formatNumber value="${recommandKcal}" pattern="0"/>kcal &nbsp;</td> 
				<td>현재 섭취 칼로리 <fmt:formatNumber value="${currentKcal}" pattern="0"/>kcal &nbsp;</td>
				<td>&nbsp; ⇒ &nbsp; 잔여 <fmt:formatNumber value="${recommandKcal-currentKcal}" pattern="0.#"/>kcal</td>
			</tr>
		</table>
	</c:if>
	<br>
	<c:if test="${diary.diary_no eq 0}">
		<div class="noneD">
			<h3>다이어리가 없네요, 작성하시겠습니까?</h3>
			<div>
				<button class="writebtn">글쓰기</button>
			</div>		
		</div>
	</c:if>
	<br> 
<c:if test="${diary.diary_no ne 0}">
${diarys }
${diary }
${eats }
	<div class="dbtn">
		<button class="writebtn">글쓰기</button>
	</div>
<div id="eatPart">
	<c:forEach var="D" items="${diarys}" varStatus="status">
		<div class="D">
			<table class="D">
				<tr class="dbtn">
					<td colspan="3">
						<button type="button" class="modifyBtn" id="${D.diary_no}">수정</button>
						<button type="button" class="deleteBtn" id="${D.diary_no}">${D.diary_no}삭제</button>
					</td>
				</tr>			
				<tr class="dimg">
					<td rowspan="3">
						<c:if test="${empty D.diary_image}">
							<img alt="${D.diary_no}의 이미지" src="${ pageContext.servletContext.contextPath }/resources/images/diary/noimage.jpg">
						</c:if>
						<c:if test="${!empty D.diary_image}">
							<img alt="${D.diary_no}의 이미지" src="${ pageContext.servletContext.contextPath }/resources/diary_upfile/${D.diary_image}">
						</c:if>
					</td>
					<th id="dtime">
						<h3> 🍴 &nbsp;<fmt:formatDate value="${D.diary_post_date}" type="date" pattern="a HH:mm" /></h3>
					</th>
				</tr>
				<tr>
					<td>
						<table class="E">
							<c:forEach var="eat" items="${eats}">
								<c:if test="${eat.diary_no eq D.diary_no}">
									<tr>
										<td>
											<b>${eat.food_code}</b> &nbsp; ${eat.eat_g}g &nbsp; &nbsp; &nbsp; &nbsp;
										</td>
										<td>
											⇒ ${eat.eat_kcal} kcal 
										</td>
									</tr>
									<tr>
										<td colspan="2" class="even-row">
											↳ 탄수화물 ${eat.eat_carbohydrate}g &nbsp; 단백질 ${eat.eat_protein}g &nbsp; 지방 ${eat.eat_fat}g &nbsp;&nbsp;
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</table>
					</td>
				</tr>
				<tr class="etotal">			
					<td>
						<label>
							총 탄수화물 <span id="car">${sum.eat_carbohydrate}</span>g &nbsp; 
							총 단백질<span id="pro">${sum.eat_protein}</span>g &nbsp; 
							총 지방 <span id="fat" >${sum.eat_fat}</span>g &nbsp; &nbsp;
							 &nbsp; &nbsp; ⇒ <span id="kcal">${sum.eat_kcal}</span>
						</label>
					</td>
				</tr>
				<tr class="dmemo">
					<td colspan="2">
						<textarea rows="5" cols="100">${D.diary_memo}</textarea>
					</td>
				</tr>
			</table>
		</div><!-- class="D" -->
		<br>
		<br>
	</c:forEach>
</div>	<!-- id="eatPart" -->	
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
				<td><img alt="탄수화물관련 이미지" src="${ pageContext.servletContext.contextPath }/resources/images/diary/noimage.jpg"></td>
				<td><img alt="단백질관련 이미지" src="${ pageContext.servletContext.contextPath }/resources/images/diary/noimage.jpg"></td>
				<td><img alt="단백질관련 이미지" src="${ pageContext.servletContext.contextPath }/resources/images/diary/noimage.jpg"></td>
			</tr>			
			</table>
			</c:if>		
		</c:forEach>
</c:if> <!-- diary yes -->
</div><!--  diaryPart-->
</div><!--  mainContain-->

<div id="footer">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</div>
</body>
</html>