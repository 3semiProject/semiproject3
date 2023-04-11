<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>회원가입</title>
<style>
/* * {
	box-sizing: border-box;
}

.home_a {
	display: block;
	text-decoration: none;
	color: #01CD88;
	border: 1px solid #01CD88;
}
body {
	width: 1200px;
	height: 1200px;
}

 h1 {
 	color: #A4A4A4;
 	font-weight: 800;
 	font-size: 30pt;
 }
#enroll_form {
	text-align: center;
	font-size: 15pt;
	font-style: inherit;
	color: #5f5f5f;
}

#join_box {
	display: flex;
	align-items: center;
	border: 3px solid #D1D1D1;
	width: 600px;
	height: 1000px;
	border-radius: 30px;
	display: inline-block;
	margin: 0;
}



.join_e {
	border-bottom: 2px solid #D1D1D1;
	height: 100px;
	width: 600px;
	display: flex;

}

.join_item {
	line-height: 100px;
	margin: 0;
	height: 100px;
	width: 200px;
	border-right: 2px solid #D1D1D1;
}

.join_item2{
	display: flex;
	padding: 30px;
}
.join_item2 > * {
	height: 30px;
	vertical-align: middle;
	
}


#title {
	display: inline-block;
	border-bottom: 3px solid #D1D1D1;
	margin: 50px 0;
	width: 500px;
	padding-bottom: 20px;
	font-size: xx-large;
	 
} */
.home_a {
	display: block;
	text-decoration: none;
	color: #01CD88;
	border: 1px solid #01CD88;
}
body {
	width: 1200px;
	height: 1200px;
}

 h1 {
 	color: #A4A4A4;
 	font-weight: 800;
 	font-size: 30pt;
 }
#enroll_form {
	text-align: center;
	font-size: 15pt;
	font-style: inherit;
	color: #5f5f5f;
}

#join_box {
	display: flex;
	align-items: center;
	border: 3px solid #D1D1D1;
	width: 600px;
	height: 1000px;
	border-radius: 30px;
	display: inline-block;
	margin: 0;
}
#enroll_form #text {
	display: flex;
	color: #D96969;
}

.join_e {
	border-bottom: 2px solid #D1D1D1;
	height: 110px;
	width: 600px;
	display: flex;

}

.join_item {
	line-height: 100px;
	margin: 0;
	height: 100px;
	width: 200px;
	border-right: 2px solid #D1D1D1;
}

.join_item2{
	display: flex;
	padding: 30px;
}
.join_item2 > * {
	
	height: 30px;
	vertical-align: middle;
	
}


#title {
	display: inline-block;
	border-bottom: 3px solid #D1D1D1;
	margin: 50px 0;
	width: 500px;
	padding-bottom: 20px;
	font-size: xx-large;
	 
}

.api_join_item2 {
	padding: 10px 30px;
}

.button_box {
	padding: 0 20px;
	width: 500px;
	display: flex;
	justify-content:space-between;
	font-size: x-large;
	margin-bottom: 20px;
	position: relative;
	left: 300px;

}
.mail_input_box{
	padding: 10px 30px;
	display: flex;
}
.mail_check_input_box{
	padding: 10px 30px;
	display: flex;
}


.button_box_form {
	display: flex;
}

</style>
<script
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>

<script type="text/javascript">

        function validate() {
            // 유효성 검사

            // 암호확인
            var pwd1 = document.getElementById("user_pw1").value;
            var pwd2 = $('#user_pw2').val();

            if (pwd1 !== pwd2) {
                alert("암호 확인이 일치하지 않습니다.");
                $('#user_pw2').select();
                return false;
            }
            
            if (pwd1 == pwd2){
           		alert("암호 확인 일치합니다.");
           		$('#user_name').select();
            return true;
            }
        }

        // ajax (Asynchronous Javascript and Xml) :
        // 페이지를 바꾸거나 새로고침하지 않고, 서버와 통신하는 기술
        // 서비스 서버로 요청하고 결과받음
        function dupCheckId() {
            $.ajax({
                url: "idChk.do",
                type: "post",
                data: {user_id: $('#user_id').val()},
                success: function (data) {
                    console.log("success : " + data);
                    if (data === 'ok') {
                        alert("사용 가능한 아이디입니다");
                        $('#user_pw1').focus();
                    } else {
                        alert("이미 존재하는 아이디입니다");
                        $('#user_id').focus();
                    }

                },
                error: function (jqXHR, textStatujs, errorThrown) {
                    console.log("error : " + jqXHR + ", " + textStatujs + ", " + errorThrown);

                }
            })
            ;

            return false;
        }
        
        //nickname check
        function dupCheckNick() {
            $.ajax({
                url: "nickChk.do",
                type: "post",
                data: {user_nickname: $('#user_nickname').val()},
                success: function (data) {
                    console.log("success : " + data);
                    if (data === 'ok') {
                        alert("사용 가능한 닉네임입니다");
                        $('#birth').focus();
                    } else {
                        alert("이미 존재하는 닉네임입니다");
                        $('#user_nickname').focus();
                    }

                },
                error: function (jqXHR, textStatujs, errorThrown) {
                    console.log("error : " + jqXHR + ", " + textStatujs + ", " + errorThrown);

                }
            })
            ;

            return false;
        }

// ----------------------------------------------------------------------------------
// 전화번호 인증
        
        
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
					if(data !="0") {
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
           		$('#email').select();
            	return true;
            }else{
                alert("인증번호가 일치하지 않습니다1.");
                $('#authNumber').select();
                return false;
            }  
		}
	
// --------------------------------------------------------------------------
// 이메일인증
		
		var code;	 //이메일전송 인증번호 저장위한 코드

		$(function(){	
			/* 인증번호 이메일 전송 */
			$(".mail_check_button").click(function(){
				alert("인증번호 발송되었습니다.\n이메일에서 인증번호를 확인해주세요.");
			    
				var email = $(".mail_input").val();        // 입력한 이메일
			    var cehckBox = $(".mail_check_input");        // 인증번호 입력란
			    var boxWrap = $(".mail_check_input_box");    // 인증번호 입력란 박스 
			    $.ajax({
			    	data: {en : '0' },
			        type:"GET",
			        url:"mailCheck.do?email=" + email,
			        success:function(data){
			            
			            cehckBox.attr("disabled",false);
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
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<hr>
	<div id="enroll_form">
		<h1 align="center" id="title">회원가입</h1>
		<br>
		<div align="center" style="color: #D96969; font-size: x-large; margin-bottom: 20px;">필수입력항목</div>
		<form action="enroll.do" method="post">
			<div id="join_box" align="center">
				<div class="join_e">
					<div class="join_item">ID</div>
					<div class="join_item2">
						<input type="text" name="user_id" id="user_id" required>
						&nbsp; &nbsp; <input type="button" value="중복확인"
							onclick="return dupCheckId();">
					</div>
				</div>
				<div class="join_e">
					<div class="join_item">PW</div>
					<div class="join_item2">
						<input type="password" name="user_pw" id="user_pw1" min="6" max="12" required>
					</div>
				</div>
				<div class="join_e">
					<div class="join_item">PW CHECK</div>
					<div class="join_item2">
						<input type="password" id="user_pw2" required> &nbsp; &nbsp;
						<input type="button" value="중복확인" onclick="return validate();">
					</div>
				</div>
				<div class="join_e">
					<div class="join_item">이름</div>
					<div class="join_item2">
						<input type="text" name="user_name" required>
					</div>
				</div>
				<div class="join_e">
					<div class="join_item">닉네임</div>
					<div class="join_item2">
						<input type="text" name="user_nickname" id="user_nickname" 
							required> &nbsp; &nbsp; <input type="button" value="중복확인"
							onclick="return dupCheckNick();">
					</div>
				</div>
				<div class="join_e">
					<div class="join_item">생년월일</div>
					<div class="join_item2">
						<input type="date" name="birth"required> &nbsp;
					</div>
				</div>
				<div class="join_e">
					<div class="join_item">성별</div>
					<div class="join_item2">
						<input type="radio" name="gender" value="M"> 남자 &nbsp;
						<input type="radio" name="gender" value="F"> 여자
					</div>
				</div>
				<div class="join_e">
					<div class="join_item">전화번호</div>
					<div class="auto_number api">
						<div class="join_item2 api_join_item2">
							<input type="tel" name="phone" id="phone" required> &nbsp; &nbsp;
							<input type="button" value="인증번호받기" onclick="return phoneAuth();">
						</div>
						<div class="join_item2 api_join_item2" id="authBox">
							<input type="tel" id="authNumber" value="인증번호 입력하세요." onfocus="this.value=null" required /> &nbsp; &nbsp;
							<input type="button" value="인증번호확인" onclick="return authNumberChek();" />
						</div>						
					</div>
				</div>
				<div class="join_e">
					<div class="join_item">이메일</div>
					<div class="mail_api">
						<div class="mail_input_box">
							<input class="mail_input" name="memberMail"> &nbsp; &nbsp;
							<input class="mail_check_button" type="button" value="인증번호전송">
						</div>
						<div class="mail_check_wrop">
							<div class="mail_check_input_box">
								<input class="mail_check_input" value="인증번호 입력하세요." onfocus="this.value=null" /> &nbsp; &nbsp;
								<input type="button" value="인증번호확인" onclick="emailck(); return false;" />
							</div>
						</div>
					</div>
				</div>
				<div class="join_button">
					<div>
						<input type="submit" value="가입"> &nbsp; &nbsp; 
						<input type="reset" value="취소" onclick="javascript:location.href='${ pageContext.servletContext.contextPath}/main.do';"> &nbsp; &nbsp;
					</div>
				</div>
			</div>
		</form>
	</div>
	<br><br><br><br>
</body>
</html>
