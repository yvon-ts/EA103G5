<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.course.model.*"%>
<%@ page import="com.video.model.*"%>

<%
	CourseVO courseVO = (CourseVO) request.getAttribute("courseVO");
	
	// 處理課程評分精度以及分母為零的問題
	Integer csscore = courseVO.getCsscore();
	Integer csscoretimes = courseVO.getCsscoretimes();
	NumberFormat formatter = new DecimalFormat("#.#");
	String courseScore = formatter.format(0);
	if (csscoretimes > 0) {
		courseScore = formatter.format(Double.valueOf(csscore) / Double.valueOf(csscoretimes));
	}
%>

<!DOCTYPE html>
<html lang="zh-Hant">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<!-- ========== CSS Area ========== -->
	<!-- Bootstrap 的 CSS -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- Font Awesome CSS -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
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
							<jsp:useBean id="courseTypeSvc" scope="page" class="com.course_type.model.CourseTypeService" />
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
								<video id="coursePlayer" width="100%" height="auto" controls preload="metadata">
									<source src="<%=request.getContextPath()%>/front-end/course/Nyan_Cat.mp4" type="video/mp4">
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
								<!-- 宣告複合查詢使用的 map -->
								<%
									String courseno = courseVO.getCourseno();
									Map<String, String[]> map = new TreeMap<String, String[]>();
									map.put("courseno", new String[]{courseno});
									request.setAttribute("map", map);
								%>
								<!-- 讀出課程現有的單元清單 -->
								<jsp:useBean id="videoSvc" scope="page" class="com.video.model.VideoService" />
								<c:forEach var="videoVO" items="${videoSvc.getAll(map)}">
									<a
										class="list-group-item list-group-item-action list-group-item-primary"
										href="<%=request.getContextPath()%>/video/VideoReaderFromDB?videono=${videoVO.videono}"  chaptername="${videoVO.chaptername}">
										<div class="d-flex">
										<div class="w-75">
											<h3 style="color:#0099CC;">單元 ${videoVO.chapterno}</h3>
										</div>
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
<!-- NG -->
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
						<div class="col-md col-3 courseInfo ">
							<!-- 須要查詢該使用者是否已加入收藏 -->
							<i id="track"></i>
						</div>
						<div class="col-md col-3 courseInfo ">
							<!-- 須要查詢該使用者是否已購買 -->
							<i id="addShopCart" class="fas fa-cart-plus"></i>
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
							<a class="nav-link" data-toggle="pill" href="#downloadfile">教材下載</a>
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
					<div id="downloadfile" class="tab-pane fade">
						<h3>教材下載</h3>
						<jsp:include page="/front-end/course/subpage_downloadfile.html" />
					</div>
					<div id="coursescope" class="tab-pane fade">
						<h3>課程評價</h3>
						<jsp:include page="/front-end/course_assess/listAllAjax.jsp" flush="true">
						<jsp:param name="courseno" value="${courseVO.courseno}"/>
						</jsp:include>
						
					</div>
					<div id="post" class="tab-pane fade">
						<h3>問題討論</h3>
						<jsp:include page="/front-end/posts/posts.jsp" />
					</div>
				</div>

			</div>

		</section>
	</main>

	<!-- ========== JavaScript Area ========== -->
	<!-- Bootstrap 的 JS (jquery 改為完整版)-->
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<!-- 計算 video durarion 相關的 JS -->
	<script src="<%=request.getContextPath()%>/front-end/video/js/videoDurationCaculation.js"></script>

	<script>
		$(function () {
			// 顯示各單元影片時間
			$("#courseTtlTime").text(convertSecToHrFormatter(${courseVO.ttltime}));
			showInitOriginalVideoLen();

			// 註冊影片清單點擊事件
			$("#videolist .list-group-item").click(function (e) {
				e.preventDefault();
				$("#videoContainer video").attr("autoplay", true);
				$("#videoContainer video source").attr("src", $(this).attr("href"));
				let videoPlayer = document.getElementById("coursePlayer");
				videoPlayer.load();
				$("#nowPlaying").text(" → " + $(this).attr('chaptername'));
			});

			// 追蹤清單
			trackingOrNot(false);
		});

		function trackingOrNot(isTracking) {
			// 追蹤清單初始化
			if (isTracking) {
				// 實心愛心
				$("#track").addClass("fas fa-heart");
			} else {
				// 空心愛心
				$("#track").addClass("far fa-heart");
			}

			// 註冊切換追蹤清單事件
			$("#track").click(function () {
				$(this).toggleClass("fas fa-heart");
				$(this).toggleClass("far fa-heart");

				if ($(this).hasClass("fas fa-heart")) {
					console.log("**增加追蹤清單");
				} else if ($(this).hasClass("far fa-heart")) {
					console.log("**刪除追蹤清單");
				}
			});
		}
	</script>

	<!-- include 前台頁面的 footer -->
	<jsp:include page="/index/front-index/footer.jsp" />
</body>

</html>