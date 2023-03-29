<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>회원가입</title>
<style>
* {
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

        
        var checknum=0;
        
        //전화번호 인증
        function phoneAuth() {
        	alert("인증번호 발송되었습니다.\n휴대폰에서 인증번호를 확인해주세요.");
			$.ajax({
				url:"authNumber.do",
				type: "POST",
				data: {phone : $('#phone').val()},
				dataType: "text",
				success: function(data) {
					alert("테스트");
					console.log("success : " + data);
					if(data !="no") {
						alert("테스트2");
                        $('#authNumber').focus();
                        checknum = data;
					}
				},
				error: function (jqXHR, textStatujs, errorThrown) {
                    console.log("error : " + jqXHR + ", " + textStatujs + ", " + errorThrown);
                    alert("휴대폰 번호가 올바르지 않습니다.\n다시 입력해주세요.");
					$('#phone').focus();
				}
			});
		}
        
		function authNumberChek() {
	        // 유효성 검사 / 인증번호 확인
            var authNumber = $('#authNumber').val();

            if (checknum !== authNumber) {
                alert("인증 번호가 일치하지 않습니다.");
                $('#authNumber').select();
                return false;
            }
            
            if (checknum == authNumber){
           		alert("인증 번호가 일치합니다.");
           		$('#email').select();
            	return true;
            }
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
		<form action="enroll.do" method="post" onsubmit="return validate();">
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
						<input type="password" name="user_pw" id="user_pw1" required>
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
						<input type="text" name="user_name" id="user_name" required>
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
						<input type="date" name="birth" id="birth" required> &nbsp;
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
					<div class="auto_number">
						<div class="join_item2">
							<input type="tel" name="phone" id="phone" required> &nbsp; &nbsp;
							<input type="button" value="인증번호받기" onclick="return phoneAuth();">
						</div>
					</div>
				</div>
				<div class="join_e">
						<div class="join_item">인증번호</div>
						<div class="join_item2" id="authBox">
							<input type="number" id="authNumber" required /> &nbsp; &nbsp;
							<input type="button" value="인증번호확인"
								onclick="return authNumberChek();" />
						</div>
				</div>
				<div class="join_e">
					<div class="join_item">이메일</div>
					<div class="join_item2">
						<input type="email" name="email" id="email" required />
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
</body>
</html>
