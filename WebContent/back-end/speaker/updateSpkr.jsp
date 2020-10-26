<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.speaker.model.*"%>
<%@ include file="/back-end/index/homepage.jsp" %>

<%
	SpkrVO spkrVO = (SpkrVO) request.getAttribute("spkrVO");
	String info = "資訊更新中";
	try{
		byte[] b = spkrVO.getSpkrinfo();
		info = new String(b);
	} catch (Exception e){
		info = "資訊更新中";
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Xducation - 陪你成長的學習好夥伴</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
	<link href="css/blog-post.css" rel="stylesheet">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
<style>
	.row{
		color: #333;
	}
	input:read-only {
		background: #E3E3E3;
		color: #333333;
		border: 2px #E3E3E3 solid;
	}
	input:focus {
		outline: none;
	}
	#preview img{
		max-height: 100px;
		width: 100px;
		position: absolute;
		margin-top: 25px;
		margin-left: 350px;
		}
	.img-border{
		border: 2px solid #999;
	}
</style>
</head>
<body>
<main class="app-content" style="background-color: #f3f3f3">
	<div id="table-area" class="container-xl">
		<div class="table-responsive">
			<form method="post"	action="<%=request.getContextPath()%>/back-end/speaker/listAllSpkr.jsp">
				<button class="bttn" type="submit">放棄變更</button>
			</form><p>
			<div class="table-wrapper">
				<div class="table-title">
					
               		<div class="row">
						<c:if test="${not empty errorMsgs}">
							<ul>
								<c:forEach var="err" items="${errorMsgs}">
									<li style="color: red">${err}</li>
								</c:forEach>
							</ul>
						</c:if>
					<div class="col-sm-3" style="margin-left: -40px">
						<h2 class="text-center">修改講師資料</h2>
					</div>
                </div>
           </div>
			<div id="preview">
				<img id="dbimg" class="d-flex mr-3 rounded-circle img-border" src="<%=request.getContextPath()%>/speaker/iconreader?spkrno=${spkrVO.spkrno}">
				<img id="newimg" src="">
			</div>
				<form method="post"	action="<%=request.getContextPath()%>/speaker/speaker.do" enctype="multipart/form-data">
				<table>
					<tr><td>講師編號：</td><td><input type="text" name="spkrno" value="${spkrVO.spkrno}"readonly></td></tr>
					<tr><td>講師姓名：</td><td><input type="text" name="spkrname" value="${spkrVO.spkrname}"></td></tr>
					<tr><td>講師電話：</td><td><input type="text" name="spkrphone" value="${spkrVO.spkrphone}"></td></tr>
					<tr><td>講師信箱：</td><td><input type="text" name="spkremail" value="${spkrVO.spkremail}"></td></tr>
					<tr><td>講師圖片：</td><td><input type="file" id="upimg" name="spkricon" value="${spkrVO.spkricon}"></td></tr>
					<tr><td>講師資訊：</td></tr>	
				</table>
				<%@ include file="/back-end/pool/ck.file" %>
				<input type="hidden" name="spkrno" value="${spkrVO.spkrno}">
				<input id="action" type="hidden" name="action" value="updateText"></form>
		</div>
	</div>
</div>
</main>
<script type="text/javascript">		
	//upload image preview
	var upimg = document.getElementById("upimg");
	var dbimg = document.getElementById("dbimg");
	upimg.addEventListener("change", function(){
		readURL(this);
		dbimg.setAttribute("style", "display: none;");
		dbimg.removeAttribute("class", "img-border");
	});
	
	function readURL(input){
		if (input.files && input.files[0]){
			var reader = new FileReader();
			reader.onload = function(e){
				var newimg = document.getElementById("newimg");
				newimg.setAttribute("src", e.target.result);
				newimg.setAttribute("class", "d-flex mr-3 rounded-circle img-border");
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	$("#btn").mouseenter(function(){
		var fileInput = $("#upimg").get(0).files[0];
		if(fileInput){
			$("#action").val("updateOne");
		}
	});
</script>
</body>
</html>
