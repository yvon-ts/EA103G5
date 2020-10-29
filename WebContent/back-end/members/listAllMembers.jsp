<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.members.model.*"%>

<%
	MembersService membersSvc = new MembersService();
List<MembersVO> list = membersSvc.getAll();
pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Sign Up Form by Colorlib</title>
<style type="text/css">
h2.form-title {
	text-align: center;
	margin-bottom: 0px;
}

div.signup-content {
	padding-top: 0px;
}

div.signup-form {
	margin-left: 0px;
}

input#name {
	padding: 0px 0px 0px 30px;
	width: 300px;
}

#table {
	border: 1px solid black;
}

tr, th {
	width: 300px;
}

tr, td {
	width: 200px;
	text-align: center;
}

#pic {
	width: 100px;
	height: 100px;
}
</style>
<!-- Font Icon -->

<!-- Main css -->
</head>
<body>

	<div class="main">

		<!-- Sign up form -->
		<section class="signup">
			<div class="container">
				<h2 class="form-title">Education所有會員資料</h2>

				<div class="signup-content">

					<div class="signup-form">

						<table id="table">
							<tr>
								<th>會員頭像</th>
								<th>會員編號</th>
								<th>會員帳號</th>
								<th>會員姓名</th>
								<th>會員暱稱</th>
								<th>會員生日</th>
								<th>會員電郵</th>
								<th>會員電話</th>

								<th>會員註冊時間</th>
								<th>資格狀態</th>
							</tr>
							<%@ include file="page1.file"%>
							<c:forEach var="membersVO" items="${list}" begin="<%=pageIndex%>"
								end="<%=pageIndex+rowsPerPage-1%>" varStatus="s">
								<tr>

									<td><img id="pic"
										src="<%=request.getContextPath()%>/front-end/members/MprofileDisplayServlet?MEMNO=${membersVO.memno}"
										alt="No Image Uploaded"></td>
										
									<td>${membersVO.memno}</td>
									<td>${membersVO.memacc}</td>
									<td>${membersVO.memname}</td>
									<td>${membersVO.nkname}</td>
									<td>${membersVO.membday}</td>
									<td>${membersVO.memail}</td>
									<td>${membersVO.mphone}</td>
									<td><fmt:formatDate value="${membersVO.regdate}" type="date" dateStyle="full"/></td>
									<td id="status${s.count}">${membersVO.memdelete}</td>

									<td>
									<input id="memdelete${s.count}" type="hidden" name="memno" value="${membersVO.memdelete}">
									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/members/members.do">
									
 								<input id="memno${s.count}" type="hidden" name="memno" value="${membersVO.memno}">  
										<input type="hidden" name="action" value="updatestatus">
                                      <input type="submit" value="修改"></FORM>
                                    <button onclick="sendRequest(${s.count})">Ajax按鈕</button>
									</td>
								</tr>
							</c:forEach>
						</table>
						<%@ include file="page2.file"%>


					</div>

				</div>
				<a class="form-submit" href="<%=request.getContextPath()%>/back-end/members/select_members.jsp">回首頁</a>
			</div>
		</section>

<script type="text/javascript">





var request;

function creLHttpRequest() {
  if (window.ActiveXObject) {
    request = new ActiveXObject("Microsoft.XMLHTTP");
  } else if (window.XMLHttpRequest) {
    request = new XMLHttpRequest();
  } else {
    window.alert("建議使用GOOGLE CHROME瀏覽器");
  }
}

function processResult() {
  if ((request.readyState == 4) && (request.status == 200)) {
    var str = request.responseText;
    
     if(str==="已啟用"){
    	 console.log('123');
     }else{
    	 console.log("456");
    } 
    
  }
}


function sendRequest(count) {
  createXMLHttpRequest();
  display(count);
  request.onreadystatechange = processResult;
  var memno = document.getElementById("memno"+count).value;
 
  
  
  	request.open("POST", "MemdeleteSwichServlet", true);
	    request.setRequestHeader("Content-Type",
	        "application/x-www-form-urlencoded");
	   
	    	request.send("memno=" + memno);
  }
  

</script>


		<!-- JS -->
		
</body>
<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>