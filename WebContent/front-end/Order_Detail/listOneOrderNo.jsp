<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.order_detail.model.*, com.course.model.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<%
	OrderDetailService orderSvc = new OrderDetailService();
	List<OrderDetailVO> list = (List<OrderDetailVO>) request.getAttribute("orderDetailVO");
	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="lecSvc" scope="page"
	class="com.lecture.model.LecService" />
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
<%@ include file="/index/front-index/header.jsp"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
<style>
</style>
<script>
	
</script>
</head>
<body>

	<jsp:useBean id="courSvc" scope="page"
		class="com.course.model.CourseService" />
	<jsp:useBean id="courVO" scope="page" class="com.course.model.CourseVO" />

	<div id="table-area" class="container-xl">
		<div class="table-responsive">
			<div class="table-wrapper">
				<div class="table-title">
					<div class="row">
						<div class="col-sm-3"></div>
						<div class="col-sm-4">
							<h2 class="text-center">我的訂單明細</h2>
						</div>
					</div>
				</div>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>訂單編號</th>
							<th>課程名稱</th>
							<th>課程金額</th>
							<th>訂單狀態</th>
							<th>退款</th>
						</tr>
					</thead>
					<tbody>
						<%@ include file="/back-end/pool/page1.file"%>
						<c:forEach var="orderDetailVO" items="${list}"
							begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
							<tr>
								<td>${orderDetailVO.orderno}</td>
								<td>${courSvc.getOneCourse(orderDetailVO.courseno).coursename}</td>
								<td>${orderDetailVO.sellprice}</td>
								<td>${orderDetailVO.odstatus}</td>
								<td>
									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Order_Detail/Order_Detail.do" style="margin-bottom: 0px;" id="refund-form">
										<input type="hidden" name="orderno" value="${orderDetailVO.orderno}"> 
										<input type="hidden" name="courseno" value="${orderDetailVO.courseno}">
										<input type="hidden" name="action" value="refund">
										<button type="submit" class="btn btn-primary" id="${orderDetailVO.courseno}">退款</button>
									</FORM>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<%@ include file="/back-end/pool/page2.file"%>
			</div>
		</div>
	</div>
	<%@ include file="/index/front-index/footer.jsp"%>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

	<script>
		$(".btn").click(function(e){
			e.preventDefault();
			Swal.fire({
				  title: '確定要退款嗎?',
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: '確定退款!'
				}).then((result) => {
				  if (result.isConfirmed) {
				    Swal.fire(
				      '已提交申請',
				    )
				    $("#refund-form").submit();
				  }
				})
		})
	</script>
</body>
</html>
