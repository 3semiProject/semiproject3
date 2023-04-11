<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">

body {
	 	width:1200px;
    	height:1200px;
}
#findcontainer{
width: 800px;
height: 100px;
margin: 0 auto;
}

#findcontainer > * {
border: 1px solid black;
margin: 0 auto;

}

#findEvBox{
	margin-top: 100px;
	margin-bottom: 50px;
	width: 600px;
	height: 100px;
	border: 1px solid black;
	border-radius: 30px;
	display: flex;
	justify-content: center;
	align-items: center;
}

#findEvBox div {
	width: 280px;
	height: 90px;
	border: 1px solid black;
	border-radius: 30px;
	margin: 0 10px;
	text-align: center;
	line-height: 90px;
	font-size: xx-large;
}

.label {
	text-align: center;
	width: 400px;
	height: 50px;
	line-height: 50px;
	font-size: x-large;
	border-radius: 15px;
	background: #EBF8D7;
	
}


.formBox {
 	width: 650px;
 	height: 320px;
 	border-radius: 20px;
 	position: relative;
}


.formBox > form {
	position: relative;
	left: 125px;
	
}
.formBox > form > div:first-child {
	margin: 15px 0;
}


.formBox > form > div > input {
	height: 50px;
	width: 400px;
	font-size: xx-large;
	text-align: center;
	color: #D1D1D1;
	border-radius: 20px;
}


.mail_api > div > input:first-child, .phone_api > div > input:first-child {
	height: 40px;
	width: 300px;
	margin-bottom: 10px;
}


.sumbitBtn {
	width: 120px;
	height: 50px;
	border: 1px solid black;
	border-radius: 20px;
	text-align: center;
	line-height: 50px;
	position: relative;
	left: 125px;
	background: #FEE6E6;
	
	
}

</style>

<script type="text/javascript"
   src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
//상단 버튼 클릭시이벤트 => 이동및 색상변화
function clickID() {
	document.getElementById('clickPW').style.backgroundColor = '#white';
	document.getElementById('clickID').style.backgroundColor = '#BEE9C6';
	location.href="findId.do"
}

function clickPW() {
	document.getElementById('clickID').style.backgroundColor = 'white';
	document.getElementById('clickPW').style.backgroundColor = '#BEE9C6';
	location.href="findPw.do"
}


//ajax-----------------------------------------------------
function findPwPhone() {
	$.ajax({
		url: "findPwPhone.do",
		data: { name : $('#user_name').val(), id : $('#user_id').val(), phone : $('#phone').val()},
		type: "post",
		success: function(result) {
			if(result = "ok") {
				alert("비밀번호는 입력하신 이메일로 전송하였습니다.\n확인하시고 비밀번호를 바꿔주세요.");
				location.href = "loginPage.do";
			}else {
				alert("해당 ID는 존재하지 않거나, 잘못 입력되었습니다.");
				location.href = "findPw.do";
			}	
		},
		error: function(request, status, errorData) {
			console.log("error code : " + request.status + "\nMessage : " + request.response
						+ "\nError : " + errorData);
		}//error close;
	});	//ajax close;
}	//function close;



function findPwEmail() {
	$.ajax({
		url: "findPwEmail.do",
		data: { name : $('#user_name2').val(), id : $('#user_id2').val(), email : $('#email').val()},
		type: "post",
		success: function(result) {
			if(user_id = "ok") {
				alert("비밀번호는 입력하신 이메일로 전송하였습니다.\n확인하시고 비밀번호를 바꿔주세요.");
				location.href = "loginPage.do";
			}else {
				alert("해당 ID는 존재하지 않거나, 잘못 입력되었습니다.");
				location.href="findPw.do";
			}
		},
		error: function(request, status, errorData) {
			console.log("error code : " + request.status + "\nMessage : " + request.response
						+ "\nError : " + errorData);
		}//error close;
	});	//ajax close;
}	//function close;



//----------------------------------------------------------------------------------
//전화번호 인증
     
     
     var checknum; //문자전송 인증번호 저장위한 코드
     
     function phoneAuth() {
     	alert("인증번호 발송되었습니다.\n휴대폰에서 인증번호를 확인해주세요.");
     	
			$.ajax({
				url:"authNumber.do",
				type: "POST",
				data: {phone : $('#phone').val()},
				dataType: "text",
				success: function(data) {
					console.log("data : " + data);
					if(data != "0") {
                     $('#authNumber').focus();
                     checknum = data;
				}else{
					alert("휴대폰 번호가 올바르지 않습니다.\n다시 입력해주세요.");
					}
				},
				error: function (jqXHR, textStatujs, errorThrown) {
                 console.log("error : " + jqXHR + ", " + textStatujs + ", " + errorThrown);
                 alert("에러 발생.");
					$('#phone').focus();
				}
			});
		}
     
		function authNumberChek() {
	        // 유효성 검사 / 인증번호 확인
         var authNumber = $('#authNumber').val();
         
	        if ((checknum != null) && (checknum == authNumber)){
        		alert("인증번호가 일치합니다.");
         	return true;
         }else{
             alert("인증번호가 일치하지 않습니다1.");
             $('#authNumber').select();
             return false;
         }  
		}
	
//--------------------------------------------------------------------------
//이메일인증
		
		var code;	 //이메일전송 인증번호 저장위한 코드

		$(function(){	
			/* 인증번호 이메일 전송 */
			$(".mail_check_button").click(function(){
				alert("인증번호 발송되었습니다.\n이메일에서 인증번호를 확인해주세요.");
			    
				var email = $(".mail_input").val();        // 입력한 이메일
			    var checkBox = $(".mail_check_input");        // 인증번호 입력란
			    var boxWrap = $(".mail_check_input_box"); 	// 인증번호 입력란 박스
			    											 
			    $.ajax({
			        type:"post",
			        url:"mailCheck.do?email=" + email,
			        success:function(data){
			            
			            checkBox.attr("disabled",false);
			            boxWrap.attr("id", "mail_check_input_box_true");
			            code = data;
			        }      
			    });
			    
			});
		}); //document.ready
     
		//이메일인증번호 확인
		function emailck(){
			/* 인증번호 비교 */
			/* $(".mail_check_input").blur(function(){ */
			    
			    var inputCode = $(".mail_check_input").val();   // 입력코드    

			 // 일치할 경우
			    if((code != null) && (inputCode == code)){
			    	alert("인증번호가 일치합니다.");
			    	return true;
			    // 일치하지 않을 경우
			    } else {
			    	alert("인증번호를 다시 확인해주세요2. ");
			    	return false;

			    }    
			    
			/* }); */
		}
		

</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<hr>
<div id="findcontainer">
<div id="findEvBox">
<div id="clickID" onclick="clickID();" >Find ID</div>
<div id="clickPW" onclick="clickPW();" style="background-color: #BEE9C6">Find PW</div>
</div>
<div class="label">핸드폰으로 본인인증</div>
<div class="formBox" style="top: 10px;">
<form action="findIdPhone.do">
<div><input type="text" id="user_name" value="이름" onfocus="this.value=''" /></div>
<div><input type="text" id="user_id" value="아이디" onfocus="this.value=''" /></div>
<div class="phone_api">
<div style="position: relative; top:10px;">
	<input type="tel" id="phone" value="휴대폰번호('-'없이 입력)" onfocus="this.value=''" />
	 <input type="button" value="인증번호받기" onclick="return phoneAuth();">		
</div>
<div id="authBox">
	<input type="tel" id="authNumber" value="인증번호 입력하세요." onfocus="this.value=null" required />
	<input type="button" value="인증번호확인" onclick="return authNumberChek();" />
</div>	
</div>
<div class="sumbitBtn" onclick="findPwPhone();" >확인</div>
</form>
</div>


<div class="label" style="position: relative; top: 30px;">이메일으로 본인인증</div>
<div class="formBox" style="top: 40px;">
<form action="findPwEmail.do">
<div><input type="text" id="user_name2" value="이름" onfocus="this.value=''" /></div>
<div><input type="text" id="user_id2" value="아이디" onfocus="this.value=''" /></div>
<div class="mail_api">
<div class="mail_input_box" style="position: relative; top:10px;">
	<input type="email" id="email" class="mail_input" name="memberMail" value="이메일@직접입력" onfocus="this.value=''" />
	<input class="mail_check_button" type="button" value="인증번호전송">
</div>
<div class="mail_check_input_box">
	<input class="mail_check_input" value="인증번호 입력하세요." onfocus="this.value=''" />
	<input type="button" value="인증번호확인" onclick="emailck(); return false;" />
</div>
</div>
<div class="sumbitBtn" onclick="findPwEmail();" >확인</div>
</form>
</div>
</div>
</body>
</html>