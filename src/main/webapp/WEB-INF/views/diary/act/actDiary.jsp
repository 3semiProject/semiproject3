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

div#all {
	margin: auto;
	display: table
}

div#imageBox {
	border-radius: 10px;
	border: 1.5px solid black;
	padding: 15px;
	width: 170px;
	height: 170px;
	text-align: right;
	margin-left: 280px;
	margin-right: 150px;
	margin-bottom: 35px;
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

input.a {
	font-size: .2em;
	border: 1.5px solid grey;
	text-align: justify;
	background-color: #e2e2e2;
}

a#memo {
	font-size: 15px;
	margin: 20px;
	font-weight: bold;
	margin-top: 35px;
	margin-left: 110px;
}

input:focus {
	outline: none;
}

.memobox {
	text-align: justify;
	border: 1.3px solid black;
	resize: none;
	outline: none;
}

body {
	font-family: Copperplate, Papyrus, fantasy;
	font-size: .5em;
	text-align: justify;
	font-weight: bold;
}

a {
	font-size: 20px;
}
/* ul{
padding: 0;}
ol{
padding:0;}
ol li{
display: inline-block;
}
#footer {
    position: relative;
    transform: translatY(-100%);
}  */
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
	//운동추천 화면출력용 ajax
	//diary_showActRec.do실행
	//
</script>
</head>
<body>
<%-- <br><c:import url="/WEB-INF/views/common/menubar.jsp" /> <!--메인 메뉴바-->
<br><c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp" /> <!--다이어리 메뉴바-->


<br><c:import url="/WEB-INF/views/diary/common/weekBar.jsp" />		<!--날짜이동바-->
<br><c:import url="/WEB-INF/views/diary/common/diaryTap.jsp" />		<!--식단/운동/식단 탭-->
<br><c:import url="/WEB-INF/views/diary/common/goalBar.jsp" />		<!--목표 표시-->
<hr>

<h2> diary_showAct.do -> actDiaryView : 운동다이어리 보기</h2>
보낼값 : ${ diary}
<br>${acts}



<div>
<ul><li><ol>
	<li>운동이름 : ${act[0].actname}</li>
	<li>운동한 시간 : ${act[0].act_mm}</li>
	<li>소모 칼로리 : ${act[0].act_kacl}</li>
</ol></li></ul>

<ul><li><ol>
	<li>운동이름 : ${act[1].actname}</li>
	<li>운동한 시간 : ${act[1].act_mm} }</li>
	<li>소모 칼로리 : ${act[1].act_kacl} }</li>
</ol></li></ul>
</div>
<hr>
<div>
운동추천 ajax화면
</div>
<pre>
글쓰기버튼 ->ActWrite : 운동다이어리 작성
	시간입력
	이미지입력
	메모입력
	운동추가 : ajax 운동이름 검색기능 name 
			-> diary_serarchMove.do ->ajax: move 
			-> 운동추가, var에 담아뒀다가 분입력되면 kcal계산식에 사용
	저장버튼 -> diary_insertAct.do ->insertDiary, insertOneAct * n -> diary_showAct.do
	 
수정버튼 ->ActModify : 운동다이어리 수정
	시간수정
	이미지수정
	메모수정
	운동삭제
	운동추가
	운동수정
	ajax 운동이름 검색기능 name 
			-> diary_serarchMove.do ->ajax: move 
			-> 운동추가, var에 담아뒀다가 분입력되면 kcal계산식에 사용
	저장버튼 -> diary_modifyAct.do -> updateDiary, insertOneAct, updateOneAct, deleteOneAct -> diary_showAct.do
	삭제버튼 -> 운동다이어리 삭제 diary_delAct.do ->deleteDiary, deleteOneAct -> diary_showAct.do


</pre>
<hr> --%>
	<div id="all">
		<!-- 운동 추가시 -->
		<div style="width: 75%; height: 150px;">
			<br> <br> <br> <br>
			<div id="textmove">
				<a>운동1</a> &nbsp; <label><input class="a" type="text" size=1
					maxlength=3></label> <a>분(m)=></a> &nbsp; <a>00kcal</a>
			</div>
			<br> <br> <br>
			<div id="textmove">
				<a>운동2</a> &nbsp; <label><input class="a" type="text" size=1
					maxlength=3></label> <a>분(m)=></a> &nbsp; <a>00kcal</a>
			</div>
			<br> <br> <br>
			<div id="textmove">
				<a>운동3</a> &nbsp; <label><input class="a" type="text" size=1
					maxlength=3></label> <a>분(m)=></a> &nbsp; <a>00kcal</a>
			</div>
			<br> <br> <br> <br> <br>

			<div id="totmove">
				<a>총 소모칼로리 =></a> &nbsp; <a>kcal</a>
			</div>
		</div>
		<div id="imageBox" class="lineBox">
			<br>
			<div class="textBox">
				<br>
				<h2>image</h2>
			</div>
		</div>
		<div>
			<a id="memo"> Memo</a>
			<center>
				<textarea class="memobox"
					style="width: 430px; height: 80px; font-size: 0.5em;"></textarea>
			</center>
		</div>
	</div>
<div id="footer">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</div>
</body>
</html>