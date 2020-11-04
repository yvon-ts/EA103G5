<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.course.model.*"%>
<%@ page import="com.video.model.*"%>
<%@ page import="com.members.model.*"%>
<%@ page import="com.teacher.model.*"%>
<%@ page import="com.order_master.model.*"%>
<%@ page import="com.order_detail.model.*"%>

<jsp:useBean id="courseTypeSvc" scope="page" class="com.course_type.model.CourseTypeService" />
<jsp:useBean id="videoSvc" scope="page" class="com.video.model.VideoService" />
<jsp:useBean id="orderDetailSvc" scope="page" class="com.order_detail.model.OrderDetailService" />
<jsp:useBean id="QuestionBankSvc" scope="page" class="com.question_bank.model.QuestionBankService" />
<%
	// 取得課程物件
	CourseVO courseVO = (CourseVO) request.getAttribute("courseVO");
	if(courseVO == null){
		courseVO = new CourseService().getOneCourse(request.getParameter("courseno"));
		request.setAttribute("courseVO",courseVO);
	}
	// ==========================================================================================
	// 由此 2 個 Boolean 判斷登入者是否可以使用課程
	Boolean isMyCourse = false;
	Boolean alreadyBuyIt = false;
	// 判斷登入者是否已買過此課程
	MembersVO loginMembersVO = (MembersVO) session.getAttribute("loginMembersVO");
	if (loginMembersVO != null) {
		alreadyBuyIt = orderDetailSvc.boughtNot(courseVO.getCourseno(), loginMembersVO.getMemno());
		System.out.println("=== 我買了這堂課? === " + alreadyBuyIt);
	}
	// 判斷是不是登入者自己開設的的課程
	TeacherVO loginTeacherVO = (TeacherVO) session.getAttribute("loginTeacherVO");
	if (loginTeacherVO != null) {
		isMyCourse = courseVO.getTchrno().equals(loginTeacherVO.getTchrno());
		System.out.println("=== 這是我開的課? === " + isMyCourse);
	}
	// 結合上述 2 條件，檢查登入者使用課程之權限
	Boolean canViewThisCourse = isMyCourse || alreadyBuyIt; 
	// ==========================================================================================
	// 處理課程評分精度以及分母為零的問題
	Integer csscore = courseVO.getCsscore();
	Integer csscoretimes = courseVO.getCsscoretimes();
	NumberFormat formatter = new DecimalFormat("#.#");
	String courseScore = formatter.format(0);
	if (csscoretimes > 0) {
		courseScore = formatter.format(Double.valueOf(csscore) / Double.valueOf(csscoretimes));
	}
	// ==========================================================================================
			
			
%>

<!DOCTYPE html>
<html lang="zh-Hant">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<!-- ========== CSS Area ========== -->
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
	<!-- Font Awesome CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/library/font-awesome/5.15.1/css/all.min.css">
	<!-- 自己的 CSS 一定放在最下面 -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/course/css/mainCoursePage.css">
	<!-- ========== CSS Area ========== -->

	<title>${courseVO.coursename} - Xducation 陪你成長的學習好夥伴</title>
</head>

<body>
	<!-- include 前台頁面的 header -->
	<jsp:include page="/index/front-index/header.jsp" />

	<main>
		<section id="videoView">
			<div class="jumbotron">
				<div class="container">
					<div class="row">
						<div class="col">
							<!-- 麵包屑 -->
							<nav aria-label="breadcrumb">
								<ol class="breadcrumb">
									<li class="breadcrumb-item">
										<a href="<%=request.getContextPath()%>/front-end/course/listAllCourseForUser.jsp">所有課程</a>
									</li>
									<li class="breadcrumb-item">
										<a href="#">${courseTypeSvc.getOneCourseType(courseVO.cstypeno).cstypename}</a>
									</li>
									<li class="breadcrumb-item active" aria-current="page">
										${courseVO.coursename}
									</li>
								</ol>
							</nav>
						</div>
					</div>

					<div class="row">
						<div class="col">
							<!-- 課程名稱 -->
							<h1 style="color:#0099CC;">${courseVO.coursename}<span id="nowPlaying"></span></h1>
						</div>
					</div>

					<div class="row">
						<div class="col-lg-8 align-self-center">
							<!-- 影片播放 -->
							<div id="videoContainer">
								<video id="coursePlayer" width="100%" height="auto" controls preload="metadata"
								poster="<%=request.getContextPath()%>/front-end/course/image/videoPoster.png">
									<source src="#" type="video/mp4">
									您的瀏覽器未支援此播放系統，建議使用 Chrome 瀏覽器瀏覽網頁
								</video>
							</div>
						</div>
						<div class="col-lg-4">
							<!-- 單元選擇欄位 -->
							<div>
								<h2 style="color:#0099CC;">課程單元清單</h2>
							</div>
							<div class="list-group" id="videolist">
							
								<!-- Button trigger modal -->

								<!-- 測驗連結 -->
								<% if (!canViewThisCourse){ %>
								<a class="list-group-item list-group-item-action list-group-item-primary locked"
									href="#">
									<h3 style="color:black;"><i class="fas fa-lock"></i> 自我評量 <i class="far fa-arrow-alt-circle-right"></i></h3>
								</a>
								<% } else { %>
 								<!--測驗 modal -->
								<button type="button" class="list-group-item list-group-item-action list-group-item-primary" data-toggle="modal" data-target="#exampleModalCenter"><h3 style="color:#b07e2d;"><i class="fas fa-pen"></i> 自我評量 <i class="far fa-arrow-alt-circle-right"></i></h3></button>
								
								<% } %>

								<!-- 宣告複合查詢使用的 map -->
								<%
									String courseno = courseVO.getCourseno();
									Map<String, String[]> map = new TreeMap<String, String[]>();
									map.put("courseno", new String[]{courseno});
									request.setAttribute("map", map);
								%>

								<!-- 讀出課程現有的單元清單 -->
								<c:forEach var="videoVO" items="${videoSvc.getAll(map)}">
									<%
										VideoVO videoVO = (VideoVO)(pageContext.getAttribute("videoVO"));
										Integer chapterno = videoVO.getChapterno();
										if (!canViewThisCourse && chapterno > 2) {
									%>
									<a class="list-group-item list-group-item-action list-group-item-primary locked">
										<div class="d-flex">
											<div class="w-75">
												<h3 style="color:black;"><i class="fas fa-lock"></i> 單元 ${videoVO.chapterno}</h3>
											</div>
									<% } else { %>
									<a class="list-group-item list-group-item-action list-group-item-primary allowToWatch"
										href="<%=request.getContextPath()%>/video/VideoReaderFromDB?videono=${videoVO.videono}" chaptername="${videoVO.chaptername}">
										<div class="d-flex">
											<div class="w-75">
												<h3 style="color:#0099CC;"><i class="fas fa-play"></i> 單元 ${videoVO.chapterno}</h3>
											</div>
									<%	} %>
											<div class="w-25">
												<p class="showVideoLen text-right"></p>
												<input type="hidden" name="chapterlen" value=${videoVO.chapterlen } min=0 step=1 readonly>
											</div>
										</div>
										<div>
											<h5>${videoVO.chaptername}</h5>
										</div>
									</a>
								</c:forEach>
							</div>
						</div>
					</div>

					<div class="row align-items-center text-center courseInfoContainer">
						<div class="col-md-2 col-4 courseInfo">
							<!-- 須要查詢訂單中的購買人次 -->
							<i class="fas fa-users"></i>
							<!-- NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG  NG -->
							<p><span>ToBeChange</span> 位同學</p>
						</div>
						<div class="col-md-2 col-4 courseInfo">
							<!-- 須要video中的課程的時間加總 -->
							<i class="fas fa-clock"></i>
							<p>總長 <span id="courseTtlTime"></span></p>
						</div>
						<div class="col-md-2 col-4 courseInfo">
							<!-- 須要查詢評分 -->
							<i class="fas fa-star"><%= courseScore %></i>
							<p><span>${courseVO.csscoretimes}</span> 則評價</p>
						</div>
						<div class="col-md-3 col-6 courseInfo">
							<!-- 須要查詢原本單價、類別、優惠活動 -->
							<i class="fas fa-dollar-sign">
								<sapn id="courseprice">${courseVO.courseprice}</sapn>
							</i>
						</div>

						<!-- 須要查詢該使用者是否已加入收藏 -->
						<div class="col-md col-3 courseInfo">
							<c:forEach var="TrackingListVO" items="${TrackingListSvc.getOneByMemno(membersVO.memno)}">
								<c:choose>
									<c:when test="${ courseVO.courseno eq TrackingListVO.courseno}">
										<label class="bookmark"><i class="fa fa-heart" aria-hidden="true">
												<input type="hidden" id="courseno" value="${courseVO.courseno}" />
											</i></label>
										<c:set var="flag" value="true" />
									</c:when>
								</c:choose>
							</c:forEach>

							<c:if test="${empty flag}">
								<label class="bookmark"><i class="fa fa-heart-o" aria-hidden="true">
										<input type="hidden" id="courseno" value="${courseVO.courseno}" />
									</i></label>
							</c:if>
							<c:remove var="flag" />
						</div>

						<!-- 須要查詢該使用者是否已購買 -->
						<div class="col-md col-3 courseInfo">
							<!-- 是否購買 -->
							<% if (!canViewThisCourse){ %>
							<!-- 未購買，所以要可以買 -->
							<label class="shoppingcart">
								<i class="fa fa-shopping-cart" aria-hidden="true">
									<input type="hidden" name="courseno" id="courseno" value="${courseVO.courseno}" />
									<%-- <input type ="hidden" name="courseprice" id="courseprice" value ="${courseVO.courseprice}"/> --%>
									<%-- <input type ="hidden" name="courseinfo"  id="courseinfo"  value ="${courseVO.courseinfo}"/> --%>
								</i>
							</label>
							<% } else { %>
							<!-- 已購買，無法點選 -->
							<i class="fas fa-user-check"></i>
							<% } %>

						</div>
					</div>
				</div>
			</div>
		</section>

		<section>
			<div class="container">

				<nav>
					<ul class="nav nav-pills nav-justified" id="nav-subpage">
						<li class="nav-item">
							<a class="nav-link active" data-toggle="pill" href="#courseinfo">課程簡介</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="pill" href="#coursescope">課程評價</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="pill" href="#post">問題討論</a>
						</li>
					</ul>
				</nav>

				<div class="tab-content" id="subpage">
					<div id="courseinfo" class="tab-pane fade show active">
						<div>${courseVO.courseinfo}</div>
					</div>
					<div id="coursescope" class="tab-pane fade">
						<jsp:include page="/front-end/course_assess/listAllAjax.jsp" flush="true">
							<jsp:param name="courseno" value="${courseVO.courseno}" />
						</jsp:include>
					</div>
					<div id="post" class="tab-pane fade">
<%-- 						<jsp:include page="/front-end/posts/postsAjax.jsp"> --%>
<%-- 							<jsp:param name="courseno" value="${courseVO.courseno}"/> --%>
<%-- 						</jsp:include> --%>
					</div>
				</div>
			</div>
		</section>
	</main>
	


<!-- 測驗單元Modal -->
<form action='<%= request.getContextPath()%>/question/questionTest.do' method='post' id="myForm">
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">請選擇題型</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      			<div class="modal-body">
						
						
        				<div class="form-group">
    						<select class="form-control" id="exampleFormControlSelect1" name ="level">
      				 			<option value="-1">請選擇考題難易度</option>
            		 			<option value="simple">簡單</option>
            		 			<option value="medium">中等</option>
            		 			<option value="hard">困難</option>
			    			</select>
  						</div>
        			
        				<div class="form-group">
    						<select class="form-control" id="exampleFormControlSelect2" name ="unit">
      				 			<option value="-1">請選擇測驗單元</option>
            		 			<c:forEach var="videoVO" items="${videoSvc.getAll(map)}" varStatus="counter">
									<option value="${counter.count}">單元 ${videoVO.chapterno}</option>
								</c:forEach>
			    			</select>
  						</div>
				</div>
      			
      		<div class="modal-footer">
      			<input type='hidden' name='courseno' value="${courseVO.courseno}">
      			<input type="hidden" name="action" value="printPaper">
        		<button type="button" class="btn btn-info" id="turnin">進入測驗</button>
      		</div>
    </div>
  </div>
</div>
</form>
	<!-- ========== JavaScript Area ========== -->
	<!-- Bootstrap 的 JS (jquery 改為完整版)-->
	<script src="<%=request.getContextPath()%>/library/jquery/jquery-3.5.1.js"></script>
	<script src="<%=request.getContextPath()%>/library/bootstrap/4.5.3/js/bootstrap.bundle.min.js"></script>
	<!-- 計算 video durarion 相關的 JS -->
	<script src="<%=request.getContextPath()%>/front-end/video/js/videoDurationCaculation.js"></script>

	<script>
		$(function () {
			//送出測驗表單
			$('#turnin').click(function(){
				if($('#exampleFormControlSelect1').find('option:selected').val() === '-1'  || $('#exampleFormControlSelect2').find('option:selected').val() === '-1' ){
					swal('請選擇難易度及單元', '', 'error');
				}
				//判斷題庫是否有題目
				else if('${QuestionBankSvc.getAll(courseVO.courseno).size()}' < 20 ){
					swal('目前尚無測驗題目', '', 'warning');
				}else{
					$('#myForm').submit();
				}
			});
			
			
			// 顯示各單元影片時間
			var ttltime = ${courseVO.ttltime};
			$("#courseTtlTime").text(convertSecToHrFormatter(ttltime));
			showInitOriginalVideoLen();

			// 註冊影片清單點擊事件
			$("#videolist .allowToWatch").click(function (e) {
				e.preventDefault();
				$("#videoContainer video").attr("autoplay", true);
				$("#videoContainer video source").attr("src", $(this).attr("href"));
				let videoPlayer = document.getElementById("coursePlayer");
				videoPlayer.load();
				$("#nowPlaying").text(" → " + $(this).attr('chaptername'));
			});

			// 註冊影片清單點擊事件
			$("#videolist .locked").click(function (e) {
				e.preventDefault();
				swal('付費課程', '請先登入或購買課程', 'warning')
			});

			// 追蹤清單
				$('body').on('click' , '.bookmark',function(){
			
			
			if(`${loginMembersVO.memno}` == ''){
				swal({ 
					  title: '您尚未登入', 
					  text: '您將無法追蹤此課程！', 
					  type: 'warning',
					  showCancelButton: true, 
					  confirmButtonColor: '#3085d6',
					  cancelButtonColor: '#d33',
					  confirmButtonText: '會員登入', 
					}).then(function(){
						this.location.href = '<%=request.getContextPath()%>/front-end/members/signIn.jsp';
					}).catch(swal.noop);
			}
			else{
			
			var updateTrackingList;
			
			if ($(this).children().attr("class") === "fa fa-heart-o"){
				updateTrackingList = "insert";
				$(this).children().attr("class","fa fa-heart");
			}
			else{
				updateTrackingList = "delete";
				$(this).children().attr("class","fa fa-heart-o");
			}
			
// 			console.log(updateTrackingList + "," + $(this).find('#courseno').val() );
			
			$.ajax({
				url	:"<%=request.getContextPath()%>/tracking_list/tracking_list.do", 
				data:{
					courseno : $(this).find('#courseno').val(),
					action   : updateTrackingList ,
				},
				success: function(data){
					console.log('操作成功--->searchPage');
				}
			});
			
			}
		});

			// 購物車
			$('body').on('click', '.shoppingcart', function () {
				$.ajax({
					url: "<%=request.getContextPath()%>/Shop/Shopping_Cart.do",
					data: {
						courseno: $(this).find('#courseno').val(),
						// 						memno    : $("#memno").val(),
						action: "shoppingCart"
					},
					success: function (data) {
						if (data !== 'false') {
							console.log('加入購物車');
							swal('你已將課程加入購物車！！', '', 'success');
						}
					}
				});
			});
		});

		// 		function trackingOrNot(isTracking) {
		// 			// 追蹤清單初始化
		// 			if (isTracking) {
		// 				// 實心愛心
		// 				$("#track").addClass("fas fa-heart");
		// 			} else {
		// 				// 空心愛心
		// 				$("#track").addClass("far fa-heart");
		// 			}

		// 			// 註冊切換追蹤清單事件
		// 			$("#track").click(function () {
		// 				$(this).toggleClass("fas fa-heart");
		// 				$(this).toggleClass("far fa-heart");

		// 				if ($(this).hasClass("fas fa-heart")) {
		// 					console.log("**增加追蹤清單");
		// 				} else if ($(this).hasClass("far fa-heart")) {
		// 					console.log("**刪除追蹤清單");
		// 				}
		// 			});
		// 		}
	</script>

	<!-- include 前台頁面的 footer -->
	<jsp:include page="/index/front-index/footer.jsp" />
</body>

</html>