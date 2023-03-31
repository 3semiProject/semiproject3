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
<style type="text/css">
a:link, a:visited 
{
	text-decoration: none; 
	color: #656565;
}
.event_view 
{
	width:50%;
	border-top:2px solid #252525;
	border-bottom:1px solid #ccc
}
.event_view tbody th 
{
	text-align:left;
	background:#01CD88;
	color:#3b3a3a
}
.event_view tbody th.list_tit 
{
	font-size:13px;
	color:#000;
	letter-spacing:0.1px
}
.event_view tbody .no_line_b th, .event_view tbody .no_line_b td 
{
	border-bottom:none
}
.event_view tbody th, .event_view tbody td 
{
	padding:15px 0 16px 16px;
	border-bottom:1px solid #ccc
}
.event_view tbody td.view_text 
{
	border-top:1px solid #ccc; 
	border-bottom:1px solid #ccc;
	padding:45px 18px 45px 18px
}
.event_view tbody th.th_file 
{
	padding:0 0 0 15px; 
	vertical-align:middle
}
.wdp_90 
{
	width:90%
}
.btn 
{
	border-radius:3px;
	padding:5px 11px;
	color:#fff !important;
	display:inline-block; 
	background-color:#01CD88; 
	border:1px solid #56819d;
	vertical-align:middle
}
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<c:import url="/WEB-INF/views/common/csbar.jsp" />
<hr>
<br>
	<table class="event_view">
		<colgroup>
			<col width="15%"/>
			<col width="35%"/>
			<col width="15%"/>
			<col width="35%"/>
		</colgroup>
		<caption>게시글 상세</caption>
		<tbody>
			<tr>
				<th scope="row">글 번호</th>
				<td>${event.event_no }</td>
				<th scope="row">조회수</th>
				<td>${event.event_views }</td>
			</tr>
			<tr>
				<th scope="row">작성자</th>
				<td>${event.user_id }</td>
				<th scope="row">작성시간</th>
				<td>${event.write_event_date }</td>
			</tr>
			<tr>
				<th scope="row">첨부파일</th>
				<td colspan="3">            
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
				<th scope="row">제목</th>
				<td colspan="3">${event.event_title }</td>
			</tr>
			<tr>
				<td colspan="4">${event.event_content }</td>
			</tr>
		</tbody>
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
