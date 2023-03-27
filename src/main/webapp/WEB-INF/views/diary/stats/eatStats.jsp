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
<eat>
<c:import url="/WEB-INF/views/diary/common/menubar.jsp" /> <!--메인 메뉴바-->
<c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp" /> <!--다이어리 메뉴바-->
 

<c:import url="/WEB-INF/views/diary/common/tap.jsp" />			<!--식단/식단/식단 탭-->
<hr>

<h2> diary_showEatStats.do-> eatStatsView : 식단 통계 보기  </h2>
보낼값 : diary, term -> 
받은값 : diary, period

<hr>
diary_eatGraph.do -> ajax : graphs, period, title -> 그래프 ajax
<hr>
diary_eatStats.do ->ajax : stats -> 분석내용, top3 이미지


<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</eat>
</html>