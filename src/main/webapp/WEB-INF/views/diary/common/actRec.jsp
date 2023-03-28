<%--
  Created by IntelliJ IDEA.
  Date: 2023/03/27
  Time: 5:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <script type="text/javascript"
            src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
    <script type="text/javascript">
        $(function () {

            $.ajax({
                url: "diary_showActRec.do",
                type: "POST",
                dataType: "json",
                success: function (data) {
                    var jsonStr = JSON.stringify(data);

                    console.log("data : " + data);

                    var json = JSON.parse(jsonStr);

                    console.log("json : " + json);
                    for (var i in json.list) {

                        console.log("json.list[" + i + "] : " + json.list[i]);

                        var actRecStr = $('fieldset[name=actRec]').eq(i).html();

                        actRecStr += "<a href='https://" + json.list[i].link + "'><img src=${pageContext.servletContext.contextPath}/resources/images/diary/rec_act_img/" + json.list[i].image +
                            " /></a><br><br>" + json.list[i].title;
                        $('fieldset[name=actRec]').eq(i).html(actRecStr);
                    }// for in
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("diary_showActRec.do error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
                }


            }); //ajax
        }); //ready

    </script>


    <style type="text/css">
        #actRecDiv{
            width: 1200px;
            height: 1200px;
            position: relative;
        }

        fieldset[name="actRec"]{
            text-align: center;
            margin: auto;
            float: left;
            border: none;
        }

        fieldset[name="actRec"] img{
            width: 250px;
            height: 250px;
            border-radius: 30px;
        }
    </style>
</head>
<body>


<div id="actRecDiv" style=": center">
    <br><br><br>
    <div>
        <fieldset name="actRec">
            <legend>easy</legend>

        </fieldset>
    </div>
    <div>
        <fieldset name="actRec">

            <legend>normal</legend>

        </fieldset>
    </div>
    <div>
        <fieldset name="actRec">
            <legend>hard</legend>
        </fieldset>
    </div>
</div>
</body>
</html>
