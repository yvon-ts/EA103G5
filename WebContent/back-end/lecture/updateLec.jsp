<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.lecture.model.*"%>

<%@ include file="/back-end/pool/bstage1.jsp"%>

<!DOCTYPE html>

<%
	LecVO lecVO = (LecVO) request.getAttribute("lecVO");
	String info = "資訊更新中";
	try{
		byte[] b = lecVO.getLecinfo();
		info = new String(b);
	} catch (Exception e){
		info = "資訊更新中";
	}
%>

<html>
<head>
<meta charset="UTF-8">
<title>updateLec.jsp</title>
<style>
	#newimg{
		max-height: 200px;
		width: auto;
		position: absolute;
		margin-top: -70px;
		margin-left: 320px;
		}
	input:read-only {
		background: #E3E3E3;
		color: #333333;
		border: 2px #E3E3E3 solid;
	}
	input:focus {
		outline: none;
	}
</style>
</head>
<body>

	<div style="margin-left: 400px; margin-top: 150px;">
		<c:if test="${not empty errorMsgs}">
			<ul>
				<c:forEach var="err" items="${errorMsgs}">
					<li style="color: red">${err}</li>
				</c:forEach>
			</ul>
		</c:if>
		<form method="post"
			action="<%=request.getContextPath()%>/back-end/lecture/listAllLec.jsp">
			<input type="submit" value="回列表">
		</form>
		<div id="preivew"><img id="dbimg" src="<%=request.getContextPath()%>/lecture/picreader?lecno=${lecVO.lecno}"><img id="newimg" src=""></div>
		<form method="post"	action="<%=request.getContextPath()%>/lecture/lecture.do" enctype="multipart/form-data">
			講座編號：<input type="text" name="lecno" value="${lecVO.lecno}" readonly><br>
			講座名稱：<input type="text" name="lecname" value="${lecVO.lecname}"><br>
			講師姓名：<jsp:useBean id="spkrSvc" scope="page" class="com.speaker.model.SpkrService" />
			<select name="spkrno">
			<c:forEach var="spkrVO" items="${spkrSvc.list}">
				<option value="${spkrVO.spkrno}" ${(lecVO.spkrno==spkrVO.spkrno)? 'selected':'' } >${spkrVO.spkrno}${spkrVO.spkrname}</option>
			</c:forEach>
			</select><br>
			講座地點：<input type="text" name="roomno" value="${lecVO.roomno}" readonly><br>
			講座票價：<input type="text" name="lecprice" value="${lecVO.lecprice}"><br>
			講座時間：<input name="lecstart" id="f_date1" type="text"><br>
			結束時間：<input name="lecend" id="f_date2" type="text"><br>
			開始報名：<input name="signstart" id="f_date3" type="text"><br>
			結束報名：<input name="signend" id="f_date4" type="text"><br>
			講座狀態：<select name="lecstatus"><option value="1">正常</option><option value="0">取消</option></select>
			講座圖片：<input name="lecpic" id="upimg" type="file"><br>
			<%@ include file="/back-end/lecture/roomsetting/updateLayout.jsp"%><br>
			講座資訊：
			<%@ include file="/back-end/lecture/ckLec.file"%>
			<input id="action" type="hidden" name="action" value="updateText">
		</form>
	</div>
	<script type="text/javascript">
		//圖片預覽
		var upimg = document.getElementById("upimg");
		upimg.addEventListener("change", function(){
			readURL(this);
		});
		
		function readURL(input){
			if (input.files && input.files[0]){
				var reader = new FileReader();
				reader.onload = function(e){
					var newimg = document.getElementById("newimg");
					newimg.setAttribute("src", e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
	</script>
</body>
<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<% 
  	java.sql.Timestamp lecstart = null;
	java.sql.Timestamp lecend = null;
	java.sql.Timestamp signstart = null;
	java.sql.Timestamp signend = null;
  try {
	    lecstart = lecVO.getLecstart();
	    lecend = lecVO.getLecend();
	    signstart = lecVO.getSignstart();
	    signend = lecVO.getSignend();
   } catch (Exception e) {
	    lecstart = new java.sql.Timestamp(System.currentTimeMillis());
	    lecend = new java.sql.Timestamp(System.currentTimeMillis());
	    signstart = new java.sql.Timestamp(System.currentTimeMillis());
	    signend = new java.sql.Timestamp(System.currentTimeMillis());
   }
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
		//----------------------------------------------------------格式化日期-----------------------------------------------------------

        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 60,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value: '<%=lecstart%>', // value:   new Timestamp(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 60,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value: '<%=lecend%>', // value:   new Timestamp(),
        });
        
        $.datetimepicker.setLocale('zh');
        $('#f_date3').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 60,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value: '<%=signstart%>', // value:   new Timestamp(),
        });
        
        $.datetimepicker.setLocale('zh');
        $('#f_date4').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 60,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value: '<%=signend%>', // value:   new Timestamp(),
        });
        
   
        // ----------------------------------------------------------排定無法選擇的日期-----------------------------------------------------------

        //      1.以下為某一天之前的日期無法選擇
        		
              //講座開始日期(無法選擇昨天以前)
              var lecdate1 = new Date();
              $('#f_date1').datetimepicker({
                  beforeShowDay: function(date) {
                	  if (  date.getYear() <  lecdate1.getYear() || 
        		           (date.getYear() == lecdate1.getYear() && date.getMonth() <  lecdate1.getMonth()) || 
        		           (date.getYear() == lecdate1.getYear() && date.getMonth() == lecdate1.getMonth() && date.getDate() < lecdate1.getDate())
                      ) {
                           return [false, ""]
                      }
                      return [true, ""];
              }});
              //講座結束日期(無法選擇昨天以前)
              $('#f_date2').datetimepicker({
                  beforeShowDay: function(date) {
                	  if (  date.getYear() <  lecdate1.getYear() || 
        		           (date.getYear() == lecdate1.getYear() && date.getMonth() <  lecdate1.getMonth()) || 
        		           (date.getYear() == lecdate1.getYear() && date.getMonth() == lecdate1.getMonth() && date.getDate() < lecdate1.getDate())
                      ) {
                           return [false, ""]
                      }
                      return [true, ""];
              }});
      //以下待修改(動態抓講座日期)  
      /*   //      2.以下為某一天之後的日期無法選擇
              //報名開始日期(無法選擇講座之後)
              var lecdate0 = new Date();
              lecdate0.setDate(lecdate0.getDate() - 1); //講座的昨天
              $('#f_date3').datetimepicker({
                  beforeShowDay: function(date) {
                	  if (  date.getYear() >  lecdate0.getYear() || 
        		           (date.getYear() == lecdate0.getYear() && date.getMonth() >  lecdate0.getMonth()) || 
        		           (date.getYear() == lecdate0.getYear() && date.getMonth() == lecdate0.getMonth() && date.getDate() > lecdate0.getDate())
                      ) {
                           return [false, ""]
                      }
                      return [true, ""];
              }});
              
            //報名結束日期(無法選擇講座之後)
              var lecdate0 = new Date();
              lecdate0.setDate(lecdate0.getDate() - 1); //講座的昨天
              $('#f_date4').datetimepicker({
                  beforeShowDay: function(date) {
                	  if (  date.getYear() >  lecdate0.getYear() || 
        		           (date.getYear() == lecdate0.getYear() && date.getMonth() >  lecdate0.getMonth()) || 
        		           (date.getYear() == lecdate0.getYear() && date.getMonth() == lecdate0.getMonth() && date.getDate() > lecdate0.getDate())
                      ) {
                           return [false, ""]
                      }
                      return [true, ""];
              }});
 */

        //      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
        //      var somedate1 = new Date('2017-06-15');
        //      var somedate2 = new Date('2017-06-25');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //		             ||
        //		            date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
        //upload image preview
		var upimg = document.getElementById("upimg");
		var dbimg = document.getElementById("dbimg");
		upimg.addEventListener("change", function(){
			readURL(this);
			dbimg.setAttribute("style", "display: none;")
		});
		
		function readURL(input){
			if (input.files && input.files[0]){
				var reader = new FileReader();
				reader.onload = function(e){
					var newimg = document.getElementById("newimg");
					newimg.setAttribute("src", e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
		$("#btn").mouseenter(function(){
			var fileInput = $("#upimg").get(0).files[0];
			if(fileInput){
				$("#action").val("update");
			}
		});
		
		
</script>

</html>

