<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>마이페이지</title>
<style>

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
            var pwd1 = document.getElementById("user_pw").value;
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
		
		
        var chekcode=0;
        
        //이메일 인증
        function emailAuth() {
        	alert("인증코드 발송되었습니다.\n이메일에서 인증코드를 확인해주세요.");
			$.ajax({
				url:"authEmail.do	",
				type: "POST",
				data: {phone : $('#email').val()},
				dataType: "text",
				success: function(data) {
					alert("테스트");
					console.log("success : " + data);
					if(data !="no") {
						alert("테스트2");
                        $('#authEmail').focus();
                        chekcode = data;
					}
				},
				error: function (jqXHR, textStatujs, errorThrown) {
                    console.log("error : " + jqXHR + ", " + textStatujs + ", " + errorThrown);
                    alert("이메일 주소가 올바르지 않습니다.\n다시 입력해주세요.");
					$('#email').focus();
				}
			});
		}
        
		function authEmailChek() {
	        // 유효성 검사 / 인증번호 확인
            var authEmail = $('#authEmail').val();

            if (chekcode !== authEmail) {
                alert("인증 코드가 일치하지 않습니다.");
                $('#authNumber').select();
                return false;
            }
            
            if (chekcode == authEmail){
           		alert("인증 번호가 일치합니다.");
           		$('#email').select();
            	return true;
            }
		}
		
		function form_submit() {
			$('#mupdate_form').submit();
			
		}
		
		<%-- 			<input type="hidden" name="user_id" value="${ member.user_id }" />
					<input type="hidden" name="user_pw" value="${ member.user_pw }" />
					<input type="hidden" name="phone" value="${ member.phone }" />
					<input type="hidden" name="email" value="${ member.email }" /> --%>
					
        
    </script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<c:import url="/WEB-INF/views/member/memberbar.jsp"/>
	<hr>
	<div id="enroll_form">
		<h1 align="center" id="title">회원정보 수정</h1>
		<div class="button_box">
			<div id="text">기본정보</div>
			<div class="button_box_form">
				<form action="deletePage.do" method="post" name="deleteMember">
					<input type="hidden" name="user_id" value="${ member.user_id }" />
					<input type="reset" value="취소" onclick="history.go(-2)">
				</form>
				<button type="button" style="height: 23px; margin-left: 10px;" onclick="form_submit();">수정완료</button>
			</div>
		</div>
	</div>
	<form action="mupdate.do" method="post" name="updateMember" id="mupdate_form">
			<div id="join_box" align="center">
				<div class="join_e">
					<div class="join_item">ID</div>
					<div class="join_item2">
						<input type="hidden" name="user_id" id="user_id" value="${ member.user_id }"/>
						<div>${ member.user_id }</div>
					</div>
				</div>
				<div class="join_e">
					<div class="join_item">PW</div>
					<div class="join_item2">
						<input type="password" name="user_pw" id="user_pw" value="${ member.user_pw }" onfocus="this.value=''" required>
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
						<div>${ member.user_name }</div>
					</div>
				</div>
				<div class="join_e">
					<div class="join_item">닉네임</div>
					<div class="join_item2">
						<div>${ member.user_nickname }</div>
					</div>
				</div>
				<div class="join_e">
					<div class="join_item">생년월일</div>
					<div class="join_item2">
						<div>${ member.birth }</div>
					</div>
				</div>
				<div class="join_e">
					<div class="join_item">성별</div>
					<div class="join_item2">
							<c:if test="${ member.gender eq 'M' }">
								<div>남자</div>
							</c:if>
							<c:if test="${ member.gender eq 'F' }">
								<div>여자</div>
							</c:if>				
					</div>
				</div>
				<div class="join_e">
					<div class="join_item">전화번호</div>
					<div class="auto_number api">
						<div class="join_item2 api_join_item2">
							<input type="tel" name="phone" id="phone" value="${ member.phone }" onfocus="this.value=''" required> &nbsp; &nbsp;
							<input type="button" value="인증번호받기" onclick="return phoneAuth();">
						</div>
						<div class="join_item2 api_join_item2" id="authBox">
							<input type="tel" id="authNumber" value="인증번호 입력하세요." onfocus="this.value=''" required /> &nbsp; &nbsp;
							<input type="button" value="인증번호확인" onclick="return authNumberChek();" />
						</div>						
					</div>
				</div>
				<div class="join_e">
					<div class="join_item">이메일</div>
					<div class="auto_number api">
						<div class="join_item2 api_join_item2">
							<input type="email" name="email" id="email" value="${ member.email }" onfocus="this.value=null" required> &nbsp; &nbsp;
							<input type="button" value="인증메일전송" onclick="return emailAuth();">
						</div>
						<div class="join_item2 api_join_item2" id="authBox">
							<input type="email" id="authEmail" value="이메일인증코드 입력하세요." onfocus="this.value=null" required /> &nbsp; &nbsp;
							<input type="button" value="인증번호확인" onclick="return authEmailChek();" />
						</div>						
					</div>
				</div>
			</div>
			</form>
</body>
</html>
