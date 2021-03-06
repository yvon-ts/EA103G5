<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Xducation管理後臺</title>
    <meta charset="utf-8">
    <!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Main CSS-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/back-end/index/css/main.css">
    <!-- Font-icon css-->
    <link rel="icon" type="image/png" href="<%=request.getContextPath()%>/back-end/login/logincss/images/icons/logo.svg"/>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css	/font-awesome.min.css">	
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js" type="text/javascript"></script>
    <style>
       input[type="submit"].test{
			width: 80px;
			height: 30px;
			color: black;
			border: 0px solid;
			border-radius: 30px;
			text-align: center;
        }
    </style>
</head>

<body class="app sidebar-mini">
    <!-- Navbar-->
    <header class="app-header"><a class="app-header__logo" href="<%=request.getContextPath() %>/back-end/employee/loginsuccess.jsp">
            <img src="<%=request.getContextPath() %>/back-end/index/images/logo.svg" alt="" width="50px" height="50px">
            Xducation
        </a>
        <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
        <!-- Navbar Right Menu-->
        <ul class="app-nav">     
            <!-- User Menu-->
            <li class="dropdown"><a class="app-nav__item" href="#" data-toggle="dropdown" aria-label="Open Profile Menu"><i class="fa fa-user fa-lg"></i></a>
                <ul class="dropdown-menu settings-menu dropdown-menu-right">
                    <a class="dropdown-item" href="#">
                    	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/employee/employee.do">
                    		<li><i class="fa fa-user fa-lg"></i>
                    		<input type="submit" value="個人資料" class="test">
			     			<input type="hidden" name="empno"  value="${empno}">
			     			<input type="hidden" name="action"	value=getone_show></li>									
			     		</FORM>
			     	</a>
                    <li><a class="dropdown-item" href="<%=request.getContextPath() %>/back-end/login/login.jsp"><i class="fa fa-sign-out fa-lg"></i> 登出</a></li>
                </ul>
            </li>
        </ul>
    </header>
    <!-- Sidebar menu-->
    <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
    <aside class="app-sidebar">
        <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="${pageContext.request.contextPath}/ShowEmpPic?empno=${empno}" alt="User Image" width="80px" height="80px">
            <div>
            	 <p class="app-sidebar__user-name"> </p>
                <p class="app-sidebar__user-designation">${empname}</p>
            </div>
        </div>
        <ul class="app-menu">
            <li><a class="app-menu__item active" href="<%=request.getContextPath() %>/back-end/employee/loginsuccess.jsp"><i class="fa fa-home" aria-hidden="true"> </i><span class="app-menu__label"> 首頁 </span></a></li>
            <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="fa fa-user" aria-hidden="true"></i>
                    <span class="app-menu__label"> 員工管理 </span><i class="treeview-indicator fa fa-angle-right"></i></a>
                <ul class="treeview-menu">
                    <li><a class="treeview-item" href="<%=request.getContextPath() %>/back-end/employee/empall/newallemp.jsp"><i class="icon fa fa-circle-o"></i> 員工資料</a></li>
                </ul>
            </li>
            <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="fa fa-users" aria-hidden="true"></i>
                    <span class="app-menu__label"> 老師管理 </span><i class="treeview-indicator fa fa-angle-right"></i></a>
                <ul class="treeview-menu">
                    <li><a class="treeview-item" href="<%=request.getContextPath() %>/back-end/teacher/listAllTeachers.jsp"><i class="icon fa fa-circle-o"></i> 老師資料</a></li>
                </ul>
            </li>
            <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="fa fa-user-plus" aria-hidden="true"></i>
                    <span class="app-menu__label"> 實體講座 </span><i class="treeview-indicator fa fa-angle-right"></i></a>
                <ul class="treeview-menu">
                    <li><a class="treeview-item" href="<%=request.getContextPath()%>/back-end/classroom/listAllClassroom.jsp"><i class="icon fa fa-circle-o"></i> 教室管理</a></li>
                    <li><a class="treeview-item" href="<%=request.getContextPath()%>/back-end/lecture/lectureIndex.jsp"><i class="icon fa fa-circle-o"></i> 講座管理</a></li>
                    <li><a class="treeview-item" href="<%=request.getContextPath()%>/back-end/lecorder/listAllLodr.jsp" rel="noopener"><i class="icon fa fa-circle-o"></i>報名管理 </a></li>
                    
                </ul>
            </li>
            <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="fa fa-cart-plus" aria-hidden="true"></i>
                    <span class="app-menu__label"> 課程商城 </span><i class="treeview-indicator fa fa-angle-right"></i></a>
                <ul class="treeview-menu">
                    <li><a class="treeview-item" href="<%=request.getContextPath()%>/back-end/Order_Detail/listAllOrderDetail.jsp"><i class="icon fa fa-circle-o"></i> 訂單管理</a></li>
                    <li><a class="treeview-item" href="<%=request.getContextPath()%>/back-end/course/editCourseStatus.jsp" rel="noopener"><i class="icon fa fa-circle-o"></i>課程管理 </a></li>
                </ul>
            </li>
        </ul>
    </aside>
    <!-- 內容放在下面 -->
  
    <!-- Essential javascripts for application to work-->
    <script src="<%=request.getContextPath() %>/back-end/index/js/jquery-3.3.1.min.js"></script>
    <script src="<%=request.getContextPath() %>/back-end/index/js/popper.min.js"></script>
    <script src="<%=request.getContextPath() %>/back-end/index/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath() %>/back-end/index/js/main.js"></script>
    <script>
    	<c:if test="${not empty error}">
			swal({
	  			   title: "${error}",
	  			   type: "error",
				});	
		</c:if>
		<%request.getSession().removeAttribute("error");%>
   </script>
      
</body>

</html>