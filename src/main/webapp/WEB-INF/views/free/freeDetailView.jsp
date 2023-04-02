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
Simple Css --> /* 	html, body{ margin:0; padding:0}
	 */ form td {
	width: 800px;
	margin: 0 auto;
}
body{
        line-height:2em;        
        font-family:"맑은 고딕";
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
	<c:import url="/WEB-INF/views/common/commubar.jsp" />
	<hr>
	<div>
		<p id="title">게시글 상세보기</p>
	</div>
	<div>
			<table width="100%" border="1px solid" cellpadding="0"
				cellspacing="0">
				<tr>
				<c:if test="${ requestScope.free.user_id eq sessionScope.loginMember.user_id }">
				<th>게시물 관리</th><td align="center">
				<c:url var="ffup" value="/freeupdate.do">
					<c:param name="free_no" value="${ free.free_no }" />
				</c:url>
				<a href="${ ffup }">[글수정]</a> &nbsp; &nbsp;
				</c:if>
				
				<c:if test="${ requestScope.free.user_id eq sessionScope.loginMember.user_id }">
				<c:url var="ffde" value="/freedelete.do">
					<c:param name="free_no" value="${ free.free_no }" />
				</c:url>
				<a href="${ ffde }">[글삭제]</a> &nbsp; &nbsp;
				</c:if>
				</td></tr>
				<tr height="40">
					<th>제목</th>
					<td> &nbsp; &nbsp; ${ free.free_name }</td>
				</tr>
				<tr height="40">
					<th>작성자</th>
					<td> &nbsp; &nbsp; ${ free.user_id }</td>
				</tr>
				<tr height="40">
					<th>작성일</th>
					<td> &nbsp; &nbsp; 
					<fmt:formatDate value="${free.write_free_date}" pattern="yyyy-MM-dd a HH:mm:ss"/>
					</td>
				</tr>
				<tr height="40">
					<th>조회수</th>
					<td> &nbsp; &nbsp; ${free.click_free_no}</td>
				</tr>
				<tr height="100">
					<th>내용</th>
					<td>
					&nbsp; &nbsp; 
					${free.free_value}
					</td>
				</tr>
				<tr height="40">
					<th>FILE</th>
					<td>
					<!-- 첨부파일이 있다면, 파일명 클릭시 다운로드 실행 처리 -->
					<c:if test="${ !empty free.originfile_free }">
						<c:url var="ffd" value="/freedown.do">
							<c:param name="ofile" value="${ free.originfile_free }" />
							<c:param name="rfile" value="${ free.renamefile_free }" />
						</c:url>
						&nbsp; &nbsp; [&nbsp; <a href="${ ffd }">${ free.originfile_free }</a> &nbsp;]
					</c:if>
					<!-- 첨부파일이 없다면, 공백 처리 -->
					<c:if test="${ empty free.originfile_free }">
						 &nbsp; &nbsp; Empty
					</c:if>
					</td>
				</tr>
				<tr height="50">
					<th>작성자</th>
					<td align="center" >댓글내용</td>
				</tr>
				<c:forEach items="${ list }" var="f">
				<tr>
				<c:if test="${ f.user_id eq sessionScope.loginMember.user_id }">
				<th>댓글 관리</th>
				<td align="center">
					<c:url var="ffreup" value="/freerepupdate.do">
						<c:param name="free_no" value="${f.free_no }" />
					</c:url>
					<a href="${ ffreup }">[댓글 수정하기]</a> &nbsp;
					</c:if>
					<c:if test="${ f.user_id eq sessionScope.loginMember.user_id }">
					<c:url var="ffrede" value="/freerepdelete.do">
						<c:param name="free_no" value="${ f.free_no }" />
						<c:param name="free_ref" value="${ f.free_ref }" />
						<c:param name="free_reply_ref" value="${ f.free_reply_ref }" />
						<c:param name="free_reply_lev" value="${ f.free_reply_lev }" />
						<c:param name="freeno" value="${ free.free_no }" />
					</c:url>
					<a href="${ ffrede }">[댓글 삭제하기]</a> &nbsp;
					</c:if>
				</td>
				</tr>
				<tr height="35">
					<c:if test="${ f.free_reply_lev eq 2 }">
					<th>${f.user_id}</th>
					<td>&nbsp; &nbsp; ${f.free_value} <br>
					</td>
					</c:if>
					<c:if test="${ f.free_reply_lev eq 3 }">
					<th>${f.user_id}</th>
					<td>&nbsp; &nbsp; &nbsp;   &nbsp;▶ ${f.free_value}</td>
					</c:if>
				</tr>
				</c:forEach>
			</table>
			<div>
			<table>
			<c:if test="${ requestScope.free.user_id ne sessionScope.loginMember.user_id }">
			<c:url var="ffrein" value="/freerepinsert.do">
				<c:param name="free_no" value="${free.free_no }" />
				<c:param name="page" value="${ currentPage }" />
			</c:url>
			<a href="${ ffrein }">[댓글달기]</a> &nbsp;
			</c:if>
			</table>
		</div>
	</div>
	<br>
<hr>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>