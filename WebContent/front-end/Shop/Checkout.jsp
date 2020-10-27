<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page
	import="com.course.model.*, com.coup_code.model.*, com.members.model.*"%>

<%
	List<CourseVO> buylist = (List<CourseVO>) session.getAttribute("shoppingList");

	MembersVO membersVO = (MembersVO) session.getAttribute("membersVO");

	for (CourseVO vo : buylist) {
		System.out.println(vo);
	}
%>

<html>
<head>
<meta charset="UTF-8">
<title>Checkout.jsp</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/rateit.css" />
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style>
.title {
	height: 1px;
	margin: 0 auto 30px;
	position: relative;
	background-color: #0099CC;
}

.checkoutArea
,
{
text-align
 
:
 
center
;

	
}
.js-load-more {
	padding: 0 15px;
	width: 120px;
	height: 30px;
	background-color: #D31733;
	color: #fff;
	line-height: 30px;
	border-radius: 5px;
	margin: 20px auto;
	border: 0 none;
	font-size: 16px;
	display: none; /*預設不顯示，ajax呼叫成功後才決定顯示與否*/
}

.rateit .rateit-preset {
	color: #FFCC36;
	background:
		url(https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/star.gif)
		left -32px !important;
}
</style>
</head>
<body>

	<jsp:include page="/index/front-index/header.jsp" />
	<jsp:useBean id="coupSvc" scope="page"
		class="com.coup_code.model.CoupCodeService" />

	<form method="post"
		action="<%=request.getContextPath()%>/Order_Master/Order_Master.do"
		id="myForm">
		<section id="services" class="section-padding" style="padding: 90px 0">
			<div class="container">
				<div class="section-header">
					<h2 class="section-title wow fadeInDown" data-wow-delay="0.3s">
						<i class="fa fa-shopping-cart" aria-hidden="true"
							style="font-size: 25px"></i>&nbsp;Checkout list
					</h2>
					<div class="row">
						<h6>要使用折扣券嗎?&nbsp;</h6>
						<select name="coupno">
							<option value="empty">不使用折扣券
								<c:forEach var="coupVO"
									items="${coupSvc.getMemberCoup(membersVO.memno)}">
									<option value="${coupVO.coupno}">${coupVO.coupcode}
								</c:forEach>
						</select>
					</div>
					<section>
						<div class="container">
							<div class="row w-100">
								<div class="col-lg-12 col-md-12 col-12">
									<div class="checkoutArea">
										<table id="checkoutArea"
											class="table table-condensed table-responsive  wow fadeInDown"
											data-wow-delay="0.3s">
											<thead>
												<tr>
													<th style="width: 60%">課程名稱</th>
													<th style="width: 20%">售價</th>
													<th style="width: 18%"></th>
												</tr>
											</thead>
											<tbody>

												<c:set var="totalPrice" value="${0}" />
												<%
													int orderamt = 0;
													for (CourseVO courseVO : buylist) {
												%>
												<tr>
													<td data-th="Product">
														<div class="row">
															<div class="col-md-3 text-left">
																<img src="<%=request.getContextPath()%>/course/CoursePictureReaderFromDB?courseno=<%=courseVO.getCourseno()%>"
																	alt="" class="img-fluid d-none d-md-block rounded mb-2 shadow ">
															</div>
															<div class="col-md-9 text-left mt-sm-2">
																<h5><%=courseVO.getCoursename()%></h5>
															</div>
														</div>
													</td>

													<td data-th="Price"><%=courseVO.getCourseprice()%></td>
													<%
														orderamt += courseVO.getCourseprice();
														}
													%>
												</tr>
											</tbody>
										</table>

										<div class="float-right text-right" style="margin-top: -30px">
											<h5 id="totalPrice">
												Total:$<%=orderamt%></h5>
										</div>
										<div class="row mt-4 d-flex align-items-center">
											<div class="col-sm-6 mb-3 mb-m-1 order-md-1 text-md-left">
												<a href="<%=request.getContextPath()%>/front-end/course/listAllCourseForUser.jsp">
													<i class="fa fa-undo" aria-hidden="true"></i>&nbsp;&nbsp;回到商店頁面
												</a>
											</div>
										</div>
										<div>
											<h5>請填寫訂購人資訊</h5>
											<div class="row">
												<div class="col-2">訂購人姓名</div>
												<div class="col-3"><Input type="text" id="name"></div>
												<div class="col-2">連絡電話</div>
												<div class="col-3"><Input type="text" id="phone"></div>
											</div>
											<br>
											<div class="row">
												<div class="col-2">電子信箱</div>
												<div class="col-3"><Input type="text" id="name"></div>
												<div class="col-2">連絡地址</div>
												<div class="col-3"><Input type="text" id="phone"></div>
											</div>
											
										</div>
										<br> <input type="hidden" name="action" value="insert">
										<input type="hidden" name="memno" value="<%=membersVO.getMemno()%>"> 
										<input type="hidden" name="orderamt" value="<%=orderamt%>">
										<div class="col-sm-6 order-md-2 text-right">
											<input type="submit" value="結帳">
										</div>
									</div>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>
		</section>
	</form>

	<jsp:include page="/index/front-index/footer.jsp" />
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/jquery.rateit.min.js"></script>
</body>
</html>