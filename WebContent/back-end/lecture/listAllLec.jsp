<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.lecture.model.*"%>
<%@ include file="/back-end/index/homepage.jsp" %>

<%
	LecService lecSvc = new LecService();
	List<LecVO> list = lecSvc.getList();
	pageContext.setAttribute("list", list);
	
	String startdate = "";
	String starttime = "";
	String endtime = "";
	String opendate = "";
	String closedate = "";
%>
<!DOCTYPE html>
<jsp:useBean id="spkrSvc" scope="page" class="com.speaker.model.SpkrService" />
<jsp:useBean id="roomSvc" scope="page" class="com.classroom.model.ClassroomService" />
<html>
<head>
<title>Xducation - 陪你成長的學習好夥伴</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
<style>
	#table-area{
		background-color: #f3f3f3;
		padding: 30px;
	}
	#calendar{
		background-color: #ffffff;
		margin-left:5%;
		margin-right: -5%;
	}
	.defaultLec{
		color: #fff;
		font-weight: 600;
		background-color: #0099cc;
		border-radius: 20px;
		padding: 8px 20px;
	}
	.cancelLec{
		color: #fff;
		font-weight: 600;
		background-color: orange;
		border-radius: 20px;
		padding: 8px 20px;
	}
	.soldOutLec{
		color: #fff;
		font-weight: 600;
		background-color: #ff6680;
		border-radius: 20px;
		padding: 8px 20px;
	}
	.endLec{
		color: #333;
		font-weight: 600;
		background-color: #e5e5e5;
		border-radius: 20px;
		padding: 8px 20px;
	}
	#statusText{
		margin-left: 52%;
	}
	#status{
		margin-top: 25px;
		outline: none;
	}
	.onPage{
	border: 0;
	outline: none;
	color: #fff;
	background-color: #0099cc;
	}
</style>
<body>
<main class="app-content" style="background-color: #f3f3f3">
<%if (list == null || list.size() == 0){%>
	<b style="color: red">查無資料</b>		
<%}%>
<div id="table-area" class="container-fluid">
    <div class="table-responsive">
        <div class="table-wrapper">			
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-2">
						<form method="post"	action="<%=request.getContextPath()%>/back-end/lecture/addLecIndex.jsp">
						<button class="bttn" type="submit">新增講座</button>
						</form>
					</div>
                    <div class="col-sm-7">
                        <h2 class="text-center">講座清單</h2>
                    </div>
                    <!-- search box start -->
                    <div class="col-sm-3">
                        <div class="search-box">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="material-icons">&#xE8B6;</i></span>
                                <input id="query" name="query" type="text" class="form-control" placeholder="Search&hellip;">
                            </div>
                        </div><br>
                        <span id="statusText">狀態篩選：</span><select id="status" name="status">
                        	<option value="9" selected>全選</option>
							<option value="0">取消</option>
							<option value="1">正常</option>
							<option value="2">額滿</option>
							<option value="3">結束</option>
						</select>
                    </div>
                    <!-- search box end -->
                </div>
            </div>
            <table id="table" class="table table-bordered">
                <thead>
					<tr>
						<th>編號<i id="no" class="fa fa-sort noDesc"></i></th>
						<th>名稱</th>
						<th>講師</th>
						<th>地點</th>
						<th>票價<i id="price" class="fa fa-sort priceAsc"></i></th>
						<th>日期<i id="time" class="fa fa-sort timeAsc"></i></th>
						<th>開始時間</th>
						<th>結束時間</th>
						<th>狀態</th>
						<th>檢視</th>
						<th>修改</th>
					</tr>
					<tbody>
					<% int listindex = 0; %>
					<%@ include file="/back-end/pool/page1.file" %>
					<c:forEach var="lecVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
					<%
						//時間設定
						LecVO lecVO = list.get(listindex + pageIndex);
						Timestamp lecstart = lecVO.getLecstart();
						Timestamp lecend = lecVO.getLecend();
						Timestamp signstart = lecVO.getSignstart();
						Timestamp signend = lecVO.getSignend();
						SimpleDateFormat fmtdate = new SimpleDateFormat("yyyy/MM/dd");
						SimpleDateFormat fmttime = new SimpleDateFormat("HH:mm");
						startdate = fmtdate.format(lecstart);
						starttime = fmttime.format(lecstart);
						endtime = fmttime.format(lecend);
						opendate = fmtdate.format(signstart);
						closedate = fmtdate.format(signend);
						//狀態設定
						String status = "";
						String statusCss = "";
						
						if (lecVO.getLecstatus() == 1){
							status = "正常";
							statusCss = "defaultLec";
						} else if (lecVO.getLecstatus() == 0) {
							status = "取消";
							statusCss = "cancelLec";
						} else if (lecVO.getLecstatus() == 2){
							status = "額滿";
							statusCss = "soldOutLec";
						} else if (lecVO.getLecstatus() == 3){
							status = "結束";
							statusCss = "endLec";
						} 
					%>
					<tr>
						<td>${lecVO.lecno}</td>
						<td>${lecVO.lecname}</td>
							<c:forEach var="spkrVO" items="${spkrSvc.list}">
                    			<c:if test="${lecVO.spkrno==spkrVO.spkrno}">
	                   				<td>${spkrVO.spkrname}</td>
				                    </c:if>
				                </c:forEach>
							<c:forEach var="roomVO" items="${roomSvc.all}">
                   				<c:if test="${lecVO.roomno==roomVO.roomno}">
	                    			<td>${roomVO.roomname}</td>
                   				</c:if>
               				</c:forEach>
						<td>$${lecVO.lecprice}</td>
						<td><%=startdate%></td>
			 			<td><%=starttime%></td>
						<td><%=endtime%></td>
						<td><span class="<%=statusCss%>"><%=status%></span></td>
						<td>
							<form method="post" action="<%=request.getContextPath()%>/lecture/lecture.do">
								<button class="btn view" style="color: #03A9F4"><i class="material-icons">&#xE417;</i></button>
								<input type="hidden" name="lecno" value="${lecVO.lecno}">
								<input type="hidden" name="action" value="getOne"></form>
							</td>
						<td>
							<form method="post"	action="<%=request.getContextPath()%>/lecture/lecture.do">
								<button class="btn edit" style="color: orange"><i class="material-icons">&#xE254;</i></button>
								<input type="hidden" name="lecno" value="${lecVO.lecno}">
								<input type="hidden" name="action" value="update_fromList">
							</form>
						</td>
					</tr>
					<% listindex++;%>
					</c:forEach>
					</tbody>
			</table>
			<div id="page-area">
			<%@ include file="/back-end/pool/page2.file" %>
 			</div>
			<div id="calendar" style="margin-top: 2%">
			<%@ include file="/calendar/calendar.jsp" %>
			</div>
		</div>
	</div>
</div>
</main>
<script>
var orderBy = "";

$("#status").change(function(){
	console.log("status="+ $("#status").val());
 	$("#table tbody").empty();
 	$("#page-area").empty();
 	sendAjaxQuery();
	console.log("ajax sent");
});

$("#no").click(function(){
	if ($(this).hasClass("noAsc")){
		$(this).removeClass("noAsc");
		$(this).addClass("noDesc");
		orderBy = "noDesc";
	} else if ($(this).hasClass("noDesc")){
		$(this).removeClass("noDesc");
		$(this).addClass("noAsc");
		orderBy = "noAsc";
	}
	console.log("orderBy="+orderBy);
 	$("#table tbody").empty();
 	$("#page-area").empty();
 	sendAjaxQuery();
	console.log("ajax sent");
});

$("#price").click(function(){
	 if ($(this).hasClass("priceAsc")){
		$(this).removeClass("priceAsc");
		$(this).addClass("priceDesc");
		orderBy = "priceDesc";
	} else if ($(this).hasClass("priceDesc")){
		$(this).removeClass("priceDesc");
		$(this).addClass("priceAsc");
		orderBy = "priceAsc";
	}
// 	else if ($(this).attr("id") === "timeAsc"){
// 		orderBy = "timeDesc";
// 		$("#timeAsc button").addClass("chosen");
// 		$("#priceDesc button").removeClass("chosen");
// 		$("#priceAsc button").removeClass("chosen");
// 		$("#timeDesc button").removeClass("chosen");
// 	}
// 	else if ($(this).attr("id") === "timeDesc"){
// 		orderBy = "timeAsc";
// 		$("#timeDesc button").addClass("chosen");
// 		$("#priceAsc button").removeClass("chosen");
// 		$("#priceDesc button").removeClass("chosen");
// 		$("#timeAsc button").removeClass("chosen");
// 	}
// 	else{
// 		orderBy = "";
// 	}
	console.log("orderBy="+orderBy);
 	$("#table tbody").empty();
 	$("#page-area").empty();
 	sendAjaxQuery();
	console.log("ajax sent");
});

$("#time").click(function(){
	if ($(this).hasClass("timeAsc")){
		$(this).removeClass("timeAsc");
		$(this).addClass("timeDesc");
		orderBy = "timeDesc";
	} else if ($(this).hasClass("timeDesc")){
		$(this).removeClass("timeDesc");
		$(this).addClass("timeAsc");
		orderBy = "timeAsc";
	}
	console.log("orderBy="+orderBy);
 	$("#table tbody").empty();
 	$("#page-area").empty();
 	sendAjaxQuery();
	console.log("ajax sent");
});


$("#query").keyup(function(e){
	 if (e.keyCode === 13){
	 	console.log("press");
	 	$("#table tbody").html("");
	 	$("#page-area").empty();
	 	sendAjaxQuery();
	 }
	});

function sendAjaxQuery(){
	$.ajax({
	  		url: "<%=request.getContextPath()%>/lecture/lecJson.get",
			type: "POST",
			data:{
				action: "sendQuery",
				query: $("#query").val(),
				status: $("#status").val(),
				condition: orderBy
			},
			dataType: 'json',
			success: function(data){
//	  			var lecs = JSON.parse(data);
			var lecs = data;
			if (lecs.length != 0){
 				for (let i = 0; i < lecs.length; i++){
	 				jQuery('<tr/>', {
		 		    id: 'tr'+ i,
		 		    "html" : `<td class="lecno"></td>
								<td class="lecname"></td>
		           				<td class="spkrname"></td>
		            			<td class="roomname"></td>
								<td class="lecprice"></td>
								<td class="startlec"></td>
					 			<td class="starttime"></td>
								<td class="endtime"></td>
								<td class="lecstatus"></td>
								<td>
									<form method="post" action="<%=request.getContextPath()%>/lecture/lecture.do">
										<button class="btn view" style="color: #03A9F4"><i class="material-icons">&#xE417;</i></button>
										<input class="sendLecno" type="hidden" name="lecno" value=lecs[i].lecno>
										<input type="hidden" name="action" value="getOne">
									</form>
								</td>
								<td>
									<form method="post"	action="<%=request.getContextPath()%>/lecture/lecture.do">
										<button class="btn edit" style="color: orange"><i class="material-icons">&#xE254;</i></button>
										<input class="sendLecno" type="hidden" name="lecno" value=lecs[i].lecno>
										<input type="hidden" name="action" value="update_fromList">
									</form>
								</td>`
 				}).appendTo('#table tbody');

	 			$("#tr"+i+" .lecno").text(lecs[i].lecno);
	 			$("#tr"+i+" .lecname").text(lecs[i].lecname);
	 			$("#tr"+i+" .roomname").text(lecs[i].roomname);
	 			$("#tr"+i+" .spkrname").text(lecs[i].spkrname);
	 			$("#tr"+i+" .lecprice").text(lecs[i].lecprice);
	 			$("#tr"+i+" .startlec").text(lecs[i].startlec);
	 			$("#tr"+i+" .starttime").text(lecs[i].starttime);
	 			$("#tr"+i+" .endtime").text(lecs[i].endtime);
	 			$("#tr"+i+" .sendLecno").val(lecs[i].lecno);
	 			
	 			if (lecs[i].lecstatus === 1)
	 				$("#tr"+i+" .lecstatus").html(`<span class="defaultLec">正常</span>`);
	 			 else if (lecs[i].lecstatus === 0)
	 				$("#tr"+i+" .lecstatus").html(`<span class="cancelLec">取消</span>`);
 				 else if (lecs[i].lecstatus === 2)
 					$("#tr"+i+" .lecstatus").html(`<span class="soldOutLec">額滿</span>`);
				 else if (lecs[i].lecstatus === 3)
					 $("#tr"+i+" .lecstatus").html(`<span class="endLec">結束</span>`);
	 			
 			
 			}
		}
	}
})
}
</script>
</body>
</html>
