<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order_detail.model.*"%>

<%
	OrderDetailService orderSvc = new OrderDetailService();
	List<OrderDetailVO> list = (List<OrderDetailVO>)request.getAttribute("orderDetailVO");
	pageContext.setAttribute("list", list);
%>

<html>
<head>
<title>listOneOrderNo.jsp</title>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>listOneOrderNo.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/Order_Master/ListAllOrder.jsp">回上頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<table>
		<tr>
			<th>課程訂單編號</th>
			<th>課程編號</th>
			<th>課程售價</th>
			<th>課程明細狀態</th>
			<th>優惠活動編號</th>
			<th>退款申請</th>
		</tr>
		<%@ include file="page1.file"%>
		<%-- 	<c:out value ="${pageScope.list}"></c:out> --%>
		<c:forEach var="orderDetailVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">

			<tr>
				<td>${orderDetailVO.orderno}</td>
				<td>${orderDetailVO.courseno}</td>
				<td>${orderDetailVO.sellprice}</td>
				<td>${orderDetailVO.odstatus}</td>
				<td>${orderDetailVO.promono}</td>

				<td>
					<FORM METHOD="post" onsubmit="return confirm('確定要申請退款嗎?');"
						ACTION="<%=request.getContextPath()%>/Order_Detail/Order_Detail.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="退款"><input type="hidden"
							name="orderno" value="${orderDetailVO.orderno}"><input type="hidden"
							name="courseno" value="${orderDetailVO.courseno}"> <input
							type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>