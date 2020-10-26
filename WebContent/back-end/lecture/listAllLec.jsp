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
</style>
<body>
<main class="app-content" style="background-color: #f3f3f3">
<%if (list == null || list.size() == 0){%>
	<b style="color: red">查無資料</b>		
<%}%>
<div id="table-area" class="container-xl">
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
                                <input type="text" class="form-control" placeholder="Search&hellip;">
                            </div>
                        </div>
                    </div>
                    <!-- search box end -->
                </div>
            </div>
            <table class="table table-bordered">
                <thead>
					<tr>
						<th>講座編號</th>
						<th>講座名稱</th>
						<th>講師姓名</th>
						<th>講座地點</th>
						<th>講座票價</th>
						<th>講座日期</th>
						<th>開始時間</th>
						<th>結束時間</th>
<!-- 						<th>開始報名</th> -->
<!-- 						<th>結束報名</th> -->
						<th>講座狀態</th>
						<th>檢視</th>
						<th>修改</th>
					</tr>
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
						
						if (lecVO.getLecstatus() == 1){
							status = "正常";
						} else {
							status = "取消";
						}
					%>
					<tr>
						<td data-title="講座編號">${lecVO.lecno}</td>
						<td data-title="講座名稱">${lecVO.lecname}</td>
							<c:forEach var="spkrVO" items="${spkrSvc.list}">
                    			<c:if test="${lecVO.spkrno==spkrVO.spkrno}">
	                   				<td data-title="講師姓名">${spkrVO.spkrname}</td>
				                    </c:if>
				                </c:forEach>
							<c:forEach var="roomVO" items="${roomSvc.all}">
                   				<c:if test="${lecVO.roomno==roomVO.roomno}">
	                    			<td data-title="講座地點">${roomVO.roomname}</td>
                   				</c:if>
               				</c:forEach>
						<td data-title="講座票價">$${lecVO.lecprice}</td>
						<td data-title="講座日期"><%=startdate%></td>
			 			<td data-title="開始時間"><%=starttime%></td>
						<td data-title="結束時間"><%=endtime%></td>
<%-- 						<td data-title="報名開始"><%=opendate%></td> --%>
<%-- 						<td data-title="報名結束"><%=closedate%></td> --%>
						<td data-title="講座狀態"><%=status%></td>
						<td>
							<form method="post" action="<%=request.getContextPath()%>/lecture/lecture.do">
<!-- 								<input type="submit" value="資訊"> -->
								<button class="btn view" style="color: #03A9F4"><i class="material-icons">&#xE417;</i></button>
								<input type="hidden" name="lecno" value="${lecVO.lecno}">
								<input type="hidden" name="action" value="getOne"></form>
							</td>
						<td>
							<form method="post"	action="<%=request.getContextPath()%>/lecture/lecture.do">
<!-- 								<input type="submit" value="修改"> -->
								<button class="btn edit" style="color: orange"><i class="material-icons">&#xE254;</i></button>
								<input type="hidden" name="lecno" value="${lecVO.lecno}">
								<input type="hidden" name="action" value="update_fromList">
							</form>
						</td>
					</tr>
					<% listindex++;%>
					</c:forEach>
			</table>
			<%@ include file="/back-end/pool/page2.file" %>
			<div id="calendar">
			<%@ include file="/calendar/calendar.jsp" %>
		</div>
	</div>
	</div>
	</div>
	
	</main>
</body>

</html>
