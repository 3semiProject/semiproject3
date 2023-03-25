<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  Date: 2023/03/17
  Time: 11:42 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="date" value="<%= new Date() %>"/>

<html>
<head>
    <title>Title</title>
    <script type="text/javascript"
            src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
    <script type="text/javascript">
        // jQuery 로 이벤트 처리 : 검색 form 을 보이게/안보이게 처리

        $(function () {
            $('input[name=item]').on('change', function () {
                // change 이벤트가 발생한 radio 와 연결된 폼만 보여지게 함
                // 나머지 폼들은 안보이게 처리함
                $('input[name=item]').each(function (index) {
                    //해당 index 번째 radio 가 checked 인지 확인
                    if ($(this).is(':checked')) {
                        $('form.sform').eq(index).css('display', 'block');
                    } else {
                        $('form.sform').eq(index).css('display', 'none');
                    } // if
                }); // each
            }); // on


        }); //document.ready

        // 로그인 제한 변경되었을 때
        function changeLogin(element) {
            // 선택한 radio 의 name 속성의 이름에서 userid 분리 추출함
            var userid = element.name.substring(9);
            console.log("changeLogin : " + userid);

            if (element.checked === true && element.value === 'N') {
                console.log("로그인 제한 체크함");
                location.href = "${ pageContext.servletContext.contextPath }/loginok.do?userid=" + userid + "&login_ok=N";

            } else {
                console.log("로그인 제한 해제함");
                location.href = "${ pageContext.servletContext.contextPath }/loginok.do?userid=" + userid + "&login_ok=Y";
            }

        }
    </script>
    <style>
        form.sform {
            display: none;
            background: lightgray;
        }
    </style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<hr>
<h1 align="center">회원 관리 페이지</h1>
<h2 align="center">현재 회원수 : ${list.size()} 명</h2>
<center>
    <button onclick="javascript:location.href=${pageContext.servletContext.contextPath}'mlist.do'">전체 보기</button>

    <fieldset id="ss">
        <legend>검색할 항목을 선택하세요.</legend>
        <input type="radio" name="item" id="uid"> 회원아이디 &nbsp;
        <input type="radio" name="item" id="gender"> 성별 &nbsp;
        <input type="radio" name="item" id="age"> 연령대 &nbsp;
        <input type="radio" name="item" id="enroll_date"> 가입날짜 &nbsp;
        <input type="radio" name="item" id="login_ok"> 로그인 제한여부 &nbsp;
    </fieldset>
    <br>

    <form action="${pageContext.servletContext.contextPath}/msearch.do"
          method="post" id="idform" class="sform">
        <input type="hidden" name="action" value="id">
        <input type="search" name="keyword"> &nbsp;
        <input type="submit" value="검색">
    </form>


    <form action="${pageContext.servletContext.contextPath}/msearch.do"
          method="post" id="genderform" class="sform">
        <input type="hidden" name="action" value="gender">
        <input type="radio" name="keyword" value="M"> 남자 &nbsp;
        <input type="radio" name="keyword" value="F"> 여자 &nbsp;

        <input type="submit" value="검색">
    </form>

    <form action="${pageContext.servletContext.contextPath}/msearch.do"
          method="post" id="ageform" class="sform">
        <input type="hidden" name="action" value="age">
        <input type="radio" name="keyword" value="20"> 20대 &nbsp;
        <input type="radio" name="keyword" value="30"> 30대 &nbsp;
        <input type="radio" name="keyword" value="40"> 40대 &nbsp;
        <input type="radio" name="keyword" value="50"> 50대 &nbsp;
        <input type="radio" name="keyword" value="60"> 60대 이상 &nbsp;
        <input type="submit" value="검색">
    </form>

    <form action="${pageContext.servletContext.contextPath}/msearch.do"
          method="post" id="enrollform" class="sform">
        <input type="hidden" name="action" value="enroll_date">
        <input type="date" name="begin"> ~
        <input type="date" name="end"> &nbsp;
        <input type="submit" value="검색">
    </form>

    <form action="${pageContext.servletContext.contextPath}/msearch.do"
          method="post" id="lokform" class="sform">
        <input type="hidden" name="action" value="login_ok">
        <input type="radio" name="keyword" value="Y"> 로그인 가능 회원 &nbsp;
        <input type="radio" name="keyword" value="N"> 로그인 제한 회원 &nbsp;
        <input type="submit" value="검색">
    </form>
</center>
<br><br>
<table align="center" border="1" cellspacing="0" cellpadding="3">

    <tr>
        <th>아이디</th>
        <th>이름</th>
        <th>성별</th>
        <th>나이</th>
        <th>전화번호</th>
        <th>이메일</th>
        <th>가입날짜</th>
        <th>마지막 정보수정날짜</th>
        <th>로그인 제한여부</th>
    </tr>
    <c:forEach items="${list}" var="m">

        <tr>
            <td>${m.userid}</td>
            <td>${m.username}</td>
            <td>${m.gender}</td>
            <td>${m.age}</td>
            <td>${m.phone}</td>
            <td>${m.email}</td>
            <td><fmt:formatDate value="${m.enroll_date}" type="date"
                                dateStyle="medium"/></td>
            <td><fmt:formatDate value="${m.lastmodified}" type="date"
                                dateStyle="medium"/></td>
            <td>
                <c:if test="${ m.login_ok eq 'Y'}">
                    <input type="radio" name="login_ok_${m.userid}" onchange="changeLogin(this);" value="Y"
                           checked>가능 &nbsp;
                    <input type="radio" name="login_ok_${m.userid}" onchange="changeLogin(this);" value="N">제한
                </c:if>
                <c:if test="${ m.login_ok eq 'N'}">
                    <input type="radio" name="login_ok_${m.userid}" onchange="changeLogin(this);" value="Y">가능 &nbsp;
                    <input type="radio" name="login_ok_${m.userid}" onchange="changeLogin(this);" value="N" checked>제한
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
