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

        .tandanzi tr {
            height: 50px
        }



        .tabs a.left{
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
    <canvas id="eatChart"></canvas>
</div>


<hr>

My 다이어리 분석
<hr class="horizontalBar" style="width: 100%">
<div id="stats" style="height: 300px; display: flex;">
    <div style="width: 50%">
        <div class="stats" style="width:100%; height: 40%">
            <table>
                <tr>
                    <td class="lefttd">권장 칼로리 섭취량 :</td>
                    <td id="recommendKcal"></td>
                </tr>
                <tr>
                    <td class="lefttd">평균 칼로리 섭취량 :</td>
                    <td id="averageKcal"></td>
                </tr>
            </table>
        </div>
        <div class="horizontalBar"></div>

        <div class="stats" style="width:100%; height: 60%">
            <table>
                <tr>
                    <td class="lefttd">대비 :</td>
                    <td id="contrastKcal"></td>
                </tr>
            </table>

        </div>
    </div>
    <div class="verticalBar"></div>
    <div style="width: 50%; height: 300px; display: flex;">


        <div style="width: 290px;">
            <canvas id="eatStatsChart"></canvas>
        </div>


        <div style="display: flex;align-items: center;">
            <table class="tandanzi">
                <tr>
                    <td>탄수화물 :</td>
                    <td id="tan_g"></td>
                </tr>
                <tr>
                    <td>단백질 :</td>
                    <td id="dan_g"></td>
                </tr>
                <tr>
                    <td>지방 :</td>
                    <td id="zi_g"></td>
                </tr>
            </table>
        </div>
    </div>


</div>
<hr class="horizontalBar" style="width: 100%">
<c:import url="/WEB-INF/views/common/footer.jsp"/>


<script type="text/javascript">
    var eatStats;
    var barLineChart;
    var pieChart;
    const ctxStats = document.getElementById('eatStatsChart');
    const ctx = document.getElementById('eatChart');

    function eatResult(range) {
        $.ajax({
            url: "diary_EatStats.do",
            data:
                {statsRange: range},
            dataType: "json",
            success: function (data) {
                var jsonStr = JSON.stringify(data);

                eatStats = JSON.parse(jsonStr);

                $('#recommendKcal').text(eatStats.rec_eat + " Kcal");
                $('#averageKcal').text(eatStats.avg_eat + " Kcal");
                $('#contrastKcal').text(eatStats.contrast_eat + " Kcal");

                $('#avgTime').text(eatStats.many_food + " 분");
                $('#weakTime').text(eatStats.many_food + " 분");


                $('#tan_g').text(eatStats.tan_g + "g");
                $('#dan_g').text(eatStats.dan_g + "g");
                $('#zi_g').text(eatStats.zi_g + "g");

                if (pieChart !== undefined) {
                    pieChart.destroy();
                }



                pieChart = new Chart(ctxStats, {
                    type: 'pie',
                    data: {
                        labels: ['탄수화물', '단백질', '지방'],
                        datasets: [{
                            label: 'Kcal',
                            backgroundColor: ['rgba(150,255,150,1)', 'rgba(255,255,50,1)', 'rgba(255,100,50,1)'],
                            data: [Number(eatStats.tan_g) * 4, Number(eatStats.dan_g) * 4, Number(eatStats.zi_g) * 9]
                        }]
                    }, option: {}
                });


            }, //success
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("diary_eatStats.do error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
            }
        })
        ; // .ajax





        $.ajax({
            url: "diary_EatChart.do",
            data:
                {statsRange: range},
            dataType: "json",
            success: function (data) {


                var jsonStr = JSON.stringify(data);
                console.log("차트통계 json : " + jsonStr);
                eatChart = JSON.parse(jsonStr);
                console.log("parse json : " + eatChart);

                var dateX = new Array();

                for (var i in eatChart.list) {
                    dateX[i] = eatChart.list[i].date;
                }

                var a_e = new Array();

                for (var i in eatChart.list) {
                    a_e[i] = eatChart.list[i].avg_eat;
                }

                var r_e = new Array();

                for (var i in eatChart.list) {
                    r_e[i] = eatChart.list[i].rec_eat;
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
                                label: '권장 칼로리 섭쉬량',
                                backgroundColor: "pink",
                                borderColor: "rgba(244,174,75,0.7)",
                                data: r_e

                            },

                            {
                                type: 'bar',
                                label: '칼로리 섭취량',
                                backgroundColor: 'rgba(86, 180, 50, 0.7)',
                                data: a_e
                            },
                          ]
                    },
                });


            }, //success
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("diary_eatChart.do error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
            }
        }); // .ajax








    }


    $(function () {

        eatResult(1);

        // if (sessionStorage.getItem('loginMember') != null) {
        $('input[type="radio"]').change(function () {

            eatResult(this.value);

        }) //onchange

    });// document.ready

</script>

</body>
</html>