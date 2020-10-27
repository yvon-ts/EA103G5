<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.classroom.model.*"%>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>addClassroom</title>

<!-- Bootstrap 的 CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
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
		
		<div class="col-md-12">
				
				<jsp:useBean id="roomSvc" scope="page" class="com.classroom.model.ClassroomService" />
		<span id="room">&nbsp;講座地點&emsp;</span><select id="roomSelect" style="outline: none; border: 0;border-bottom: 1px solid #999"required>
			<option>------請選擇教室------</option>
			<c:forEach var="roomVO" items="${roomSvc.all}">
				<option value="${roomVO.roomno}" ${(lecVO.roomno==roomVO.roomno)? 'selected':'' } >${roomVO.roomno}&nbsp;${roomVO.roomname}</option>
			</c:forEach>
		</select><br>
			</div>
				<div id="classroom">
					<div id="stage">
						Stage
					</div>
					<br>
					<div id="seatmapping"></div>
					<%-- hidden layout settings --%>
					<input type="hidden" id="roomno" >
					<input type="hidden" id="roomrow" class="roomSpace" name="roomrow" value="3">
					<input type="hidden" id="roomcolumn" class="roomSpace" name="roomcolumn" value="3">
					<input type="hidden" id="fixedseat" name="initseat" value="" readonly>
					<input type="hidden" id="defaultseat" name="currseat" value="111111111" readonly>
					座位數量：<span id="seatCount"></span> / <span id="blockCount"></span>
				</div>
		</div>
	
		
	<div id="div"></div>
	<script src="<%=request.getContextPath()%>/back-end/lecture/roomsetting/javascript/classroom.js"></script>
  	<script>
  	setDefaultseatValue($("#defaultseat").val());
  	showSeatMapping();
  	
  	$("#roomSelect").change(function(){
  		var roomno = $(this).val();
  		$("#roomno").val(roomno);
  		$("#roomnoForm").val(roomno);
  		
  		$.ajax({
  	  		url: "<%=request.getContextPath()%>/lecture/defLayout.show",
  	  		type: "POST",
  	  		data:{
  	  			classroomno: roomno
  	  		},
  	  		success: function(data){
  	  			console.log(data);
  	  			var rooms = JSON.parse(data);
  	  			for (let i = 0; i < rooms.length; i++){
  	  				$("#roomname").val(rooms[i].roomname);
  	  	  			$("#roomrow").val(rooms[i].roomrow);
  	  	  			$("#roomcolumn").val(rooms[i].roomcolumn);
  	  	  			$("#defaultseat").val(rooms[i].defaultseat);
  	  	  			$("#fixedseat").val(rooms[i].defaultseat);
  	  			}
  	  	         let roomRow = $("#roomrow").val();
  	  	         let roomColumn = $("#roomcolumn").val();
  	  	         let statusStr = $("#defaultseat").val();

  	  	        // print layout
  	  	       	setBothSeatsValue(statusStr);
  	  	        showSeatMapping();
  	  	    	addClickToBothSeats();
  	  		}
  	  	});
  		
  	});
    </script>
</body>
</html>