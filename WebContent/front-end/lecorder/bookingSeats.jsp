<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.classroom.model.*"%>
<%@ page import="com.lecture.model.*"%>

<%
	LecVO lvo = (LecVO) request.getAttribute("lecVO");
	String lno = lvo.getLecno();
	String defseat = lvo.getCurrseat();
%>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>addClassroom</title>

<!-- Bootstrap 的 CSS -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/roomsetting/css/classroom.css">
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
					<input type="text" id="defaultseat" name="currseat" value="<%=defseat%>" readonly>
				</div>
				<div style="display:inline-block">
				<div id="seatAppend" style="display:inline-block">
				剩餘座位數量：<span id="seatCount"></span> / <span id="blockCount"></span><br>
				</div>
	</div>
	</div>
	
		
	<div id="div"></div>
	<script src="<%=request.getContextPath()%>/roomsetting/javascript/classroom.js"></script>
  	<script>
  	var defseat = "<%=defseat%>";
  		
  		$.ajax({
  	  		url: "<%=request.getContextPath()%>/lecture/currLayout.show",
  	  		type: "POST",
  	  		data:{
  	  			lecno: "<%=lno%>"
  	  		},
  	  		success: function(data){
  	  			var layout = JSON.parse(data);
  	  			console.log(data);
  	  			for (let i = 0; i < layout.length; i++){
  	  	  			$("#roomrow").val(layout[i].roomrow);
  	  	  			$("#roomcolumn").val(layout[i].roomcolumn);
  	  	  			$("#defaultseat").val(defseat);
  	  	  			console.log(layout[i].roomrow);
  	  	  		console.log(layout[i].roomcolumn);
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
  	// 訂位用，將 input 內寫入剩餘座位字串值
  		function setCurrseatValue(statusStr) {
  			$("#defaultseat").val(statusStr);
  			$("#seatCount").text(seatCount(statusStr));
  			$("#blockCount").text(totalSeatCount(statusStr));
  			let chosenCount = chosenSeatCount(statusStr);
  			console.log("chosenCount=" + chosenCount);
  			$("#count").val(chosenCount);
  			let lecprice = $("#lecprice").val();
  			console.log(lecprice);
  			let currAmount = chosenCount * lecprice;
  			$("#lecamt").val(currAmount);
  		}
    </script>
</body>
</html>