<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.tracking_list.model.*,com.course.model.*,java.util.*"%>

<%

	List<CourseVO> shoppingList = (List<CourseVO>)request.getSession().getAttribute("shoppingList");
	
		
%>

<html>
<head>
	<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
	.title{
            height: 1px;
            margin: 0 auto 30px;
            position: relative;
            background-color: #0099CC;
	}
	.shoppingCartArea{
		text-align : center;
	}
	</style>


</head>
<body>
	<jsp:include page="/index/front-index/header.jsp" />
	<section id="services" class="section-padding" style="padding:90px 0">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title wow fadeInDown" data-wow-delay="0.3s"><i class="fa fa-shopping-cart" aria-hidden="true" style="font-size:25px"></i>購物車</h2>
                <div class="title wow fadeInDown" data-wow-delay="0.3s"></div>
                
                <c:if test="${empty shoppingList}">
                	<div class="shoppingCartArea">
                	<img class="fit-picture"
    							 src="<%=request.getContextPath()%>/index/front-index/assets/img/empty-box.svg"
     									alt="shoppingCart Empty"/>
     				<div>購物車空空的，來去逛逛吧!!!</div>	
     				
     				<button class="btn btn-common"  onclick="location.href='<%=request.getContextPath()%>/index/front-index/index.jsp'" style="margin-top:3%;">
                    		搜尋課程
                    </button>
               		 </div>
     				
                </c:if>
                
                
            </div>
         </div>
	</section>

	<section id="services" class="section-padding" style="padding:90px 0">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title wow fadeInDown" data-wow-delay="0.3s"><i class="fa fa-heart" aria-hidden="true" style="font-size:25px" ></i>追蹤清單</h2>
                <div class="title wow fadeInDown" data-wow-delay="0.3s"></div>
                
            </div>
         </div>
	</section>
	
	<jsp:include page="/index/front-index/footer.jsp" />
</body>




</html>