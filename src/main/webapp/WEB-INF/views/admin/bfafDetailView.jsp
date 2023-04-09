<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
body{
		width:1200px;
		height: 1200px;
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
<c:if test="${ sessionScope.loginMember.admin_ck eq 'Y' and !empty sessionScope.loginMember}">
				<c:url var="ffde" value="/adBfafdelete.do" />
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<hr>
	<div>
		<p id="title">BF & AF 게시글 상세보기</p>
	</div>
	<div>
		<table width="100%" border="1px solid" cellpadding="0" cellspacing="0">
			<tr>
			<th>게시물 관리</th><td align="center">
			<c:if test="${ sessionScope.loginMember.admin_ck eq 'Y' and !empty sessionScope.loginMember}">
					<c:url var="bade" value="/adBfafdelete.do">
						<c:param name="bfaf_no" value="${ bfaf.bfaf_no }" />
					</c:url>
					<a href="${ bade }">[글삭제]</a> &nbsp; &nbsp;
				</c:if>
				</td>
			</tr>
			<tr height="40">
				<th>제목</th>
				<td>&nbsp; &nbsp; ${ bfaf.bfaf_name }</td>
			</tr>
			<tr height="40">
				<th>작성자</th>
				<td>&nbsp; &nbsp; ${ bfaf.user_id }</td>
			</tr>
			<tr height="40">
				<th>작성일</th>
				<td>&nbsp; &nbsp; <fmt:formatDate
						value="${bfaf.write_bfaf_date}" pattern="yyyy-MM-dd a HH:mm:ss" />
				</td>
			</tr>
			<tr height="40">
				<th>조회수</th>
				<td>&nbsp; &nbsp; ${bfaf.click_bfaf_no}</td>
			</tr>
			<tr height="100">
				<th>내용</th>
				<td>
				<c:forEach items="${ rfile }" var="rf">
					<c:if test="${ !empty rf and !empty sessionScope.loginMember}">
					<br>
					&nbsp; &nbsp; <img src="${ pageContext.servletContext.contextPath }/resources/bfaf_upfiles/${rf}" width="400" alt="upfile">
					<br>
				</c:if>
				</c:forEach>
				&nbsp; &nbsp; ${bfaf.bfaf_value}</td>
			</tr>
			<tr height="40">
				<th>FILE</th>
				<td>
					<!-- 첨부파일이 있다면, 파일명 클릭시 다운로드 실행 처리 -->
					<c:forEach items="${ ofile }" var="of" varStatus="status">
					<c:if test="${ !empty of and !empty sessionScope.loginMember}">
						<c:url var="babd" value="/adBfafdown.do">
							<c:param name="ofile" value="${ of }" />
							<c:param name="rfile" value="${ rfile[status.index] }" />
						</c:url>
						&nbsp; &nbsp; &nbsp; <a href="${ babd }">${ of }</a> &nbsp;
					</c:if>
					</c:forEach> 
					<!-- 첨부파일이 없다면, Empty 처리 --> 
					<c:if test="${ empty bfaf.originfile_bfaf}">
						 &nbsp; &nbsp; Empty
					</c:if>
				</td>
			</tr>
			<tr height="100">
				<th>게시글 추천</th>
				<td>
					<!-- likeFree --> 
				<c:if test="${!empty likeBfaf.user_id and likeBfaf.user_id eq sessionScope.loginMember.user_id}">
					&nbsp; <img
							src="${ pageContext.servletContext.contextPath }/resources/images/fullheart.png"
							width="30" height="30" alt="fullheart"> &nbsp; 
					좋아요 ${bfaf.bfaf_like_no}개 &nbsp; &nbsp;
					</c:if>
					<c:if test="${empty likeBfaf.user_id or likeBfaf.user_id ne sessionScope.loginMember.user_id}">
					&nbsp; <img
							src="${ pageContext.servletContext.contextPath }/resources/images/heart.png"
							width="30" height="30" alt="heart"> &nbsp; 
					좋아요 ${bfaf.bfaf_like_no}개 &nbsp; &nbsp;
					</c:if> 
				</td>
			</tr>
			<tr height="50">
				<th>댓글 작성자</th>
				<td align="center">댓글내용 &nbsp; &nbsp; 
				<c:if test="${ sessionScope.loginMember.admin_ck eq 'Y' and !empty sessionScope.loginMember}">
				<c:url var="barede" value="/adBfafrepdelete.do">
									<c:param name="bfaf_no" value="${ ba.bfaf_no }" />
									<c:param name="bfaf_ref" value="${ ba.bfaf_ref }" />
									<c:param name="bfaf_reply_ref" value="${ ba.bfaf_reply_ref }" />
									<c:param name="bfaf_reply_lev" value="${ ba.bfaf_reply_lev }" />
									<c:param name="bfafno" value="${ bfaf.bfaf_no }" />
								</c:url>
								<a href="${ barede }">[댓글 삭제하기]</a> &nbsp;
				</c:if> 	
				</td>
			</tr>
			<c:forEach items="${ list }" var="ba">
				<tr height="35">
					<c:if test="${ ba.bfaf_reply_lev eq 2 }">
						<th>${ba.user_id}</th>
						<td>&nbsp; &nbsp; ${ba.bfaf_value} &nbsp; 
					<c:if test="${ sessionScope.loginMember.admin_ck eq 'Y' and !empty sessionScope.loginMember}">
								<c:url var="barede" value="/adBfafrepdelete.do">
									<c:param name="bfaf_no" value="${ ba.bfaf_no }" />
									<c:param name="bfaf_ref" value="${ ba.bfaf_ref }" />
									<c:param name="bfaf_reply_ref" value="${ ba.bfaf_reply_ref }" />
									<c:param name="bfaf_reply_lev" value="${ ba.bfaf_reply_lev }" />
									<c:param name="bfafno" value="${ bfaf.bfaf_no }" />
								</c:url>
								<a href="${ barede }">[댓글 삭제하기]</a> &nbsp;
						</c:if> 
						</td>
					</c:if>
					<c:if test="${ ba.bfaf_reply_lev eq 3 }">
						<th>${ba.user_id}</th>
						<td>&nbsp; &nbsp; &nbsp; &nbsp; ▶ ${ba.bfaf_value}
					<c:if test="${ sessionScope.loginMember.admin_ck eq 'Y' and !empty sessionScope.loginMember}">
								<c:url var="barede2" value="/adBfafrepdelete.do">
									<c:param name="bfaf_no" value="${ ba.bfaf_no }" />
									<c:param name="bfaf_ref" value="${ ba.bfaf_ref }" />
									<c:param name="bfaf_reply_ref" value="${ ba.bfaf_reply_ref }" />
									<c:param name="bfaf_reply_lev" value="${ ba.bfaf_reply_lev }" />
									<c:param name="bfafno" value="${ bfaf.bfaf_no }" />
								</c:url>
								<a href="${ barede2 }">[댓글 삭제하기]</a> &nbsp;
					</c:if>
						</td>
					</c:if>
				</tr>
			</c:forEach>
			<tr>
					<td colspan="2" align="right">
						<c:if test="${!empty sessionScope.loginMember}">
						<input type="button" value="메인페이지"
						onclick="location.href='main.do'">
						</c:if>
						<input type="button" value="뒤로가기"
						onclick="javascript:history.go(-1)"></td>
				</tr>
		</table>
	</div>
	<br>
	<hr>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</c:if>
</body>
</html>