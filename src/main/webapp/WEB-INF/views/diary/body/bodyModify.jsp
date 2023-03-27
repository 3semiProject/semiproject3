<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>
diary_showBodyModify -> bodyModify : 체형다이어리 수정화면
</h2>
받은값 diary : 어떤날짜에 누구의 어떤 다이어리를 수정하는건지
	body : 화면에 띄울 기존 다이어리 정보


입력	이미지수정
	메모수정
	체형 4가지 수정
	
	저장버튼 -> diary_modifyBody.do 
		-> updateOneDiary, insertBody, updateBody
		-> diary_showBody.do -> bodyView : 체형 다이어리 보기

보낼값 diary, body

</body>
</html>