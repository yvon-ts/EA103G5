<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.speaker.model.*"%>

<%@ include file="/back-end/pool/bstage1.jsp" %>

<!DOCTYPE html>

<%
	SpkrService spkrSvc = new SpkrService(); 
	List<SpkrVO> list = spkrSvc.getList();
	pageContext.setAttribute("list", list);
	
%>

<html>
<head>
<title>listAllSpkr.jsp</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/table.css">
<style>
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
<h1>講師名單</h1>
<div id="include">
<%if (list == null || list.size() == 0){%>
	<b style="color: red">查無資料</b>		
<%}%>

<table>
	<tr>
		<th>講師編號</th>
		<th>講師姓名</th>
		<th>講師電話</th>
		<th>講師信箱</th>
		<th></th>
		<th></th>
		<th></th>
	</tr>

	<%@ include file="/back-end/pool/page1.file" %>
	<c:forEach var="spkrVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr>
			<td>${spkrVO.spkrno}</td>
			<td>${spkrVO.spkrname}</td>
			<td>${spkrVO.spkrphone}</td>
			<td>${spkrVO.spkremail}</td>
			<td>
			<form method="post" action="<%=request.getContextPath()%>/speaker/speaker.do">
			
			<input type="submit" value="資訊">
			<input type="hidden" name="spkrno" value="${spkrVO.spkrno}">
			<input type="hidden" name="action" value="display_fromList"></form>
			</td>
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
	</c:forEach>

	</table>
	<%@ include file="/back-end/pool/page2.file" %>
	<form method="post"	action="<%=request.getContextPath()%>/back-end/speaker/select_page.jsp">
	<input type="submit" value="回首頁"></form>
	</div>
</body>
</html>

