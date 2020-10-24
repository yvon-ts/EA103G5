<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order_master.model.*, com.members.model.*"%>


<%
	MembersVO membersVO = (MembersVO) session.getAttribute("membersVO");
	String memno = membersVO.getMemno().toString();

	OrderMasterService orderSvc = new OrderMasterService();
	List<OrderMasterVO> list = orderSvc.getOnesOrder(memno);
	pageContext.setAttribute("list", list);
%>

<html>
<head>
<title>listAllByMemno.jsp</title>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>listAllByMemno.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/Order_Master/OrderMasterDB.jsp">回上頁</a>
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
			<th>會員編號</th>
			<th>訂單成立時間</th>
			<th>課程訂單狀態</th>
			<th>總金額</th>
			<th>折扣碼編號</th>
			<th>付款方式</th>
		</tr>
		<%@ include file="page1.file"%>
		<%-- 			<c:out value ="${pageScope.list}"></c:out> --%>

		<c:forEach var="ordermasterVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">

			<tr>
				<td><a
					href="<%=request.getContextPath()%>/Order_Detail/Order_Detail.do?action=getOne_For_Display_ByMember&orderno=${ordermasterVO.orderno}">${ordermasterVO.orderno}</a></td>
				<td>${ordermasterVO.memno}</td>
				<td>${ordermasterVO.orderdate}</td>
				<td>${ordermasterVO.orderstatus}</td>
				<td>${ordermasterVO.orderamt}</td>
				<td>${ordermasterVO.coupno}</td>
				<td>${ordermasterVO.payby}</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>