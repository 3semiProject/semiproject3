<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
.footer_box{
        width: 1200px;
        height: 100px;
        font-size: 8px;
}
footer {
	text-align: center;

}

.footer_list {

	text-align: center;
}

.footer_list li {
	list-style: none;
	display: inline-block;;
	padding: 10px;
}
</style>
</head>
<body>
<footer>
<br>
<div class="footer_box">
<ul class="footer_list" >
	<li><a href="${ pageContext.servletContext.contextPath }/info.do">이용안내</a></li> | 
	<li><a href="${ pageContext.servletContext.contextPath }/tos.do">이용약관</a></li> | 
	<li><a href="${ pageContext.servletContext.contextPath }/mp.do">운영정책</a></li> <br>
	    <li style="font-weight: bolder;">Copyright ⓒ DAMUNITY. All rights reserved.</li>
</ul>
</div>
</footer>
</body>
</html>