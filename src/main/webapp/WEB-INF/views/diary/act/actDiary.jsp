<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Diary</title>
<style type="text/css">
ul{
padding: 0;}
ol{
padding:0;}
ol li{
display: inline-block;
}
#footer {
    position: relative;
    transform: translatY(-100%);
} 
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
	//운동추천 화면출력용 ajax
	//diary_showActRec.do실행
	//
</script>
</head>
<body>
<br><c:import url="/WEB-INF/views/common/menubar.jsp" /> <!--메인 메뉴바-->
<br><c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp" /> <!--다이어리 메뉴바-->


<br><c:import url="/WEB-INF/views/diary/common/weekBar.jsp" />		<!--날짜이동바-->
<br><c:import url="/WEB-INF/views/diary/common/diaryTap.jsp" />		<!--식단/운동/식단 탭-->
<br><c:import url="/WEB-INF/views/diary/common/goalBar.jsp" />		<!--목표 표시-->
<hr>

<h2> diary_showAct.do -> actDiaryView : 운동다이어리 보기</h2>
보낼값 : ${ diary}
<br>${acts}



<%-- <div>
<ul><li><ol>
	<li>운동이름 : ${act[0].actname}</li>
	<li>운동한 시간 : ${act[0].act_mm}</li>
	<li>소모 칼로리 : ${act[0].act_kacl}</li>
</ol></li></ul>

<ul><li><ol>
	<li>운동이름 : ${act[1].actname}</li>
	<li>운동한 시간 : ${act[1].act_mm} }</li>
	<li>소모 칼로리 : ${act[1].act_kacl} }</li>
</ol></li></ul>
</div> --%>
<hr>
<div>
운동추천 ajax화면
</div>
<pre>
글쓰기버튼 ->ActWrite : 운동다이어리 작성
	시간입력
	이미지입력
	메모입력
	운동추가 : ajax 운동이름 검색기능 name 
			-> diary_serarchMove.do ->ajax: move 
			-> 운동추가, var에 담아뒀다가 분입력되면 kcal계산식에 사용
	저장버튼 -> diary_insertAct.do ->insertDiary, insertOneAct * n -> diary_showAct.do
	 
수정버튼 ->ActModify : 운동다이어리 수정
	시간수정
	이미지수정
	메모수정
	운동삭제
	운동추가
	운동수정
	ajax 운동이름 검색기능 name 
			-> diary_serarchMove.do ->ajax: move 
			-> 운동추가, var에 담아뒀다가 분입력되면 kcal계산식에 사용
	저장버튼 -> diary_modifyAct.do -> updateDiary, insertOneAct, updateOneAct, deleteOneAct -> diary_showAct.do
	삭제버튼 -> 운동다이어리 삭제 diary_delAct.do ->deleteDiary, deleteOneAct -> diary_showAct.do


</pre>
<hr>
<div id="footer">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</div>
</body>
</html>