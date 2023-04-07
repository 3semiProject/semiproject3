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
function fileCheck(obj) {
    pathpoint = obj.value.lastIndexOf('.');
    filepoint = obj.value.substring(pathpoint+1,obj.length);
    filetype = filepoint.toLowerCase();
    if(filetype=='jpg' || filetype=='gif' || filetype=='png' || filetype=='jpeg' || filetype=='bmp') {

        // 정상적인 이미지 확장자 파일일 경우 ...

    } else {
        alert('이미지 파일만 선택할 수 있습니다.');

        parentObj  = obj.parentNode
        node = parentObj.replaceChild(obj.cloneNode(true),obj);

        return false;
    }
    if(filetype=='bmp') {
        upload = confirm('BMP 파일은 웹상에서 사용하기엔 적절한 이미지 포맷이 아닙니다.\n그래도 계속 하시겠습니까?');
        if(!upload) return false;
    }
}
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
			<input type="hidden" name="originfile_bfaf" value="${ bfaf.originfile_bfaf }">
			<input type="hidden" name="renamefile_bfaf" value="${ bfaf.renamefile_bfaf }">
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
					<c:forEach items="${ ofile }" var="of" varStatus="status">
					<c:if test="${ !empty of }">
					${ of } &nbsp; 
					<input type="checkbox" name="delflag" value="${ rfile[status.index] }"> 파일삭제
					<br>
					</c:if>
					</c:forEach>
					새로 첨부 : <input type="file" name="upfile"
					accept="image/gif, image/jpeg, image/png" onchange="fileCheck(this)"><br>
					새로 첨부 : <input type="file" name="upfile"
					accept="image/gif, image/jpeg, image/png" onchange="fileCheck(this)"><br>
					새로 첨부 : <input type="file" name="upfile"
					accept="image/gif, image/jpeg, image/png" onchange="fileCheck(this)"><br>
					* 신규파일 첨부시 기존 첨부파일은 삭제됩니다 *
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
CKEDITOR.replace("bfaf_value", { height: 100 });
</script>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>