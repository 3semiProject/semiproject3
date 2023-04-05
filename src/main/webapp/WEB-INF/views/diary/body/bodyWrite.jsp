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
<!-- diary_showBodyWrite.do -> bodyWrite : 체형다이어리 작성화면
받은값 diary : 어떤날짜에 누가 작성하는건지


	이미지입력
	메모입력
	체형값 4가지 입력 : 체중, 체지방량, 골격근량, 허리둘레
	
보낼값 diary, body
	저장버튼 -> diary_insertBody.do 
			->insertDiary, selectOneDiary, 
			insertOneBody -> diary_showBody.do -> bodyView -->
	<div id="all">
	<!-- 입력 및 저장  -->
	<!-- 하단값은 입력값에 맞춰 출력ajax -->
		<!-- body minbox  -->
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>BMI</h3>
				<label><input class="a" type="text" size=1 maxlength=4 value="${ body.body_bmi }"></label>
				<br> <a>${ body.bmilevel }</a> &nbsp;
			</div>
		</div>
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>Bmr</h3>
				<label><input class="a" type="text" size=1 maxlength=4 value="${ body.body_bmr }"></label>
			</div>
		</div>
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>체중</h3>
				<label><input class="a" type="text" size=1 maxlength=4 value="${ body.body_weight }">kg</label>
				<br> <a>${ body.weightlevel }</a> &nbsp;
			</div>
		</div>
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>체지방량</h3>
				<label><input class="a" type="text" size=1 maxlength=4 value="${ body.body_fat }">g</label>
				<br> <a>${ body.fatlevel }</a> &nbsp;
			</div>
		</div>
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>골격근량</h3>
				<label><input class="a" type="text" size=1 maxlength=4 value="${ body.body_muscle }">g</label>
				<br> <a>${ body.musclelevel }</a> &nbsp;
			</div>
		</div>
		<div id="minBox" class="lineBox">
			<br>
			<div class="textBox">
				<h3>허리둘레</h3>
				<label><input class="a" type="text" size=1 maxlength=4 value="${ body.body_waistline }">cm</label>
				<br> <a>${ body.waistlinelevel }</a> &nbsp;
			</div>
		</div>
		<div id="minBox"></div>
		<!-- Image Box -->
		<!-- 첨부하고싶은 사진을 등록 하고 저장 -->
		<div id="imageBox" class="lineBox">
			<div id="image">
				<br>
				<h1>image</h1>
			<img src="${ diary.diary_image }">
			<!--  <img src="${ pageContext.servletContext.contextPath }/resources/images/photo2.jpg"> -->
			<input type=""file" name="upfile">
			</div>
		</div>
		<!-- 메모를 입력하고 저장 -->
		<!-- Memo Box -->
		<div>
			<a id="memo">Memo</a>
			<center>
				<textarea class="memobox"
					style="width: 480px; height: 170px; font-size: 11px;" maxlength=587>${ diary.diary_memo }</textarea>
			</center>
		</div>
		<!-- 글쓰기완료 버튼 -->
		<footer>
			<input type="submit" value="저장">
		</footer>
	</div>

</body>
</html>