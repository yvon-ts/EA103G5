<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.members.model.*"%>

<!DOCTYPE html>
<html lang="en" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xducation後台系統</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/members/css/back_Index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" charset="utf-8"></script>
</head>

<body>
    <input type="checkbox" id="check">
    <!--header area start-->
    <header>
        <label for="check">
            <i class="fas fa-bars" id="sidebar_btn"></i>
        </label>
        <div class="left_area">
            <img src="<%=request.getContextPath()%>/back-end/members/css/logo.svg" alt="" width="50px" height="50px">
            <h3>Xducation <span>管理系統</span></h3>
        </div>
        <div class="right_area">
            <a href="#" class="logout_btn">Logout</a>
            <!-- </div> -->
    </header>
    <!--header area end-->
    <!--mobile navigation bar start-->
    <div class="mobile_nav">
        <div class="nav_bar">
            <img src="<%=request.getContextPath()%>/back-end/members/css/cat.jpg" class="mobile_profile_image" alt="">
            <i class="fa fa-bars nav_btn"></i>
        </div>
        <div class="mobile_nav_items">
            <a href="#"><i class="fas fa-desktop"></i><span>Dashboard</span></a>
            <a href="#"><i class="fas fa-cogs"></i><span>Components</span></a>
            <a href="#"><i class="fas fa-table"></i><span>Tables</span></a>
            <a href="#"><i class="fas fa-th"></i><span>Forms</span></a>
            <a href="#"><i class="fas fa-info-circle"></i><span>About</span></a>
            <a href="#"><i class="fas fa-sliders-h"></i><span>Settings</span></a>
        </div>
    </div>
    <!--mobile navigation bar end-->
    <!--sidebar start-->
    <div class="sidebar">
        <div class="profile_info">
            <img src="<%=request.getContextPath()%>/back-end/members/css/cat.jpg" class="profile_image" alt="">
            <h4>Jason</h4>
        </div>
        <!-- <li class="item" id="emp">
            <a href="#emp" class="menu-btu">
                <i class="fas fa-user-circle"></i><span>員工管理 </span><i class="fas fa-chevron-down drop-down"></i></a>
            <div class="sub-menu">
                <a href="#"><i class="fas fa-image"></i><span>員工資料</span></a>
                <a href="#"><i class="fas fa-address-card"></i><span>員工權限</span></a>
            </div>
        </li> -->
        <li class="item" id="member">
            <a href="#member" class="menu-btn">
                <i class="fas fa-user-circle"></i><span>員工管理 <i class="fas fa-chevron-down drop-down"></i></span>
            </a>
            <div class="sub-menu">
                <a href="#"><i class="fas fa-image"></i><span>員工資料</span></a>
                <a href="#"><i class="fas fa-address-card"></i><span>員工權限</span></a>
            </div>
        </li>
        <li class="item" id="member">
            <a href="" class="menu-btn">
                <i class="fas fa-desktop"></i><span>會員&老師管理 <i class="fas fa-chevron-down drop-down"></i></span>
            </a>
            <div class="sub-menu">
                <a href="<%=request.getContextPath()%>/back-end/members/select_members.jsp"><i class="fas fa-image"></i><span>會員資料</span></a>
                 <a href="<%=request.getContextPath()%>/back-end/teacher/select_teacher.jsp"><i class="fas fa-image"></i><span>老師資料</span></a>
                <a href="#"><i class="fas fa-address-card"></i><span>會員課程</span></a>
            </div>
        </li>
        <li class="item" id="messages">
            <a href="#messages" class="menu-btn">
                <i class="fas fa-envelope"></i><span>實體講座 <i class="fas fa-chevron-down drop-down"></i></span>
            </a>
            <div class="sub-menu">
                <a href="#"><i class="fas fa-envelope"></i><span>教室管理</span></a>
                <a href="#"><i class="fas fa-envelope-square"></i><span>講座管理</span></a>
                <a href="#"><i class="fas fa-exclamation-circle"></i><span>報名管理</span></a>
            </div>
        </li>
        <li class="item" id="settings">
            <a href="#settings" class="menu-btn">
                <i class="fas fa-cog"></i><span>課程商城 <i class="fas fa-chevron-down drop-down"></i></span>
            </a>
            <div class="sub-menu">
                <a href="#"><i class="fas fa-lock"></i><span>訂單管理</span></a>
                <a href="#"><i class="fas fa-language"></i><span>優惠管理</span></a>
                <a href="#"><i class="fas fa-language"></i><span>課程管理</span></a>
            </div>
        </li>
        <li class="item">
            <a href="#" class="menu-btn">
                <i class="fas fa-info-circle"></i><span>檢舉管理</span>
            </a>
        </li>
        <!-- <a href="#"><i class="fas fa-desktop"></i><span>Dashboard</span></a> -->
        <!-- <a href="#"><i class="fas fa-cogs"></i><span>Components</span></a>
        <a href="#"><i class="fas fa-table"></i><span>Tables</span></a>
        <a href="#"><i class="fas fa-th"></i><span>Forms</span></a>
        <a href="#"><i class="fas fa-info-circle"></i><span>About</span></a>
        <a href="#"><i class="fas fa-sliders-h"></i><span>Settings</span></a> -->
    </div>
    <!--sidebar end-->
    <div class="content">
        <div class="card">
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</p>
        </div>
        <div class="card">
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</p>
        </div>
        <div class="card">
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</p>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function() {

            $('.nav_btn').click(function() {
                $('.mobile_nav_items').toggleClass('active');
            });

            $('.menu-btn').click(function(e) {
                e.preventDefault();
                $(this).next().slideToggle();
            });


        });
    </script>
</body>

</html>