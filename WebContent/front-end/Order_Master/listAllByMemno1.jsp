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
<title>Xducation - 陪你成長學習的好夥伴</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/rateit.css" />
<style>
.orderListArea {
	text-align: center;
}
</style>
</head>
<body>


	<jsp:include page="/index/front-index/header.jsp" />

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


	<c:if test="${empty list}">
		<div class="orderListArea">無訂單清單</div>
	</c:if>
	<c:if test="${not empty list}">
		<section>
			<div class="container">
				<div class="row w-100">
					<div class="col-lg-12 col-md-12 col-12">

						<table id="orderList"
							class="table table-condensed table-responsive  wow fadeInDown"
							data-wow-delay="0.3s">
							<thead>
								<tr>
									<th>課程訂單編號</th>
									<th>訂單成立時間</th>
									<th>課程訂單狀態</th>
									<th>總金額</th>
									<th>折扣碼編號</th>
									<th>付款方式</th>
								</tr>
							</thead>
							<%@ include file="page1.file"%>
							<tbody>

								<tr>
									<td><a
										href="<%=request.getContextPath()%>/Order_Detail/Order_Detail.do?action=getOne_For_Display_ByMember&orderno=${ordermasterVO.orderno}">${ordermasterVO.orderno}</a></td>
									<td>${ordermasterVO.orderdate}</td>
									<td>${ordermasterVO.orderstatus}</td>
									<td>${ordermasterVO.orderamt}</td>
									<td>${ordermasterVO.coupno}</td>
									<td>${ordermasterVO.payby}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</section>
	</c:if>
	<jsp:include page="/index/front-index/footer.jsp" />
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/jquery.rateit.min.js"></script>


</body>
</html>