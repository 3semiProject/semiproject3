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
}
footer {
	text-align: center;
	color: white;

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
<hr>
<ul class="footer_list" >
    <li>ⓒDAMUNITY</li>
	<li><a href="${ pageContext.servletContext.contextPath }/info.do">다뮤니티 이용안내</a></li>
	<li><a href="${ pageContext.servletContext.contextPath }/tos.do">이용약관</a></li>
	<li><a href="${ pageContext.servletContext.contextPath }/mp.do">운영정책</a></li>
</ul>
</div>
</footer>
</body>
</html>