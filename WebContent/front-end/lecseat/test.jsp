<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xducation - 陪你成長的學習好夥伴</title>
</head>
<body>
<div id="output"></div>
<button id="getQR">click me</button>
<input id="lodrno" type="text" value="LODR0008">
<input id="seatno" type="text" value="B2">
<!-- <input id="lecno" type="text" value="LEC0001"> -->
<script src="<%=request.getContextPath()%>/library/jquery/jquery-3.5.1.js"></script>
<script src="<%=request.getContextPath()%>/front-end/lecorder/qrcode/qrcode.js"></script>
<script>
 	var lodrno = $("#lodrno").val();
 	var seatno = $("#seatno").val();
//	var lecno = $("#lecno").val();
	$("#getQR").click(function(){
		var qrcode = new QRCode("output",{
			//text: "http://abcd803f6a40.ngrok.io/EA103G5/lecture/picreader?lecno=" + lecno,
			text: "http://0bc80c9d5136.ngrok.io/EA103G5/lecseat/updateSeat?lodrno=" + lodrno + "&seatno=" + seatno,
			width: 300,
			height: 300,
			correctLevel: QRCode.CorrectLevel.H
		});
	});

</script>
</body>
</html>