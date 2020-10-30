<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page
	import="com.course.model.*,com.course_type.model.*,com.members.model.*,com.tracking_list.model.*"%>
<%@ page import="com.teacher.model.*"%>

<%	
	int i = 0;
	MembersVO membersVO = (MembersVO) session.getAttribute("membersVO");
	
	TeacherService teacherSvc = new TeacherService();
	TeacherVO teacherVO = teacherSvc.getStatus(membersVO.getMemno());
	
// 	${teacherSvc.getOneTeacher(teacherSvc.getStatus(membersVO.memno).tchrno).tchrintro}
			
	String tchrno = teacherVO.getTchrno();
	Map<String, String[]> map = new TreeMap<String, String[]>();
	map.put("tchrno", new String[]{tchrno});
	request.setAttribute("map", map);
		
	List<CourseVO> list = null;	
	// List<CourseVO> list = (List<CourseVO>) request.getAttribute("list");
	if (list == null) {
		CourseService cSvc = new CourseService();
		list = cSvc.getAll(map);
	}

	pageContext.setAttribute("Courselist", list);

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
	<!-- <link rel="stylesheet" -->
	<!-- 	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/library/font-awesome/5.15.1/css/all.min.css">
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

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
	<jsp:useBean id="courseTypeSvc" scope="page"
		class="com.course_type.model.CourseTypeService" />
	<jsp:useBean id="TrackingListSvc" scope="page"
		class="com.tracking_list.model.TrackingListService" />


	<!-- include 前台頁面的 header -->
	<jsp:include page="/index/front-index/header.jsp" />

	<div id="hero-area" style="background-image: none">
		<div class="container">
			<h1>我開設的課程</h1>
			
			<section id="services" class="section-padding">
				<div class="container">

					<!-- Services item1 -->
					<div class="row seacharea">
						<c:forEach var="courseVO" items="${Courselist}">
							<div class="col-md-6 col-lg-3 col-xs-12">
								<div class="services-item wow fadeInRight" data-wow-delay="0.3s">
									<a href="<%=request.getContextPath()%>/course/course.do?action=getOneCourseForUpdate&courseno=${courseVO.courseno}">
										<div class="icon">
											<img src="<%=request.getContextPath()%>/course/CoursePictureReaderFromDB?courseno=${courseVO.courseno}" style="max-width: 100%; height: 150px;" class="pic">
										</div>
										<div class="services-content">
											&nbsp;&nbsp;&nbsp;
											<div class="rateit" data-rateit-value="${courseVO.csscore / courseVO.csscoretimes }" data-rateit-ispreset="true" data-rateit-readonly="true">
											</div>
											<br>&nbsp;&nbsp;&nbsp;${courseVO.csscoretimes}則評價
											<h3>${courseVO.coursename}</h3>
										</div>
									</a>
									<p>課程共${courseVO.ttltime}分鐘</p>
									<h5>NT$${courseVO.courseprice}</h5>
								</div>
							</div>
						</c:forEach>
					</div>
				</div> <!-- end of container -->
			</section>

		</div><!-- end of container -->
	</div>

	<script>
// 		$(document).ready(function () {
// 			$('#turnin').click(function () {
// 				$.ajax({
// 					type: "post",
<%-- 					url: "<%=request.getContextPath()%>/course/coursesearch.do", --%>
// 					data: {
// 						searchText: $('#searchText').val(),
// 						cstypeno: $('#cstypeno').val(),
// 						memno: $("#memno").val(),
// 						min: $('#min').val(),
// 						max: $('#max').val(),
// 						order: $('#order').val(),
// 						action: 'mutlipleSearch'
// 					},
// 					success: function (data) {

// 						var JSONarray = JSON.parse(data);
// 						$(".seacharea").empty();

// 						var str = "";
// 						for (let i = 0; i < JSONarray.length; i++) {

<%-- 							var courseimgno = "<%=request.getContextPath()%>/course/coursephoto.do?action=searchPhoto&courseno=" + JSONarray[i].courseno; --%>
// 							// 						str +=  `<div class="col-md-6 col-lg-3 col-xs-12">
// 							// 		                    <div class="services-item wow fadeInRight" data-wow-delay="0.3s">
// 							// 		                        <div class="icon">
// 							// 		                            <img src=  "` +  courseimgno    + `"style="width:200px;height:150px">
// 							// 		                        </div>
// 							// 		                        <div class="services-content">`;

// 							// 顯鈞：替換成新版本讀圖測試2020/10/22
<%-- 							var pictureURL = "<%=request.getContextPath()%>/course/CoursePictureReaderFromDB?courseno=" + JSONarray[i].courseno; --%>


// 							str += `<div class="col-md-6 col-lg-3 col-xs-12">`;
// 							str += `<div class="services-item wow fadeInRight" data-wow-delay="0.3s">`;
// 							str += `<div class="icon">`
<%-- 							str += `<a href="<%=request.getContextPath()%>/course/course.do?action=showCourseMainPage&courseno=` + JSONarray[i].courseno + `">` --%>
// 							str += `<img src=  "` + pictureURL + `"style="width:200px;height:150px"></div>`;

// 							str += `<div class="services-content">`;
// 							str += `&nbsp;&nbsp;<div class="rateit" data-rateit-value="` + JSONarray[i].csscore / JSONarray[i].csscoretimes + `" data-rateit-ispreset="true" data-rateit-readonly="true"></div><br>`;


// 							str += `&nbsp;&nbsp;&nbsp;` + JSONarray[i].csscoretimes + `則評價`;
// 							str += `<h3>` + JSONarray[i].coursename + `</h3></a>`;
// 							str += `<p>課程共` + JSONarray[i].ttltime + `分鐘</p>`;
// 							<!-- < p > 同學累計9487人 < /p> -->
// 							str += `<label class="shoppingcart"><i class="fa fa-shopping-cart" aria-hidden="true"><input type ="hidden" name="courseno" 	 id="courseno"   value ="` + JSONarray[i].courseno + `"/></i>加入購物車</label>`;


// 							str += `<label class="bookmark"><i class="` + JSONarray[i].class + `" aria-hidden="true" style="color:red"><input type ="hidden"  id="courseno" value ="` + JSONarray[i].courseno + `"/></i>加入追蹤</label>`;
// 							str += `<h5>NT$` + JSONarray[i].courseprice + `</h5></div></div></div>`;

// 						}

// 						$(".seacharea").append(str);
// 						$("div.rateit, span.rateit").rateit()




// 					}
// 				});
// 			});

// 		});
	</script>

	<jsp:include page="/index/front-index/footer.jsp" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/jquery.rateit.min.js"></script>
</body>

</html>