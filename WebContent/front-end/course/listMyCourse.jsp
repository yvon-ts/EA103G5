<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.members.model.*"%>
<%@ page import="com.course.model.*"%>
<%@ page import="com.order_detail.model.*"%>

<jsp:useBean id="courseSvc" scope="page" class="com.course.model.CourseService" />
<jsp:useBean id="orderDetailSvc" scope="page" class="com.order_detail.model.OrderDetailService" />

<%	
	// 施工中，尚未完成 2020/10/30 01:30 顯鈞
	
	// 檢查登入者身分
	MembersVO loginMembersVO = (MembersVO) session.getAttribute("loginMembersVO");
	if (loginMembersVO == null) {
		// 若未登入，則導回所有課程的頁面
		RequestDispatcher failureView = request.getRequestDispatcher("/front-end/course/listAllCourseForUser.jsp");
		failureView.forward(request, response);
		return;
	}
	
	List<OrderDetailVO> myOrderDetailList = new ArrayList<OrderDetailVO>();
	myOrderDetailList = orderDetailSvc.getMyCourse(loginMembersVO.getMemno());
	System.out.println("買過幾門課" + myOrderDetailList.size());
	
	List<CourseVO> list = new ArrayList<CourseVO>();	
	for (int i = 0; i < myOrderDetailList.size(); i++) {
		list.add(courseSvc.getOneCourse(myOrderDetailList.get(i).getCourseno()));		
	}
	
	pageContext.setAttribute("courseList", list);
	
	List<Integer> averageScore = new ArrayList<>();
	for (CourseVO vo : list) {
		// 處理課程評分精度以及分母為零的問題
		Integer csscore = vo.getCsscore();
		Integer csscoretimes = vo.getCsscoretimes();
		if (csscoretimes > 0) {
			averageScore.add(csscore/csscoretimes);
		} else {
			averageScore.add(0);
		}				
	}
%>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Xducation - 陪你成長的學習好夥伴</title>
	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/rateit.css" />
	<link rel="stylesheet" href="<%=request.getContextPath()%>/library/font-awesome/5.15.1/css/all.min.css">

	<style>
		.rateit .rateit-preset {
			color: #FFCC36;
			background: url(https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/star.gif) left -32px !important;
		}
	</style>
</head>

<body>
	<!-- member -->
	<input type="hidden" id="memno" value="${membersVO.memno}" />
	
	<!-- include 前台頁面的 header -->
	<jsp:include page="/index/front-index/header.jsp" />

	<div id="hero-area" style="background-image: none">
		<div class="container">
			<h1>已購買課程</h1>
			
			<section id="services" class="section-padding">
				<div class="container">

					<!-- Services item1 -->
					<div class="row seacharea">
						<c:forEach var="courseVO" items="${courseList}">
							<div class="col-md-6 col-lg-3 col-xs-12">
								<div class="services-item wow fadeInRight" data-wow-delay="0.3s">
									<a href="<%=request.getContextPath()%>/course/course.do?action=showCourseMainPage&courseno=${courseVO.courseno}">
										<div class="icon">
											<img src="<%=request.getContextPath()%>/course/CoursePictureReaderFromDB?courseno=${courseVO.courseno}" style="max-width: 100%; height: 150px;" class="pic">
										</div>
										<div class="services-content">
											&nbsp;&nbsp;&nbsp;
											<div class="rateit" data-rateit-value="${courseVO.csscore / courseVO.csscoretimes }" data-rateit-ispreset="true" data-rateit-readonly="true">
											</div>
											<br>&nbsp;&nbsp;&nbsp;${courseVO.csscoretimes}則評價
											<h3 style="line-height:40px;">${courseVO.coursename}</h3>
										</div>
									</a>
									<% 
										// 將課程總時數換算為分鐘
                    					Integer ttltimeInMin = ((CourseVO)pageContext.getAttribute("courseVO")).getTtltime()/60;
                    				%>                            
                    				<p>課程總長 <%= ttltimeInMin %> 分鐘</p>
									<h5>NT$${courseVO.courseprice}</h5>
								</div>
							</div>
						</c:forEach>
					</div>
				</div> <!-- end of container -->
			</section>

		</div><!-- end of container -->
	</div>

	<jsp:include page="/index/front-index/footer.jsp" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/jquery.rateit.min.js"></script>
</body>

</html>