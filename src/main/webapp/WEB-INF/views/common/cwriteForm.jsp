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


</script>

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
		<p id="title">게시글 작성</p>
		<select name="searchtype">
			<option value="#ffdiv" selected>FREE</option>
			<option value="#ttdiv">TIP</option>
			<option value="#ebdiv">EYEBODY</option>
			<option value="#badiv">BF & AF</option>
		</select>
	</div>
	<div id="ffdiv">
		<form action="commuinsert.do" method="post"
			enctype="multipart/form-data" name="boardform">
			<table width="100%" border="1px solid" cellpadding="0"
				cellspacing="0">
				<tr>
					<th>게시판 종류</th>
					<td align="center">FREE</td>
				</tr>
				<tr height="40">
					<th>작성자</th>
					<td><input name="user_id"
						value="${ sessionScope.loginMember.user_id }" readonly /></td>
				</tr>
				<tr height="40">
					<th>제목</th>
					<td><input name="free_name" type="text" style="width: 90%;" required/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="free_value"
							style="width: 90%; height: 200px;"required></textarea>
	
					</td>
				</tr>
				<tr height="40">
					<th>FILE</th>
					<td><input name="upfile" type="file" 
					accept="image/gif, image/jpeg, image/png" onchange="fileCheck(this)"/></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="등록">
						<input type="button" value="뒤로가기"
						onclick="javascript:history.go(-1)"></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="ebdiv">
		<form action="eyebodyinsert.do" method="post"
			enctype="multipart/form-data" name="boardform">
			<table width="100%" border="1px solid" cellpadding="0"
				cellspacing="0">
				<tr>
					<th>게시판 종류</th>
					<td align="center">EYEBODY</td>
				</tr>
				<tr height="40">
					<th>작성자</th>
					<td><input name="user_id"
						value="${ sessionScope.loginMember.user_id }" readonly /></td>
				</tr>
				<tr height="40">
					<th>제목</th>
					<td><input name="eyebody_name" type="text" style="width: 90%;" required/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="eyebody_value"
							style="width: 90%; height: 200px;" required></textarea>
					</td>
				</tr>
				<tr height="40">
					<th>FILE</th>
					<td><input name="upfile" type="file" 
					accept="image/gif, image/jpeg, image/png" onchange="fileCheck(this)"/></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="등록">
						<input type="button" value="뒤로가기"
						onclick="javascript:history.go(-1)"></td>
				</tr>
			</table>
		</form>
		
	</div>
	<div id="ttdiv">
		<form action="tipinsert.do" method="post"
			enctype="multipart/form-data" name="boardform">
			<table width="100%" border="1px solid" cellpadding="0"
				cellspacing="0">
				<tr>
					<th>게시판 종류</th>
					<td align="center">TIP</td>
				</tr>
				<tr height="40">
					<th>작성자</th>
					<td><input name="user_id"
						value="${ sessionScope.loginMember.user_id }" readonly /></td>
				</tr>
				<tr height="40">
					<th>제목</th>
					<td><input name="tip_name" type="text" style="width: 90%;" required/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="tip_value"
							style="width: 90%; height: 200px;" required></textarea>
					</td>
				</tr>
				<tr height="40">
					<th>FILE</th>
					<td><input name="upfile" type="file" 
					accept="image/gif, image/jpeg, image/png" onchange="fileCheck(this)"/></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="등록">
						<input type="button" value="뒤로가기"
						onclick="javascript:history.go(-1)"></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="badiv">
		<form action="bfafinsert.do" method="post"
			enctype="multipart/form-data" name="boardform">
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
					<td><input name="bfaf_name" type="text" style="width: 90%;" required/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="bfaf_value"
							style="width: 90%; height: 200px;" required></textarea>
					</td>
				</tr>
				<tr height="40">
					<th>FILE</th>
					<td><input name="upfile" type="file" 
					accept="image/gif, image/jpeg, image/png" onchange="fileCheck(this)"/></td>
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
<hr>

		<script type="text/javascript">
	    CKEDITOR.replace("free_value", { height: 100 });
	    CKEDITOR.replace("eyebody_value", { height: 100 });
	    CKEDITOR.replace("tip_value", { height: 100 });
	    CKEDITOR.replace("bfaf_value", { height: 100 });
		</script>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>