<%--
  Created by IntelliJ IDEA.
  Date: 2023/04/13
  Time: 2:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>
<script type="text/javascript"
        src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>

<script>

    var isExist = '${isExist}';
    $(function () {

        if (isExist === 'N') {

            if (confirm("작성된 목표가 없습니다. 작성하시겠습니까?") == true) {
                location.href = "notExistGoal.do?isExist=N&isok=y";
            }else{
                location.href = "notExistGoal.do?isExist=N&isok=n";
            }

        } else {
            if (confirm("목표 기간이 지났습니다. 새로 작성하시겠습니까?") == true) {
                location.href = "notExistGoal.do?isExist=D&isok=y";
            }else{
                location.href = "notExistGoal.do?isExist=D&isok=n";
            }
        }
    });

</script>
</body>
</html>
