<%--
  Created by IntelliJ IDEA.
  Date: 2023/03/20
  Time: 3:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>공지사항</title>

    <script type="text/javascript"
            src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
    <script type="text/javascript">
        // jQuery 로 이벤트 처리 : 검색 form 을 보이게/안보이게 처리

        $(function () {

            showDiv();
            $('input[name=item]').on('change', function () {
                showDiv();
            }); // on
        }); //document.ready
        function showDiv() {
            if ($('input[name=item]').eq(0).is(':checked')) {
                $('#titleDiv').css('display', 'block');
                $('#writerDiv').css('display', 'none');
                $('#dateDiv').css('display', 'none');
            } else if ($('input[name=item]').eq(1).is(':checked')) {
                $('#titleDiv').css('display', 'none');
                $('#writerDiv').css('display', 'block');
                $('#dateDiv').css('display', 'none');
            } else if
            ($('input[name=item]').eq(2).is(':checked')) {
                $('#titleDiv').css('display', 'none');
                $('#writerDiv').css('display', 'none');
                $('#dateDiv').css('display', 'block');
            }
        }
    </script>
    <style>
        table {
            text-align: center;
        }
    </style>
</head>
<body>
<c:import url="../common/menubar.jsp"/>
<hr>

<%--관리자 접속시--%>
<center>
    <c:if test="${sessionScope.loginMember.admin eq 'Y'}">
        <button onclick="location.href='movewrite.do'">새 공지글 등록</button>
    </c:if>
</center>


<%--검색 항목--%>
<center>
    <h2>검색할 항목을 선택하세요</h2>
    <div>
        <input type="radio" name="item" value="title" checked>제목 &nbsp;
        <input type="radio" name="item" value="writer">작성자 &nbsp;
        <input type="radio" name="item" value="date">날짜 &nbsp;
    </div>
    <div id="titleDiv">
        <form action="nsearchTitle.do" method="post">
            <label>검색할 제목 키워드를 입력하세요 :
                <input type="search" name="keyword">
            </label>
            <input type="submit" value="검색">
        </form>
    </div>
    <div id="writerDiv">
        <form action="nsearchWriter.do" method="post">
            <label>검색할 작성자 아이디를 입력하세요 :
                <input type="search" name="keyword">
            </label>
            <input type="submit" value="검색">
        </form>
    </div>
    <div id="dateDiv">
        <form action="nsearchDate.do" method="post">
            <label>검색할 등록날짜를 입력하세요 :
                <input type="date" name="begin"> ~
                <input type="date" name="end"> ~
            </label>
            <input type="submit" value="검색">
        </form>
    </div>
</center>


<%--목록 출력--%>
<center>
    <button onclick="location.href='${pageContext.servletContext.contextPath}/nlist.do'">전체 목록 보기</button>
</center>
<br>
<table align="center" width="500" border="1" cellspacing="0" cellpadding="1">
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>첨부파일</th>
        <th>날짜</th>
    </tr>
    <c:forEach items="${requestScope.list}" var="n">
        <tr>
            <td>${n.noticeno}</td>
            <c:url var="ndt" value="/ndetail.do">
                <c:param name="noticeno" value="${n.noticeno}"/>
            </c:url>
            <td><a href="${ndt}">${n.noticetitle}</a></td>
            <td>${n.noticewriter}</td>
            <td>
                <c:if test="${!empty n.original_filepath}">◎</c:if>
                <c:if test="${empty n.original_filepath}">&nbsp;</c:if>
            </td>
            <td><fmt:formatDate value="${n.noticedate}" pattern="yyyy-MM-dd"/></td>
        </tr>
    </c:forEach>
</table>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
