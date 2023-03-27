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
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" /> <!--메인 메뉴바-->
<c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp" /> <!--다이어리 메뉴바-->
 

<c:import url="/WEB-INF/views/diary/common/tap.jsp" />			<!--식단/운동/체형 탭-->
<hr>
<pre>
<h2>diary_showActStats.do-> actStats : 운동 통계 보기  </h2>
받은 값 : diary, term
보낼 값 : diary, term

diary_ActGraph.do -> ajax : graphs, period, title -> 그래프 ajax
diary_ActStats ->ajax : stats -> 분석내용, top3


</pre>
<hr>

<c:import url="${pageContext.servletContext.contextPath}/WEB-INF/views/diary/common/actRec.jsp" />
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>