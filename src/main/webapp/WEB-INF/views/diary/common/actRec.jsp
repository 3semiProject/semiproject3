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
                type: "post",
                dataType: "json",
                success: function (data) {
                    // Object -> String
                    var jsonStr = JSON.stringify(data);
                    // String -> JSON
                    var json = JSON.parse(jsonStr);

                    for (var i in json.list) {

                        $('')
                        values += "<tr><td>" + json.list[i].noticeno +
                            "</td><td><a href='ndetail.do?noticeno=" + json.list[i].noticeno + "'>" +
                            decodeURIComponent(json.list[i].noticetitle.replace(/\+/gi, ' ')) + "</a></td><td>" +
                            json.list[i].noticedate + "</td></tr>";
                    }// for in


                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("diary_showActRec.do error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
                }


            }); //ajax
        }); //ready

    </script>

</head>
<body>
<div>
    <fieldset id="actRec0">
        <legend>easy</legend>

    </fieldset>
</div>
<div>
    <fieldset id="actRec1">

        <legend>normal</legend>

    </fieldset>
</div>
<div>
    <fieldset id="actRec2">
        <legend>hard</legend>
    </fieldset>
</div>
</body>
</html>
