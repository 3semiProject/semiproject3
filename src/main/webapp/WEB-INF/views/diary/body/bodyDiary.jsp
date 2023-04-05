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
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">

$(function(){
	
	var bmiLv = null;
/* 	var cbmi = $( BODY_WEIGHT ) / $( GOAL.HEIGHT ) / $( GOAL.HEIGHT );
	if(cbmi < 18.5){
		bmiLv = "저체중";
	} else if(18.5 =< cbmi < 25) {
		bmiLv = "정상";
	} else if(25 =< cbmi < 30) {
		bmiLv = "경도비만";
	} else if(30 =< cbmi < 35) {
		bmiLv = "중도비만";
	} else if(35 =< cbmi < 40) {
		bmiLv = "고도비만";
	} else if(40 =< cbmi) {
		bmiLv = "초고도비만";
	} else {
		bmiLv = " ";
	}
 */
	$('#bmilevel').text("테스트확인용");
});// document.ready

</script>
<style type="text/css">
/* ul{
padding: 0;}
ol{
padding:0;}
ol li{
display: inline-block;
}
#footer {
    position: relative;
    transform: translateY(-100%);
}  */



div.lineBox {
	border-bottom: 1px;
	float: left;
	position: relative;
	background-color: #ffffff;
}

div#all {
	margin: auto;
	display: table
}

div#imageBox {
	border-radius: 10px;
	border: 1.5px solid black;
	padding: 30px;
	width: 407px;
	height: 300px;
	left: 2%;
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
	font-size: .5em;
	font-weight: bold;
}

input.a {
	font-size: .2em;
	border: 0;
	border-bottom: 1.2px solid black;
	text-align: justify
}

input:focus {
	outline: none;
}

body {
	font-family: Copperplate, Papyrus, fantasy;
	text-align: justify;
}

div#minBox {
	margin: 10px;
	border-radius: 10px;
	border: 1.5px solid black;
	padding: 12px;
	width: 35px;
	height: 32px;
}

div#image {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	height: 70px;
	font-size: .5em;
}

a#memo {
	font-size: 15px;
	margin: 20px;
	font-weight: bold;
}

.memobox {
	border: 1.3px solid black;
	margin: 3px;
	resize: none;
	outline: none;
	background-color: #f5f5f5
}

footer {
	text-align: center;
}

</style>
</head>
<body>
<%-- <br><c:import url="/WEB-INF/views/common/menubar.jsp" /> <!--메인 메뉴바-->
<br><c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp" /> <!--다이어리 메뉴바-->
<br><c:import url="/WEB-INF/views/diary/common/weekBar.jsp" />		<!--날짜이동바-->
<br><c:import url="/WEB-INF/views/diary/common/diaryTap.jsp" />		<!--식단/운동/식단 탭-->
<br><c:import url="/WEB-INF/views/diary/common/target.jsp" />		<!--목표 표시-->
<hr>

<h2> diary_showBody.do -> bodyView : 체형다이어리 보기</h2>
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
<hr> --%>
<div id="all">
	<!-- 입력값은 db에 저장  -->
	<!-- 하단값은 입력값에 맞춰 출력 -->
		<!-- body minbox  -->
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>BMI</h3>
				<label><input class="a" name="vbmi" type="text" size=1 maxlength=4 readonly value="${ body.body_bmi }"></label>
				<br> <label type="text" name="bmiLv">asdf</label> &nbsp;
				<!-- 체중/키제곱 -->
				<!-- ~18.5저체중 ~24.9정상 ~29.9경도비만 ~34.9중도비만 ~39.9고도비만 초고도비만40~ -->
			</div>
		</div>
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>Bmr</h3>
				<!-- 체지방량 입력시 -->
				<!-- 370 + 21.6*(몸무게-체지방량) -->
				<!-- 남성이며 체지방량 미입력시 -->
				<!-- 66+(13.8*몸무게)+(5*키*100)-(6.8*나이) -->
				<!-- 여성이며 체지방량 미입력시 -->
				<!-- 655+(9.6*몸무게)+(1.8*키*100)-(4.7*나이) -->
				
				<label><input class="a" name="vbmr" type="text" size=1 maxlength=4 readonly value="${ body.body_bmr }"></label>
			</div>
		</div>
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>체중</h3>
				<label><input class="a" name="vweight" type="text" size=1 maxlength=4 readonly value="${ body.body_weight }">kg</label>
				<br> <a type="text" name="weightLv">${ body.weightlevel }</a> &nbsp;
				<!-- 현재체중/표준체중 -->
				<!-- ~1.2정상 ~1.3경도비만 ~1.5중도비만 고도비만1.5~ -->
			</div>
		</div>
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>체지방량</h3>
				<label><input class="a" name="vfat" type="text" size=1 maxlength=4 readonly value="${ body.body_fat }">g</label>
				<br> <a type="text" name="fatLv">${ body.fatlevel }</a> &nbsp;
				<!-- 체지방량/체중*100 -->
				<!-- 남성 -->
				<!-- ~14.9부족 ~24.9표준 과다31~ -->
				<!-- 여성 -->
				<!-- ~24.9부족 ~34.9표준 과다41~ -->
			</div>
		</div>
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>골격근량</h3>
				<label><input class="a" name="vmuscle" type="text" size=1 maxlength=4 readonly value="${ body.body_muscle }">g</label>
				<br> <a type="text" name="muscleLv">${ body.musclelevel }</a> &nbsp;
				<!-- 남성 : ~31.9부족, ~37.9표준, 충분38.0~ -->
				<!-- 여성 : ~26.4부족, ~32.4표준, 충분32.5~ -->
			</div>
		</div>
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>허리둘레</h3>
				<label><input class="a" name="vwaistline" type="text" size=1 maxlength=4 readonly value="${ body.body_waistline }">cm</label>
				<br> <a type="text" name="waistlineLv">${ body.waistlinelevel }</a> &nbsp;
				<!-- 남성 : 저0.43, 정상0.53, 과체중0.58, 비만1 -->
				<!-- 여성 : 저0.42, 정상0.49, 과체중0.54, 비만1 -->
			</div>
		</div>
		<div id="minBox"></div>
		<!-- Image Box -->
		<!-- 등록된 사진 출력 -->
		<div id="imageBox" class="lineBox">
			<div id="image">
				<br>
				<h1>image</h1>
			<img src="${ diary.diary_image }">
			<!--  <img src="${ pageContext.servletContext.contextPath }/resources/images/photo2.jpg"> -->
			</div>
		</div>
		<!-- 등록된 메모 출력 -->
		<!-- Memo Box -->
		<div>
			<a id="memo">Memo</a>
			<center>
				<textarea class="memobox"
					style="width: 480px; height: 170px; font-size: 11px;" maxlength=587 readonly>${ diary.diary_memo }</textarea>
			</center>
		</div>
		<footer>
			<!-- 체형 클릭시 게시물이 없는 경우 -->
			<c:if test="${ empty sessionScope.diaryno }">
				<div>
					<!-- 글쓰기 페이지로(bodyWrite) 이동 버튼 -->
					<c:url var="bmoveup" value="/bmoveup.do">
						<c:param name="diaryno" value="${ diary.diary_no }" />
					</c:url>
					<button onclick="javascript:location.href='${ bmoveup }';">글쓰기</button>
				</div>
			</c:if>
			<!-- 체형 클릭시 게시물이 있는 경우 -->
			<c:if test="${ !empty sessionScope.diaryno }">
				<div>
					<!-- 수정 페이지(bodyModify)로 이동 버튼 -->
					<c:url var="bmoveup" value="/bmoveup.do">
						<c:param name="diaryno" value="${ diary.diary_no }" />
					</c:url>
					<button onclick="javascript:location.href='${ bmoveup }';">수정하기</button>
					<!-- 삭제하기 버튼 -->
					<c:url var="bdel" value="/bdel.do">
						<c:param name="diaryno" value="${ diary.diary_no }" />
						<c:param name="rfile" value="${ body.rename_filepath }" />
					</c:url>
					<button onclick="javascript:location.href='${ bdel }';">삭제하기</button>
				</div>
			</c:if>
		</footer>
	</div>
<%-- <div id="footer">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</div> --%></body>
</html>