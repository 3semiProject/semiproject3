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

        .intensity tr {
            height: 50px
        }

        .tabs a.center{
            background-color: rgba(130, 201, 18, 0.5);
            border-bottom: 3px solid rgba(86,140,8,0.5);
        }
    </style>
    <script type="text/javascript"
            src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>


</head>
<body style="width: 1280px">
<c:import url="/WEB-INF/views/common/menubar.jsp"/> <!--메인 메뉴바-->
<br><br>
<c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp"/> <!--다이어리 메뉴바-->

<br><br><br>
<c:import url="/WEB-INF/views/diary/common/statsTap.jsp"/>            <!--식단/운동/체형 탭-->
<br><br>
<c:import url="/WEB-INF/views/diary/common/statsRangeBar.jsp"/>            <!--식단/운동/체형 탭-->


<div>
    <canvas id="actChart"></canvas>
</div>


<hr>

My 다이어리 분석
<hr class="horizontalBar" style="width: 100%">
<div id="stats" style="height: 300px; display: flex;">
    <div style="width: 50%">
        <div class="stats" style="width:100%; height: 40%">
            <table>
                <tr>
                    <td class="lefttd">총 운동 횟수 :</td>
                    <td id="actCount"></td>
                </tr>
                <tr>
                    <td class="lefttd">총 운동 시간 :</td>
                    <td id="actTime"></td>
                </tr>
            </table>
        </div>
        <div class="horizontalBar"></div>

        <div class="stats" style="width:100%; height: 60%">
            <table>
                <tr>
                    <td class="lefttd">자주하는 운동 :</td>
                    <td id="maxDay"></td>
                </tr>
                <tr>
                    <td class="lefttd">칼로리 소모량이 가장 많은 운동 :</td>
                    <td id="maxKcal"></td>
                </tr>
                <tr>
                    <td class="lefttd">가장 오래한 운동 :</td>
                    <td id="maxTime"></td>
                </tr>
                <tr>
                    <td class="lefttd">평균 운동 시간 :</td>
                    <td id="avgTime"></td>
                </tr>
            </table>

        </div>
    </div>
    <div class="verticalBar"></div>
    <div style="width: 50%; height: 300px; display: flex;">


        <div style="width: 290px;">
            <canvas id="actStatsChart"></canvas>
        </div>


        <div style="display: flex;align-items: center;">
            <table class="intensity">
                <tr>
                    <td>저강도 :</td>
                    <td id="weakTime"></td>
                </tr>
                <tr>
                    <td>중강도 :</td>
                    <td id="middleTime"></td>
                </tr>
                <tr>
                    <td>고강도 :</td>
                    <td id="strongTime"></td>
                </tr>
            </table>
        </div>
    </div>


</div>
<hr class="horizontalBar" style="width: 100%">
<c:import url="/WEB-INF/views/common/footer.jsp"/>


<script type="text/javascript">
    var actStats;
    var barLineChart;
    var pieChart;
    var actChart;

    const ctxStats = document.getElementById('actStatsChart');
    const ctx = document.getElementById('actChart');

    function actResult(range) {
        $.ajax({
            url: "diary_ActStats.do",
            data:
                {statsRange: range},
            dataType: "json",
            success: function (data) {
                var jsonStr = JSON.stringify(data);
                console.log("통계 json : " + jsonStr);

                actStats = JSON.parse(jsonStr);
                console.log("parse json : " + actStats);


                $('#actCount').text(actStats.tot_act_val + " 회");
                $('#actTime').text(actStats.tot_act_time + " 분");
                $('#maxDay').text(actStats.maxDay_actName);
                $('#maxKcal').text(actStats.maxKcal_actName);
                $('#maxTime').text(actStats.maxTime_actName);
                $('#avgTime').text(actStats.avg_act_one + " 분");
                $('#weakTime').text(actStats.tot_weak_time + " 분");
                $('#middleTime').text(actStats.tot_middle_time + " 분");
                $('#strongTime').text(actStats.tot_strong_time + " 분");


                if (pieChart !== undefined) {
                    pieChart.destroy();
                }


                pieChart = new Chart(ctxStats, {
                    type: 'pie',
                    data: {
                        labels: ['저강도', '중강도', '고강도'],
                        datasets: [{
                            label: '총 운동시간 (분)',
                            backgroundColor: ['rgba(150,255,150,1)', 'rgba(255,255,50,1)', 'rgba(255,100,50,1)'],
                            data: [Number(actStats.tot_weak_time), Number(actStats.tot_middle_time), Number(actStats.tot_strong_time)]
                        }]
                    }, option: {}
                });


            }, //success
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("diary_ActStats.do error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
            }
        })
        ; // .ajax


        $.ajax({
            url: "diary_ActChart.do",
            data:
                {statsRange: range},
            dataType: "json",
            success: function (data) {


                var jsonStr = JSON.stringify(data);
                console.log("차트통계 json : " + jsonStr);
                actChart = JSON.parse(jsonStr);
                console.log("parse json : " + actChart);

                var dateX = new Array();

                for (var i in actChart.list) {
                    dateX[i] = actChart.list[i].date;
                }

                var a_k = new Array();

                for (var i in actChart.list) {
                    a_k[i] = actChart.list[i].act_kcal;
                }

                var a_m = new Array();

                for (var i in actChart.list) {
                    a_m[i] = actChart.list[i].act_mm;
                }

                if (barLineChart !== undefined) {
                    barLineChart.destroy();
                }


                barLineChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: dateX,
                        datasets: [
                            {
                                type: 'line',
                                label: '소비 칼로리 (kcal)',
                                backgroundColor: "green",
                                borderColor: "rgba(244,174,75,0.7)",
                                fill: false,
                                data: a_k
                            },

                            {
                                type: 'bar',
                                label: '운동 시간 (분)',
                                backgroundColor: 'rgba(86, 180, 50, 0.7)',
                                yAxisID: 'y-axis-left',
                                data: a_m

                            }
                        ]
                    },
                    option: {
                        scale: {
                            y: {
                                id: 'y-axis-right',
                                position: 'right'
                            }
                        }
                    }
                });


            }, //success
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("diary_actChart.do error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
            }
        }); // .ajax


    }


    $(function () {

        actResult(1);

        // if (sessionStorage.getItem('loginMember') != null) {
        $('input[type="radio"]').change(function () {

            actResult(this.value);

        }) //onchange

    });// document.ready

</script>

</body>
</html>