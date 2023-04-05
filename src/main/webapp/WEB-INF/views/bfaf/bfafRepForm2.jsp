<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//cdn.ckeditor.com/4.7.3/standard/ckeditor.js"></script>
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
		<p id="title">대댓글 작성</p>
	</div>
	<div>
		<form action="bfafrepinsert2.do" method="post"
			enctype="multipart/form-data" name="boardform">
			<input type="hidden" name="bfaf_reply_ref" value="${ bfaf.bfaf_reply_ref }">
			<input type="hidden" name="bfaf_ref" value="${ bfaf.bfaf_ref }">
			<input type="hidden" name="bfaf_name" value="${ bfaf.bfaf_ref }번 게시물 ${ bfaf.bfaf_reply_ref }번째 댓글의 댓글">
			<table width="100%" border="1px solid" cellpadding="0"
				cellspacing="0">
				<tr height="40">
					<th>작성자</th>
					<td><input name="user_id"
						value="${ sessionScope.loginMember.user_id }" readonly /></td>
				</tr>
				<tr  height="40">
					<th>내용</th>
					<td><textarea name="bfaf_value" style="width: 90%;"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="등록">
						<input type="button" value="뒤로가기"
						onclick="javascript:history.go(-1)"></td>
				</tr>
			</table>
		</form>
	</div>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>