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
.drop-zone {
        width: auto;
        height: 100px;
        background-color: azure;
        display: flex;
    }

    .drop-zone-dragenter, .drop-zone-dragover {
        border: 10px solid blue;
    }
</style>
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
function fileCheck(obj) {
	
	var x = document.getElementById("file");
	var txt = "";
	if ('files' in x) {
	    if (x.files.length > 3) {
	        alert("파일 개수가 초과되었습니다.");
	        document.getElementById("file").value = "";
	        return;
	    }
	}
	
    pathpoint = obj.value.lastIndexOf('.');
    filepoint = obj.value.substring(pathpoint+1,obj.length);
    filetype = filepoint.toLowerCase();
    if(filetype=='jpg' || filetype=='gif' || filetype=='png' || filetype=='jpeg') {

        // 정상적인 이미지 확장자 파일일 경우 ...

    } else {
        alert('이미지 파일만 선택할 수 있습니다.');
        document.getElementById("file").value = "";

        parentObj  = obj.parentNode
        node = parentObj.replaceChild(obj.cloneNode(true),obj);

        return false;
    }
}

$(function() {
    
    var $file = document.getElementById("file");
    var dropZone = document.querySelector(".drop-zone");

    var toggleClass = function(className) {
        
        console.log("current event: " + className);

        var list = ["dragenter", "dragleave", "dragover", "drop"];

        for (var i = 0; i < list.length; i++) {
            if (className === list[i]) {
                dropZone.classList.add("drop-zone-" + list[i])
            } else {
                dropZone.classList.remove("drop-zone-" + list[i])
            }
        }
    }
    
    var showFiles = function(files) {
        dropZone.innerHTML = "";
        for(var i = 0, len = files.length; i < len; i++) {
            dropZone.innerHTML += "<p>" + files[i].name + "</p>&nbsp;"
        }
    }

    var selectFile = function(files) {
        // input file 영역에 드랍된 파일들로 대체
        if(files.length > 0 && $file.files.length < 3){
	        $file.files = files;
		    showFiles($file.files);
        }else{
        	alert("파일은 3개까지 등록가능합니다.");
        }
        
        
        
    }
    
    $file.addEventListener("change", function(e) {
        showFiles(e.target.files);
    })

    // 드래그한 파일이 최초로 진입했을 때
    dropZone.addEventListener("dragenter", function(e) {
        e.stopPropagation();
        e.preventDefault();

        toggleClass("dragenter");

    })

    // 드래그한 파일이 dropZone 영역을 벗어났을 때
    dropZone.addEventListener("dragleave", function(e) {
        e.stopPropagation();
        e.preventDefault();

        toggleClass("dragleave");

    })

    // 드래그한 파일이 dropZone 영역에 머물러 있을 때
    dropZone.addEventListener("dragover", function(e) {
        e.stopPropagation();
        e.preventDefault();

        toggleClass("dragover");

    });

    // 드래그한 파일이 드랍되었을 때
    dropZone.addEventListener("drop", function(e) {
        e.preventDefault();

        toggleClass("drop");

        var files = e.dataTransfer && e.dataTransfer.files
        console.log(files);
        for(var i = 0; i < files.length; i++){
	        if (!(files[i].type.match(/image.*/))) {
	        	alert('이미지 파일만 선택할 수 있습니다.');
	        	return
	        }
   		}

        if (files != null) {
            if (files.length < 1) {
                alert("폴더 업로드 불가")
                return
            }
            
            selectFile(files)
        } else {
            alert("ERROR")
        }

    });

});


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
					<b> * 신규파일 첨부시 기존 첨부파일은 삭제됩니다 * </b><br>
					<input type="file" name="upfile" id="file" multiple
					accept="image/gif, image/jpeg, image/png" onchange="fileCheck(this);">
					<br>
					<div class="drop-zone" align="center">
            		 * 파일선택 버튼 클릭 또는 이미지 파일을 여기로 드래그하세요 *<br>
            		 * 파일은 이미지 파일만 가능하며 3개까지 업로드 가능합니다 *
        			</div>
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