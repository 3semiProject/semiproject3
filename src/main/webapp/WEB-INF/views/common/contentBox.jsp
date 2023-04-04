<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main page content box</title>
<style type="text/css">
* {
	color: #01CD88;
}
.cona:hover {
		text-decoration: none;
		color: black;
		font-weight: bold;
	}
#mainTextBox {
	width: 1200px;
	height: 500px;
	border-radius: 35px;
	height: 800px;
	float: left;
	margin-bottom: 50px;
}

#mainTextBox_topN {
	position: relative;
	width: 52%;
	margin-left: 0.5%;
	margin-top: 15px;
	background-color: white;
	border-radius: 35px;
	height: 800px;
	float: left;
}

#mainTextBox_banner {
	position: relative;
	width: 46%;
	margin-right: 0.5%;
	margin-top: 15px;
	background-color: white;
	border-radius: 35px;
	height: 800px;
	float: right;
}

#banner_article {
	position: relative;
	float: left;
	margin: 0;
	width: 49.5%;
	height: 800px;
	border: 1px blue solid;
	background-color: white;
}

#banner_youtube {
	position: relative;
	margin: 0;
	float: right;
	width: 49.5%;
	height: 800px;
	border: 1px blue solid;
	background-color: white;
}

div[name="article"] {
	align-self: center;
	text-align: center;
	width: 80%;
	height: 22%;
	margin: 0 auto;
	margin-top: 4%;
	border: 1px solid black;
	border-radius: 35px;
}

div[name="youtube"] {
	align-self: center;
	text-align: center;
	width: 80%;
	height: 22%;
	margin: 0 auto;
	margin-top: 4%;
	border: 1px solid black;
	border-radius: 35px;
}

#tab1 h1 {
	color: #01CD88;
	font-weight: bold;
	text-shadow: 1px 1px 2px #D1D1D1;
}
</style>
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
	$(function() {
		var values = $('#new_topN').html();
		console.log("values : " + values);
		$.ajax({
			url : "ftop5.do",
			type : "post",
			dataType : "json",
			success : function(data) {
				console.log("success : " + data);

				var jsonStr = JSON.stringify(data);
				var json = JSON.parse(jsonStr);

				for ( var i in json.list) {
					values += "<tr><td>"
							+ "<a class='cona' href='freedetail.do?free_no="
							+ json.list[i].free_no
							+ "'>"
							+ decodeURIComponent(json.list[i].free_name)
									.replace(/\+/gi, " ") + "</a></td><td>"
							+ json.list[i].user_id + "</td><td>"
							+ json.list[i].write_free_date + "</td><td>"
							+ json.list[i].click_free_no + "</td></tr>";
				}
				$('#new_topN').html(values);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log("ftop5.do error : " + jqXHR + ", " + textStatus
						+ ", " + errorThrown);
			}
		});

	}); //document ready

	$(function() {
		var values = $('#hot_topN').html();
		console.log("values : " + values);
		$.ajax({
			url : "hntop5.do",
			type : "post",
			dataType : "json",
			success : function(data) {
				console.log("success : " + data);

				var jsonStr = JSON.stringify(data);
				var json = JSON.parse(jsonStr);

				for ( var i in json.list) {
					values += "<tr><td><a class='cona' href='hotnewdetail.do?hotnew_no="
							+ json.list[i].hotnew_no
							+ "&hotnew_name="
							+ json.list[i].hotnew_name
							+ "&user_id="
							+ json.list[i].user_id
							+ "'>"
							+ decodeURIComponent(json.list[i].hotnew_name)
									.replace(/\+/gi, " ") + "</a></td><td>"
							+ json.list[i].user_id + "</td><td>"
							+ json.list[i].write_hotnew_date + "</td><td>"
							+ json.list[i].click_hotnew_no + "</td></tr>";
				}
				$('#hot_topN').html(values);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log("hntop5.do error : " + jqXHR + ", " + textStatus
						+ ", " + errorThrown);
			}
		});

	}); //document ready
</script>
</head>
<body>
	<hr style="clear: both; border: none">
	<%-- hot/new & article / youtube --%>
	<div id="mainTextBox">
		<div id="mainTextBox_topN">
			<div id="tab1" style="height: 50%; border: 1px solid black;">
				<h1 style="text-align: center">조회수 TOP 게시글</h1>
				<table id="hot_topN" align="center" border="1"
					style="width: 95%; margin-top: 50px;">
					<tr>
						<th style="width: 45%">제목</th>
						<th style="width: 20%">글쓴이</th>
						<th style="width: 20%">날짜</th>
						<th style="width: 15%">조회수</th>
					</tr>

				</table>
			</div>
			<div id="tab1" style="height: 50%; border: 1px solid black;">
				<h1 style="text-align: center">최신 Free 게시글</h1>
				<table id="new_topN" align="center" border="1"
					style="width: 95%; margin-top: 50px;">
					<tr>
						<th style="width: 45%">제목</th>
						<th style="width: 20%">글쓴이</th>
						<th style="width: 20%">날짜</th>
						<th style="width: 15%">조회수</th>
					</tr>
				</table>

			</div>
		</div>


		<div id="mainTextBox_banner">
			<div id="banner_article">

				<div name="article">article1</div>
				<div name="article">article2</div>
				<div name="article">article3</div>
				<div name="article">article4</div>


			</div>
			<div id="banner_youtube">
				<div name="youtube">youtube1</div>
				<div name="youtube">youtube2</div>
				<div name="youtube">youtube3</div>
				<div name="youtube">youtube4</div>


			</div>
		</div>
	</div>
</body>
</html>