<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.order_detail.model.*"%>
<%@ page import="java.util.*"%>

<%
OrderDetailVO ordVO = (OrderDetailVO) request.getAttribute("orderDetailVO"); 
%>

<html>
<head>
<title>listOneOrderDetail.jsp</title>

<body>

<table id="table-1">
	<tr><td>
		 <h4><a href="<%=request.getContextPath() %>/back-end/Order_Master/OrderMasterDB.jsp">回訂單</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>課程訂單編號</th>
			<th>課程編號</th>
			<th>課程售價</th>
			<th>課程明細狀態</th>
			<th>優惠活動編號</th>
	</tr>
	<tr>
		<td>${orderDetailVO.orderno}</td>
				<td>${orderDetailVO.courseno}</td>
				<td>${orderDetailVO.sellprice}</td>
				<td>${orderDetailVO.odstatus}</td>
				<td>${orderDetailVO.promono}</td>
	</tr>
</table>

</head>


</body>
</html>