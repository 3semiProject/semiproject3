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
div#diaryPart{
	height: 80%;
	min-height: 100%;
	align-items: center;
	display: flex;
	justify-content: center;
	font-family: Copperplate, Papyrus, fantasy;
}
div.button{
	float: center;
}
#modifybtn{
	width: 55px;
	height: 30px;
	border: 1px solid #827482;
	background-color: white;
	color: #827482;
	border-radius: 7px;
}
div.bodyBox{
	align-items: center;
	flex-direction: column;
	justify-content: center;
	
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
</head>
<body>
<script type="text/javascript">
//전역변수 선언 
var user_id = '${diary.user_id}';
var diary_post_date = '${diary.diary_post_date}';
var diary_no = '${diary.diary_no}';
</script>

<script type="text/javascript">
//----- 프로필 이미지 미리보기 관련 function ----------
//FileReader() 객체는 비동기적으로 파일의 내용을 읽어들이는 데 사용
const reader = new FileReader();

function changeImg(input) {

	if(input.files && input.files[0]) {	
	reader.onload = e => {
	//이미지 src변경
	const previewImage = document.getElementById("showimg_body");
      previewImage.src = e.target.result;
      console.log(previewImage.src);
  }	
	//이미지 읽기
	reader.readAsDataURL(input.files[0]);
	}

}

//1일 1개 작성가능한 다이어리 :act, body에 대해 중복체크
//변경한 작성일에 이미 다이어리가 존재하는 경우 수정화면으로 이동할지 돌아갈지를 물어봄
$(function() {
  // diary_post_date 값 변경 시 중복 체크
  $('input[name="diary_post_date"]').on('change', function() {
    var diary_post_date = $(this).val();
    var user_id = $('input[name="user_id"]').val();
    $.ajax({
      url: 'diary_checkDuplicateDiary.do',
      method: 'POST',
      data: {
    	diary_category : "body",
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
        		  window.location.href = 'diary_showBodyDiary.do?diary_no=' + data;
        		  
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
}); //ready

</script>
</head>

<body>
<div id="bodyPart">
	<form action="diary_insertBodyWrite.do" method="post" enctype="multipart/form-data">
		<div class="bodyBox">
					<input name="user_id" type="hidden" value="${ diary.user_id }"><br>
					<input name="diary_no" type="hidden" value="${ diary.diary_no }"><br>
					<label> 작성일시 : 					
					<input name="diary_post_date" type="date" value="${ diary.diary_post_date }"><br>
					</label>
				<div>
					<h4>BMI</h4>
					<input name="body_bmi"  placeholder="0.0"><br>
				</div>			
				<div >
					<h4>Bmr</h4>
					<input name="body_bmr"  placeholder="0.0"><br>
				</div>			
				<div >
					<h4>체중</h4>
					<input name="body_weight" placeholder="0.0">kg <br>
				</div>			
				<div >
					<h4>체지방량</h4>
					<input name="body_fat"  placeholder="0.0">g <br>
				</div>			
				<div >
					<h4>골격근량</h4>
					<input name="body_muscle"  placeholder="0.0">g<br>
				</div>			
				<div >
					<h4>허리둘레</h4>
					<input  name="body_waistline"  placeholder="0.0">cm <br>
				</div>
		</div>
		<br>
		<!-- Image Box -->
		<!-- 등록된 사진 출력 -->
		<div class="imageBox">
				<div>
					<input style="width: 70px;" type="file" name="upfile" onchange="changeImg(this);" />
				</div>			
				<!-- 이미지입력되면 event인식해서 changeImage() function 실행됨 -->
			<img id="showimg_body"
				src="${ pageContext.servletContext.contextPath }/resources/images/diary/noimage2.jpg" alt="선택이미지 미리보기" />
			
		</div>
		<!-- 등록된 메모 출력 -->
		<!-- Memo Box -->
		<div class="memobox">
			<textarea name="diary_memo">${ diary.diary_memo }</textarea>
		</div>
			<br>
			<!-- 다이어리에 : 시간, 메모, 이미지파일 -->
			<input type="submit" value="저장">
		</form>
		
		<script type="text/javascript">
		$("form").submit(function(e) {
			  //체중이 0이상이어야 전송가능
			  var body_weight = $('input[name="body_weight"]').val();
			  if(body_weight<=0){
			 alert("체중은 필수 입력사항입니다. 작성화면으로 돌아갑니다.");  
			  e.preventDefault(); // 기본 동작 방지
			  }else{
			  console.log($(this).serialize());
		        alert("성공");				  
			  }

			});
		</script>
	<br>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>