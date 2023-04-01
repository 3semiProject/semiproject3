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
<!-- <script type="text/javascript">
	$(function() {

		$('#ffdiv').css('display', 'block');
		$('#ebdiv').css('display', 'none');
		$('#ttdiv').css('display', 'none');
		$('#badiv').css('display', 'none');

		$('select[name=searchtype]').on("change", function() {
			$('#ffdiv').css('display', 'none');
			$('#ebdiv').css('display', 'none');
			$('#ttdiv').css('display', 'none');
			$('#badiv').css('display', 'none');

			$(this).children().each(function() {
				if ($(this).is(":selected")) {
					$($(this).val()).css('display', 'block');
					
					
				}// if

			});// each

		}); //onchange

		

	}); //ready

</script> -->
<title></title>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<c:import url="/WEB-INF/views/common/csbar.jsp" />
	<hr>
	<div id="qnarediv">
		<form action="qreply.do" method="post" enctype="multipart/form-data" name="boardform">
			<input type="hidden" name="qna_ref" value="${ qna_no }">
			<input type="hidden" name="page" value="${ currentPage }">
			
			<table width="100%" border="1px solid" cellpadding="0"
				cellspacing="0">
				<tr>
					<th>게시판 종류</th>
					<td align="center">QnA 답변</td>
				</tr>
				<tr height="40">
					<th>작성자</th>
					<td><input name="user_id"
						value="${ sessionScope.loginMember.user_id }" readonly /></td>
				</tr>
				<tr height="40">
					<th>제목</th>
					<td><input name="qna_title" type="text" style="width: 90%;" /></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="qna_content"
							style="width: 90%; height: 200px;"></textarea>
					</td>
				</tr>
				<tr height="40">
					<th>FILE</th>
					<td><input name="upfile" type="file" /></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="등록">
						<input type="button" value="뒤로가기"
						onclick="javascript:history.go(-1)"></td>
				</tr>
			</table>
		</form>
	</div>
	<br>

		<script type="text/javascript">
	    CKEDITOR.replace("qna_content", { height: 100 });
		</script>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>