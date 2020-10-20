<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%> 
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page import="javax.sql.DataSource"%>

<%@ include file="/back-end/pool/bstage1.jsp" %>

<!DOCTYPE html>
<%
	//===============================Declaration===============================//
	JSONArray arr = null;
	DataSource ds = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "SELECT lecname, lecstart FROM LECTURE ORDER BY LECNO";
	//===============================Connection pool===============================//
	try {
		Context ctx = new InitialContext();
		ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
	} catch (NamingException e) {
		e.printStackTrace();
	}
	//===============================New Lecture===============================//
			String newTitle = "新講座";
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			String newStart = df.format(new java.util.Date().getTime());
			JSONObject newLec = new JSONObject();
			newLec.put("title", newTitle);
			newLec.put("start", newStart);
			newLec.put("color", "#FF9966");
			newLec.put("startEditable", true);
	//===============================Get Data from Server===============================//
	try {
		con = ds.getConnection();
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		arr = new JSONArray();
		
		while(rs.next()){
			JSONObject obj = new JSONObject();
			//obj.put("lecno", rs.getString("lecno"));
			obj.put("title", rs.getString("lecname"));
			obj.put("start", rs.getTimestamp("lecstart"));
			obj.put("startEditable", false);
			//if (rs.getInt("lecstatus") == 0 )
			//	obj.put("color", "pink");
			arr.put(obj);
		}
		arr.put(newLec);
		//out.print(arr); //testing
	//===============================try catch part===============================//
		} catch (SQLException se) {
			throw new RuntimeException("Database error." + se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
%>
<html>
<head>
<link href='<%=request.getContextPath()%>/calendar/lib/main.css' rel='stylesheet' />
<script src='<%=request.getContextPath()%>/calendar/lib/main.js'></script>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<style>

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 16px;
  }
  header{
  	margin-left: -10px;
  }
  #btn{
  	margin-left: 50px;
  }

  #calendar {
    max-width: 800px;
    margin: 50px;
  }
  #textarea{
  	display: none;
  }
  .fc-daygrid-event-dot {
            /* the actual dot */
            margin: 0 4px;
            box-sizing: content-box;
            width: 0;
            height: 0;
            border: 4px solid #0099CC;
            border: calc(var(--fc-daygrid-event-dot-width, 8px) / 2) solid var(--fc-event-border-color, #0099CC);
            border-radius: 4px;
            border-radius: calc(var(--fc-daygrid-event-dot-width, 8px) / 2);
        }

</style>
</head>
<body>
<textarea id="textarea"><%=arr %></textarea>
<div style="margin-left: 300px; margin-top: 130px;">
<form method="post" action="<%=request.getContextPath()%>/back-end/lecture/addLec2.jsp">
<input id="lecno" type="hidden"><br>
<input id="lecinit" name="lecinit"  value="<%=newStart%>" type="hidden">
<input id="btn" type="submit" value="確定送出，繼續新增講座">
</form>
<div id='calendar'></div>
</div>
<script>
//========================get JSON data========================//
var val = $("#textarea").val();
var lec = JSON.parse(val);
//========================fullCalendar========================//
var today = new Date();
var todaysDate = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate()+'T'+today.getHours()+':'+today.getMinutes()+':'+today.getSeconds()+'.000Z';
document.getElementById("lecinit").value = todaysDate;


var calendarEl = document.getElementById('calendar');

var calendar = new FullCalendar.Calendar(calendarEl, {
  timeZone: 'false',
  initialDate: today,
  editable: true,
  selectable: true,
  businessHours: true,
  dayMaxEvents: true, // allow "more" link when too many events
  events: lec,
   eventTimeFormat: { 
    hour: '2-digit',
    minute: '2-digit',
    hour12:false
},
eventDrop: function(info) {
    //alert(info.event.title + " was dropped on " + info.event.start.toISOString());
	document.getElementById("lecno").value = info.event.title;
	document.getElementById("lecinit").value = info.event.start.toISOString();
    if (!confirm("確定要移動嗎 ?")) {
      info.revert();
    }
  }
});

calendar.render();
</script>
</body>
</html>