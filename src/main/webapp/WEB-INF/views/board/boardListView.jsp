<%--
  Created by IntelliJ IDEA.
  Date: 2023/03/22
  Time: 4:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<c:set var="listCount" value="${listCount}"/>
<c:set var="startPage" value="${startPage}"/>
<c:set var="endPage" value="${endPage}"/>
<c:set var="maxPage" value="${maxPage}"/>
<c:set var="currentPage" value="${currentPage}"/>

<head>
    <title>게시글 목록</title>

    <%--######################################--%>
    <%--######################################--%>

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

        function showWriteForm() {
            location.href = "${pageContext.servletContext.contextPath}/bwform.do";

        }
    </script>

    <%--######################################--%>
    <%--######################################--%>

    <style>
        table {
            text-align: center;
        }
    </style>
</head>
<body>
<c:import url="../common/menubar.jsp"/>
<hr>
<h1 align="center">게시글 목록</h1>
<h3 align="center">총 게시글 수 : ${listCount} 개</h3>

<center>

    <div>
        <input type="radio" name="item" value="title" checked>제목 &nbsp;
        <input type="radio" name="item" value="writer">작성자 &nbsp;
        <input type="radio" name="item" value="date">날짜 &nbsp;
    </div>
    <div id="titleDiv">
        <form action="bsearchTitle.do" method="post">
            <label>검색할 제목 키워드를 입력하세요 :
                <input type="search" name="keyword">
            </label>
            <input type="submit" value="검색">
        </form>
    </div>
    <div id="writerDiv">
        <form action="bsearchWriter.do" method="post">
            <label>검색할 작성자 아이디를 입력하세요 :
                <input type="search" name="keyword">
            </label>
            <input type="submit" value="검색">
        </form>
    </div>
    <div id="dateDiv">
        <form action="bsearchDate.do" method="post">
            <label>검색할 등록날짜를 입력하세요 :
                <input type="date" name="begin"> ~
                <input type="date" name="end"> ~
            </label>
            <input type="submit" value="검색">
        </form>
    </div>
</center>


<center>
    <button onclick="location.href='${pageContext.servletContext.contextPath}/blist.do?page=${currentPage}'">전체 목록 보기
    </button>
</center>
<br>
<table align="center" width="500" border="1" cellspacing="0" cellpadding="1">
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>조회수</th>
        <th>날짜</th>
    </tr>
    <c:forEach items="${requestScope.list}" var="b">
        <tr>
            <td>${b.board_num}</td>
                <%-- 게시글 제목 클릭시 해당 게시글의 상세보기로 넘어가기 --%>
            <c:url var="bdt" value="/bdetail.do">
                <c:param name="board_num" value="${b.board_num}"/>
                <c:param name="page" value="${currentPage}"/>
            </c:url>
                <%-- 제목 글자 앞 댓글과 대댓글 표시 기호 붙임
                    들여쓰기 처리 : --%>
            <td>
                <c:if test="${b.board_lev eq 2}">&nbsp;▶︎&nbsp; </c:if>
                <c:if test="${b.board_lev eq 3}">&nbsp;&nbsp; ▶︎▶︎︎&nbsp; ︎ </c:if>
                <c:if test="${ !empty sessionScope.loginMember}">
                    <a href="${bdt}" style="text-align: left;">${b.board_title}</a>
                </c:if>
                <c:if test="${ empty sessionScope.loginMember}">
                    <a href="login.do">${b.board_title}</a>
                </c:if>
            </td>

            <td>${b.board_writer}</td>
            <td>
                    ${b.board_readcount}
            </td>


            <td><fmt:formatDate value="${b.board_date}" pattern="yyyy-MM-dd"/></td>
        </tr>
    </c:forEach>
</table>
<br><br>
<%-- 페이징 처리 --%>
<div style="text-align: center;">

    <%-- 1페이지 이동 버튼 --%>
    <c:if test="${currentPage eq 1}">
        [1] &nbsp;
    </c:if>
    <c:if test="${currentPage > 1}">
        <c:url var="p1" value="/blist.do">
            <c:param name="page" value="1"/>
        </c:url>
        <a href="${p1}">[1]</a> &nbsp;
    </c:if>


    <%-- 이전 페이지 그룹으로 이동하는 버튼 --%>
    <c:if test="${ !((currentPage-10) < startPage and (currentPage -10) >1)}">
        [...] &nbsp;
    </c:if>

    <c:if test="${ (currentPage-10) < startPage and (currentPage -10) >1}">
        <c:url var="pbefore" value="/blist.do">
            <c:param name="page" value="${startPage-10}"/>
        </c:url>
        <a href="${pbefore}">[...]</a> &nbsp;
    </c:if>


    <%-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 --%>
    <c:forEach var="p" begin="${startPage}" end="${endPage}" step="1">

        <c:if test="${p eq currentPage}">
            <font size="4" color="blue">[${p}]</font>
        </c:if>

        <c:if test="${p ne currentPage}">
            <c:url var="pp" value="blist.do">
                <c:param name="page" value="${p}"/>
            </c:url>
            <a href="${pp}">[${p}]</a>
        </c:if>
    </c:forEach>


    <%-- 다음 페이지 그룹으로 이동하는 버튼 --%>
    <c:if test="${ !((currentPage+10) < endPage and (currentPage +10) <maxPage)}">
        &nbsp; [...] &nbsp;
    </c:if>

    <c:if test="${ (currentPage+10) < endPage and (currentPage +10) <maxPage}">
        <c:url var="pafter" value="/blist.do">
            <c:param name="page" value="${startPage-10}"/>
        </c:url>
        <a href="${pafter}">[...]</a> &nbsp;
    </c:if>


    <%-- 끝페이지 이동 버튼 --%>
    <c:if test="${currentPage eq maxPage}">
        [${maxPage}] &nbsp;
    </c:if>
    <c:if test="${currentPage < maxPage}">
        <c:url var="pmax" value="/blist.do">
            <c:param name="page" value="${maxPage}"/>
        </c:url>
        <a href="${pmax}">[${maxPage}]</a> &nbsp;
    </c:if>


</div>

<hr>
<c:import url="../common/footer.jsp"/>

</body>
</html>
