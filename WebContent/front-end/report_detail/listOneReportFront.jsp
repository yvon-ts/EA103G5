<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.report_detail.model.*"%>


<%
  ReportDetailVO reportdetailVO = (ReportDetailVO) request.getAttribute("reportdetailVO"); //EmpServlet.java(Concroller), 存入req的empVO物件

%>

<html>
<head>
<title>listOneReportFront.jsp</title>


<style type="text/css">
table {
	border-collapse: collapse
}

td, th {
	padding: 5px 20px;
	border: 1px solid #ccc
}

th {
	background-color: #fce8e2
}
</style>

</head>
<body bgcolor='white'>



<table>

	<tr>
		<th><h4><a href="<%= request.getContextPath() %>/front-end/report_detail/select_page.jsp"><img src="<%= request.getContextPath() %>/front-end/report_detail/images/back1.gif" width="100" height="32" border="0"></a></h4></th>
		<th>文章檢舉編號</th>
		<th>檢舉者會員編號</th>
		<th>文章編號</th>
		<th>處理狀態</th>
		
		
	</tr>
	<tr>
		<td><h4><a href="<%= request.getContextPath() %>/front-end/report_detail/select_page.jsp">回首頁</a></h4></td>
		<td><%=reportdetailVO.getReportno()%></td>
		<td><%=reportdetailVO.getMemno()%></td>
		<td><%=reportdetailVO.getPostno()%></td>
		<td><%=reportdetailVO.getPoststatus()%></td>
		
		
	</tr>
</table>


</body>
</html>