<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <meta charset="UTF-8">
    <title>Diary</title>
    <style type="text/css">
        ul {
            padding: 0;
            list-style: none;
        }

        ol {
            padding: 0;
        }

        ol li {
            display: inline-block;
        }

        .verticalBar {
            border-left: 3px solid rgba(86, 140, 8, 0.5);
            height: 300px;
        }

        .horizontalBar {
            margin: 0 auto;
            border-bottom: 3px solid rgba(86, 140, 8, 0.5);
            width: 500px;
        }

        div.stats {
            margin: 0;
            text-align: center;
        }

        table {
            margin: 5% auto;
            width: 80%;
            display: inline-block;
        }

        table tr td {
            width: 150px;
            font-size: 18pt;
            text-align: right;
        }

        table tr td.lefttd {
            width: 400px;
        }

        .avgstats tr {
            height: 50px
        }
    </style>
    <script type="text/javascript"
            src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>


</head>
<body style="width: 1280px">
<c:import url="/WEB-INF/views/common/menubar.jsp"/> <!--메인 메뉴바-->
<hr>
<c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp"/> <!--다이어리 메뉴바-->
<hr>
<hr>
<c:import url="/WEB-INF/views/diary/common/statsTap.jsp"/>            <!--식단/운동/체형 탭-->
<hr>
<c:import url="/WEB-INF/views/diary/common/statsRangeBar.jsp"/>            <!--식단/운동/체형 탭-->


<div>
    <canvas id="bodyChart"></canvas>
</div>


<hr>

My 다이어리 분석
<hr class="horizontalBar" style="width: 100%">
<div id="stats" style="height: 300px; display: flex;">
    <div style="width: 50%">
        <div class="stats" style="width:100%; height: 40%">
            <table>
                <tr>
                    <td class="lefttd">목표 체중 :</td>
                    <td id="target_weight"></td>
                </tr>
                <tr>
                    <td class="lefttd">현재 체중 :</td>
                    <td id="current_weight"></td>
                </tr>
            </table>
        </div>
        <div class="horizontalBar"></div>

        <div class="stats" style="width:100%; height: 60%">
            <table>
                <tr>
                    <td class="lefttd">목표까지 :</td>
                    <td id="goal_weight"></td>
                </tr>
            </table>

        </div>
    </div>
    <div class="verticalBar"></div>
    <div style="width: 50%; height: 300px; display: flex;">

        <div style="width: 500px; margin-top:50px">
            <canvas id="bodyStatsChart"></canvas>
        </div>


        <div style="display: flex;align-items: center;">
            <table class="avgstats">
                <tr>
                    <td style="width: 300px;">평균 체중 :</td>
                    <td style="width: 50px;" id="average_weight"></td>
                </tr>
                <tr>
                    <td>평균 골격근량 :</td>
                    <td id="average_fat"></td>
                </tr>
                <tr>
                    <td>평균 체지방량 :</td>
                    <td id="average_muscle"></td>
                </tr>
            </table>
        </div>
    </div>


</div>
<hr class="horizontalBar" style="width: 100%">
<c:import url="/WEB-INF/views/common/footer.jsp"/>


<script type="text/javascript">
    var bodyStats;
    var bodyChart;
    var barLineChart;
    var barLineChartData;
    var pieChart;

    const ctxStats = document.getElementById('bodyStatsChart');
    const ctx = document.getElementById('bodyChart');

    function bodyResult(range) {
        $.ajax({
            url: "diary_BodyStats.do",
            data:
                {statsRange: range},
            dataType: "json",
            success: function (data) {
                var jsonStr = JSON.stringify(data);
                console.log("통계 json : " + jsonStr);

                bodyStats = JSON.parse(jsonStr);
                console.log("parse json : " + bodyStats);

                $('#target_weight').text(bodyStats.target_weight + " kg");
                $('#current_weight').text(bodyStats.current_weight + " kg");
                $('#goal_weight').text(bodyStats.target_weight - bodyStats.current_weight + " kg");

                // $('#avgTime').text(bodyStats.many_food + " 분");
                // $('#weakTime').text(bodyStats.many_food + " 분");


                $('#average_weight').text(bodyStats.average_weight + " kg");
                $('#average_fat').text(bodyStats.average_fat + " kg");
                $('#average_muscle').text(bodyStats.average_muscle + " kg");

                if (pieChart !== undefined) {
                    pieChart.destroy();
                }


                pieChart = new Chart(ctxStats, {
                    type: 'bar',
                    data: {
                        labels: ['평균 체중', '평균 골격근량', '평균 체지방량'],
                        datasets: [{
                            label: 'kg',
                            backgroundColor: ['rgba(255,255,50,1)', 'rgba(150,255,150,1)', 'rgba(50,100,255,1)'],
                            data: [Number(bodyStats.average_weight), Number(bodyStats.average_fat), Number(bodyStats.average_muscle)]
                        }]
                    }, option: {}
                });


            }, //success
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("diary_bodyStats.do error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
            }
        }); // .ajax


        $.ajax({
            url: "diary_BodyChart.do",
            data:
                {statsRange: range},
            dataType: "json",
            success: function (data) {


                var jsonStr = JSON.stringify(data);
                console.log("차트통계 json : " + jsonStr);
                bodyChart = JSON.parse(jsonStr);
                console.log("parse json : " + bodyStats);

                var dateX = new Array();

                for (var i in bodyChart.list) {
                    dateX[i] = bodyChart.list[i].date;
                }

                var t_w = new Array();

                for (var i in bodyChart.list) {
                    t_w[i] = bodyChart.list[i].target_weight;
                }

                var c_w = new Array();

                for (var i in bodyChart.list) {
                    c_w[i] = bodyChart.list[i].current_weight;
                }

                if (barLineChart !== undefined) {
                    barLineChart.destroy();
                }


                barLineChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: dateX,
                        datasets: [{
                            type: 'line',
                            label: '목표 체중',
                            borderColor: "rgba(255,153,17,0.7)",
                            data: t_w,

                        }, {
                            type: 'line',
                            label: '현재 체중',
                            borderColor: "rgba(99,225,70,0.49)",
                            data: c_w,

                        }],
                    },
                    option: {}
                });


            }, //success
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("diary_bodyStats.do error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
            }
        }); // .ajax


    }


    $(function () {

        bodyResult(1);

        // if (sessionStorage.getItem('loginMember') != null) {
        $('input[type="radio"]').change(function () {

            bodyResult(this.value);

        }) //onchange

    });// document.ready

</script>

</body>
</html>