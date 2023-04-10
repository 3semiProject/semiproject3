<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
div#actBox{
height: 300px;
width: 900px;

}
div.A{
width: 900px;
height: 50px;
}
div .#actPart {
	margin: auto;
	width: 900px;
	color: inherit;
	font-weight: 400;
	box-sizing: border-box;
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
</head>
<body>
<script type="text/javascript">
//전역변수 선언 
var user_id = '${diary.user_id}';
var diary_post_date = '${diary.diary_post_date}';
var diary_no = '${diary.diary_no}';
$(function(){
	//kcal 합계 구하기 : 추가예정
$('#act_total').val(100);
//작성일, 식사시간에 현재시간 띄우기
var now = new Date();
document.getElementById('actTime').value = now.toISOString().slice(11, 16);
//작성일에 이미 다이어리가 존재하면 수정화면으로 이동 안내창띄우기
// diary_post_date 값 변경 시 중복 체크
  $('input[name="diary_post_date"]').on('change', function() {
    var diary_post_date = $(this).val();
    var user_id = $('input[name="user_id"]').val();
    $.ajax({
      url: 'diary_checkDuplicateDiary.do',
      method: 'POST',
      data: {
    	diary_category = "act";
        diary_post_date: diary_post_date,
        user_id: user_id,
        diary_no: diary_no
      },
      success: function(data) {
        if (data == 'ok') {    	
    	  console.log("성공" + data);
        }else{
        	if (confirm('해당 일자의 다이어리가 이미 존재합니다. 다이어리화면으로 이동합니다.')){
        		  // 수정 페이지로 이동
        		  window.location.href = 'diary_showActDiary.do?diary_no=' + data;
        		  
        		} else {
        		  // 작성화면으로 되돌아감
        		  $('input[name="diary_post_date"]').val('${ diary.diary_post_date }');
        		}          
        }
      }, //success
      error : function(request, status, errorData) {
			//jqXHR:request, textStatus: status, errorThrown :errorData
        console.log("error code : " + request.status
                 + "\nMessage : " + request.responseText
                 +"\nError : " + errorData);
     }
    }); //ajax
  }); //date change



//운동이름 검색이벤트
	$('#searchM').on('click', function (){
	//검색창에 운동이름을 입력하면
	//유사한이름의 운동목록이 드롭다운됨
	//운동이름 보내고 move 테이블 받아오기 : 한글 인코딩, 디코딩해야함!!!
	//테이블은 안보였다가 결과값 있으면 드롭다운	
		$.ajax({
			url : "diary_searchMoveAjax.do",
			type : "post",
			dataType: "json", 
			data : { move_name : $('#search_move').val() },
			success : function(dataObj){
				console.log("운동검색"+ dataObj );
				var objStr = JSON.stringify(dataObj);//문자로
				var jsonObj = JSON.parse(objStr);//객체로					
				var outtable="<tr><th>저장</th><th>운동이름</th><th>운동량 입력</th><th>운동강도</th><th>Met계수</th><th>운동코드</th></tr>";
					for(var i in jsonObj.movelist){
					outtable += "<tr><td>"
					+'<input type="radio" name="user_CheckBox"></td><td>'
					+decodeURIComponent(jsonObj.movelist[i].move_name).replace(/\+/gi,' ') + "</td><td>"
					+'<input type="number" value=""/></td><td>'
					+decodeURIComponent(jsonObj.movelist[i].move_intensity).replace(/\+/gi,' ') + "</td><td>"
					+jsonObj.movelist[i].move_met + "</td><td>"
					+decodeURIComponent(jsonObj.movelist[i].move_code).replace(/\+/gi,' ') + "</td><td>";
					}
				//검색 결과가 존재할때와 존재하지 않을때
				/* 	}
				if(jsonObj && jsonObj.length > 0){ 
				}else{
					outtable += "<tr><th>검색결과가 없습니다. 다시 조회해 주세요</th></tr>";
				} */
				//++테이블 보이게 설정하는 코드추가 : $('#moveList>table') visable
				$('#moveList>table').html(outtable);
			},
			error : function(request, status, errorData) {
				//jqXHR:request, textStatus: status, errorThrown :errorData
	          console.log("error code : " + request.status
	                   + "\nMessage : " + reqeust.response
	                   +"\nArror : " + errorData);
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
	            alert("선택된 운동이 없습니다.");
	            return;
	        }		
		//list 리셋
		var outtable = "<tr><th>저장</th><th>운동이름</th><th>운동량 입력</th><th>운동강도</th><th>Met계수</th><th>운동코드</th></tr>";
		$('#moveList>table').html(outtable);
		
 		var tdArr = new Array();
		var tr = radio.parent().parent();
		var td = tr.children();
		var s_name = td.eq(1).text();
		var s_mm    = td.eq(2).children().val();
		 if (s_mm === null) {
			 if(confirm("입력된 운동량이 없습니다. kcal가 0으로 계산됩니다. 0으로 입력하시겠습니까?")===false){
	            return false;				 
			 }
	        }
		var s_kcal= Math.round(td.eq(4).text() *s_mm);
		var s_code = td.eq(5).text();
		
		//div 추가
		//readonly 설정 상태 : g 변경시 다른 값도 변경되게 계산식으로 설정해야함 : 추가예정
		var divString = '<div class="A">' +'<label>'+
		'<input name="move_code" type="hidden" value="' + s_code + '" readonly>' +
		'<input name="move_name" type="text" value="' + s_name + '" readonly>' +
		'<input name="act_mm" type="number" value="' + s_mm + '" step="1" readonly>g ' +
		'&nbsp; ⇒<input name="act_kcal" type="number" value="' + s_kcal+ '" step="1" readonly>kcal' +
		'<button type="button" class="delAct">➖</button></label></div>';
		
		$('#actBox').append(divString);

		}); // + button
		
		
		//#actBox에 이벤트 추가, 버튼이 들어있는 divA 삭제
		$('#actBox').on('click', '.delAct', function(){
			$(this).parent().parent().remove();
		}); // - button
	
}); //document.ready
</script>

<script type="text/javascript">
function addActs(){
	//값 추출하기	& 객체 생성 및 배열 추가
	var acts = new Array();
	$('.A').each(function(index) {
		var a = new Object;
		a.diary_no = diary_no;
		a.act_seq = index +1 ;
		a.move_code = $(this).find('input[name="move_code"]').val();
		a.act_mm = parseInt($(this).find('input[name="act_mm"]').val());
		a.act_kcal =parseInt($(this).find('input[name="act_kcal"]').val());
	acts.push(a);
	}); //for in문
	console.log(JSON.stringify(acts));

	//작성ajax
	    $.ajax({
		      url: 'diary_insertActWrite.do',
		      type: "post",
		      data: JSON.stringify(acts),
		      processData: false,
		      contentType: "application/json; charset=utf-8",
		      success: function() {
		        console.log("succest : acts");
		        alert("다이어리가 작성되었습니다. 다이어리 보기 페이지로 이동합니다.");
		        window.location.href = 'diary_showActDiary.do?diary_no='+diary_no;
		      },
		      error: function(request, status, errorData){
					console.log("error code : " + request.status
							+ "\nMessage : " + request.responseText
							+ "\nError : " + errorData);
		      }
		    });
} //addActs
</script>
<script type="text/javascript">
$(function() {
	  $("#diaryM").on("submit", function(event) {
		  console.log($('input[name="move_code"]').val());
	event.preventDefault();
	var formData = new FormData($('#diaryM')[0]);
	    $.ajax({
	      url: 'diary_insertWrite.do',
	      type: 'POST',
	      data: formData,
	      processData: false,
	      contentType: false,
	      success: function() {
	        alert("성공");
	        addActs();
	      },
	      error: function(error) {
	        console.log(error);
	        alert("다이어리 작성에 실패했습니다.다이어리 보기 화면으로 이동합니다.");
	        window.location.href = 'diary.do;
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
	const previewImage = document.getElementById("showimg_act");
      previewImage.src = e.target.result;
      console.log(previewImage.src);
  }	
	//이미지 읽기
	reader.readAsDataURL(input.files[0]);
	}

}
</script>
<div id="actPart">
	<p>
	${diary}
	</p>
	<br><div id="left">
				<div id="actBox">
				<!-- search에서 운동이름 클릭하면 addActDiv : ajax 구동 				
				<!-- 삭제 클릭하면 해당 div.A 만 삭제되는 ajax 구동: 이름,g, g*act_kcal -->

				</div>
				<!-- 반복문으로 div.A 내의 모든 합계값 구해서 입력해야함  -->
				<div class="totalBox">
					<label>총 소모 칼로리 &nbsp; <input name="act_total" type="number" id="act_total" value="" />kcal </label>
				</div>
			</div>


			<div class="searchBox">
				<!-- 운동이름 검색하면 하단에 목록보여짐
					운동이름에 addActDiv ajax 링크걸기 -->
				<input id="search_move" type="search" value=""
					placeholder="운동 이름을 검색하세요" />
				<button id="searchM">검색</button>
				
				<div id="moveList">
					* 운동량이 0이면 kcal는 0으로 계산됩니다.
					* 운동량을 입력한 뒤 추가버튼을 눌러주세요. &nbsp; &nbsp; &nbsp; 
							<button type="button" id="selectBtn">➕</button>
					<table id="movelist">
						<tr><th>저장</th><th>운동이름</th><th>운동량 입력</th><th>운동강도</th><th>Met계수</th><th>운동코드</th></tr>
						<tr>
							<td><input type="radio" name="user_CheckBox"></td>
							<td>검도</td>
							<td><input type="number" value="3"/></td>							
							<td>고</td>
							<td>6</td>
							<td>M000007</td>
						</tr>
					</table>
				</div>
			</div>
		<form id="diaryM" action="diary_insertWrite.do" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="user_id" value="${diary.user_id}">
			<input type="hidden" name="diary_no" value="${diary.diary_no}">
			<input type="hidden" name="diary_category" value="${diary.diary_category}">
			<div class="timeBox">
			<input type="hidden" name="" value="">
				<label>날짜 : <input name="diary_post_date" type="date" value="${diary.diary_post_date}" pattern="yyyy-MM-dd"/></label>
				<label>운동시간 : <input name="time" type="time" id="actTime" value="" pattern ="hh:mm a"/></label>
			</div>
			<div class="right" align="center" style="margin: 0; padding: 0; display: flex;">
				<!-- 이미지입력되면 event인식해서 changeImage() function 실행됨 -->
				<div>
					<img id="showimg_act" style="height: 200px; width: 200px; border-radius: 25px; border: 2px solid #D1D1D1;"
						src="${ pageContext.servletContext.contextPath }/resources/images/diary/noimage.jpg" alt="선택이미지 미리보기" />
				</div>
				<div>
					<input style="width: 70px;" type="file" name="upfile" onchange="changeImg(this);" />
				</div>
			</div>
			<div class="memoBox">
				<label>Memo : <br> <textarea name="diary_memo"></textarea></label>
			</div>
			<br>
			<!-- 다이어리에 : 시간, 메모, 이미지파일 -->
			<input type="submit" value="저장">
		</form>
	</div>
</body>
</html>