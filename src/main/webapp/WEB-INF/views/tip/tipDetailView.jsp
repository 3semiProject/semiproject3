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
	<c:import url="/WEB-INF/views/common/commubar.jsp" />
	<hr>
	<div>
		<p id="title">TIP 게시글 상세보기</p>
	</div>
	<div>
		<table width="100%" border="1px solid" cellpadding="0" cellspacing="0">
			<tr>
				<c:if
					test="${ requestScope.tip.user_id eq sessionScope.loginMember.user_id and !empty sessionScope.loginMember}">
					<th>게시물 관리</th>
					<td align="center"><c:url var="ttup" value="/tipupmove.do">
							<c:param name="tip_no" value="${ tip.tip_no }" />
						</c:url> <a href="${ ttup }">[글수정]</a> &nbsp; &nbsp;
				</c:if>

				<c:if
					test="${ requestScope.tip.user_id eq sessionScope.loginMember.user_id and !empty sessionScope.loginMember}">
					<c:url var="ttde" value="/tipdelete.do">
						<c:param name="tip_no" value="${ tip.tip_no }" />
					</c:url>
					<a href="${ ttde }">[글삭제]</a> &nbsp; &nbsp;
				</c:if>
				</td>
			</tr>
			<tr height="40">
				<th>제목</th>
				<td>&nbsp; &nbsp; ${ tip.tip_name }</td>
			</tr>
			<tr height="40">
				<th>작성자</th>
				<td>&nbsp; &nbsp; ${ tip.user_id }</td>
			</tr>
			<tr height="40">
				<th>작성일</th>
				<td>&nbsp; &nbsp; <fmt:formatDate value="${tip.write_tip_date}"
						pattern="yyyy-MM-dd a HH:mm:ss" />
				</td>
			</tr>
			<tr height="40">
				<th>조회수</th>
				<td>&nbsp; &nbsp; ${tip.click_tip_no}</td>
			</tr>
			<tr height="100">
				<th>내용</th>
				<td>
				<c:if test="${ !empty tip.renamefile_tip and !empty sessionScope.loginMember}">
					<br>
					&nbsp; &nbsp; <img src="${ pageContext.servletContext.contextPath }/resources/tip_upfiles/${tip.renamefile_tip}" width="400" alt="upfile">
					<br>
				</c:if>
				&nbsp; &nbsp; ${tip.tip_value}</td>
			</tr>
			<tr height="40">
				<th>FILE</th>
				<td>
					<!-- 첨부파일이 있다면, 파일명 클릭시 다운로드 실행 처리 --> <c:if
						test="${ !empty tip.originfile_tip and !empty sessionScope.loginMember}">
						<c:url var="ttd" value="/tipdown.do">
							<c:param name="ofile" value="${ tip.originfile_tip }" />
							<c:param name="rfile" value="${ tip.renamefile_tip }" />
						</c:url>
						&nbsp; &nbsp; &nbsp; <a href="${ ttd }">${ tip.originfile_tip }</a> &nbsp;
					</c:if> <!-- 첨부파일이 없다면, Empty 처리 --> <c:if
						test="${ empty tip.originfile_tip}">
						 &nbsp; &nbsp; Empty
					</c:if>
				</td>
			</tr>
			<tr height="100">
				<th>게시글 추천</th>
				<td>
					<!-- likeFree --> <c:if
						test="${!empty likeTip.user_id and likeTip.user_id eq sessionScope.loginMember.user_id}">
					&nbsp; <img
							src="${ pageContext.servletContext.contextPath }/resources/images/fullheart.png"
							width="30" height="30" alt="fullheart"> &nbsp; 
					좋아요 ${tip.tip_like_no}개 &nbsp; &nbsp;
					</c:if> <c:if
						test="${empty likeTip.user_id or likeTip.user_id ne sessionScope.loginMember.user_id}">
					&nbsp; <img
							src="${ pageContext.servletContext.contextPath }/resources/images/heart.png"
							width="30" height="30" alt="heart"> &nbsp; 
					좋아요 ${tip.tip_like_no}개 &nbsp; &nbsp;
					</c:if> <c:if test="${ !empty sessionScope.loginMember }">
						<c:url var="ttlikein" value="/tiplike.do">
							<c:param name="user_id"
								value="${sessionScope.loginMember.user_id }" />
							<c:param name="tip_no" value="${tip.tip_no }" />
							<c:param name="tip_like_no" value="${tip.tip_like_no }" />
						</c:url>
						<a href="${ ttlikein }">[추천하기]</a>
					</c:if>
				</td>
			</tr>
			<tr height="50">
				<th>댓글 작성자</th>
				<td align="center">댓글내용 &nbsp; &nbsp; <c:if
						test="${ !empty sessionScope.loginMember.user_id and !empty sessionScope.loginMember}">
						<c:url var="ttrein" value="/movetiprepin.do">
							<c:param name="tip_no" value="${tip.tip_no }" />
						</c:url>
						<a href="${ ttrein }">[댓글등록]</a>
					</c:if>
				</td>
			</tr>
			<c:forEach items="${ list }" var="t">
				<tr height="35">
					<c:if test="${ t.tip_reply_lev eq 2 }">
						<th>${t.user_id}</th>
						<td>&nbsp; &nbsp; ${t.tip_value} &nbsp; <c:if
								test="${ t.user_id eq sessionScope.loginMember.user_id and !empty sessionScope.loginMember}">
								<c:url var="ttreup" value="/movetiprepup.do">
									<c:param name="tip_no" value="${t.tip_no }" />
								</c:url>
								<a href="${ ttreup }">[댓글 수정하기]</a> &nbsp;
					</c:if> <c:if
								test="${ t.user_id eq sessionScope.loginMember.user_id and !empty sessionScope.loginMember}">
								<c:url var="ttrede" value="/tiprepdelete.do">
									<c:param name="tip_no" value="${ t.tip_no }" />
									<c:param name="tip_ref" value="${ t.tip_ref }" />
									<c:param name="tip_reply_ref" value="${ t.tip_reply_ref }" />
									<c:param name="tip_reply_lev" value="${ t.tip_reply_lev }" />
									<c:param name="tipno" value="${ tip.tip_no }" />
								</c:url>
								<a href="${ ttrede }">[댓글 삭제하기]</a> &nbsp;
					</c:if> <c:if test="${!empty sessionScope.loginMember}">
								<c:url var="ttrereup" value="/movetiprepin2.do">
									<c:param name="tip_ref" value="${t.tip_ref }" />
									<c:param name="tip_reply_ref" value="${t.tip_reply_ref }" />
									<c:param name="tip_reply_lev" value="${t.tip_reply_lev }" />
								</c:url>
								<a href="${ ttrereup }">[대댓글등록]</a>
							</c:if>
						</td>
					</c:if>
					<c:if test="${ t.tip_reply_lev eq 3 }">
						<th>${t.user_id}</th>
						<td>&nbsp; &nbsp; &nbsp; &nbsp; ▶ ${t.tip_value} <c:if
								test="${ t.user_id eq sessionScope.loginMember.user_id and !empty sessionScope.loginMember}">
								<c:url var="ttreup2" value="/movetiprepup.do">
									<c:param name="tip_no" value="${t.tip_no }" />
								</c:url>
								<a href="${ ttreup2 }">[댓글 수정하기]</a> &nbsp;
					</c:if> <c:if
								test="${ t.user_id eq sessionScope.loginMember.user_id and !empty sessionScope.loginMember}">
								<c:url var="ttrede2" value="/tiprepdelete.do">
									<c:param name="tip_no" value="${ t.tip_no }" />
									<c:param name="tip_ref" value="${ t.tip_ref }" />
									<c:param name="tip_reply_ref" value="${ t.tip_reply_ref }" />
									<c:param name="tip_reply_lev" value="${ t.tip_reply_lev }" />
									<c:param name="tipno" value="${ tip.tip_no }" />
								</c:url>
								<a href="${ ttrede2 }">[댓글 삭제하기]</a> &nbsp;
					</c:if>
						</td>
					</c:if>
				</tr>
			</c:forEach>
			<tr>
					<td colspan="2" align="right">
						<c:if test="${empty sessionScope.loginMember}">
						* 메인페이지의 TOP5 게시글 상세보기 이외의 모든 기능을 이용하시려면 로그인해주세요 *
						<input type="button" value="로그인이동"
						onclick="location.href='loginPage.do'">
						</c:if>
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
</body>
</html>