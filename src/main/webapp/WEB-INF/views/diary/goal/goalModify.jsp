<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Diary</title>
    <style type="text/css">
        ul {
            padding: 0;
        }

        ol {
            padding: 0;
        }

        ol li {
            display: inline-block;
        }

        body {
            width: 1200px;
            height: 1200px;
        }

        h1 {
            color: #A4A4A4;
            font-weight: 800;
            font-size: 30pt;
        }

        #enroll_form {
            text-align: center;
            font-size: 15pt;
            font-style: inherit;
            color: #5f5f5f;
        }

        #join_box {
            align-items: center;
            border: 3px solid #D1D1D1;
            width: 600px;
            height: 560px;
            border-radius: 30px;
            display: inline-block;
            margin: 0;
        }

        #enroll_form #text {
            display: flex;
            color: #D96969;
        }

        .join_e {
            border-bottom: 2px solid #D1D1D1;
            height: 110px;
            width: 600px;
            display: flex;
        }

        .join_e2 {
            border-top: 0 solid #D1D1D1;
            height: 110px;
            width: 600px;
            display: flex;
        }

        .join_item {
            line-height: 100px;
            margin: 0;
            height: 110px;
            width: 200px;
            border-right: 2px solid #D1D1D1;
        }

        .join_item2 {
            display: flex;
            padding: 40px;
        }

        input[type=submit] {
            height: 40px;
            padding: 10px 16px;
            border: none;
            background: #f3f3f4;
            color: #0d0c22;
            border-radius: 8px;
            text-align: center;
            font-size: 14px;
            font-weight: 500;
            line-height: 20px;
            box-sizing: border-box;
        }

        button:hover, button:focus {
            background-color: #e7e7e9;
        }


        div.join_item2 label {
            border: none;
            font-size: 15pt;
            font-weight: bold;
            font-family: Copperplate, Papyrus, fantasy;

        }

        input[type='text'] {
            border: rgba(99, 225, 70, 0.49) solid 3px;
            font-size: 15pt;
            font-weight: bold;
            font-family: Copperplate, Papyrus, fantasy;
            width: 80px;
            border-radius: 8px;
        }

        input[type='date'] {
            border: rgba(99, 225, 70, 0.49) solid 3px;
            font-size: 15pt;
            font-weight: bold;
            font-family: Copperplate, Papyrus, fantasy;
            width: 140px;
            border-radius: 8px;
        }


        input[type='radio'] {
            appearance: none;
            background-color: #00ff00;
            width: 10px;
            height: 8px;
            border-radius: 50%;
            opacity: 10%;
            border: none;
            margin-left: 10px;
        }

        input[type='radio']:checked {
            opacity: 1;
        }
    </style>
    <script type="text/javascript"
            src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
</head>


<c:if test="${isExist eq 'Y'}">
<body>
<script>
    $(function () {
        $('input[name=energy_demand]').each(function () {

            if ($(this).val() == ${goal.energy_demand}) {
                $(this).prop('checked', true);
            }
        }); //each
    });//document.ready
</script>
<c:import url="/WEB-INF/views/common/menubar.jsp"/> <!--메인 메뉴바-->
<br>
<c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp"/> <!--다이어리 메뉴바-->
<hr>

<form action='<c:url value="/diary_GoalModify.do"/>' method="post">
    <div id="enroll_form">
        <br>
        <div align="left"
             style="color: #D96969; font-size: x-large; margin-bottom: 20px; margin-left: 320px;">목표 수정
        </div>
        <div id="join_box" align="center">
            <div class="join_e">
                <div class="join_item">키</div>
                <div class="join_item2">
                    <label><input type="text" name="height" value="${goal.height}" maxlength="6"> cm</label>
                </div>
            </div>
            <div class="join_e">
                <div class="join_item">몸무게</div>
                <div class="join_item2">

                    <label><input type="text" name="current_weight" value="${goal.current_weight}"> kg</label>
                </div>
            </div>
            <div class="join_e">
                <div class="join_item">활동량</div>
                <div id="energy_demand" style="font-size: 10pt; text-align: left;">
                    <br>
                    <label> <input type="radio" name="energy_demand" value="25"> 활동이 적거나 운동을 하지 않는다.</label> <br>
                    <label> <input type="radio" name="energy_demand" value="30"> 가벼운 활동 및 운동(주 1~3회)을 한다. </label><br>
                    <label> <input type="radio" name="energy_demand" value="35"> 보통의 활동 및 운동(주 3~5회)을 한다. </label><br>
                    <label> <input type="radio" name="energy_demand" value="40"> 적극적인 활동 및 운동(주 6~7회)을 한다.</label> <br>
                    <label> <input type="radio" name="energy_demand" value="45"> 아주 적극적인 활동 또는 운동선수 (하루 2번, 고중량 운동
                        등)</label>
                </div>
            </div>
            <div class="join_e">
                <div class="join_item">목표 체중</div>
                <div class="join_item2">
                    <label><input type="text" name="target_weight" value="${goal.target_weight}"> kg</label>
                </div>
            </div>
            <div class="join_e2">
                <div class="join_item">목표 기간</div>
                <div class="join_item2">
                    <label><input type="date" name="goal_date" value="${goal.goal_date}"></label>
                </div>
            </div>
        </div>
    </div>
    <br>

    <div style="text-align: center">
        <input type="submit" value="수정하기"/>
    </div>

</form>
</c:if>

<c:if test="${isExist ne 'Y'}">
    없어
</c:if>


<c:import url="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>