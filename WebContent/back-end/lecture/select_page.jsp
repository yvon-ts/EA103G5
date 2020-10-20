<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.lecture.model.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<%
	LecService lecSvc = new LecService();
	List<LecVO> leclist = lecSvc.getList();
	pageContext.setAttribute("leclist", leclist);
%>
<html>
<head>
<title>select_page.jsp</title>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body>

	<c:if test="${not empty errorMsgs}">
		<ul>
			<c:forEach var="err" items="${errorMsgs}">
				<li style="color: red">${err}</li>
			</c:forEach>
		</ul>
	</c:if>
	<form method="post"	action="<%=request.getContextPath()%>/lecture/lecture.do">
		<select name="lecno">
			<c:forEach var="lecVO" items="${leclist}">
				<option value="${lecVO.lecno}">${lecVO.lecno}&nbsp;${lecVO.lecname}</option>
			</c:forEach>
		</select>
		<input type="submit" value="送出查詢">
		<input type="hidden" name="action" value="getOne">
	</form>

	<form method="post"	action="<%=request.getContextPath()%>/back-end/lecture/listAllLec.jsp">
		<input type="submit" value="查詢全部">
	</form>

	<form method="post"	action="<%=request.getContextPath()%>/calendar/addLecIndex.jsp">
		<input type="submit" value="新增講座">
	</form>
	<script>
		$.ajax({
			url: "selectAjax.jsp",
			type: "GET",
			success: function(data){
				showNames(data);
			}
		});
		
		function showNames(data){
			var names = data.split(",");
			var txt = "";
			for(i in names)
				txt += "<option value='" + names[i] + "'>" + names[i] + "</option>";
				$("$lecno").html(txt);
		}
	</script>
</body>
</html>