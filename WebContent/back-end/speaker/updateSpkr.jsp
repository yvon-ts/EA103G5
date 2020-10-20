<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.speaker.model.*"%>

<%@ include file="/back-end/pool/bstage1.jsp" %>

<!DOCTYPE html>

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

<html>
<head>
<meta charset="UTF-8">
<title>updateSpkr.jsp</title>
<style>
	input:read-only {
		background: #E3E3E3;
		color: #333333;
		border: 2px #E3E3E3 solid;
	}
	input:focus {
		outline: none;
	}
	#btn1{
		margin-top: 130px;
	}
	#preview img{
		max-height: 200px;
		width: auto;
		position: absolute;
		margin-top: -70px;
		margin-left: 320px;
		}
</style>
</head>
<body>
<div style="margin-left: 400px;">
<c:if test="${not empty errorMsgs}">
		<ul>
			<c:forEach var="err" items="${errorMsgs}">
				<li style="color: red">${err}</li>
			</c:forEach>
		</ul>
	</c:if>
<div id="btn1">
	<form method="post"	action="<%=request.getContextPath()%>/back-end/speaker/listAllSpkr.jsp">
	<input type="submit" value="回列表">
	</form>
</div><p>
<div id="preview"><img id="dbimg" src="<%=request.getContextPath()%>/speaker/iconreader?spkrno=${spkrVO.spkrno}"><img id="newimg" src=""></div>
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
	<input type="hidden" name="action" value="updateOne"></form>
	</div>
	<script type="text/javascript">		
		//upload image preview
		var upimg = document.getElementById("upimg");
		var dbimg = document.getElementById("dbimg");
		upimg.addEventListener("change", function(){
			readURL(this);
			dbimg.setAttribute("style", "display: none;")
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
