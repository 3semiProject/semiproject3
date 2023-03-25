<%--
  Created by IntelliJ IDEA.
  Date: 2023/03/16
  Time: 10:46 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>회원가입</title>
    <style>
        table th {
            background: #99ffff;
        }

        table#tbl {
            border: 2px solid black;

        }
    </style>
    <script src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>

    <script type="text/javascript">

        function validate() {
            // 유효성 검사

            // 암호확인
            var pwd1 = document.getElementById("userpwd1").value;
            var pwd2 = $('#userpwd2').val();

            if (pwd1 !== pwd2) {
                alert("암호 확인이 일치하지 않습니다.");
                $('#userpwd2').select();
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
                data: {userid: $('#userid').val()},
                success: function (data) {
                    console.log("success : " + data);
                    if (data === 'ok') {
                        alert("사용 가능한 아이디입니다");
                        $('#userpwd1').focus();
                    } else {
                        alert("이미 존재하는 아이디입니다");
                        $('#userid').focus();
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
<h1 align="center">회원 가입 페이지</h1>
<br>
<form action="enroll.do" method="post" onsubmit="return validate();">
    <table id="tbl" align="center" width="500" cellspacing="5" cellpadding="0">
        <tr>
            <th colspan="2">회원 정보를 입력해주세요 (* 표시는 필수입력 항목)</th>
        </tr>
        <tr>
            <th width="120">* 이 름</th>
            <td><input type="text" name="username" id="username" required></td>
        </tr>
        <tr>
            <th width="120">* 아이디</th>
            <td><input type="text" name="userid" id="userid" required> &nbsp; &nbsp;
                <input type="button" value="중복확인" onclick="return dupCheckId();">
            </td>
        </tr>
        <tr>
            <th width="120">* 비밀번호</th>
            <td><input type="password" name="userpwd" id="userpwd1" required></td>
        </tr>
        <tr>
            <th width="120">* 비밀번호 확인</th>
            <td><input type="password" id="userpwd2" required></td>
        </tr>
        <tr>
            <th width="120">* 성 별</th>
            <td>
                <input type="radio" name="gender" value="M"> 남자 &nbsp;
                <input type="radio" name="gender" value="F"> 여자
            </td>
        </tr>
        <tr>
            <th width="120">* 나 이</th>
            <td><input type="number" min="19" name="age" id="age" required></td>
        </tr>
        <tr>
            <th width="120">* 전화번호</th>
            <td><input type="tel" name="phone" required></td>
        </tr>
        <tr>
            <th width="120">* 이메일</th>
            <td><input type="email" name="email"></td>
        </tr>
        <tr>
            <th colspan="2">
                <input type="submit" value="가입하기"> &nbsp;
                <input type="reset" value="작성취소"> &nbsp;
                <a href="main.do">시작페이지로 이동</a>
            </th>
        </tr>

    </table>

</form>

<fotter>
    <c:import url="/WEB-INF/views/common/footer.jsp"/>

</fotter>
</body>
</html>
