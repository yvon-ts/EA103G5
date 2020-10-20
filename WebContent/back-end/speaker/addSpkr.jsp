<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.speaker.model.*"%>

<%@ include file="/back-end/pool/bstage1.jsp"%>

<!DOCTYPE html>

<%
	SpkrVO spkrVO = (SpkrVO) request.getAttribute("spkrVO");
	String info = "請輸入講師資訊";
%>

<html>
<head>
<meta charset="UTF-8">
<title>addSpkr.jsp</title>
<style>
	#newimg{
		max-height: 200px;
		width: auto;
		position: absolute;
		margin-top: -70px;
		margin-left: 320px;
		}
	h1{
		margin-top: 150px;
		margin-left: 400px;
	}
	#include{
		margin-left: 400px;
		padding: 30px;
		background-color: #F3F3F3;
		border-radius: 1%;
	}
</style>
</head>
<body>
<h1>新增講師</h1>
	<div id="include">
		<c:if test="${not empty errorMsgs}">
			<ul>
				<c:forEach var="err" items="${errorMsgs}">
					<li style="color: red">${err}</li>
				</c:forEach>
			</ul>
		</c:if>
		<form method="post"
			action="<%=request.getContextPath()%>/back-end/speaker/select_page.jsp">
			<input type="submit" value="回首頁">
		</form>
		<div id="preivew"><img id="newimg" src=""></div>
		<form method="post"
			action="<%=request.getContextPath()%>/speaker/speaker.do"
			enctype="multipart/form-data">
			<br>
			講師姓名：<input type="text" name="spkrname" value="${spkrVO.spkrname}"><br>
			講師電話：<input type="text" name="spkrphone" value="${spkrVO.spkrphone}"><br>
			講師信箱：<input type="text" name="spkremail" value="${spkrVO.spkremail}"><br>
			講師圖片：<input type="file" id="upimg" name="spkricon" value="${spkrVO.spkricon}"><br>
			講師資訊：
			<%@ include file="/back-end/pool/ck.file"%>
			<input type="hidden" name="action" value="insert">
		</form>
	</div>
	<script type="text/javascript">
		//圖片預覽
		var upimg = document.getElementById("upimg");
		upimg.addEventListener("change", function(){
			readURL(this);
		});
		
		function readURL(input){
			if (input.files && input.files[0]){
				var reader = new FileReader();
				reader.onload = function(e){
					var newimg = document.getElementById("newimg");
					newimg.setAttribute("src", e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
	</script>
</body>
</html>

