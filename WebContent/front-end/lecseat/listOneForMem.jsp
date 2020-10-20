<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.lecture.model.*" %>
<%@ page import="com.lecorder.model.*" %>
<%@ page import="com.lecseat.model.*" %>

<%
	//lecseat
	String lodrno = request.getParameter("lodrno").trim();
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
	//日期設定
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
<%
%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Bootstrap Elegant Table Design</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<style>
body {
    color: #566787;
    background: #f5f5f5;
    font-family: 'Roboto', sans-serif;
}
#lecinfo{
	position: absolute;
	top: 50%;
  	left: 50%;
 	margin: -150px 0 0 -300px;

}
.hide{
	display: none;
}

</style>
<script>
$(document).ready(function(){
	$('[data-toggle="tooltip"]').tooltip();
	// Animate select box length
	var searchInput = $(".search-box input");
	var inputGroup = $(".search-box .input-group");
	var boxWidth = inputGroup.width();
	searchInput.focus(function(){
		inputGroup.animate({
			width: "300"
		});
	}).blur(function(){
		inputGroup.animate({
			width: boxWidth
		});
	});
});
</script>
</head>
<body>
<div class="container-xl">
    <div class="table-responsive">
        <div class="table-wrapper">			
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-4">
                    </div>
                    <div class="col-sm-4">
                        <h2 class="text-center">座位查詢</h2>
                    </div>
                    <div class="col-sm-4">
                       
                    </div>
                </div>
            </div>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>訂單編號<i class="fa fa-sort"></i></th>
                        <th>講座名稱</th>
                        <th>講座票價<i class="fa fa-sort"></i></th>
                        <th>座位號碼</th>
                        <th>訂單狀態<i class="fa fa-sort"></i></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
               <%@ include file="/back-end/pool/page1.file" %>
                        <c:forEach var="seatVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">

			<tr><td>${seatVO.lodrno}</td>
			 <td>${lecVO.lecname}</td>
			<td>${lecVO.lecprice}</td>
			<td>${seatVO.seatno}</td>
			<td>${seatVO.seatstatus}</td>
            <td>
            <form id="formGetOne" method="post" action="<%=request.getContextPath()%>/lecseat/lecseat.do">
            <input type="hidden" name="lodrno" value="${lodrVO.lodrno}">
			<button type="submit" class="btn edit"><i class="material-icons">&#xE254;</i></button></form>
            </td>
            </tr>
		</c:forEach>
                </tbody>
            </table>
            <div class="clearfix">
                <ul class="pagination">
                    <li class="page-item disabled"><a href="#">Previous</a></li>
                    <li class="page-item"><a href="#" class="page-link">1</a></li>
                    <li class="page-item"><a href="#" class="page-link">2</a></li>
                    <li class="page-item active"><a href="#" class="page-link">3</a></li>
                    <li class="page-item"><a href="#" class="page-link">4</a></li>
                    <li class="page-item"><a href="#" class="page-link">5</a></li>
                    <li class="page-item"><a href="#" class="page-link">Next</a></li>
                </ul>
            </div>
        </div>
    </div>
</div> 
 <div class="row">
   <div class="col-sm-6">
   <div id="lecinfo">
   	<ul>
   	<li>講座名稱：${lecVO.lecname}</li>
   	<li>講師姓名：${lecVO.spkrno}</li>
   	<li>講座日期：<%=startdate%></li>
	<li>講座時間：<%=starttime%> - <%=endtime%></li>
	<li>講座地點：<%=roomname%>教室</li>
   	</ul>
   	</div>
   </div>
		
       <div class="col-sm-6"><button id="modify">修改座位</button><form method="post" action="<%=request.getContextPath()%>/lecorder/lecorder.do">
       <%@ include file="/front-end/lecseat/bookedSeats.jsp" %>
       <input type="hidden" name="lodrno" value="<%=lodrno%>">
       <input type="hidden" name="lecno" value="<%=lecno%>">
       <input type="hidden" name="action" value="update">
         <input id="count" type="hidden" name="count" readonly>
  <input id="lecamt" type="text" name="lecamt" readonly>
  <input id="lecprice" type="hidden" value=<%=lecprice%> readonly>
  <input id="seatno" type="text" name="seatno" readonly>
       <button id="confirm" class="hide">確定變更</button></form>
       
      </div>
      </div>
	<script>
		$("#modify").click(function(){
			addClickForCancel();
			$("#confirm").removeClass("hide");
		});
		$("#confirm").mouseenter(function(){
			 var arr = document.getElementsByClassName("cancelled");
			    let txt = "";
			    if (arr.length > 0) {
			        for (let i = 0; i < arr.length; i++) {
			            txt += arr[i].textContent + " ";
			        }
			    }
			    $("#seatno").val(txt);
		});
		
		function verify(){
			var c = confirm("座位即將被取消，請問是否確認？");
			return c;
		}
		
	</script>
</body>
</html>                                		