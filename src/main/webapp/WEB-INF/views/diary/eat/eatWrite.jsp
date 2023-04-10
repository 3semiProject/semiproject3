<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
 href="${ pageContext.servletContext.contextPath }/resources/css/vars.css" >
<link rel="stylesheet" type="text/css"
 href="${ pageContext.servletContext.contextPath }/resources/css/diarytab.css" >
<link rel="stylesheet" type="text/css"
 href="${ pageContext.servletContext.contextPath }/resources/css/button_div.css" >
<title>write</title>
<style type="text/css">
div#diaryPart{
	height: 80%;
	min-height: 100%;
	align-items: center;
	display: flex;
	flex-direction: column;
	justify-content: center;
	font-family: Copperplate, Papyrus, fantasy;
	margin: auto;
   	display: table
}
div#eatBox{
height: 300px;
width: 900px;

}
div .#eatpart {
	margin: auto;
	width: 900px;
	color: inherit;
	font-weight: 400;
	box-sizing: border-box;
}

div#foodlist table {
	border: 1px solid green;
}

div.E{
width: 900px;
height: 50px;
}
div {
	border: 1px solid green;
}
textarea{
	height: 150px;
	border: 1.2px solid black;
	width: 750px;
	font-size: 15px;
	margin: 20px;
	padding: 10px;
}
button {
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
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<!--메인 메뉴바-->
	<br>
	<c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp" />
	<br><!--다이어리 메뉴바-->
	<hr>
<script type="text/javascript">
//전역변수 선언 
var user_id = '${diary.user_id}';
var diary_post_date = '${diary.diary_post_date}';
var diary_no = '${diary.diary_no}';
$(function(){
//kcal 합계 구하기 : 추가예정
$('#eat_total').val(100);
//작성일, 식사시간에 현재시간 띄우기
var now = new Date();
document.getElementById('eatTime').value = now.toISOString().slice(11, 16);

//음식이름 검색이벤트
 	$('#searchF').on('click', function (){
	//검색창에 음식이름을 입력하면
	//유사한이름의 음식목록이 드롭다운됨
	//음식이름 보내고 food 테이블 받아오기 : 한글 인코딩, 디코딩해야함!!!
	//테이블은 안보였다가 결과값 있으면 드롭다운	
		$.ajax({
			url : "diary_searchFoodAjax.do",
			type : "post",
			dataType: "json", 
			data : { food_name : $('#search_name').val() },
			success : function(dataObj){
				console.log("음식검색"+ dataObj);
				var objStr = JSON.stringify(dataObj);//문자로
				var jsonObj = JSON.parse(objStr);//객체로
				
				var outtable = "<tr><th>저장</th><th>음식이름</th><th>식사량 입력</th><th>섭취kcal량</th><th>탄수화물함량</th><th>단백질함량</th><th>지방함량</th><th>음식코드</th></tr>";
				for(var i in jsonObj.foodlist){
				outtable += "<tr><td>"
				+'<input type="radio" name="user_CheckBox"></td><td>'
				+decodeURIComponent(jsonObj.foodlist[i].food_name).replace(/\+/gi,' ') + "</td><td>"
				+'<input type="number" value=""/></td><td>'
				+jsonObj.foodlist[i].food_kcal + "</td><td>" 
				+jsonObj.foodlist[i].food_carbohydrate + "</td><td>"
				+jsonObj.foodlist[i].food_protein + "</td><td>"
				+jsonObj.foodlist[i].food_fat + "</td><td>"
				+jsonObj.foodlist[i].food_code + "</td></tr>";
				}
				//++테이블 보이게 설정하는 코드추가 : $('#foodList>table') visable
				$('#foodList>table').html(outtable);
			},
			error : function(request, status, errorData) {
				//jqXHR:request, textStatus: status, errorThrown :errorData
	          console.log("error code : " + request.status
	                   + "\nMessage : " + reqeust.response
	                   +"\nError : " + errorData);
	       }
		}); //ajax
 	}); // searchFood event
 
}); //document.ready
</script>
<script type="text/javascript">
//기존에 등록된 운동은 추가 못하게 중복체크 : 추가예정
$(function(){
	$('#selectBtn').on('click', function(e){
		var radio = $("input[name=user_CheckBox]:checked");
		console.log("버튼");
		 if (radio.length === 0) {
	            alert("선택된 음식이 없습니다.");
	            return;
	        }
		//list 리셋
		var outtable = "<tr><th>저장</th><th>음식이름</th><th>식사량 입력</th><th>"
		+"섭취kcal량</th><th>탄수화물함량</th><th>단백질함량</th><th>지방함량</th></tr>";
		$('#foodList>table').html(outtable);
		
 		var tdArr = new Array();
		var tr = radio.parent().parent();
		var td = tr.children();
		var s_name = td.eq(1).text();
		var s_g    = td.eq(2).children().val();
		 if (s_g === null) {
			 if(confirm("입력된 식사량이 없습니다. kcal가 0으로 계산됩니다. 0으로 입력하시겠습니까?")===false){
	            return false;				 
			 }
	        }
		var s_kcal= td.eq(3).text();
		var s_car = td.eq(4).text();
		var s_pro = td.eq(5).text();
		var s_fat = td.eq(6).text();
		var s_code = td.eq(7).text();
		
		//div 추가
		//readonly 설정 상태 : g 변경시 다른 값도 변경되게 계산식으로 설정해야함 : 추가예정
		var divString = '<div class="E">' +'<label>' +
		'<input name="food_code" type="hidden" value="' + s_code + '" readonly>' +
		'<input name="food_name" type="text" value="' + s_name + '" readonly>' +
		'<input name="eat_g" type="number" value="' + s_g + '" step="1" readonly >g ' +
		'&nbsp; ⇒<input name="eat_kcal" type="number" value="' + Math.round(s_kcal *s_g/100) + '"readonly>kcal' +
		'</label><br>' + '<label>' +
		'⇒탄수화물 <input name="eat_carbohydrate" type="number" value="' + Math.round(s_car *s_g/100) + '" readonly>g ' +
		'&nbsp; ⇒단백질 <input name="eat_protein" type="number" value="' + Math.round(s_pro *s_g/100) + '" readonly>g ' +
		'&nbsp; ⇒지방 <input name="eat_fat" type="number" value="' + Math.round(s_fat *s_g/100) + '" readonly>g &nbsp;' +
		'</label>' + '<button type="button" class="delEat">➖</button></div>';
		
		$('#eatBox').append(divString);

		}); // + button		
		
		//#eatBox에 이벤트 추가, 버튼이 들어있는 divE 삭제
		$('#eatBox').on('click', '.delEat', function(){
			$(this).parent().remove();
		}); // - button
	
}); //document.ready
</script>

<script type="text/javascript">
function addEats(){
	//값 추출하기	& 객체 생성 및 배열 추가
	var eats = new Array();
	$('.E').each(function(index) {
		var e = new Object;
		e.diary_no = diary_no;
		e.eat_seq = index +1 ;
		e.food_code = $(this).find('input[name="food_code"]').val();
		e.eat_g = $(this).find('input[name="eat_g"]').val();
		e.eat_kcal = $(this).find('input[name="eat_kcal"]').val();
		e.eat_carbohydrate = $(this).find('input[name="eat_carbohydrate"]').val();
		e.eat_protein = $(this).find('input[name="eat_protein"]').val();
		e.eat_fat = $(this).find('input[name="eat_fat"]').val();
			
	eats.push(e);
	}); //for in문
	console.log(JSON.stringify(eats));

	//작성ajax
	    $.ajax({
		      url: 'diary_insertEatWrite.do',
		      type: "post",
		      data: JSON.stringify(eats),
		      processData: false,
		      contentType: "application/json; charset=utf-8",
		      success: function() {
		        console.log("succest : eats");
		        alert("다이어리가 작성되었습니다. 다이어리 보기 페이지로 이동합니다.");
		        window.location.href = 'diary_showEatDiary.do?diary_no='+diary_no;
		      },
		      error: function(request, status, errorData){
					console.log("error code : " + request.status
							+ "\nMessage : " + request.responseText
							+ "\nError : " + errorData);
		      }
		    });
} //addEats
</script>
<script type="text/javascript">
$(function() {
	  $("#diaryF").on("submit", function(event) {
		  console.log($('input[name="eat_protein"]').val());
	event.preventDefault();
	var formData = new FormData($('#diaryF')[0]);
	    $.ajax({
	      url: 'diary_insertWrite.do',
	      type: 'POST',
	      data: formData,
	      processData: false,
	      contentType: false,
	      success: function() {
	        alert("성공");
	        addEats();
	      },
	      error: function(error) {
	        console.log(error);
	        alert("다이어리 작성에 실패했습니다.다이어리 보기 화면으로 이동합니다.");
	        window.location.href = 'diary.do';
	      }
	    });
	  });
	});
</script>
<script type="text/javascript">
//----- 프로필 이미지 미리보기 관련 function ----------
//FileReader() 객체는 비동기적으로 파일의 내용을 읽어들이는 데 사용
const reader = new FileReader();

function changeImg(input) {
	if(input.files && input.files[0]) {	
	reader.onload = e => {
	//이미지 src변경
	const previewImage = document.getElementById("showimg_eat");
      previewImage.src = e.target.result;
      console.log(previewImage.src);
  }	
	//이미지 읽기
	reader.readAsDataURL(input.files[0]);
	}

}
</script>
<div id="eatPart">
	<p>${diary}</p>
				<!-- 첫화면에 띄울 현재시간
				저장시 기존 다이어리 날짜값과 수정된 time값을 각각 스트링으로 만들어서 합치고
				 문자타입(오라클 날짜형식 맞추기)으로 diary update 할때 넘기기 -->
			<div id="left">
				<div id="eatBox">
				<!-- search에서 음식이름 클릭하면 addEatDiv : ajax 구동 				
				<!-- 삭제 클릭하면 해당 div.E 만 삭제되는 ajax 구동: 이름,g, g*eat_kcal -->
				</div>
				<!-- 반복문으로 div.E 내의 모든 합계값 구해서 입력해야함  -->
				<div class="totalBox">
					<label>총 섭취 칼로리 &nbsp; <input name="eat_total" type="number" id="eat_total" value="" />kcal </label>
				</div>
			</div>


			<div class="searchBox">
				<!-- 음식이름 검색하면 하단에 목록보여짐
					음식이름에 addEatDiv ajax 링크걸기 -->
				<input id="search_name" type="search" value=""
					placeholder="음식 이름을 검색하세요" />
				<button id="searchF">검색</button>
				
				<div id="foodList">
					* 식사량이 0이면 kcal는 0으로 계산됩니다.
					* 식사량을 입력한 뒤 추가버튼을 눌러주세요. &nbsp; &nbsp; &nbsp; 
							<button type="button" id="selectBtn">➕</button>
					<table id="list">
						<tr><th>저장</th><th>음식이름</th><th>식사량 입력</th><th>섭취kcal량</th><th>탄수화물함량</th><th>단백질함량</th><th>지방함량</th></tr>
						<tr>
							<td><input type="radio" name="user_CheckBox"></td>
							<td>음식이름</td>
							<td><input type="number" value="3"/></td>							
							<td>100</td>
							<td>100</td>
							<td>100</td>
							<td>100</td>
						</tr>
					</table>
				</div>
			</div>
		<form id="diaryF" action="diary_insertWrite.do" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="user_id" value="${diary.user_id}">
			<input type="hidden" name="diary_no" value="${diary.diary_no}">
			<input type="hidden" name="diary_category" value="${diary.diary_category}">
			<div class="timeBox">
			<input type="hidden" name="" value="">
				<label>날짜 : <input name="diary_post_date" type="date" value="${diary.diary_post_date}" pattern="yyyy-MM-dd"/></label>
				<label>식사시간 : <input name="time" type="time" id="eatTime" value="" pattern ="hh:mm a"/></label>
			</div>
			<div class="right" align="center" style="margin: 0; padding: 0; display: flex;">
				<!-- 이미지입력되면 event인식해서 changeImage() function 실행됨 -->
				<div>
					<img id="showimg_eat" style="height: 90px; width: 110px; border-radius: 25px; border: 2px solid #D1D1D1;"
						src="${ pageContext.servletContext.contextPath }/resources/images/diary/noimage.jpg" alt="선택이미지 미리보기" />
				</div>
				<div>
					<input style="width: 70px;" type="file" id="profile" name="upfile" onchange="changeImg(this);" />
				</div>
			</div>
			<div class="memoBox">
				<label>Memo : <br> <textarea id="memo" name="diary_memo"></textarea></label>
			</div>
			<br>
			<!-- 다이어리에 : 시간, 메모, 이미지파일 -->
			<input type="submit" value="저장">
		</form>
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>