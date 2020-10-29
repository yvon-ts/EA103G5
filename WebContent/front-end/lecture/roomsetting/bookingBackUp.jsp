<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.classroom.model.*"%>
<%@ page import="com.lecture.model.*"%>

<%
	//LecVO lvo = (LecVO) request.getAttribute("lecVO");
	//String roomnoStr = lvo.getRoomno();
	String lecno = "LEC0006";
	//String lecno = lvo.getLecno();
	//String initseat = lvo.getInitseat();
	//String currseat = lvo.getCurrseat();
	//ClassroomService roomSvc = new ClassroomService();
	//ClassroomVO roomVO = roomSvc.getOneClassroom(roomnoStr);
%>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>addClassroom</title>

<!-- Bootstrap 的 CSS -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/lecture/roomsetting/css/classroom.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<style>
	.hide{
		display: none;
	}
</style>
</head>

<body>
	<div class="container">
				<div id="classroom">
					<div id="stage">
						Stage
					</div>
					<br>
					<div id="seatmapping"></div>
					<%-- hidden layout settings --%>
					<input type="hidden" id="roomrow" class="roomSpace" name="roomrow" value="${roomVO.roomrow}">
					<input type="hidden" id="roomcolumn" class="roomSpace" name="roomcolumn" value="${roomVO.roomcolumn}">
					<input type="text" id="fixedseat" name="initseat" value="${lvo.initseat}" readonly>
					<input type="text" id="defaultseat" name="currseat" value="${lvo.currseat}" readonly>
				</div>
				<div>剩餘座位數量：<span id="seatCount"></span> / <span id="blockCount"></span></div>
	</div>
	
		
	<div id="div"></div>
	<script src="<%=request.getContextPath()%>/back-end/lecture/roomsetting/javascript/classroom.js"></script>
  	<script>
  		$.ajax({
  	  		url: "<%=request.getContextPath()%>/lecture/currLayout.show",
  	  		type: "POST",
  	  		data:{
  	  			lecno: "<%=lecno%>"
  	  		},
  	  		success: function(data){
  	  			console.log(data);
  	  			var layout = JSON.parse(data);
  	  			for (let i = 0; i < layout.length; i++){
  	  	  			$("#roomrow").val(layout[i].roomrow);
  	  	  			$("#roomcolumn").val(layout[i].roomcolumn);
  	  	  			$("#defaultseat").val(layout[i].currseat);
  	  	  			$("#fixedseat").val(layout[i].initseat);
  	  			}
  	  	         let roomRow = $("#roomrow").val();
  	  	         let roomColumn = $("#roomcolumn").val();
  	  	         let statusStr = $("#defaultseat").val();

  	  	        // print layout
  	  	        setCurrseatValue(statusStr);
  	  	        showSeatMapping();
	  	  	    addClickForBooking();
  	  		}
  	  	});
  	
    </script>
</body>
</html>