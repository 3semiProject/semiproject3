<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>회원가입</title>
    <style>
    	body {
    		text-align: center;
    		 width: 1200px;
            height: 1200px;
	    	 margin: auto;
           
    	}
	
    	#join_box {
    	border: 3px solid #D1D1D1;
    	width : 600px;
    	height: 900px;
    	border-radius: 30px;
    	display: inline-block;	
    	}
    	
    	.join_e {
    		border-bottom: 2px solid #D1D1D1;
    		height: 100px;
    		width: 600px;
    		float: left;
    		
    	}
    	
    	.join_e div {
    		height: 100px;
			display: inline-block;
			
    	}
    	
    	.join_item {
    		height: 100px;
    		width: 150px;
    		border-right: 2px solid #D1D1D1;
    	}
    	
    	.join_e:last-child {
    		height: 100px;
    		width: 600px;

    	}


        table#tbl {
            border: 2px solid #D1D1D1;

        }
        
        #title{
        	display: inline-block;
         	border-bottom : 3px solid #D1D1D1;
         	margin: 50px 0;
         	width: 500px;
         	padding-bottom: 20px;
         	font-size: xx-large;
         	  
        }
    </style>
    <script src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>

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
            return true;
        }

        // ajax (Asynchronous Javascript and Xml) :
        // 페이지를 바꾸거나 새로고침하지 않고, 서버와 통신하는 기술
        // 서비스 서버로 요청하고 결과받음
        function dupCheckId() {
            $.ajax({
                url: "idchk.do",
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
                url: "nickchk.do",
                type: "post",
                data: {user_nickname: $('#user_nickname').val()},
                success: function (data) {
                    console.log("success : " + data);
                    if (data === 'ok') {
                        alert("사용 가능한 닉네임입니다");
                        $('#user_pw1').focus();
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
        
    </script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<hr>
<div align="center" id="title">회원 가입 페이지</div>
<br>
<div style="color: #D96969; font-size: x-large;">필수입력항목</div>
<form action="enroll.do" method="post" onsubmit="return validate();">
    <div id="join_box" align="center" cellspacing="5" cellpadding="0">
        <div class="join_e">
            <div class="join_item">ID</div>
            <div><input type="text" name="user_id" id="user_id" required> &nbsp; &nbsp;
                <input type="button" value="중복확인" onclick="return dupCheckId();">
         	</div>
        </div>
        <div class="join_e">
            <div class="join_item">PW</div>
            <div><input type="password" name="user_pw" id="user_pw1" required></div>
         </div>	
        <div class="join_e">
            <div class="join_item">PW CHECK</div>
            <<div><input type="password" id="user_pw2" required>
            <input type="button" value="중복확인" onclick="return dupCheckPw();">
            </div>
        </div>
        <div class="join_e">
            <div class="join_item">이름</div>
            <div><input type="text" name="user_name" id="user_name" required></div>
        </div>
         <div class="join_e">
            <div class="join_item">닉네임</div>
            <div><input type="text" name="user_nickname" id="user_nickname" required> &nbsp; &nbsp;
                <input type="button" value="중복확인" onclick="return dupCheckNick();">
         	</div>
        </div>
        <div class="join_e">
            <div class="join_item">생년월일</div>
            <div>
                <input type="date" name="birth" > &nbsp;
            </div>
        </div>
         <div class="join_e">
            <div class="join_item">성별</div>
            <div>
                <input type="radio" name="gender" value="M"> 남자 &nbsp;
                <input type="radio" name="gender" value="F"> 여자
            </div>
        </div>       
        <div class="join_e">
            <div class="join_item">전화번호</div>
            <div><input type="tel" name="phone" required></div>
        </div>
        <div class="join_e">
            <div class="join_item">이메일</div>
            <div><input type="email" name="email"></div>
        </div>
        
          <div class="join_button">
            <div colspan="2">
                <input type="submit" value="가입"> &nbsp;
                <input type="reset" value="취소"> &nbsp;
                <a href="main.do">홈으로 이동</a>
            </div>
        </div>
</div>
</form>

</body>
</html>
