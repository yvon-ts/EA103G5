<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/back-end/index/homepage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xducation - 陪你成長的學習好夥伴</title>
<style>
	body{
		background-color: #fff; !important
	}
	#link-area{
		position: absolute;
		top: 20%;
		left: 30%;
		margin: 0 auto;
	}
	.link{
		display: inline-block;
		border-radius: 20px;
		background-color: #fff;
		width: fit-content;
		margin: 0 10px;
		cursor: pointer;
	}
	.link img{
		max-height: 300px;
	}
	#spkr{
		border: 7px solid #5bb7e5;
	}
	#spkr img{
		padding: 20px;
	}
	#lec{
		border: 7px solid #5bb7e5;
	}
	#lec img{
		padding: 15px 10px 5px 10px;
	}
	.title{
		display: inline-block;
		padding: 20px 110px;
		color: #5bb7e5;
		font-size: 28px;
		font-weight: 700;
	}
</style>
</head>
<body>
	<main class="app-content">
	<div id="link-area">
		<div id="spkr" class="link">
			<img src="<%=request.getContextPath()%>/index/front-index/assets/img/head/05.png"><br>
		</div>
		<div id="lec" class="link">
		<img src="<%=request.getContextPath()%>/index/front-index/assets/img/head/lecture.png"><br>
		</div>
		<br>
		<div class="title">講師管理</div>
		<div class="title">講座管理</div>
	</div>
	</main>
	<script src="<%=request.getContextPath()%>/library/jquery/jquery-3.5.1.js"></script>
	<script>
		$("#spkr").click(function(){
			window.location = "<%=request.getContextPath()%>/back-end/speaker/select_page.jsp";
		})
		$("#lec").click(function(){
			window.location = "<%=request.getContextPath()%>/back-end/lecture/select_page.jsp";
		})
	</script>
</body>
</html>