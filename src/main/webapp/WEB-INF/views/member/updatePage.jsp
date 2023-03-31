<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>

    <style>
       body {
    		width: 1200px;
    		height: 1200px;
    		
    	}
    	#btn_box {
        	width: 1200px;
       		display: flex;
       		justify-content: center;
			
        }
    	
    	body #btn_box div{
      		left: 350px;
    		width: 100px;
    		
    	}
        table th {
            background: #99ffff;
        }

        table th {
            border: 1px solid black;
        }

        table tr td {
            border: 1px solid black;
        }

        table#tbl {
            border: 2px solid black;

        }
    </style>

    <c:url var="moveup" value="/moveup.do">
        <c:param name="user_id" value="${ member.user_id }"/>
    </c:url>

    <c:url var="mdel" value="/mdel.do">
        <c:param name="user_id" value="${ member.user_id }"/>
    </c:url>

    <script type="text/javascript">
        function validate() {
            // 유효성 검사

            // 암호확인
            var pw = document.getElementById("user_pw").value;
            var pwCheck = $('#user_pw1').val();

            if (pw !== pwCheck) {
                alert("암호 확인이 일치하지 않습니다.");
                $('#user_pw').select();
            }
        }
    </script>
</head>
<body>
<h1 align="center">마이 페이지</h1>
<hr>
<div id="btn_box" align="center">
	<div>기본정보</div>
	<div>
	<form action="updateMember.do" method="post" name="user_id">
		<input type="hidden" name="user_id" value="${ member.user_id }" />
		<input type="submit" value="저장하기" />
	</form>
	<button type="button" onclick="location.href='javascript:history.go(-1)';">취소</button>
	</div>
</div>
<form action="mupdate.do" method="post">
    <table id="tbl" align="center" width="500" cellspacing="5" cellpadding="0">
        <tr>
            <th width="120">아이디</th>
            <td><input type="text" name="user_id" value="${member.user_id}" readonly></td>
        </tr>
         <tr>
            <th width="120">비밀번호</th>
            <td>
            <input type="password" name="user_pw" id="user_pw">
            </td>
        </tr>
        <tr>
            <th width="120">비밀번호 확인</th>
            <td><input type="password" id="user_pw1" onblur="validate();"></td>
            
        </tr>
        <tr>
            <th width="120">이 름</th>
            <td><input type="text" name="user_name" value="${member.user_name}" readonly></td>
        </tr>
        <tr>
            <th width="120">닉네임</th>
            <td><input type="text" name="user_nickname" value="${member.user_nickname}" readonly></td>
        </tr>
        <tr>
            <th width="120">전화번호</th>
            <td><input type="text" name="phone" value="${ member.phone }"></td>
        </tr>
        <tr>
            <th width="120">생일</th>
            <td><input type="text" name="birth" value="${member.birth}" readonly></td>

        </tr>        
        <tr>
            <th width="120">성 별</th>
                <td>
                    <input type="text" name="gender" value="${ member.gender }" readonly>
                </td>
        </tr>
        <tr>
            <th width="120">이메일</th>
            <td><input type="text" name="email" value="${member.email}"></td>

        </tr>

        <tr>
        </tr>
    </table>
 </form>
