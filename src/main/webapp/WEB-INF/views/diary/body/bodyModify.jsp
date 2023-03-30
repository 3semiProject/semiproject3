<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
div.lineBox {
	border-bottom: 1px;
	float: left;
	position: relative;
	background-color: #ffffff;
}

div#all {
	margin: auto;
	display:table
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
<h2>
diary_showBodyModify -> bodyModify : 체형다이어리 수정화면
</h2>
받은값 diary : 어떤날짜에 누구의 어떤 다이어리를 수정하는건지
	body : 화면에 띄울 기존 다이어리 정보


입력	이미지수정
	메모수정
	체형 4가지 수정
	
	저장버튼 -> diary_modifyBody.do 
		-> updateOneDiary, insertBody, updateBody
		-> diary_showBody.do -> bodyView : 체형 다이어리 보기

보낼값 diary, body

	<div id="all">
		<!-- body minbox  -->
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>BMI</h3>
				<label><input class="a" type="text" size=1 maxlength=4></label>
				<br> <a>미달</a> &nbsp;
			</div>
		</div>
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>Bmr</h3>
				<label><input class="a" type="text" size=1 maxlength=4></label>
			</div>
		</div>
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>체중</h3>
				<label><input class="a" type="text" size=1 maxlength=4>kg</label>
				<br> <a>미달</a> &nbsp;
			</div>
		</div>
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>체지방량</h3>
				<label><input class="a" type="text" size=1 maxlength=4>g</label>
				<br> <a>표준</a> &nbsp;
			</div>
		</div>
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>골격근량</h3>
				<label><input class="a" type="text" size=1 maxlength=4>g</label>
				<br> <a>미달</a> &nbsp;
			</div>
		</div>
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>허리둘레</h3>
				<label><input class="a" type="text" size=1 maxlength=4>cm</label>
				<br> <a>미달</a> &nbsp;
			</div>
		</div>
		<div id="minBox">
		</div>
		<!-- Image Box -->
		<div id="imageBox" class="lineBox">
			<div id="image">
				<br>
				<h1>image</h1>
			</div>
		</div>
		<!-- Memo Box -->
		<div>
			<a id="memo">Memo</a>
			<center>
				<textarea class="memobox" style="width: 480px; height: 170px; font-size: 11px;" maxlength=587></textarea>
			</center>
		</div>
		<!-- 수정 버튼 -->
		<footer>
			<button onclick="Page()">수정</button>
		</footer>
	</div>

</body>
</html>