<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.speaker.model.*" %>
<%@ page import="java.util.*" %>

<%@ include file="/back-end/pool/bstage1.jsp" %>

<!DOCTYPE html>
<%
	SpkrService spkrSvc = new SpkrService();
	List<SpkrVO> spkrlist = spkrSvc.getList();
	pageContext.setAttribute("spkrlist", spkrlist);
%>
<html>
<head>
<title>select_page.jsp</title>
<style>
	#ctnt{
	margin-left: 400px;
	margin-top: 150px;
	}
</style>
</head>
<body>
<div id="ctnt">

	<c:if test="${not empty errorMsgs}">
		<ul>
			<c:forEach var="err" items="${errorMsgs}">
				<li style="color: red">${err}</li>
			</c:forEach>
		</ul>
	</c:if>
	<h2>講師管理</h2>
	<div style="">
	<form method="post"	action="<%=request.getContextPath()%>/speaker/speaker.do">
		<input type="text" name="spkrno" placeholder="想做模糊搜尋(現為講師編號)" readonly>
		<!-- <input type="submit" value="送出查詢">
		<input type="hidden" name="action" value="getOne"> -->
	</form>
	<form method="post"	action="<%=request.getContextPath()%>/speaker/speaker.do">
		<select name="spkrno">
			<c:forEach var="spkrVO" items="${spkrlist}">
				<option value="${spkrVO.spkrno}">${spkrVO.spkrno}&nbsp;${spkrVO.spkrname}</option>
			</c:forEach>
		</select>
		<input type="submit" value="送出查詢">
		<input type="hidden" name="action" value="display_fromList">
	</form>

	<form method="post"	action="<%=request.getContextPath()%>/back-end/speaker/listAllSpkr.jsp">
		<input type="submit" value="查詢全部">
	</form>

	<form method="post"	action="<%=request.getContextPath()%>/back-end/speaker/addSpkr.jsp">
		<input type="submit" value="新增講師">
	</form>
	</div><br>
	<h2>講座管理</h2>
	<%@ include file="/back-end/lecture/select_page.jsp" %>
	</div>

</body>
</html>

