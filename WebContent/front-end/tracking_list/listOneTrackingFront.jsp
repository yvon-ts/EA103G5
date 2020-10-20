<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tracking_list.model.*"%>


<%
  TrackingListVO trackinglistVO = (TrackingListVO) request.getAttribute("trackinglistVO");
%>

<html>
<head>
<title>listOneReportBack.jsp</title>


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
		<th><h4><a href="<%= request.getContextPath() %>/front-end/tracking_list/select_page.jsp"><img src="<%= request.getContextPath() %>/front-end/images/back1.gif" width="100" height="32" border="0"></a></h4></th>
		<th>會員編號</th>
		<th>課程編號</th>
		
		
	</tr>
	<tr>
		<td><h4><a href="<%= request.getContextPath() %>/front-end/tracking_list/select_page.jsp">回首頁</a></h4></td>
		<td><%=trackinglistVO.getMemno()%></td>
		<td><%=trackinglistVO.getCourseno()%></td>
		
		
	</tr>
</table>

</body>
</html>