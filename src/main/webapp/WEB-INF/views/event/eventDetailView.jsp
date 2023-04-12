<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
<!--
Simple Css --> /*    html, body{ margin:0; padding:0}
    */ form td {
	width: 800px;
	margin: 0 auto;
}

body {
	line-height: 2em;
	font-family: "맑은 고딕";
}

#title {
	text-decoration: none;
	background-color: white;
	text-align: center;
	color: #01CD88;
	font-weight: bold;
	text-shadow: 1px 1px 2px #D1D1D1;
	font-size: 20pt;
	border: 1px solid;
}
</style>
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
   
</script>
<title></title>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<c:import url="/WEB-INF/views/common/csbar.jsp" />
	<hr>
	<div>
		<p id="title">EVENT 상세보기</p>
	</div>
	<div>
		<table width="100%" border="1px solid" cellpadding="0" cellspacing="0">
			<tr>
				<c:if
					test="${ sessionScope.loginMember.admin_ck eq 'Y' }">
					<th>EVENT 게시물 관리</th>
					<td align="center"><c:url var="eup" value="/evtupview.do">
							<c:param name="event_no" value="${ event.event_no }" />
						</c:url> <a href="${ eup }">[글수정]</a> &nbsp; &nbsp;
				</c:if>

				<c:if
					test="${ sessionScope.loginMember.admin_ck eq 'Y' }">
					<c:url var="ede" value="/edel.do">
						<c:param name="event_no" value="${ event.event_no }" />
					</c:url>
					<a href="${ ede }">[글삭제]</a> &nbsp; &nbsp;
            </c:if>
				</td>
			</tr>
			<tr height="40">
				<th>제목</th>
				<td>&nbsp; &nbsp; ${ event.event_title }</td>
			</tr>
			<tr height="40">
				<th>작성자</th>
				<td>&nbsp; &nbsp; ${ event.user_id }</td>
			</tr>
			<tr height="40">
				<th>작성일</th>
				<td>&nbsp; &nbsp; <fmt:formatDate
						value="${ event.write_event_date }" pattern="yyyy-MM-dd a HH:mm:ss" />
				</td>
			</tr>
			<tr height="40">
				<th>조회수</th>
				<td>&nbsp; &nbsp; ${ event.event_views }</td>
			</tr>
			<tr height="100">
				<th>내용</th>
				<td>&nbsp; &nbsp; ${ event.event_content }</td>
			</tr>
			<tr height="40">
				<th>FILE</th>
				<td>
					<!-- 첨부파일이 있다면, 파일명 클릭시 다운로드 실행 처리 --> <c:if
						test="${ !empty event.event_originfile }">
						<c:url var="efd" value="/efdown.do">
							<c:param name="ofile" value="${ event.event_originfile }" />
							<c:param name="rfile" value="${ event.event_renamefile }" />
						</c:url>
                  &nbsp; &nbsp; [&nbsp; <a href="${ efd }">${ event.event_originfile }</a> &nbsp;]
               </c:if> <!-- 첨부파일이 없다면, 공백 처리 --> <c:if
						test="${ empty event.event_originfile }">
                   &nbsp; &nbsp; Empty
               </c:if>
				</td>
			</tr>
		</table>
	</div>
	<br>


	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>