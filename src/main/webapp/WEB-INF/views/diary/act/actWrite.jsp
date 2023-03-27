<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
diary_showActWrite.do -> ActWrite : 운동다이어리 작성화면
받은값 diary : 어떤날짜에 누가 작성하는건지

	시간입력
	이미지입력
	메모입력
	운동추가 : ajax 운동이름 검색기능 name 
			-> diary_serarchMove.do ->ajax: move 
			-> 운동추가, var에 담아뒀다가 분입력되면 kcal계산식에 사용
보낼값 diary, acts
	저장버튼 -> diary_insertAct.do ->insertDiary, insertOneAct * n 
	-> diary_showAct.do -> actView


보낼값 diary, acts
저장버튼 ->diary_inertAct.do
		-> insertDiary, 


</body>
</html>