<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.lecture.model.*"%>
<%@ page import="com.speaker.model.*"%>

<!DOCTYPE html>

<%	LecService lecSvc = new LecService();
	List<LecVO> list = lecSvc.getList();
	pageContext.setAttribute("list", list);
	
	String startdate = "";
	String startmonth = "";
	String starttime = "";
	String lecinfo = "";
%>
<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/bootstrap.min.css"> --%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/index/front-index/assets/css/main.css">
<%@ include file="/index/front-index/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/lecAll.css">
<title>Xducation - 陪你成長的學習好夥伴</title>
<style>
	h1{
		margin-top: 150px;
		margin-left: 400px;
	}
	#searchbox{
		display: inline-block;
	}
	#searchbox input{
		padding: 8px;
    	border-radius: 10px;
    	margin-left: 60px;
	}
 	.chosen {
 	    color: #0099CC; 
 	    border-color: #0099CC; 
	    background-color: #fff; 
 	} 
 	.whichPage{
		border: 0;
		outline: none;
		color: #0099cc;
		font-weight: 600;
		font-size: 1.2em;
		font-family: monospace;
		border-radius: 50px;
		padding: 3px 10px;
	}
	.onPage{
		border: 0;
		outline: none;
		color: #fff;
		background-color: #0099cc;
	}
</style>
</head>

<body>
  <!-- Header Area wrapper Starts -->
    <header id="header-wrap">
       
        <!-- Hero Area Start -->
        <div id="hero-area" class="hero-area-bg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
                        <div class="contents">
                            <div class="about-wrapper wow fadeInLeft" data-wow-delay="0.3s">
                                <h2 class="head-title">Xducation 名人講座</h2>
                                <i class="lni-rocket"></i>&emsp;達人不藏私 x 面對面交流<br>
                                <i class="lni-rocket"></i>&emsp;來聽各行各業你最想知道的事<br>
                            </div>
                            <br>
                            <div class="about-wrapper wow fadeInLeft" data-wow-delay="0.4s">
                                <div id="search">
                                </div>
                                <div class="header-button">
                                    <a href="#lecture" class="btn btn-common">搜尋講座</a>
                                    <a href="<%=request.getContextPath()%>/front-end/lecture/listAllLec.jsp" class="btn btn-border">查看全部</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
                        <div class="about-wrapper wow fadeInRight" data-wow-delay="0.3s">
                            <div id="introimg">
                                <img class="img-fluid" src="<%=request.getContextPath() %>/index/front-index/assets/img/head/lecture.png" alt="">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
            <!-- Hero Area End -->
    </header>
    <!-- Header Area wrapper End -->

    <!-- Features Section Start -->
    <%@ include file="/back-end/pool/page1.file" %>
    <section id="features" class="section-padding">
        <div class="container">
            <div class="section-header text-center">
                <h2 id="lecture" class="section-title wow fadeInDown" data-wow-delay="0.3s"><i class="lni-rocket"></i> 名人講座</h2>
            </div>
            <div id="querybox" class="box-item" style="background-color: #b3e6ff; border-radius: 10px">
            	<div id="searchbox">
            		<input id="query" name="query" type="text" placeholder="&nbsp;&rArr;&nbsp;想找什麼呢？">
            	</div>
            	<div id="orderBy" style="display: inline-block">
            		<div class="btn" style="padding: 0;"><button id="btnPrice" class="filter btn btn-common priceAsc" style="margin: 0 10px;">依價格&nbsp;<i class="fa fa-sort"></i></button></div>
            		<div class="btn" style="padding: 0"><button id="btnTime" class="filter btn btn-common timeAsc" style="margin: 0 10px;">依時間&nbsp;<i class="fa fa-sort"></i></button></div>
            		<div class="btn" style="padding: 0"><button id="canBuy" class="filter btn btn-common" style="margin: 0 10px;">只顯示可購買項目</button></div>
            		<div class="btn" style="padding: 0"><button id="buyAll" class="filter btn btn-common" style="margin: 0 10px;">顯示全部</button></div>
            	</div>
            </div>
            <div id="row" class="row">
				<% int listindex = 0; %>
					<c:forEach var="lecVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
						<%		//時間設定
								LecVO lecVO = list.get(listindex + pageIndex);
								Timestamp lecstart = lecVO.getLecstart();
								SimpleDateFormat fmtdate = new SimpleDateFormat("dd");
								SimpleDateFormat fmtmonth = new SimpleDateFormat("MMM");
								SimpleDateFormat fmttime = new SimpleDateFormat("HH:mm");
								startdate = fmtdate.format(lecstart);
								startmonth = fmtmonth.format(lecstart);
								starttime = fmttime.format(lecstart);
								//講者姓名
								SpkrService spkrSvc = new SpkrService();
								SpkrVO spkrVO = spkrSvc.getOne(lecVO.getSpkrno());
								String spkrname = spkrVO.getSpkrname();
								//講座狀態
								int lecstatus = lecVO.getLecstatus();
								//講座資訊
								lecinfo = "講座資訊更新中";
									try{
										//CKeditor - Bytes to String
										byte[] b = lecVO.getLecinfo();
										if (b != null) {
											lecinfo = new String(b);
											//lecinfo = bString.substring(0, 23);
										} else {
											System.out.println("b is null");
										}
									} catch (Exception e){
										lecinfo = "講座資訊更新中";
										e.printStackTrace();
									}
						%>
					   <div class="col-lg-1 col-md-12 col-sm-12 col-xs-12 for-align"></div>
					   <div class="div col-lg-10 col-md-12 col-sm-12 col-xs-12 box-item wow fadeInLeft" data-wow-delay="0.3s">
					        <div class="daydiv">
					            <span class="date"><%=startdate%></span><br>
					            <span class="month"><%=startmonth%></span><br>
					            <span class="time"><%=starttime%></span><br>
					        </div>
					        <div class="pic">
					            <img src="<%=request.getContextPath()%>/lecture/picreader?lecno=${lecVO.lecno}">
					        </div>
					        <div class="lec-txt">
					        	<p class="title">${lecVO.lecname}</p><br>
					        	<p class="spkr">【<%=spkrname%>】</p>
					        	<p class="info"><%=lecinfo%></p>
					        	<p><span class="price">NT$${lecVO.lecprice}</span></p>
					        </div>
					        <div class="more">
					        	<form method="post" action="<%=request.getContextPath()%>/lecture/lecture.do">
					        	<% if (lecstatus == 1){%>
					        		<input type="submit" class="btn btn-common" value="我有興趣">
					        	<%} else if (lecstatus == 0) {%>
					        		<input type="submit" class="btn btn-common" style="background-color: orange;" value="活動延期">
					        	<%} else if (lecstatus == 2) {%>
					        		<input type="submit" class="btn btn-common" style="background-color: #ff6680" value="名額已滿">
					        	<%} else if (lecstatus == 3) {%>
					        		<input type="submit" class="btn btn-common" style="background-color: #e5e5e5; color: #333" value="活動結束">
					        		
					        	<%}%>
					        		<input type="hidden" name="lecno" value="${lecVO.lecno}">
					        		<input type="hidden" name="action" value="frontOne">
					        	</form>
					        </div>
					    </div>
					    <% listindex++;%>
					<div class="col-lg-1 col-md-12 col-sm-12 col-xs-12 for-align"></div>
				</c:forEach>
	         </div>
	     </div>
  </section>
    <!-- Features Section End -->
	<div style="text-align: center">
		<%@ include file="/back-end/pool/page2.file" %>
	</div>
	<%@ include file="/index/front-index/footer.jsp" %>
	<script>
	var orderBy = "";
	var status = "9";
	
	// toggle 價格排序
	$("#btnPrice").click(function(){
		if ($(this).hasClass("priceAsc")){
			$(this).removeClass("priceAsc");
			$(this).addClass("priceDesc");
			orderBy = "priceDesc";
		} else if ($(this).hasClass("priceDesc")){
			$(this).removeClass("priceDesc");
			$(this).addClass("priceAsc");
			orderBy = "priceAsc";
		} else{
			orderBy = "";
		}
		//console.log("orderBy="+orderBy);
		$("#row").empty();
		sendAjaxQuery();
	});
	
	// toggle 時間排序
	$("#btnTime").click(function(){
		if ($(this).hasClass("timeAsc")){
			$(this).removeClass("timeAsc");
			$(this).addClass("timeDesc");
			orderBy = "timeDesc";
		} else if ($(this).hasClass("timeDesc")){
			$(this).removeClass("timeDesc");
			$(this).addClass("timeAsc");
			orderBy = "timeAsc";
		} else{
			orderBy = "";
		}
		
		//console.log("orderBy="+orderBy);
		$("#row").empty();
		sendAjaxQuery();
	});
	
	// 僅顯示可購買項目
	$("#canBuy").click(function(){
		if (!$(this).hasClass("canBuy")){
			$(this).addClass("canBuy");
			$("#buyAll").removeClass("buyAll");
			status = 1;
			$("#row").empty();
			sendAjaxQuery();
		} else {
			status = 1;
		}
	});
	
	// 顯示全部
	$("#buyAll").click(function(){
		if (!$(this).hasClass("buyAll")){
			$(this).addClass("buyAll");
			$("#canBuy").removeClass("canBuy");
			status = 9;
			$("#row").empty();
			sendAjaxQuery();
		} else {
			status = 9;
		}
	});
	
	// 關鍵字搜尋
	$("#query").keyup(function(e){
		 if (e.keyCode === 13){
		 	$("#row").empty();
		 	sendAjaxQuery();
		 }
	});
	
	function sendAjaxQuery(){
		$.ajax({
  	  		url: "<%=request.getContextPath()%>/lecture/lecJson.get",
 		type: "POST",
 		async: false,
 		data:{
 			action: "sendQuery",
 			query: $("#query").val(),
 			condition: orderBy,
 			status: status
 		},
 		dataType: 'json',
 		success: function(data){
			var lecs = data;
			console.log(lecs);
 			if (lecs.length != 0){
 				
	  			for (let i = 0; i < lecs.length; i++){
		  			var align = `<div class="col-lg-1 col-md-12 col-sm-12 col-xs-12 for-align"></div>`;
		  			$("#row").append(align);
	  			jQuery('<div/>', {
	  		    id: 'lec'+ i,
	  		    "class": 'div col-lg-10 col-md-12 col-sm-12 col-xs-12 box-item wow fadeInLeft ',
	  		    "html" : `<div class="daydiv">
	              <span class="date"></span><br>
	              <span class="month"></span><br>
	              <span class="time"></span><br>
	          </div>
	          <div class="pic">
	        <img>
	          </div>
	          <div class="lec-txt">
	          	<p class="title"></p><br>
	          	<p class="spkr"></p>
	          	<p class="info"></p>
	          	<p><span class="price"></span></p>
	          </div>
	          <div class="more">
	  	          	<form method="post" action="<%=request.getContextPath()%>/lecture/lecture.do">
	          		<input type="submit" class="btn btn-common status" value="我有興趣">
	          		<input type="hidden" name="lecno">
	          		<input type="hidden" name="action" value="frontOne">
	          	</form>
	          </div>`
	  		}).appendTo('#row');
	  			
	  			var lecno = lecs[i].lecno;
	  	  		var srcHead = "<%=request.getContextPath()%>/lecture/picreader?lecno=";
	  			var src = srcHead + lecno;
	  			var price = `NT$`+lecs[i].lecprice;
	  			
				//日期  	  			
	  			$("#lec"+i+" div .date").text(lecs[i].startdate);
	  			$("#lec"+i+" div .month").text(lecs[i].startmonth);
	  			$("#lec"+i+" div .time").text(lecs[i].starttime);
	  			
	  			//內容
	  			$("#lec"+i+" div .title").text(lecs[i].lecname);
	  			$("#lec"+i+" div .spkr").text("【" + lecs[i].spkrname + "】");
	  			$("#lec"+i+" div .info").text(lecs[i].lecinfo);
	  			$("#lec"+i+" div .price").html(price);
	  			
	  			//圖片
	  			$("#lec"+i+" img").attr("src", src)
	  			//按鈕
	  			if(lecs[i].lecstatus == 0){
	  				$("#lec"+i+" .status").val("活動延期");
	  				$("#lec"+i+" .status").attr("style", "background-color: orange");
	  			} else if(lecs[i].lecstatus == 2){
	  				$("#lec"+i+" .status").val("名額已滿");
	  				$("#lec"+i+" .status").attr("style", "background-color: #ff6680");
	  			} else if(lecs[i].lecstatus == 3){
	  				$("#lec"+i+" .status").val("活動結束");
	  				$("#lec"+i+" .status").attr("style", "background-color: #e5e5e5; color: #333;");
	  			} 
	  				
	  			$("#lec"+i+" div input[name='lecno']").attr("value", lecs[i].lecno);
	  			$("#row").append(align);
	  			}
	  			
	  		console.log($("#query").val());
	  		console.log("orderBy="+orderBy);
	  		console.log(data);
	  		} else {
	  		$("#row").text(查無資料);
	  		}
 		}
 })
	}

	</script>
</body>
</html>

