<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	
        #tab2{
            width: 1000px;
            height: 50px;
            margin:0;
            padding: 0;
            list-style: none;
            border: 1px solid #D1D1D1;
            border-radius: 35px;

        }
        
        #tab2 div {
            float: left;
            width: 250px;
            height: 50px;
            margin: 0px;
            padding: 0;
        }
        
        

        #tab2 div a {
            text-decoration: none;
            width: 250px;
            height: 50px;
            display: block;
            background-color: white;
            text-align: center;
            line-height: 50px;
            color: #01CD88;
            font-weight: bold;
            margin: 0;
            text-shadow: 1px 1px 2px #D1D1D1;
            font-size: 20pt;
            border: 1px solid #D1D1D1;
            
        }
   
/*         
        .round a {
        border-spacing: 0;
         border-radius-top-left: 35px;
        border-radius-bottom-left: 35px;
        } */
        
   /*      #tab2 div:first-child a {
        	border-radius-top-left: 35px;
        border-radius-bottom-left: 35px;
        } */

        #tab2 div a:hover {
            text-decoration: none;
            width: 250px;
            height: 50px;
            line-height: 50px;
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
        

    </style>
</head>
<body>
<hr>
<div id="tab2">
	<div class="round"><a style="border-bottom-left-radius: 35px; border-top-left-radius: 35px;" href="${ pageContext.servletContext.contextPath }/qnalist.do">QnA</a></div>
	<div><a href="${ pageContext.servletContext.contextPath }/faqlist.do">FAQ</a></div>	
	<div><a href="${ pageContext.servletContext.contextPath }/nlist.do">공지사항</a></div>
	<div class="round"><a style="border-bottom-right-radius: 35px; border-top-right-radius: 35px;" href="${ pageContext.servletContext.contextPath }/elist.do">EVENT</a></div>
   </ul>
</div>
</body>
</html>