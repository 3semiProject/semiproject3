<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<eat>
<h2>
diary_showEatModify -> eatModify : 식단다이어리 수정화면
</h2>
받은값 diary : 어떤날짜에 누구의 어떤 다이어리를 수정하는건지
	eats : 화면에 띄울 기존 다이어리 정보
	
식단 다이어리
<div>
<lable>1번식단_음식2개, 이미지, 메모</lable>

<ol>
	<li>음식이름 : </li>
	<li>음식  : </li>
	<li>섭취 kcal :</li>
	<li>탄수화물 섭취량g :</li>
	<li>단백질 섭취량g :</li>
	<li>지방 섭취량g :</li>
</ol>
<ol>
	<li>음식이름 : </li>
	<li>음식  : </li>
	<li>섭취 kcal :</li>
	<li>탄수화물 섭취량g :</li>
	<li>단백질 섭취량g :</li>
	<li>지방 섭취량g :</li>
</ol>
<ol>
	<li>총 섭취 kcal :</li>
	<li>총 탄수화물 섭취량g :</li>
	<li>총 단백질 섭취량g :</li>
	<li>총 지방 섭취량g :</li>
</ol>
이미지
메모
</div>

입력	이미지수정
	메모수정
	식단 g 변경
	식단 삭제
	식단추가 ; ajax 음식검색용기능 음식이름-> diary_serarchFood.do
			-> ajax : food -> 음식 추가, kcal계산시 사용
			
보낼값 diary, eat
	저장버튼 -> diary_modifyEat.do 
		-> selectDayEat, 
		-> updateOneDiary, insertEat, updateEat
		-> diary_showEat.do -> eatView : 식단 다이어리 보기


</eat>
</html>