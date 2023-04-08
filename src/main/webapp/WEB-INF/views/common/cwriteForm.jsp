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
#drop-zone {
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
</script>

<script type="text/javascript">
$(function() {
    
    var $file1 = document.getElementById("file1");
    var dropZone1 = document.querySelector(".drop-zone1");
    
    var toggleClass = function(className) {
        
        console.log("current event: " + className);

        var list = ["dragenter", "dragleave", "dragover", "drop"];

        for (var i = 0; i < list.length; i++) {
            if (className === list[i]) {
                dropZone1.classList.add("drop-zone-" + list[i])
            } else {
                dropZone1.classList.remove("drop-zone-" + list[i])
            }
        }
    }
    
    var showFiles = function(files) {
        dropZone1.innerHTML = "";
        for(var i = 0, len = files.length; i < len; i++) {
            dropZone1.innerHTML += "<p>" + files[i].name + "</p>&nbsp;"
        }
    }

    var selectFile = function(files) {
        // input file 영역에 드랍된 파일들로 대체
        if(files.length > 0 && $file1.files.length < 3){
	        $file1.files = files;
		    showFiles($file1.files);
        }else{
        	alert("파일은 3개까지 등록가능합니다.");
        }
        
        
        
    }
    
    $file1.addEventListener("change", function(e) {
        showFiles(e.target.files);
    })

    // 드래그한 파일이 최초로 진입했을 때
    dropZone1.addEventListener("dragenter", function(e) {
        e.stopPropagation();
        e.preventDefault();

        toggleClass("dragenter");

    })

    // 드래그한 파일이 dropZone 영역을 벗어났을 때
    dropZone1.addEventListener("dragleave", function(e) {
        e.stopPropagation();
        e.preventDefault();

        toggleClass("dragleave");

    })

    // 드래그한 파일이 dropZone 영역에 머물러 있을 때
    dropZone1.addEventListener("dragover", function(e) {
        e.stopPropagation();
        e.preventDefault();

        toggleClass("dragover");

    });

    // 드래그한 파일이 드랍되었을 때
    dropZone1.addEventListener("drop", function(e) {
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
					<td><input type="file" name="upfile" id="file1" multiple
					accept="image/gif, image/jpeg, image/png" onchange="fileCheck(this);">
					<br>
					<div class="drop-zone1" align="center" id="drop-zone">
            		 * 파일선택 버튼 클릭 또는 이미지 파일을 여기로 드래그하세요 *<br>
            		 * 파일은 이미지 파일만 가능하며 3개까지 업로드 가능합니다 *
        			</div>
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
					<td><input type="file" name="upfile" id="file2" multiple
					accept="image/gif, image/jpeg, image/png" onchange="fileCheck(this);">
					<br>
					<div class="drop-zone2" align="center" id="drop-zone">
            		 * 파일선택 버튼 클릭 또는 이미지 파일을 여기로 드래그하세요 *<br>
            		 * 파일은 이미지 파일만 가능하며 3개까지 업로드 가능합니다 *
        			</div>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="등록">
						<input type="button" value="뒤로가기"
						onclick="javascript:history.go(-1)"></td>
				</tr>
			</table>
		</form>
<script type="text/javascript">
$(function() {
    
    var $file2 = document.getElementById("file2");
    var dropZone2 = document.querySelector(".drop-zone2");
    
    var toggleClass = function(className) {
        
        console.log("current event: " + className);

        var list = ["dragenter", "dragleave", "dragover", "drop"];

        for (var i = 0; i < list.length; i++) {
            if (className === list[i]) {
                dropZone2.classList.add("drop-zone-" + list[i])
            } else {
                dropZone2.classList.remove("drop-zone-" + list[i])
            }
        }
    }
    
    var showFiles = function(files) {
        dropZone2.innerHTML = "";
        for(var i = 0, len = files.length; i < len; i++) {
            dropZone2.innerHTML += "<p>" + files[i].name + "</p>&nbsp;"
        }
    }

    var selectFile = function(files) {
        // input file 영역에 드랍된 파일들로 대체
        if(files.length > 0 && $file2.files.length < 3){
	        $file2.files = files;
		    showFiles($file2.files);
        }else{
        	alert("파일은 3개까지 등록가능합니다.");
        }
        
        
        
    }
    
    $file2.addEventListener("change", function(e) {
        showFiles(e.target.files);
    })

    // 드래그한 파일이 최초로 진입했을 때
    dropZone2.addEventListener("dragenter", function(e) {
        e.stopPropagation();
        e.preventDefault();

        toggleClass("dragenter");

    })

    // 드래그한 파일이 dropZone 영역을 벗어났을 때
    dropZone2.addEventListener("dragleave", function(e) {
        e.stopPropagation();
        e.preventDefault();

        toggleClass("dragleave");

    })

    // 드래그한 파일이 dropZone 영역에 머물러 있을 때
    dropZone2.addEventListener("dragover", function(e) {
        e.stopPropagation();
        e.preventDefault();

        toggleClass("dragover");

    });

    // 드래그한 파일이 드랍되었을 때
    dropZone2.addEventListener("drop", function(e) {
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
					<td><input type="file" name="upfile" id="file3" multiple
					accept="image/gif, image/jpeg, image/png" onchange="fileCheck(this);">
					<br>
					<div class="drop-zone3" align="center" id="drop-zone">
            		 * 파일선택 버튼 클릭 또는 이미지 파일을 여기로 드래그하세요 *<br>
            		 * 파일은 이미지 파일만 가능하며 3개까지 업로드 가능합니다 *
        			</div>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="등록">
						<input type="button" value="뒤로가기"
						onclick="javascript:history.go(-1)"></td>
				</tr>
			</table>
		</form>
<script type="text/javascript">
$(function() {
    
    var $file3 = document.getElementById("file3");
    var dropZone3 = document.querySelector(".drop-zone3");
    
    var toggleClass = function(className) {
        
        console.log("current event: " + className);

        var list = ["dragenter", "dragleave", "dragover", "drop"];

        for (var i = 0; i < list.length; i++) {
            if (className === list[i]) {
                dropZone3.classList.add("drop-zone-" + list[i])
            } else {
                dropZone3.classList.remove("drop-zone-" + list[i])
            }
        }
    }
    
    var showFiles = function(files) {
        dropZone3.innerHTML = "";
        for(var i = 0, len = files.length; i < len; i++) {
            dropZone3.innerHTML += "<p>" + files[i].name + "</p>&nbsp;"
        }
    }

    var selectFile = function(files) {
        // input file 영역에 드랍된 파일들로 대체
        if(files.length > 0 && $file3.files.length < 3){
	        $file3.files = files;
		    showFiles($file3.files);
        }else{
        	alert("파일은 3개까지 등록가능합니다.");
        }
        
        
        
    }
    
    $file3.addEventListener("change", function(e) {
        showFiles(e.target.files);
    })

    // 드래그한 파일이 최초로 진입했을 때
    dropZone3.addEventListener("dragenter", function(e) {
        e.stopPropagation();
        e.preventDefault();

        toggleClass("dragenter");

    })

    // 드래그한 파일이 dropZone3영역을 벗어났을 때
    dropZone3.addEventListener("dragleave", function(e) {
        e.stopPropagation();
        e.preventDefault();

        toggleClass("dragleave");

    })

    // 드래그한 파일이 dropZone3영역에 머물러 있을 때
    dropZone3.addEventListener("dragover", function(e) {
        e.stopPropagation();
        e.preventDefault();

        toggleClass("dragover");

    });

    // 드래그한 파일이 드랍되었을 때
    dropZone3.addEventListener("drop", function(e) {
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
					<td><input type="file" name="upfile" id="file4" multiple
					accept="image/gif, image/jpeg, image/png" onchange="fileCheck(this);">
					<br>
					<div class="drop-zone4" align="center" id="drop-zone">
            		 * 파일선택 버튼 클릭 또는 이미지 파일을 여기로 드래그하세요 *<br>
            		 * 파일은 이미지 파일만 가능하며 3개까지 업로드 가능합니다 *
        			</div>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="등록">
						<input type="button" value="뒤로가기"
						onclick="javascript:history.go(-1)"></td>
				</tr>
			</table>
		</form>
<script type="text/javascript">
$(function() {
    
    var $file4 = document.getElementById("file4");
    var dropZone4 = document.querySelector(".drop-zone4");
    
    var toggleClass = function(className) {
        
        console.log("current event: " + className);

        var list = ["dragenter", "dragleave", "dragover", "drop"];

        for (var i = 0; i < list.length; i++) {
            if (className === list[i]) {
                dropZone4.classList.add("drop-zone-" + list[i])
            } else {
                dropZone4.classList.remove("drop-zone-" + list[i])
            }
        }
    }
    
    var showFiles = function(files) {
        dropZone4.innerHTML = "";
        for(var i = 0, len = files.length; i < len; i++) {
            dropZone4.innerHTML += "<p>" + files[i].name + "</p>&nbsp;"
        }
    }

    var selectFile = function(files) {
        // input file 영역에 드랍된 파일들로 대체
        if(files.length > 0 && $file4.files.length < 3){
	        $file4.files = files;
		    showFiles($file4.files);
        }else{
        	alert("파일은 3개까지 등록가능합니다.");
        }
        
        
        
    }
    
    $file4.addEventListener("change", function(e) {
        showFiles(e.target.files);
    })

    // 드래그한 파일이 최초로 진입했을 때
    dropZone4.addEventListener("dragenter", function(e) {
        e.stopPropagation();
        e.preventDefault();

        toggleClass("dragenter");

    })

    // 드래그한 파일이 dropZone4영역을 벗어났을 때
    dropZone4.addEventListener("dragleave", function(e) {
        e.stopPropagation();
        e.preventDefault();

        toggleClass("dragleave");

    })

    // 드래그한 파일이 dropZone4영역에 머물러 있을 때
    dropZone4.addEventListener("dragover", function(e) {
        e.stopPropagation();
        e.preventDefault();

        toggleClass("dragover");

    });

    // 드래그한 파일이 드랍되었을 때
    dropZone4.addEventListener("drop", function(e) {
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