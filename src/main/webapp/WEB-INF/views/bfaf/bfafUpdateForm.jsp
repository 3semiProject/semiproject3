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
		<p id="title">게시글 수정</p>
	</div>
	<div>
		<form action="bfafupdate.do" method="post"
			enctype="multipart/form-data" name="boardform">
			<input type="hidden" name="bfaf_no" value="${ bfaf.bfaf_no }">
			<table width="100%" border="1px solid" cellpadding="0"
				cellspacing="0">
				<tr>
					<th>게시판 종류</th>
					<td align="center">BF & AF</td>
				</tr>
				<tr height="40">
					<th>작성자</th>
					<td><input name="user_id"
						value="${ sessionScope.loginMember.user_id }" readonly /></td>
				</tr>
				<tr height="40">
					<th>제목</th>
					<td><input name="bfaf_name" type="text" value="${ bfaf.bfaf_name }" style="width: 90%;" /></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="bfaf_value" style="width: 90%; height: 200px;">
					${ bfaf.bfaf_value }
					</textarea>
					</td>
				</tr>
				<tr height="40">
					<th>FILE</th>
					<td>
					<c:if test="${ !empty bfaf.originfile_bfaf }">
					${ bfaf.originfile_bfaf } &nbsp; 
					<input type="checkbox" name="delflag" value="yes"> 파일삭제
					<br>
					</c:if>
					새로 첨부 : <input type="file" name="upfile">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="수정하기"> &nbsp; 
						<input type="reset" value="수정취소"> &nbsp; 
						<input type="button" value="뒤로가기"
						onclick="javascript:history.go(-1)"></td>
				</tr>
			</table>
		</form>
	</div>
<hr>
<script type="text/javascript">
CKEDITOR.replace("free_value", { height: 100 });
</script>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>