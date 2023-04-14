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
div#eatPart {
	font-family: dfont;
}
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
/* 기본버튼 */
button {
	white-space: nowrap;
	height: 35px;
	min-width: 45px;
	padding: 5px 10px;
	border: none;
	background: #f3f3f4;
	color: #0d0c22;
	border-radius: 8px;
	text-align: center;
	font-size: 12px;
	font-weight: 500;
	line-height: 20px;
	box-sizing: border-box;
}

button:hover, button:focus {
	background-color: #c0e488;
}
/* 모든 input 기본 */
input {
	outline: none;
	text-align: center;
	border: 0px;
}
input:hover, input:focus {
	outline: none;
}

div.searchD {
	height: 500px;
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

table.S {
	border-collapse: collapse;
	text-align: center;
	width: 900px;
	padding: 10px 10px;
}
/* 검색테이블 밑줄, input제거 */
table.S tr {
	border-bottom: 1px solid rgba(92, 148, 13, 0.5);
	text-align: center;
	height: 40px;
}
table.S th,td {
	text-align: center;
	width: 80px;
}

.searchD tr td:eq(0) {
	width:40px;
}
table.S th#foodname {
	text-align: center;
	width: 130px;
}
td.foodname{
      font-weight: bold;
      font-size: larger;
	width: 130px;
	color: #18210a;
}

div.scroll {
 height: 400px;
 overflow-x: hidden;
}

/*  */

div.guide {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0px 50px 20px 50px;
}

span.guide {
	margin-right: auto;
	font-size: 8pt;
}

.guide>lable.keyword {
	font-size: 12pt;
	margin-left: auto;
}

.guide>lable.eatG {
	font-size: 12pt;
	margin-right: auto;
}

/* 식단목록 */
#eatList.foodname{
	font-size: 13px;
	font-weight: 600px;
}

#eatList tr {

}

#selectBtn {
	margin-left: auto;
}
#calendarDate{
	height: 30px;
	width: 200px;
	text-align: center;
	font-size: 12pt;
	text-weight: 200px
	border: 0px;
	border-bottom: 2px solid rgba(92, 148, 13, 0.5);
}
div.guide input {
	text-align: center;
	font-size: 12pt;
	border: 0px;
	border-bottom: 2px solid rgba(92, 148, 13, 0.5);
}

div.guide input:focus, input:hover {
	outline: none;
	font-size: 12pt;
	border-bottom: 2px solid rgba(92, 148, 13, 0.5);
}

#searchFood {
	height: 70px;
	width: 120px;
	border: 0px;
	background: white;
}

div#noneList {
	padding: 30px;
	height: 100px;
}

.hide {
	display: none;
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

div.dbtn{
	margin: auto;
	width: 900px;	
}
button#beforeBtn{
white-space: nowrap;
float: left;
}
button#saveBtn{
	white-space: nowrap;
}
tr.dbtn td{
	text-align: right;
	padding: 0px 30px 0px 0px;
}

/* 시간 */
th#dtime {
	text-align: left;
	padding: 0px 0px 0px 35px;
	height: 20px;
}
#dtime input:hover{
outline: none;
font-size: 13.3px;

}

tr.dimg {
	width: 500px;
	border-bottom: 2px solid rgba(92, 148, 13, 0.5);
}

.dimg img {
	width: 350px;
	height: 350px;
	border-radius: 27px;
}

tr.etotal {
	border-top: 2px solid rgba(92, 148, 13, 0.5);
	height: 50px;
	text-align: left;
	font-size: 9pt;
}

tr.etotal td {
	padding: 0px 35px;
}

span#kcal {
	font-size: 17pt;
	font-weight: bold;
}

tr.dmemo {
	text-align: center;
	height: 150px;
}

#eatList{
	text-align: left;
	width: 500px;
	padding: 0px 25px 0px 35px;
}

#eatList tr.even-row {
	font-size: 8px;
	padding-bottom: 20px;
}

table.dtotal {
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

table.T {
	width: 750px;
	text-align: center;
	margin: auto;
}

table.T th {
	height: 40px;
	vertical-align: bottom;
}

table.T td {
	height: 240px;
	vertical-align: top;
	padding: 0px 0px 20px 0px;
}
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
a.tabs.left{
	background : #c0e488;
}


</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>

<!--1. 전역변수 선언, 버튼 이벤트 -->
<script type="text/javascript"> 
$(function(){
	var dn = ${diary_no};
	var sessionUserId = "${sessionScope.loginMember.user_id}";
	//var sessionUserId = "USER01";
	console.log(sessionUserId);
	if(sessionUserId==null){
		window.location.href="login.do?";
	}
});

$(function(){
	$('#eatList').on('click', '.removeBtn', removeEat);
	
	$('#calendarDate').on('change', function(event){
		var movedate = $(this).val();
		window.location.href = 'diary_eatCalendar.do?no'+${diary_no} +'&movedate='+movedate;
	});//calendarDate
	
});//document.ready
</script>
<!--2.이미지 3.날짜와 시간 -->
<script type="text/javascript">
//2. 이미지
//----- 프로필 이미지 미리보기 관련 function ----------
//FileReader() 객체는 비동기적으로 파일의 내용을 읽어들이는 데 사용
const reader = new FileReader();
function changeImg(input) {
	if(input.files && input.files[0]) {	
	reader.onload = e => {
	//이미지 src변경
	const previewImage = document.getElementById("showimg");
      previewImage.src = e.target.result;
      console.log(previewImage.src);
  }	
	//이미지 읽기
	reader.readAsDataURL(input.files[0]);
	}
}

//3. 날짜와 시간입력 : 
$(function(){
//calendar 및 식사시간 현재시간 표시	
	var now = new Date();
	  var year = now.getFullYear();
	  var month = (now.getMonth() + 1).toString().padStart(2, "0");
	  var day = now.getDate().toString().padStart(2, "0");
	  var hour = now.getHours().toString().padStart(2, "0");
	  var minute = now.getMinutes().toString().padStart(2, "0");
	  var datetimeString = year + "-" + month + "-" + day + "T" + hour + ":" + minute;
	  var calendarString = year + "-" + month + "-" + day;
  	//요소에 시간적용
	  //$("#nowdate").val(datetimeString);
	  $("#calendarDate").val(calendarString);

});//document.ready
</script>
<!-- 4.음식검색  -->
<script type="text/javascript">
//4. 음식검색목록조회
$(function(){
	$('#searchBtn').on('click', function (){
	//keyword 변수에 할당, 기존목록, keyword, 섭취량, 가이드 지우기
	var keywordValue = $('#keyword').val();
	var eatGValue = $('#eatG').val();
	$('#keyword').html();
	$('#eatG').html();
	$('#foodList').html("");
	noneGuide('N');
	//ajax로 food 테이블조회, 함수 실행
	$.ajax({
			url : "diary_searchFoodAjax.do",
			type : "post",
			dataType: "json", 
			data : { food_name : keywordValue },
			success : function(dataObj){
				console.log(dataObj);
				var objStr = JSON.stringify(dataObj);//문자로
				var jsonObj = JSON.parse(objStr);//객체로				
				addFoodList(jsonObj.foodlist); //목록작성 함수실행					
				console.log(jsonObj.foodlist);
				if(jsonObj.foodlist.length===0){
				noneGuide('Y');	//결과없음 함수실행
				}
			},
			error : function(request, status, errorData){
				console.log("error code : " + request.status
						+ "\nMessage : " + request.responseText
						+ "\nError : " + errorData);
			}
		}); //search ajax
	});//searchFood
});//document.ready
//4-1. 음식목록 띄우기
function noneGuide(yn){
	var nonelist = $('#noneList');
	if(yn==="Y"){
		nonelist.show();				
	}else{
		nonelist.hide();					
	}
}
function addFoodList(foods){	
	var tableBody = document.getElementById("foodList");
	for (var i = 0; i < foods.length; i++) {
	    var food = foods[i];
	    var row = tableBody.insertRow(-1);
	    var check = row.insertCell();
	    var td1 = row.insertCell();
	    var td2 = row.insertCell();
	    var td3 = row.insertCell();
	    var td4 = row.insertCell();
	    var td5 = row.insertCell();
	    var td6 = row.insertCell();
    
	check.innerHTML = "<input type='radio' name='checkFood'>";
	td1.textContent  = decodeURIComponent(food.food_code).replace(/\+/gi,' ');
    td1.classList.add('hide');
    td2.textContent  = decodeURIComponent(food.food_name).replace(/\+/gi, ' ');
    td2.classList.add('foodname');
    td3.textContent  = food.food_kcal;
    td4.textContent  = food.food_carbohydrate;
    td5.textContent  = food.food_protein;
    td6.textContent  = food.food_fat;
	}
}
</script>
<!-- 5.선택음식 식단에 추가, 삭제 -->
<script type="text/javascript">
//전역변수
var selectedEat = new Array();

//5. 선택한 음식 배열에 담기, 식단에추가
function addEatlist(){
	var radio = $("input[name=checkFood]:checked");
	console.log("버튼");
	//radio 미선택시 돌아가기
	 if (radio.length === 0) {
          alert("선택된 음식이 없습니다.");
          return false;        }
	//음식 중복확인
	var td = radio.parent().parent().children();
	var addCode=td.eq(1).text();
	
	for (var i = 0; i < selectedEat.length; i++) {
		  if (selectedEat[i].food_code === addCode) {
			alert("이미 식단에 등록된 음식입니다.");
			return false;
		}
	}	
	 //식사량 미입력시 확인창, 체크시 묻지 않고 0으로 입력
	 var zeroCheck = $('#zeroCheck');
	 var eatG = $('#eatG').val();
	 console.log(eatG);
	 
	  if(eatG === "" || eatG === null|| eatG === undefined ) {
		  if(zeroCheck.prop('checked')){
			  eatG=0;	

		  }else{
			 if(confirm("입력된 식사량이 없습니다. kcal가 0으로 계산됩니다. 음식이름만 추가하시겠습니까?")===false){
				 return false;				 
			 }else{
			  eatG=0;	
				zeroCheck.prop('checked', true);            	 
			 }				  
		  }
	 }	 	 
	 //배열생성 값 입력
	 	var dn = ${diary_no};
	 	var eat = new Object;
	 	eat.diary_no =dn;
	 	//eat.eat_seq = ;
	 	eat.eat_g = eatG;
	 	eat.food_code = td.eq(1).text();
	 	eat.food_name = td.eq(2).text();
	 	eat.eat_kcal = Math.round(td.eq(3).text() * eatG / 100)
	 	eat.eat_carbohydrate = Math.round(td.eq(4).text() * eatG / 100)
	 	eat.eat_protein = Math.round(td.eq(5).text() * eatG / 100)
	 	eat.eat_fat = Math.round(td.eq(6).text() * eatG / 100)
	 selectedEat.push(eat);
	 	console.log(eat);
	 
	 //식단목록에 추가
	var tableBody = document.getElementById("eatList"); 
	    var row1 = tableBody.insertRow(-1);
	    var td0 = row1.insertCell();
	    var td1 = row1.insertCell();
	    var td2 = row1.insertCell();
	    var td3 = row1.insertCell();
	    
	    var row2 = tableBody.insertRow(-1);
	    row2.classList.add('even-row');
	    var td4 = row2.insertCell();
	    var td5 = row2.insertCell();
	    var td6 = row2.insertCell();
	    var td7 = row2.insertCell();
    
	td0.textContent  = eat.food_code ;
    td0.classList.add('hide');
    td1.textContent  = eat.food_name ;
    td1.classList.add('foodname');
    td2.textContent  = eatG + "g";
    td3.textContent  = " ⇒ "+Math.round(eat.eat_kcal * eatG / 100) +"kcal";
    td4.textContent  = "↳ 탄수화물 " + Math.round(eat.eat_carbohydrate * eatG / 100) + "g";
    td4.classList.add('guide');
    td5.textContent  = ", 단백질 " + Math.round(eat.eat_protein * eatG / 100) + "g";
    td5.classList.add('guide');
    td6.textContent  = ", 지방 " + Math.round(eat.eat_fat * eatG / 100) + "g";
    td6.classList.add('guide');
    td7.innerHTML = "<button type='button' class='removeBtn'>➖</button>";
    
    //총합계값 구하기
    calSum();
    console.log("합계변경");
}
//6. 식단목록, 배열에서 지우는 함수
function removeEat(event) {
  console.log("삭제전"+selectedEat.length);
  // 선택한 <tr> 엘리먼트가 속한 selectedEat 배열의 인덱스 계산
    var rowToDelete = event.target.closest('tr');
    var rowIndex = rowToDelete.rowIndex;
    var prevRowIndex = rowIndex - 1;
  // 선택한 <tr>과 이전행 삭제
//HTML DOM요소 사용해야함, jquery로 수정금지, 함수밖 선언 금지
	var tableBody = document.getElementById("eatList"); 
    tableBody.deleteRow(rowIndex);
    tableBody.deleteRow(prevRowIndex);
  // selectedEat 배열에서 선택한 요소 삭제
  selectedEat.splice((rowIndex/2 - 1), 1); 
  console.log("삭제후"+selectedEat.length);
  calSum();
}

//7. form -> ajax전송
function insertDiary(){
	var form = $('#eatWriteForm')[0];
	var formData = new FormData(form);
	console.log("diary save" +$('#dateD').val());

	//전송
	var successfleg =null;
	$.ajax({
		  type: "post",
		  url: "diary_insertDiary.do",
		  processData: false,
		  contentType: false,
		  data: formData, // FormData 객체를 전송
		  success: function(response){
		    console.log(response);
			submitActs();		
		  },
		  error: function(xhr, status, error){
		    console.log(xhr +", "+status+ ", " + error);
		    alert("다이어리 작성에 실패했습니다. 다이어리화면으로 이동합니다.");
		    window.location.href = 'diary_showEatDiary.do?diary_no='+ ${diary_no};
		  }
		}); //ajax
		
    

} //submit

function submitActs(){
	console.log('select[0] : ' + selectedEat[0]);
	//전송
	$.ajax({
		  type: "post",
		  url: "diary_insertEatWrite.do",
		  data: JSON.stringify(selectedEat),
		  processData: false,
		  contentType: "application/json; charset=utf-8",
		  success: function(response){
		    console.log(response);
		    alert("다이어리 작성 성공! 다이어리화면으로 이동합니다.");
		    window.location.href = 'diary_showEatDiary.do?diary_no='+ ${diary_no};
		  },
		  error: function(xhr, status, error){
		    console.log(xhr +", "+status+ ", " + error);
		    alert("식단다이어리 작성에 실패했습니다. 다이어리화면으로 이동합니다.");
		    window.location.href = 'diary_showEatDiary.do?diary_no='+ ${diary_no};
		  }
		}); //ajax
		
		
} //submitActs

//총합계구하는 함수
var sum = {
  eat_carbohydrate: 0,
  eat_protein: 0,
  eat_fat: 0,
  eat_kcal: 0
};
function calSum(){	
	for (var i = 0; i < selectedEat.length; i++) {
		sum.eat_carbohydrate += selectedEat[i].eat_carbohydrate;
		sum.eat_protein += selectedEat[i].eat_protein;
		sum.eat_fat += selectedEat[i].eat_fat;
		sum.eat_kcal += selectedEat[i].eat_kcal;
	}
	$('#car').html(sum.eat_carbohydrate);
	$('#pro').html(sum.eat_protein);
	$('#fat').html(sum.eat_protein);
	$('#kcal').html(sum.eat_kcal +"Kcal");
	console.log($('#nowdate').val());
}
</script>
</head>
<body>

<div id="mainContain">
	<br>
		<c:import url="/WEB-INF/views/common/menubar.jsp" /> <!--메인 메뉴바-->
	<br>
		<c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp"/> <!--다이어리 메뉴바-->
	<br>
<div class="vars">
	<div class="calendar">
		<input type="date" id="calendarDate" value="">
		<br>
	</div>
	<br>
	<div class="tabs">
 			<a class="tabs left" href="diary_showEatWrite.do?">식단</a>
 			<a class="tabs center" href="diary_showActWrite.do?">운동</a>
 			<a class="tabs right" href="diary_showBodyWrite.do?">체형</a>
	</div>
</div>

<div id="diaryPart">
	<br>
	<div class="dbtn">
			<button type="button" class="beforeBtn" onclick="history.go(-1);">← Back</button>
	</div>
<div id="eatPart">
	<div class="D">
		<form id="eatWriteForm">		
			<table class="D">
				<tr class="dbtn">
					<td colspan="3">
						<button type="button" class="saveBtn" onclick="insertDiary();">저장</button>
						<input type="hidden" name="user_id" value="${sessionScope.loginMember.user_id}" required/>
						<input type="hidden" name="diary_category" value="eat" required/>
						<input type="hidden" name="diary_no" value="${diary_no}" required/>
					</td>
				</tr>			
				<tr class="dimg">
					<td rowspan="3">
					
						<img id="showimg" alt="$이미지파일 미리보기" src="${ pageContext.servletContext.contextPath }/resources/images/diary/noimage.jpg">
						
						<div class="upload">
							<label class="upload">
								<input style="width: 70px;" type="file" name="upfile" onchange="changeImg(this);" />
							</label>
						</div>				
					</td>
					<th id="dtime">
						<h3> 🍴 식사시간 &nbsp;<input id="nowdate" name="diary_post_date"  value="" type="date" required/>
						<input id="Time" name="dateTime" value="" type="time" required/></h3>
					</th>
				</tr>
				<tr>
					<td>
						<table id="eatList" class="E">
				
						</table>
					</td>
				</tr>
				<tr class="etotal">
					<td>
						<label>
							총 탄수화물 <span id="car"></span>g &nbsp; 
							총 단백질<span id="pro"></span>g &nbsp; 
							총 지방 <span id="fat" ></span>g &nbsp; &nbsp;
							 &nbsp; &nbsp; ⇒ <span id="kcal"></span>
						</label>
					</td>						
				</tr>
				<tr class="dmemo">
					<td colspan="2">
						<textarea name="diary_memo" rows="5" cols="100"></textarea>
					</td>
				</tr>
			</table>
		</form>		
	</div><br><br>
			<div class="searchD">
				<div class="guide">
					<label class="keyword">
							<input id="keyword" type="text" placeholder="음식이름을 검색하세요.">
							<button type="button" id="searchBtn">🔍</button>
					</label>
					<label class="eatG">
							<input class="guide" type="checkBox" id="zeroCheck">
							<span class="guide"> * 식사량이 0이면 kcal는 0으로 계산됩니다.</span>			
					</label>
					<label>
							<input id="eatG" type="number" step="1" placeholder="0">g
							<button id="selectBtn" onclick="addEatlist();">➕</button>
					</label>
				</div>
				<table class="S">
					<tr>
						<th>check</th>
						<th class="hide">음식코드</th>
						<th id="foodname">음식이름</th>
						<th>섭취칼로리<span class="guide">/100g</span></th>
						<th>탄수화물<span class="guide">/100g</span></th>
						<th>단백질<span class="guide">/100g</span></th>
						<th>지방<span class="guide">/100g</span></th>
					</tr>
				</table>			
				<div class="hide" id="noneList" align="center">
							<h4>${keywordValue}</h4>
							조회된 결과가 없습니다. 다시 검색해주세요.
				</div>
				<div class="scroll">
					<table class="S" id="foodList">
						<tr></tr>
						<tr></tr>
						<tr></tr>
						<tr></tr>
					</table>
				</div>
			</div><!--  searchD-->
		</div><!--  eatPart-->
	</div><!--  diaryPart-->
</div><!--  mainContain-->
<div id="footer">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</div>
</body>
</html>