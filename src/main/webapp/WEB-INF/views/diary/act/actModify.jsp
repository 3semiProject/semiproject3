<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
diary_showActModify.do -> ActModify : 운동다이어리 수정화면
받은값 diary : 어떤날짜에 누가 수정하는건지
	body : 화면에 띄울 기존 다이어리 정보
	
입력	운동시간
	이미지수정
	메모수정
	운동추가
	운동삭제
	운동수정
	
저장버튼  ->diary_modifyAct.do
		->selectDayAct,deleteOneAct,updateOneAct,updateOneDiary
	  	->diary_showAct.do : 운동다이어리 화면
보낼값 diary, acts

</body>
</html>