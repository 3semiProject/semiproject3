<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
        ul#cmenubar {
            list-style: none;
            position: absolute;
            left: 400px;
            top: -5px;

        }

        ul#cmenubar li {
            float: left;
            width: 200px;
            height: 100px;
            margin-right: 5px;
            padding: 0;
        }

        ul#cmenubar li a {
            text-decoration: none;
            width: 200px;
            height: 100px;
            display: block;
            background-color: white;
            text-align: center;
            line-height: 100px;
            color: #01CD88;
            font-weight: bold;
            margin: 0;
            text-shadow: 1px 1px 2px #D1D1D1;
            font-size: 20pt;
            border-radius: 30px;
            border: 1px solid #D1D1D1;
        }

        ul#cmenubar li a:hover {
            text-decoration: none;
            width: 150px;
            height: 100px;
            line-height: 100px;
            display: block;
            background-color: #01CD88;
            font-size: 25pt;
            text-align: center;
            color: white;
            font-weight: bold;
            margin: 0;
            text-shadow: 1px 1px 2px #D1D1D1;
            padding-top: 5px;
        }
        

        #tab2{
            width: 900px;
            margin:0;

        }
    </style>
</head>
<body>
<div id="tab2">
	<ul id="cmenubar">
		<li><a href="${ pageContext.servletContext.contextPath }/hotlist.do">HOT</a></li>
		<li><a href="${ pageContext.servletContext.contextPath }/newlist.do">NEW</a></li>
		<li><a href="${ pageContext.servletContext.contextPath }/commu.do">FREE</a></li>
		<li><a href="${ pageContext.servletContext.contextPath }/tiplist.do">TIP</a></li>
		<li><a href="${ pageContext.servletContext.contextPath }/eyebodylist.do">EYEBODY</a></li>
		<li><a href="${ pageContext.servletContext.contextPath }/bfaflist.do">BF & AF</a></li>
	</ul>
</div>
</body>
</html>