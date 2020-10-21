<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.classroom.model.*"%>
<%@ page import="com.lecture.model.*"%>



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
		

		<div class="row">
			<div class="col-md-4">
				
				
		座位數量：<span id="seatCount"></span> / <span id="blockCount"></span> 
			</div>

			<div class="col-md-4">
				<div id="classroom">
					<div id="stage">
						Stage hi
					</div>
					<br>
					<div id="seatmapping"></div>
					<%-- hidden layout settings --%>
					<input type="hidden" id="roomno" value="${lecVO.roomno}">
					<input type="hidden" id="roomrow" class="roomSpace" name="roomrow">
					<input type="hidden" id="roomcolumn" class="roomSpace" name="roomcolumn">
					<input type="hidden" id="fixedseat" name="initseat" readonly>
					<input type="hidden" id="defaultseat" name="currseat" value="${lecVO.currseat}" readonly>
				</div>
			</div>
			
		</div>
		
	</div>
	
		
	<div id="div"></div>
	<script src="<%=request.getContextPath()%>/back-end/lecture/roomsetting/javascript/classroom.js"></script>
  	<script>
  	
  		$.ajax({
  	  		url: "<%=request.getContextPath()%>/lecture/currLayout.show",
  	  		type: "POST",
  	  		data:{
  	  			lecno: "${lecVO.lecno}"
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
  	  	        setDefaultseatValue(statusStr);
  	  	        showSeatMapping();
  	  		}
  	  	});
  		
  	
    </script>
</body>
</html>