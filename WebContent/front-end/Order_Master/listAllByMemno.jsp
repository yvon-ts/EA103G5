<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order_master.model.*, com.members.model.*"%>


<%
	MembersVO memberVO = (MembersVO) session.getAttribute("loginMembersVO");
	String memno = memberVO.getMemno().toString();
	
	OrderMasterService orderSvc = new OrderMasterService();
	List<OrderMasterVO> list = orderSvc.getOnesOrder(memno);
	pageContext.setAttribute("list", list);
%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Xducation - 陪你成長的學習好夥伴</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
<%@ include file="/index/front-index/header.jsp"%>
<style>
</style>
<script>
	
</script>
</head>
<body>

	<div id="padd">padd</div>
	<div id="table-area" class="container-xl">
		<div class="table-responsive">
			<div class="table-wrapper">
				<div class="table-title">
					<div class="row">
						<div class="col-sm-3"></div>
						<div class="col-sm-4">
							<h2 class="text-center">訂單紀錄</h2>
						</div>
					</div>
				</div>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>課程訂單編號</th>
							<th>訂單成立時間</th>
							<th>課程訂單狀態</th>
							<th>總金額</th>
							<th>折扣碼編號</th>
						</tr>
					</thead>
					<tbody>
						<%@ include file="/back-end/pool/page1.file"%>
						<c:forEach var="orderVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
						<c:set var="coup" scope="page" value="${orderVO.coupno}"></c:set>
							<tr>
								<td><a
									href="<%=request.getContextPath()%>/Order_Detail/Order_Detail.do?action=getOne_For_Display_ByMember&orderno=${orderVO.orderno}">${orderVO.orderno}</a></td>
								<td>${orderVO.orderdate}</td>
								<td>${orderVO.orderstatus}</td>
								<td>${orderVO.orderamt}</td>
								<td>
									<c:if test='${empty coup}'>
									 未使用
									</c:if>
									<c:if test='${not empty coup}'>
									 ${orderVO.coupno}
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<%@ include file="/back-end/pool/page2.file"%>
				<div class="clearfix">
					<ul class="pagination">
						<li class="page-item disabled"><a href="#">Previous</a></li>
						<li class="page-item active"><a href="#" class="page-link">1</a></li>
						<li class="page-item"><a href="#" class="page-link">2</a></li>
						<li class="page-item"><a href="#" class="page-link">3</a></li>
						<li class="page-item"><a href="#" class="page-link">4</a></li>
						<li class="page-item"><a href="#" class="page-link">5</a></li>
						<li class="page-item"><a href="#" class="page-link">Next</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/index/front-index/footer.jsp"%>
</body>
</html>
