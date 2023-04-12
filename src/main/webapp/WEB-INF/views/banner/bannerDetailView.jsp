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
	<hr>
	<div>
		<p id="title">유튜브 & 기사 상세보기</p>
	</div>
	<div>
		<table width="100%" border="1px solid" cellpadding="0" cellspacing="0">
			<tr>
				<c:if test="${ sessionScope.loginMember.admin_ck eq 'Y' }">
					<th>유튜브 & 기사 관리</th>
					<td align="left"><c:url var="baup" value="/baupview.do">
							<c:param name="banner_no" value="${ banner.banner_no }" />
						</c:url> <a href="${ baup }">[글수정]</a> &nbsp; &nbsp;
				</c:if>
				<c:if
					test="${ loginMember.admin_ck eq 'Y' }">
					<c:url var="bade" value="/bannerDelete.do">
						<c:param name="banner_no" value="${ banner.banner_no }" />
					</c:url>
					<a href="${ bade }">[글삭제]</a> &nbsp; &nbsp;
           		</c:if>
				<button onclick="javascript:location.href='bannerlist.do?page=${ currentPage }';">목 록</button>
				</td>
			</tr>
			<tr height="40">
				<th>제목</th>
				<td>&nbsp; &nbsp; ${ banner.banner_title }</td>
			</tr>
			<tr height="40">
				<th>작성자</th>
				<td>&nbsp; &nbsp; ${ banner.user_id }</td>
			</tr>
			<tr height="40">
				<th>작성일</th>
				<td>&nbsp; &nbsp; <fmt:formatDate
						value="${ banner.banner_post_date }" pattern="yyyy-MM-dd a HH:mm:ss" />
				</td>
			</tr>
			<tr height="40">
				<th>링크</th>
				<td>&nbsp; &nbsp; ${ banner.banner_link_adrress }</td>
			</tr>
			<tr height="40">
				<th>항목</th>
				<td>&nbsp; &nbsp;
					<c:if test="${ banner.banner_item eq 'Y' }">		
						유튜브
					</c:if>		
					<c:if test="${ banner.banner_item eq 'A' }">		
						기사
					</c:if>
				</td>
			</tr>
		</table>
	</div>
	<br>


	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>