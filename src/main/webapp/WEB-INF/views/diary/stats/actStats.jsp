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
    </style>
    <script type="text/javascript"
            src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>

    <script type="text/javascript">

        var actStats;

        $(function () {

            // if (sessionStorage.getItem('loginMember') != null) {
                $.ajax({
                    url: "diary_ActStats.do",
                    data:
                        {statsRange: "3"},
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

                    }, //success
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("diary_ActStats.do error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
                    }
                }); // .ajax
            <%-- else {--%>
            <%--    location.href="${pageContext.servletContext.contextPath}/loginPage.do";--%>
            <%--}--%>

        }); // document.ready
    </script>


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
    <canvas id="actChart"></canvas>
</div>


<script>
    const ctx = document.getElementById('actChart');

    new Chart(ctx, {
            type: 'line',
            data: {
                labels: "운동 일주일 통계",
                datasets: [{
                    type: 'bar',
                    label: 'Dataset 1',
                    backgroundColor: "pink",
                    borderColor: "red",
                    data: [1, 2, 3, 4, 5, 6, 7]
                }, {
                    type: 'line',
                    label: 'Dataset 3',
                    backgroundColor: "green",
                    borderColor: "black",
                    fill: false,
                    data: [1, 9, 2, 8, 3, 4, 6]
                }]
            },
        }
    );
</script>

<hr>

<pre>

받은 값 : diary, term
보낼 값 : diary, term

diary_ActGraph.do -> ajax : graphs, period, title -> 그래프 ajax
diary_ActStats ->ajax : stats -> 분석내용, top3


</pre>
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

        <script>
            setTimeout(function () {
                const ctxStats = document.getElementById('actStatsChart');
                new Chart(ctxStats, {
                        type: 'pie',
                        data: {
                            labels: ['저강도', '중강도', '고강도'],
                            datasets: [{
                                label: '총 운동시간 (분)',
                                backgroundColor: ['rgba(150,255,150,1)', 'rgba(255,255,50,1)', 'rgba(255,100,50,1)'],
                                data: [Number(actStats.tot_weak_time), Number(actStats.tot_middle_time), Number(actStats.tot_strong_time)]
                            }]
                        }, option: {}
                    }
                );
            }, 500)
        </script>

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
<c:import url="/WEB-INF/views/diary/common/actRec.jsp"/>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>