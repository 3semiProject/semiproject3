<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<eat>
diary_showEatWrite.do -> eatWrite : 식단다이어리 작성화면
받은값 diary : 어떤날짜에 누가 작성하는건지

	시간입력
	이미지입력
	메모입력
	먹은양g 입력
	식단삭제
	식단추가 ; ajax 음식검색용기능 음식이름-> diary_serarchFood.do
			-> ajax : food -> 음식 추가, kcal계산시 사용
	
보낼값 diary, eats
	저장버튼 -> diary_insertEat.do 
			->insertDiary, selectOneDiary, 
			insertOneEat -> diary_showEat.do -> eatView

</eat>
</html>