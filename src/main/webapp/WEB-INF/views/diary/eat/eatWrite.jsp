<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" /> <!--메인 메뉴바-->
<br><c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp" /> <!--다이어리 메뉴바-->
<br><c:import url="/WEB-INF/views/diary/common/weekbar.jsp" />		<!--날짜이동바-->
<br><c:import url="/WEB-INF/views/diary/common/diaryTap.jsp" />		<!--식단/운동/식단 탭-->
<br><c:import url="/WEB-INF/views/diary/common/target.jsp" />		<!--목표 표시-->
<hr>
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

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>