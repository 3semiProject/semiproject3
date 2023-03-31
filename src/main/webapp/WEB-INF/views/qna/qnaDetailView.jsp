<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="currentPage" value="${ requestScope.currentPage }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<c:import url="/WEB-INF/views/common/csbar.jsp" />
<hr>
<h2 align="center">
    ${ requestScope.qna.qna_no }번 QnA 상세보기
</h2>
<br>
<table align="center" width="500" border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>제 목</th>
        <td>${qna.qna_title}</td>
    </tr>
    <tr>
        <th>작성자</th>
        <td>${qna.user_id}</td>
    </tr>
    <tr>
        <th>날 짜</th>
        <td>${qna.qna_post_date}</td>
    </tr>
    <tr>
        <th>첨부파일</th>
        <td>
            <%-- 첨부파일이 있다면 --%>
            <c:if test="${ !empty qna.qna_originfile}">
                <c:url var="qfd" value="/qfdown.do">
                    <c:param name="ofile" value="${qna.qna_originfile}"/>
                    <c:param name="rfile" value="${qna.qna_renamefile}"/>
                </c:url>
                <a href="${qfd}">${qna.qna_originfile}</a>
            </c:if>
            <c:if test="${empty qna.qna_originfile}">
                &nbsp;
            </c:if>
        </td>
    </tr>
    <tr>
        <th>내 용</th><td>${qna.qna_content}</td></tr>
	<tr><th colspan="2">
		<button onclick="javascript:location.href='qnalist.do?page=${ currentPage }';">목 록</button>
		&nbsp;
		<!-- 본인이 등록한 게시글 일 때는 수정과 삭제 기능 제공 -->
		<c:if test="${ requestScope.qna.user_id eq sessionScope.loginMember.user_id }">
			<c:url var="qup" value="/qupview.do">
				<c:param name="qna_no" value="${ qna.qna_no }" />
				<c:param name="page" value="${ currentPage }" />
			</c:url>
			<a href="${ qup }">[수정페이지로 이동]</a> &nbsp;
			
			<c:url var="qdl" value="/qdel.do">
				<c:param name="qna_no" value="${ qna.qna_no }" />
				<c:param name="qna_lev" value="${ qna.qna_lev }" />
				<c:param name="qna_renamefile" value="${ qna.qna_renamefile }" />
			</c:url>
			<a href="${ qdl }">[글삭제]</a> &nbsp;
		</c:if>
	</th></tr>
</table>

<hr>
<c:import url="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
