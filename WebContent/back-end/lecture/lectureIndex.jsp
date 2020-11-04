<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/back-end/index/homepage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xducation - 陪你成長的學習好夥伴</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
<style>
	body{
		background-color: #fff; !important
	}
	#link-area{
		margin-top: 100px;
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
	<main class="app-content" style="background-color: #f3f3f3">
	<div class="container">
    	<div id="link-area" class="row">
        	<div class="col-md-6">
        		<div id="spkr" class="link">
					<img src="<%=request.getContextPath()%>/index/front-index/assets/img/head/05.png"><br>
				</div>
				<div class="title">講師管理</div>
            </div>
            <div class="col-md-6">
            	<div id="lec" class="link">
					<img src="<%=request.getContextPath()%>/index/front-index/assets/img/head/lecture.png"><br>
				</div>
				<div class="title">講座管理</div>
            </div>
        </div>
    </div>
	</main>
	<script src="<%=request.getContextPath()%>/library/jquery/jquery-3.5.1.js"></script>
	<script>
		$("#spkr").click(function(){
			window.location = "<%=request.getContextPath()%>/back-end/speaker/listAllSpkr.jsp";
		})
		$("#lec").click(function(){
			window.location = "<%=request.getContextPath()%>/back-end/lecture/listAllLec.jsp";
		})
	</script>
</body>
</html>