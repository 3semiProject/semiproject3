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
    <style>
        div.tabs {
            width: 1200px;
        }

        div.range {
            margin: 0 auto;
            display: inline-block;
        }

        .range input[type=radio] {
            display: none;
        }

        div label {
            border: 1px solid #868e96;
            display: inline-block;
            margin: 0px;
            padding: 0px;
            width: 150px;
            height: 40px;
            background-color: white;
            border-bottom: 3px solid rgba(134, 142, 150, 0.5);

            color: #797979;
            line-height: 40px;
            text-align: center;
            text-decoration: none;
            font-size: large;
            font-weight: 600;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
            border-bottom: 3px solid gray;

        }

        label.center {
            border-left: 1px solid #868e96;
            border-right: 1px solid #868e96;
            border-radius: 0px;
        }

        label.left {
            border-radius: 7px 0px 0px 7px;
        }

        label.right {
            border-radius: 0px 7px 7px 0px;
        }


        label:hover {
            background-color: rgba(130, 201, 18, 0.5);
            border-bottom: 3px solid rgba(86, 140, 8, 0.5);
        }

        .range input[type=radio]:checked + label {
            background-color: rgba(130, 201, 18, 0.5);
            border-bottom: 3px solid rgba(86, 140, 8, 0.5);
        }


    </style>
</head>

<body>
<div class="tabs">
    <div class="range">
        <input type="radio" name="dateRange" id="range1" value="1" checked>
        <label for="range1" class="left">일주일</label>
    </div>
    <div class="range">
        <input type="radio" name="dateRange" id="range2" value="2">
        <label for="range2" class="center">한 달</label>
    </div>
    <div class="range">
        <input type="radio" name="dateRange" id="range3" value="3">
        <label for="range3" class="center">3개월</label>
    </div>
    <div class="range">
        <input type="radio" name="dateRange" id="range4" value="4">
        <label for="range4" class="right">6개월</label>
    </div>
</div>

<div>
    <br>

</div>
</body>
</html>