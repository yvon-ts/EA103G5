<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.speaker.model.*"%>

<%@ include file="/back-end/pool/bstage1.jsp" %>

<!DOCTYPE html>

<%
	SpkrVO spkrVO = (SpkrVO) request.getAttribute("spkrVO");
	String info = "資訊更新中";
	try{
		//CKeditor - Bytes to String
		byte[] b = spkrVO.getSpkrinfo();
		info = new String(b);
	} catch (Exception e){
		info = "資訊更新中";
	}

%>

<html>
<head>
<title>listOneSpkr.jsp</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/table.css">
<style>
	#displayInfo{
		width: 83%;
		padding: 30px;
		background-color: #F3F3F3;
		border-radius: 5px;
	}
	#displayInfo img{
		max-height: 200px;
		width: auto;
	}
	#btn1{
		margin-left: 400px;
		margin-top: 150px;
		display: inline-block;
	}
	#btn2{
		margin-top: 150px;
		display: inline-block;
	}
</style>

</head>
<body>
<div id="btn1">
<form method="post"	action="<%=request.getContextPath()%>/back-end/speaker/listAllSpkr.jsp">
		<input type="submit" value="回列表">
	</form></div>
	<div id="btn2">
	<form method="post"	action="<%=request.getContextPath()%>/back-end/speaker/select_page.jsp">
	<input type="submit" value="回首頁"></form></div>
	<br>
<div style="margin-left: 400px;">

<table>
	<tr>
		<th>講師編號</th>
		<th>講師姓名</th>
		<th>講師電話</th>
		<th>講師信箱</th>
		<th></th>
		<th></th>
	</tr>
	<tr>
		<td>${spkrVO.spkrno}</td>
		<td>${spkrVO.spkrname}</td>
		<td>${spkrVO.spkrphone}</td>
		<td>${spkrVO.spkremail}</td>
		<td>
				<form method="post"	action="<%=request.getContextPath()%>/speaker/speaker.do">
				<input type="submit" value="修改">
				<input type="hidden" name="spkrno" value="${spkrVO.spkrno}">
				<input type="hidden" name="action" value="update_fromList"></form>
			</td>
			<td>
				<form method="post"	action="<%=request.getContextPath()%>/speaker/speaker.do">
				<input type="submit" value="刪除">
				<input type="hidden" name="spkrno" value="${spkrVO.spkrno}">
				<input type="hidden" name="action" value="delete"></form>
			</td>
	</tr>
</table>
<div id="displayInfo"><img src="<%=request.getContextPath()%>/speaker/iconreader?spkrno=${spkrVO.spkrno}"><br><%=info %></div>
</div>	

</body>
</html>
