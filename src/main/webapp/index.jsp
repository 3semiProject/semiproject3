<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>
</head>
<body>
<!-- <h1>spring first project</h1> -->
<!-- 첫페이지 접속 요청이 오면, 실제 보여질 메인 페이지를 포워딩함 -->
<%-- <%
	RequestDispatcher view = request.getRequestDispatcher("main.do");
	view.forward(request, response);
%> --%>
<jsp:forward page="main.do" />
</body>
</html>