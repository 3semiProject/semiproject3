<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="range" value="1"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css"
          href="${ pageContext.servletContext.contextPath }/resources/css/diarytab.css">
</head>

<body>
<div class="tabs">

    <a href="${ pageContext.servletContext.contextPath }/diary_showEatDiary.do" class="tabs left">일주일</a>
    <a href="${ pageContext.servletContext.contextPath }/diary_showEatDiary.do" class="tabs center">한 달</a>
    <a href="${ pageContext.servletContext.contextPath }/diary_showEatDiary.do" class="tabs center">3개월</a>
    <a href="${ pageContext.servletContext.contextPath }/diary_showActDiary.do" class="tabs right">6개월</a>
</div>
<div>
    <br>
    <br>
    <br>
    <form action="insertFoodData.do" method="POST" enctype="multipart/form-data" accept=".xls,.xlsx">
        <input type="file" name="mfile">
        <input type="submit" value="음식 데이터 삽입(xlsx)" />
    </form>
</div>
</body>
</html>