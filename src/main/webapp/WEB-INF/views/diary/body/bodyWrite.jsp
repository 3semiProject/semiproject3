<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
diary_showBodyWrite.do -> bodyWrite : 체형다이어리 작성화면
받은값 diary : 어떤날짜에 누가 작성하는건지


	이미지입력
	메모입력
	체형값 4가지 입력 : 체중, 체지방량, 골격근량, 허리둘레
	
보낼값 diary, body
	저장버튼 -> diary_insertBody.do 
			->insertDiary, selectOneDiary, 
			insertOneBody -> diary_showBody.do -> bodyView




</body>
</html>