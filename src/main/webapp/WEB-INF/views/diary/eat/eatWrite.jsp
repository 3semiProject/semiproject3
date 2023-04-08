<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write</title>
<style type="text/css">
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

div {
	border: 1px solid green;
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
$(function(){
	//식사시간에 현재시간 띄우기
	document.getElementById('currentTime').value = 
		new Date().toISOString().slice(11, 16);

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
				
				var outtable = "<tr><th>저장</th><th>음식이름</th><th>식사량 입력</th><th>섭취kcal량</th><th>탄수화물함량</th><th>단백질함량</th><th>지방함량</th></tr>";
				for(var i in jsonObj.foodlist){
				outtable += "<tr><td>"
				+'<input type="radio" name="user_CheckBox"></td><td>'
				+decodeURIComponent(jsonObj.foodlist[i].food_name).replace(/\+/gi,' ') + "</td><td>"
				+'<input type="number" value=""/></td><td>'
				+jsonObj.foodlist[i].food_kcal + "</td><td>" 
				+jsonObj.foodlist[i].food_carbohydrate + "</td><td>"
				+jsonObj.foodlist[i].food_protein + "</td><td>"
				+jsonObj.foodlist[i].food_fat + "</td></tr>";
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
$(function(){
	$('#selectBtn').on('click', function(e){
		var radio = $("input[name=user_CheckBox]:checked");
		console.log("버튼");
		 if (radio.length === 0) {
	            alert("선택된 음식이 없습니다.");
	            return;
	        }
		var dNo = ${diary.diary_no};
		
 		var tdArr = new Array();
		var tr = radio.parent().parent();
		var td = tr.children();
		var s_name = td.eq(1).text();
		var s_g    = td.eq(2).children().val();
		
		var s_kcal= td.eq(3).text() *s_g;
		var s_car = td.eq(4).text() *s_g;
		var s_pro = td.eq(5).text() *s_g;
		var s_fat = td.eq(6).text() *s_g;
		
		var eat = { diary_no : dNo,
				food_code : s_name,
				eat_g: s_g,
				eat_kcal: s_kcal,
				eat_carbohydrate : s_car,
				eat_protein : s_pro,
				eat_fat :s_fat
			}
		
		var divString = '<div class="E">' +
		'<form>' +
		'<label>' +
		'<input name="food_name" type="text" value="' + s_name + '">' +
		'<input name="eat_g" type="number" value="' + s_g + '">g ' +
		'&nbsp; ⇒<input name="eat_kcal" type="number" value="' + s_kcal+ '">kcal' +
		'</label><br>' +
		'<label>' +
		'⇒탄수화물 <input name="eat_carbohydrate" type="number" value="' + s_car+ '">g ' +
		'&nbsp; ⇒단백질 <input name="eat_protein" type="number" value="' +s_pro + '">g ' +
		'&nbsp; ⇒지방 <input name="eat_fat" type="number" value="' + s_fat + '">g &nbsp;' +
		'</label>' +
		'<input type="submit" value="삭제" onclick="deleteEat();">' +
		'</form>' +
		'</div>';
		
		console.log("객체생성 : "+ dNo);
		$('#eatBox').append(divString);

		}); //button
	
}); //document.ready
</script>

	<div id="eatPart">
	<p>
	${diary}
	</p>
	<br>
		diary_showEatWrite.do -> eatWrite : 식단다이어리 작성화면 받은값 diary : 어떤날짜에 누가
		작성하는건지
				<!-- 첫화면에 띄울 현재시간
				저장시 기존 다이어리 날짜값과 수정된 time값을 각각 스트링으로 만들어서 합치고
				 문자타입(오라클 날짜형식 맞추기)으로 diary update 할때 넘기기 -->
			<div id="left">
				<div class="timeBox">
					<label>식사시간 : <input name="time" type="time" id="currentTime" value="" /></label>
				</div>
				<div id="eatBox">
				<!-- search에서 음식이름 클릭하면 addEatDiv : ajax 구동 				
				<!-- 삭제 클릭하면 해당 div.E 만 삭제되는 ajax 구동: 이름,g, g*eat_kcal -->
					<div class="E">
						<form>
						<label>
							<input name="food_name" type="text"value="음식이름">
							<input name="eat_g" type="number" value="100" />g 
							&nbsp; ⇒<input name="eat_kcal" type="number" value="0" />kcal
						</label><br>
						<label>
								⇒탄수화물 <input name="eat_carbohydrate" type="number" value="0" />g 
							&nbsp; ⇒단백질 <input name="eat_protein" type="number" value="0" />g
							&nbsp; ⇒지방 <input name="eat_fat" type="number" value="0" />g &nbsp;
						</label>
						
						<input type="submit" value="삭제" onclick="deleteEat();">
						</form>
					</div>
				</div>

				<div class="delBox">
					<input type="reset" value="삭제">
				</div>
				
				<!-- 반복문으로 div.E 내의 모든 합계값 구해서 입력해야함  -->
				<div class="totalBox">
					<label>총 섭취 칼로리 &nbsp; <input name="eat_total"
						type="number" id="eat_total" value="" />kcal
					</label>
				</div>
			</div>
			<div class="right">
				<!-- 이미지입력되면 event인식해서 changeImage()의 ajax 실행됨 -->
				<input id="diary_image" name="diary_image" type="file" value="" />
				<img id="showimg"alt="diary_image미리보기" src="">
			</div>

			<div class="searchBox">
				<!-- 음식이름 검색하면 하단에 목록보여짐
					음식이름에 addEatDiv ajax 링크걸기 -->
				<input id="search_name" type="search" value=""
					placeholder="음식 이름을 검색하세요" />
				<button id="searchF">검색</button>
				
				<div id="foodList">
					* 식사량이 0이면 kcal계산이 불가능합니다. 0으로 입력하려면 체크하세요.
					<input type="checkbox" name="user_CheckBox" ><br>
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

			<div class="memoBox">
				<label>Memo : <br> <textarea id="memo" name="diary_memo"></textarea></label>
			</div>
			<!-- diary_no를 넘겨서 이미 생성된 다이어리에 update : 시간, 메모 -->
			<br> <input type="button" value="저장" onclick="updateDiary();">

		식단삭제 식단추가 ; ajax 음식검색용기능 음식이름-> -> ajax : food -> 음식 추가, kcal계산시 사용
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>