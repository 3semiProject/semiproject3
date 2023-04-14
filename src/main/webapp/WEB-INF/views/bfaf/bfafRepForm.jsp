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
   position: static;
   top: 50%;
   left: 50%;
   width: 400px;
   transform: translate(100%, 0%);
   text-decoration: none;
   background-color: white;
   text-align: center;
   color: #01CD88;
   font-weight: bold;
   text-shadow: 1px 1px 2px #D1D1D1;
   font-size: 20pt;
   border: 1px solid;
}

table {
  margin-bottom: 50px;
  margin-left:125px;
  padding: 30px;
  width: 1000px;
  -moz-border-radius: 5px !important;
  border-collapse: collapse !important;
  border: none !important;
  border-style: hidden;
  background-color: #DCFFDC;
  border-radius: 20px;
}
table th,
table td {
  border: none !important
}
table th:first-child {
  -moz-border-radius: 5px 0 0 0 !important;
}
table th:last-child {
  -moz-border-radius: 0 5px 0 0 !important;
}
table tr:last-child td:first-child {
  -moz-border-radius: 0 0 0 5px !important;
}
table tr:last-child td:last-child {
  -moz-border-radius: 0 0 5px 0 !important;
}

textarea{
	width: 850px;
	height: 100px;
	border: none;
    resize: none !important;
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
		<p id="title">댓글 작성</p>
	</div>
	<div>
		<form action="bfafrepinsert.do" method="post"
			enctype="multipart/form-data" name="boardform">
			<input type="hidden" name="bfaf_ref" value="${ bfaf_ref }">
			<input type="hidden" name="bfaf_name" value="${ bfaf_ref }번 게시물 댓글">
			<table width="100%" border="1px solid" cellpadding="0"
				cellspacing="0">
				<tr height="40">
					<th>작성자</th>
					<td><input name="user_id"
						value="${ sessionScope.loginMember.user_id }" readonly /></td>
				</tr>
				<tr  height="40">
					<th>내용</th>
					<td><textarea name="bfaf_value"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="등록">
						<input type="button" value="뒤로가기"
						onclick="javascript:history.go(-1)"> &nbsp;&nbsp;</td>
				</tr>
			</table>
		</form>
	</div>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>