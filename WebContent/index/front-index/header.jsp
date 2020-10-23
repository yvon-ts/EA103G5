<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Xducation - 陪你成長的學習好夥伴</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/bootstrap.min.css">
    <!-- Icon -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/fonts/line-icons.css">
    <!-- Animate -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/animate.css">
    <!-- Main Style -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/main.css">
    <!-- Responsive Style -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/responsive.css">
    
    <link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
    <style>
    </style>
</head>

<body>
    <header id="header-wrap">
        <!-- Navbar Start -->
        <nav class="navbar navbar-expand-md bg-inverse fixed-top scrolling-navbar">
            <div class="container">
                <!-- 左上角LOGO Start -->
                <a href="<%=request.getContextPath()%>/index/front-index/index.jsp" class="navbar-brand"><img src="<%=request.getContextPath()%>/index/front-index/assets/img/logo.svg" alt="">
                    <div id="logo">Xducation</div>
                </a>
                <!-- 左上角LOGO End -->
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="lni-menu"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <ul class="navbar-nav mr-auto w-100 justify-content-end clearfix">
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/front-end/tracking_list/listTrackingListForMember.jsp">
                            購物車&nbsp;<i class="fa fa-shopping-cart" aria-hidden="true"></i>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                精選課程&nbsp;<i class="lni-leaf"></i>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                名人講座&nbsp;<i class="lni-bulb"></i>
                            </a>
                        </li>
                        <!-- if 未登入 Start-->
                        <!--<li class="nav-item">
                            <a class="nav-link" href="#" style="color: #0099CC">
                                我要登入&nbsp;<i class="lni-home"></i>
                            </a>
                        </li>-->
                        <!--未登入 End-->
                        <!-- if 已登入 Start-->
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                會員專區&nbsp;<i class="lni-emoji-smile"></i>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="http://www.google.com" style="color: #0099CC">
                                useruseruser&nbsp;登出&nbsp;<i class="lni-exit-up"></i>
                            </a>
                        </li>
                        <!--已登入 End-->
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
    </header>

    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/jquery-min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/popper.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/owl.carousel.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/wow.js"></script>
<!--     	沒有拿掉，首頁連結會失效 -->
<%--     <script src="<%=request.getContextPath()%>/index/front-index/assets/js/jquery.nav.js"></script> --%>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/scrolling-nav.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/jquery.easing.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/jquery.counterup.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/waypoints.min.js"></script>
    <script src="<%=request.getContextPath()%>/index/front-index/assets/js/main.js"></script>
</body>

</html>