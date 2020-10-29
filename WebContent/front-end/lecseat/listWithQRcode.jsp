<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.lecture.model.*" %>
<%@ page import="com.lecorder.model.*" %>
<%@ page import="com.lecseat.model.*" %>

<%
	String memno = "";
	MembersVO memVO = (MembersVO)session.getAttribute("loginMembersVO");
	if (memVO != null){
		memno = memVO.getMemno();
		System.out.println("listWithQRCOde的memno="+ memno);
	} else {
		System.out.println("ListWithQRCOde memno == null");
	}
	
	
	//lecseat
	String lodrno = request.getParameter("lodrno").trim();
	if(lodrno.length() == 0){
		lodrno = (String) request.getAttribute("lodrno");
	}
	LecseatService seatSvc = new LecseatService();
	List<LecseatVO> list = seatSvc.getSeatsByOrder(lodrno);
	//lecorder
	LodrService lodrSvc = new LodrService();
	LodrVO lodrVO = lodrSvc.getOne(lodrno);
	String lecno = lodrVO.getLecno();
	String lodrseat = lodrVO.getLodrseat();
	//lecture
	LecService lecSvc = new LecService();
	LecVO lecVO = lecSvc.getOne(lecno);
	String roomno = lecVO.getRoomno();
	Integer lecprice = lecVO.getLecprice();
	//classroom
	ClassroomService roomSvc = new ClassroomService();
	ClassroomVO roomVO = roomSvc.getOneClassroom(roomno);
	String roomname = roomVO.getRoomname();
	//date time formatter
	Timestamp lecstart = lecVO.getLecstart();
	Timestamp lecend = lecVO.getLecend();
	String startdate = "";
	String starttime = "";
	String endtime = "";
	DateFormat fmtdate = new SimpleDateFormat("yyyy/MM/dd");
	DateFormat fmttime = new SimpleDateFormat("HH:mm");
	startdate = fmtdate.format(lecstart);
	starttime = fmttime.format(lecstart);
	endtime = fmttime.format(lecend);
	
	pageContext.setAttribute("list", list);
	pageContext.setAttribute("lodrVO", lodrVO);
	pageContext.setAttribute("lecVO", lecVO);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Xducation - 陪你成長的學習好夥伴</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
<%@ include file="/index/front-index/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/lecseat/css/listOneForMem.css">
<style>
#codeOutput{
    width: fit-content;
    margin-left: 25%;
    margin-top: 15%;
    padding: 20px;
    border-radius: 2%;
    background-color: rgba(245, 222, 179, 0.5);
}
</style>
<script>
</script>
</head>
<body>
<div id="padd">padd</div>
<div id="table-area" class="container-xl">
    <div class="table-responsive">
        <div class="table-wrapper">			
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-4">
                    </div>
                    <div class="col-sm-4">
                        <h2 class="text-center">查看座位</h2>
                    </div>
                    <div class="col-sm-4">
                    </div>
                </div>
            </div>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>訂單編號</th>
                        <th>講座名稱</th>
                        <th>講座票價</th>
                        <th>座位號碼</th>
                        <th>座位狀態</th>
                        <th>檢視票券</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="seatVO" items="${list}">

					<tr>
						<td>${seatVO.lodrno}</td>
						<td>${lecVO.lecname}</td>
						<td>${lecVO.lecprice}</td>
						<td>${seatVO.seatno}</td>
						<td id="${seatVO.seatno}seat">${seatVO.seatstatus}</td>
			            <td>
				            <div id="${seatVO.seatno}">
					            <input type="hidden" class="lodrno" name="lodrno" value="${lodrVO.lodrno}">
					            <input type="hidden" class="seatno" name="seatno" value="${seatVO.seatno}">
								<button class="btn view"><i class="material-icons">&#xE417;</i></button>
							</div>
			            </td>
		            </tr>
					
					</c:forEach>
                </tbody>
            </table>
            <div class="clearfix" style="padding-bottom: 50px">
               <div class="pagination">
               <form id="modifyForm"method="post" action="<%=request.getContextPath()%>/lecorder/lecorder.do">
			       <input type="hidden" name="lodrno" value="<%=lodrno%>">
			       <input type="hidden" name="lecno" value="<%=lecno%>">
			       <input id="count" type="hidden" name="count" readonly>
			 	   <input id="lecamt" type="hidden" name="lecamt" readonly>
				   <input id="lecprice" type="hidden" value=<%=lecprice%> readonly>
			  	   <input id="seatno" type="hidden" name="seatno" readonly>
			  	   <!-- catch currseat from seat layout for sending request -->
			  	   <input id="currseat" type="hidden" name="currseat" readonly>
			  	   <input type="hidden" name="action" value="update">
		       </form>
                </div>
            </div>
        </div>
    </div>
</div> 
<div id="table-area" class="container-xl">
    <div class="table-responsive">
	    <div class="table-wrapper">
        	<div class="container">
            	<div class="row">
                	<div class="col-md-4">
                		<div id="codeOutput" class="hide"></div>
               		  		<img id="cus-service" src="<%=request.getContextPath()%>/index/front-index/assets/img/head/cus-service.png">
               		  <br><span id="caption"></span>
               		</div>
		          	<div class="col-md-4">
					    <%@ include file="/front-end/lecseat/bookedSeats.jsp" %>
		            </div>
                	    <div id="lecinfo" class="col-md-4">
					   	<ul><li>${lecVO.lecname}</li> 
					   	<li>講師姓名：${lecVO.spkrno}</li>
					   	<li>講座日期：<%=startdate%></li>
						<li>講座時間：<%=starttime%> - <%=endtime%></li>
						<li>講座地點：<%=roomname%>教室</li>
						</ul>
						<form method="post" action="<%=request.getContextPath()%>/front-end/lecorder/listByMemno.jsp">
						<input type="hidden" name="memno" value="<%=memno%>"><br>
						<button id="return" class="btn btn-border" style="border: 1px solid #0099cc;">回上頁</button>
						</form>
						<button id="confirm" class="hide btn btn-border" style="border: 1px solid #0099cc;">確定變更</button>
                  </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/index/front-index/footer.jsp" %>
<%-- <script src="<%=request.getContextPath()%>/library/jquery/jquery-3.5.1.js"></script> --%>
<script src="<%=request.getContextPath()%>/front-end/lecseat/qrcode/qrcode.js"></script>
<script>
	var lodrno = "";
	var seatno = "";
	
	function generateQRCode(){
		var qrcode = new QRCode("codeOutput",{
			text: "http://59f489681404.ngrok.io/EA103G5/lecseat/updateSeat?lodrno=" + lodrno + "&seatno=" + seatno,
			width: 150,
			height: 150,
			correctLevel: QRCode.CorrectLevel.H
		});
	}
	$(".view").click(function(e){
		e.preventDefault();
		var id = $(this).parent().attr("id");
		lodrno = $("#"+id+" .lodrno").val();
		seatno = $("#"+id+" .seatno").val();
		console.log($("#"+id+"seat").text());
		if ($("#"+id+"seat").text() === "正常"){
			$("#codeOutput").html("");
			$("#codeOutput").removeClass("hide");
			$("#cus-service").addClass("hide");
			generateQRCode();
			$("#caption").text("請保存座位" + seatno + "的QRcode");
			$("#caption").attr("style", "margin-left: 25%");
		} else if ($("#"+id+"seat").text() === "已報到"){
			alert("該座位已報到！");
		} else {
			alert("該座位已取消！");
		}
		
	});
	
	
</script>
</body>
</html>                                		