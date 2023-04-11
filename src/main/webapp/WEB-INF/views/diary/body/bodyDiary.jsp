<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
/* 바디다이어리 출력용 */
div#bodyPart{
	height: 80%;
	min-height: 100%;
	align-items: center;
	display: flex;
	flex-direction: column;
	justify-content: center;
	font-family: Copperplate, Papyrus, fantasy;
}
div.button{
	float: right;
}
.modifybtn{
	width: 55px;
	height: 30px;
	border: 1px solid #827482;
	background-color: white;
	color: #827482;
	border-radius: 7px;
}
div.bodyBox>div{
	width: 100px;
	height: 100px;
	float: left;
	margin: 12px;
	border-radius: 18px;
	border: 1px solid #827482;
	font-weight: bold;
	text-align: center;
}

div.bodyBox>div>h4{
	margin: 5px 0px 12px 0px;
}

div.bodyBox>div>input{
	width: 40px;
	height: 20px;
	border: 0;
	font-size: 15px;
	border-bottom: 1.2px solid black;
	text-align: center;
}

div.bodyBox>div>input:focus {
	outline: none;
}

div.imageBox>img{
	width: 750px;
	height: 500px;
}
div.memobox>textarea{
	height: 150px;
	border: 1.2px solid black;
	width: 750px;
	font-size: 15px;
	margin: 20px;
	padding: 10px;
}

</style>
<style type="text/css">
/* bar들 중앙정렬 */
.vars {
   		display: flex;
   		flex-direction: column;
   		justify-content: center;
   }
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
$(function(){
	$('.writebtn').on('click', function (){
		window.location.href = 'diary_showBodyWrite.do';
		
	});//writebtn
	$('#bodyPart').on('click', '.modifyBtn',function (){
		var dn = $(this).attr('id');
		window.location.href = 'diary_showBodyModify.do?diary_no='+dn;
	});//modifyBtn
});//document.ready
</script>
</head>
<body>
	<br><c:import url="/WEB-INF/views/common/menubar.jsp" /> <!--메인 메뉴바-->
	<br><c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp" /><!--다이어리 메뉴바-->
<br>
<div class="vars">
<div class="calendar">
	<form action="" id="moveCalendar">
	<input type="date" id="calendarDate" name="diary_post_date" value="${diary.diary_post_date}">
	<input type="hidden" name="user_id" value="${diary.user_id}">	
	<input type="hidden" name="diary_category" value="${diary.diary_category}">
	</form>
	<script type="text/javascript">
	$(function() {
		  var previousDate = $('#calendarDate').val(); //현재페이지 날짜 저장

		  $('#calendarDate').on('change', function(event) {
		    var selectedDate = $(this).val(); // 새로 선택된 날짜 저장

		    if (selectedDate !== previousDate) { // 이전에 선택된 날짜와 값이 다른 경우에만 폼 전송
		      var formData = new FormData();
		      formData.append("diary_no", ${diary.diary_no});
		      formData.append("diary_post_date", selectedDate); // 새로 선택된 날짜 사용
		      submit(formData);
		      
		      var xhr = new XMLHttpRequest();
		      xhr.open('POST', 'diary_bodyCalendar.do');
		      xhr.send(formData);
		    }
		    }); //calendar event
		  });//doc.ready
	</script>
    <br>
</div>
<div class="navigation">
	<div>
		<img id="img_today" alt="today 강조" src="${ pageContext.servletContext.contextPath }/resources/images/diary/today.jpg">
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
    <a href="diary_moveDiary.do?week=${diary.diary_post_date}&ago=1">
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
<br><br>
</div>
<%-- 		${body}<br> ${compare}<br> ${diary}<br> --%>
<div id="bodyPart">
<c:if test="${diary.diary_no eq 0}">
		<div class="noneD">
			<h3>다이어리가 없네요, 작성하시겠습니까?</h3>
			<div>
				<button class="writebtn" name="${diary.diary_post_date}">글쓰기</button>
			</div>
		</div>
	</c:if>
	<c:if test="${diary.diary_no ne 0}">

		<!-- body minbox  -->
		<div class="bodyBox">
				<div>
					<h4>BMI</h4>
					<input name="body_bmi" readonly value="${ body.body_bmi }"><br>
					${compare.body_bmi}
				</div>			
				<div >
					<h4>Bmr</h4>
					<input name="body_bmr" readonly value="${ body.body_bmr }"><br>
				</div>			
				<div >
					<h4>체중</h4>
					<input name="body_weight" readonly value="${ body.body_weight }">kg <br>
					${ compare.body_weight }
				</div>			
				<div >
					<h4>체지방량</h4>
					<input name="body_fat" readonly value="${ body.body_fat }">g <br>
					${ compare.body_fat}
				</div>			
				<div >
					<h4>골격근량</h4>
					<input name="body_muscle" readonly value="${ body.body_muscle }">g<br>
					${ compare.body_muscle }
				</div>			
				<div >
					<h4>허리둘레</h4>
					<input  name="body_waistline" readonly value="${ body.body_waistline }">cm <br>
					${ compare.body_waistline }
				</div>
		</div>
		<!-- Image Box -->
		<!-- 등록된 사진 출력 -->
		<div class="imageBox">
			<c:if test="${ empty diary.diary_image }">
				<img
					src="${ pageContext.servletContext.contextPath }/resources/images/diary/noimage2.jpg" />
			</c:if>
			<c:if test="${ !empty diary.diary_image }">
				<img src="${ pageContext.servletContext.contextPath }/resources/diary_upfile/${ diary.diary_image }">
			</c:if>
		</div>
		<!-- 등록된 메모 출력 -->
		<!-- Memo Box -->
		<div class="memobox">
			<textarea>${ diary.diary_memo }</textarea>
		</div>
		<div class="button"><button class="modifyBtn" id="${diary.diary_no}">수정</button></div>
	</c:if>	
	</div>
	<br>
	<div id="footer">
		<c:import url="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>