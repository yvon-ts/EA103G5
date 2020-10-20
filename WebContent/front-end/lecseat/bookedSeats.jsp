<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.classroom.model.*"%>
<%@ page import="com.lecture.model.*"%>
<%@ page import="com.lecorder.model.*" %>
<%@ page import="com.lecseat.model.*" %>

<%
	String odrno = request.getParameter("lodrno").trim();
	LodrService svc = new LodrService();
	LodrVO odrVO = svc.getOne(odrno);
	String lec = odrVO.getLecno();
	String seat = odrVO.getLodrseat();
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
	#classroom{
		width: 50%;
	}
</style>
</head>

<body>
	<div id="classroom">
		<div id="stage">
			Stage
		</div>
		<br>
		<div id="seatmapping"></div>
		<%-- hidden layout settings --%>
		<input type="hidden" id="roomrow" class="roomSpace" name="roomrow" value="${roomVO.roomrow}">
		<input type="hidden" id="roomcolumn" class="roomSpace" name="roomcolumn" value="${roomVO.roomcolumn}">
		<input type="hidden" id="fixedseat" name="initseat" value="${lvo.initseat}" readonly>
		<input type="hidden" id="defaultseat" name="currseat" value="${lvo.currseat}" readonly>
	</div>
	<div>
	</div>
	
		
	<div id="div"></div>
	<script src="<%=request.getContextPath()%>/back-end/lecture/roomsetting/javascript/classroom.js"></script>
  	<script>
  		$.ajax({
  	  		url: "<%=request.getContextPath()%>/lecture/currLayout.show",
  	  		type: "POST",
  	  		data:{
  	  			lecno: "<%=lec%>"
  	  		},
  	  		success: function(data){
  	  			console.log(data);
  	  			var layout = JSON.parse(data);
  	  			for (let i = 0; i < layout.length; i++){
  	  	  			$("#roomrow").val(layout[i].roomrow);
  	  	  			$("#roomcolumn").val(layout[i].roomcolumn);
  	  	  			var seat = "<%=seat%>";
  	  	  			$("#defaultseat").val(seat);
  	  			}
  	  	         let roomRow = $("#roomrow").val();
  	  	         let roomColumn = $("#roomcolumn").val();
  	  	         let statusStr = $("#defaultseat").val();

  	  	        // print layout
  	  	        setCurrseatValue(statusStr);
  	  	        showSeatMapping();
	  	  	    //addClickForBooking();
  	  		}
  	  	});
  	
    </script>
</body>
</html>