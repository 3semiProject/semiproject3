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

div.lineBox {
   height: 100px;
   border-bottom: 1px;
   float: left;
   position: relative;
   left: 100px;
   margin: 5px;
   padding: 3px;
   background-color: #ffffff;
   text-align: right;
}
div.A{
width: 75%; height: 150px;
}

div#textmove {
   text-align: left;
   width: 300px;
   height: 0px;
   position: relative;
   top: 60%;
   left: 45%;
   transform: translate(-50%, -50%);
   border-bottom: 0.1em solid grey;
   
}

div#totmove {
   text-align: left;
   width: 300px;
   height: 0px;
   position: relative;
   top: 60%;
   left: 45%;
   transform: translate(-50%, -50%);
   border-top: 0.1em solid grey;
   
}

div.textBox {
   padding: 5px 10px;
   text-align: center;
   position: absolute;
   top: 50%;
   left: 50%;
   transform: translate(-50%, -50%);
   width: 100px;
   height: 70px;
}

div.textmove>input{
   font-size: 15px;
   border-bottom: 1.2px solid black;
   text-align: center;
   background-color: #e7e7e9;
}
div.memobox>textarea{
	height: 150px;
	border: 1.2px solid black;
	width: 750px;
	font-size: 15px;
	margin: 20px;
	padding: 10px;
}
input:focus {
   outline: none;
}

body {
   font-family: Copperplate, Papyrus, fantasy;
   text-align: justify;
   font-weight: bold;
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
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
$(function(){
	$('.writebtn').on('click', function (){
		var act_date = $(this).attr("name");
		window.location.href = 'diary_showActWrite.do?diary_post_date='+act_date;
		
	});//writebtn
	
	$('#eatPart').on('click', '.modifyBtn',function (){
		 var dn = $(this).attr('id');
		window.location.href = 'diary_showActModify.do?diary_no='+dn;
		
	});//modifyBtn
});//document.ready
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
</div><!--  -->
<div id="diaryPart">
	<br>
<c:if test="${diary.diary_no eq 0}">
		<div class="noneD">
			<h3>다이어리가 없네요, 작성하시겠습니까?</h3>
			<div>
				<button class="writebtn" name="${diary.diary_post_date}">글쓰기</button>
				
			</div>
		</div>
	</c:if>
	<c:if test="${diary.diary_no ne 0}">
	<br>
	<div class="A">
      <c:forEach var="A" items="${acts}" varStatus="status">
         <div id="textmove">
            <a>${A.move_code }</a> &nbsp; 
            <input name="act_mm" readonly value="${A.act_mm }"/>
			<a>분(m)=></a> &nbsp; ${A.act_kcal }<a>kcal</a>
         </div>
	  </c:forEach>
	  <script type="text/javascript">
	  	var result = ${acts};
	  	var sum;
	  	for(act a: result){
	  		sum+= a.act_kcal;
	  	}
	  </script>
         <div id="totmove">
            <a>총 소모칼로리 =></a> &nbsp; ${sum} <a>kcal</a>
         </div>
       </div>
      <!-- 등록된 사진 출력 -->
		<div class="imageBox">
			<c:if test="${ empty diary.diary_image }">
				<img
					src="${ pageContext.servletContext.contextPath }/resources/images/diary/noimage2.jpg" />
			</c:if>
			<c:if test="${ !empty diary.diary_image }">
				<img src="${ diary.diary_image }">
			</c:if>
		</div>
      <!-- Memo Box -->
		<div class="memobox">
			<textarea>${ diary.diary_memo }</textarea>
		</div>
		<div class="button"><button class="modifyBtn" id="${diary.diary_no}">수정</button></div>
	</c:if>
</div>   
<hr>
<div id="footer">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</div>
</body>
</html>