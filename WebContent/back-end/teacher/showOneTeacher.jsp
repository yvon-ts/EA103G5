<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.teacher.model.*"%>

<%@ include file="/back-end/index/homepage.jsp" %>

<!DOCTYPE html>

<% 
TeacherVO teacherVO = (TeacherVO) request.getAttribute("teacherVO");

%>
<jsp:useBean id="membersSvc" scope="page" class="com.members.model.MembersService" />

<html>
<head>
<title>Xducation - 陪你成長的學習好夥伴</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<style>
#pic {
	width:80px;
	height:80px;
}
table{
text-align:center;
}
td.number{
padding:50px 0 ;
}

.bttn{
	display: inline-block;
	background-color: #fff;
	outline: none;
	border: 1px solid #0099cc;
	color: #0099cc;
	font-size: 16px;
    padding: 5px 30px;
    cursor: pointer;
    font-weight: 550;
    border-radius: 30px;
    -webkit-transition: all 0.2s linear;
    -moz-transition: all 0.2s linear;
    -o-transition: all 0.2s linear;
    transition: all 0.2s linear;
    display: inline-block;
}
.bttn:hover{
	background-color: #0099cc;
	outline: none;
	border: 1px solid #0099cc;
	color: #fff;
}
img.pimg{
cursor:pointer;
}
</style>
</head>

<body>
<main class="app-content" style="background-color: #f3f3f3">
<div id="include">

<div id="table-area" class="container-xl">
    <div class="table-responsive">
        <div class="table-wrapper">			
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-2">
						<form method="post"	action="<%=request.getContextPath()%>/back-end/teacher/listAllTeachers.jsp">
						<button class="bttn" type="submit">回首頁</button>
						</form>
					</div>
                    <div class="col-sm-7">
                        <h2 class="text-center">單一老師查詢</h2>
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
                        <th>老師編號</th>
                        <th>老師姓名</th>
                        <th>老師簡介</th>
                        <th>證照1</th>
                        <th>證照2</th>
                        <th>資格不符原因</th>
						<th>資格狀態</th>
                        <th>審核</th>
                    </tr>
                </thead>
                <tbody>

		<tr>
		<td class="number">${teacherVO.tchrno}</td>
		<td class="number"><c:forEach var="membersVO" items="${membersSvc.all}">
                    <c:if test="${teacherVO.memno==membersVO.memno}">
                    ${membersVO.memname}
                    </c:if>
                </c:forEach>
            </td>
            
            <td class="number">
            ${teacherVO.tchrintro}
            </td>
            
            
			<td class="number"><img class="pimg" id="pic" src="<%=request.getContextPath()%>/back-end/teacher/TchrcertDisplayServlet1?TCHRNO=${teacherVO.tchrno}" 
                alt="No Image Uploaded"></td>
             <td class="number"><img class="pimg" id="pic" src="<%=request.getContextPath()%>/back-end/teacher/TchrcertDisplayServlet2?TCHRNO=${teacherVO.tchrno}" 
                alt="No Image Uploaded"></td>
                <div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;display:none;">
    <div id="innerdiv" style="position:absolute;">
        <img id="bigimg" style="border:5px solid #fff;" src="" />
    </div>
</div>
                
                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/teacher/teacher.do">
			<td class="number">
				
                  <h2 class="h2" style="color:red;">${teacherVO.rejreason}</h2>
                 <select name="rejreason">
               <option value="其它">其它
                <option value="銀行帳號:填寫錯誤">銀行帳號:填寫錯誤
                <option value="個人經歷描述:不夠詳盡">個人經歷描述:不夠詳盡
                <option value="專業證照:證照不符">專業證照:證照不符
                <option value="專業證照:證照過期">專業證照:證照過期
                <option value="專業證照:模糊不清">專業證照:模糊不清
                
                
                </select>
                </td>
                <td class="number">
                <h2 class="h2" style="color:green;">${teacherVO.tchrstatus}</h2>
                <select name="tchrstatus">
                <option value="${teacherVO.tchrstatus}">${teacherVO.tchrstatus}
                <option value="已通過">已通過
                <option value="未通過">未通過
                
                </select>
                </td>
                <td class="number">
                 <input type="hidden" name="tchrno" value="${teacherVO.tchrno}">
                <input type="hidden" name="action" value="updateStatus">
                 <input type="submit" value="送出">
              
                
                </td>
                 </FORM>
               
			</td>
			
		</tr>
		</tbody>
	</table>
	<form method="post"	action="<%=request.getContextPath()%>/back-end/teacher/listAllTeachers.jsp">
	<input type="submit" value="回首頁"></form>
	</div>
	</div>
	</div>
	</div>
	</main>
	<script type="text/javascript">
	 $(function(){  
	        $(".pimg").click(function(){  
	            var _this = $(this);//將當前的pimg元素作為_this傳入函式  
	            imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);  
	        });  
	    });  

	    function imgShow(outerdiv, innerdiv, bigimg, _this){  
	        var src = _this.attr("src");//獲取當前點選的pimg元素中的src屬性  
	        $(bigimg).attr("src", src);//設定#bigimg元素的src屬性  
	      
	            /*獲取當前點選圖片的真實大小，並顯示彈出層及大圖*/  
	        $("<img/>").attr("src", src).load(function(){  
	            var windowW = $(window).width();//獲取當前視窗寬度  
	            var windowH = $(window).height();//獲取當前視窗高度  
	            var realWidth = this.width;//獲取圖片真實寬度  
	            var realHeight = this.height;//獲取圖片真實高度  
	            var imgWidth, imgHeight;  
	            var scale = 0.8;//縮放尺寸，當圖片真實寬度和高度大於視窗寬度和高度時進行縮放  
	              
	            if(realHeight>windowH*scale) {//判斷圖片高度  
	                imgHeight = windowH*scale;//如大於視窗高度，圖片高度進行縮放  
	                imgWidth = imgHeight/realHeight*realWidth;//等比例縮放寬度  
	                if(imgWidth>windowW*scale) {//如寬度扔大於視窗寬度  
	                    imgWidth = windowW*scale;//再對寬度進行縮放  
	                }  
	            } else if(realWidth>windowW*scale) {//如圖片高度合適，判斷圖片寬度  
	                imgWidth = windowW*scale;//如大於視窗寬度，圖片寬度進行縮放  
	                            imgHeight = imgWidth/realWidth*realHeight;//等比例縮放高度  
	            } else {//如果圖片真實高度和寬度都符合要求，高寬不變  
	                imgWidth = realWidth;  
	                imgHeight = realHeight;  
	            }  
	                    $(bigimg).css("width",imgWidth);//以最終的寬度對圖片縮放  
	              
	            var w = (windowW-imgWidth)/2;//計算圖片與視窗左邊距  
	            var h = (windowH-imgHeight)/2;//計算圖片與視窗上邊距  
	            $(innerdiv).css({"top":h, "left":w});//設定#innerdiv的top和left屬性  
	            $(outerdiv).fadeIn("fast");//淡入顯示#outerdiv及.pimg  
	        });  
	          
	        $(outerdiv).click(function(){//再次點選淡出消失彈出層  
	            $(this).fadeOut("fast");  
	        });  
	    }  
	    
	    
	    
	    
	    
	    
	    
	    var MyPoint = "/NotifyWS/${teacherVO.tchrno}";
		var host = window.location.host;
		var path = window.location.pathname;
		var webCtx = path.substring(0, path.indexOf('/', 1));
		var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;

		var statusOutput = document.getElementById("statusOutput");
		var messagesArea = document.getElementById("messagesArea");
		var self = '${userName}';
		var webSocket;

		function connect() {
			// create a websocket
			webSocket = new WebSocket(endPointURL);

			webSocket.onopen = function(event) {
				console.log("Connect Success!");
				document.getElementById('sendMessage').disabled = false;
				document.getElementById('connect').disabled = true;
				document.getElementById('disconnect').disabled = false;
			};

			webSocket.onmessage = function(event) {
				var jsonObj = JSON.parse(event.data);
				if ("open" === jsonObj.type) {
					refreshFriendList(jsonObj);
				} else if ("history" === jsonObj.type) {
					messagesArea.innerHTML = '';
					var ul = document.createElement('ul');
					ul.id = "area";
					messagesArea.appendChild(ul);
					// 這行的jsonObj.message是從redis撈出跟好友的歷史訊息，再parse成JSON格式處理
					var messages = JSON.parse(jsonObj.message);
					for (var i = 0; i < messages.length; i++) {
						var historyData = JSON.parse(messages[i]);
						var showMsg = historyData.message;
						var li = document.createElement('li');
						// 根據發送者是自己還是對方來給予不同的class名, 以達到訊息左右區分
						historyData.sender === self ? li.className += 'me' : li.className += 'friend';
						li.innerHTML = showMsg;
						ul.appendChild(li);
					}
					messagesArea.scrollTop = messagesArea.scrollHeight;
				} else if ("chat" === jsonObj.type) {
					var li = document.createElement('li');
					jsonObj.sender === self ? li.className += 'me' : li.className += 'friend';
					li.innerHTML = jsonObj.message;
					console.log(li);
					document.getElementById("area").appendChild(li);
					messagesArea.scrollTop = messagesArea.scrollHeight;
				} else if ("close" === jsonObj.type) {
					refreshFriendList(jsonObj);
				}
				
			};

			webSocket.onclose = function(event) {
				console.log("Disconnected!");
			};
		}
		
		function sendMessage() {
			var inputMessage = document.getElementById("message");
			var friend = statusOutput.textContent;
			var message = inputMessage.value.trim();

			if (message === "") {
				alert("Input a message");
				inputMessage.focus();
			} else if (friend === "") {
				alert("Choose a friend");
			} else {
				var jsonObj = {
					"type" : "chat",
					"sender" : self,
					"receiver" : friend,
					"message" : message
				};
				webSocket.send(JSON.stringify(jsonObj));
				inputMessage.value = "";
				inputMessage.focus();
			}
		}
		
		// 有好友上線或離線就更新列表
		function refreshFriendList(jsonObj) {
			var friends = jsonObj.users;
			var row = document.getElementById("row");
			row.innerHTML = '';
			for (var i = 0; i < friends.length; i++) {
				if (friends[i] === self) { continue; }
				row.innerHTML +='<div id=' + i + ' class="column" name="friendName" value=' + friends[i] + ' ><h2>' + friends[i] + '</h2></div>';
			}
			addListener();
		}
		// 註冊列表點擊事件並抓取好友名字以取得歷史訊息
		function addListener() {
			var container = document.getElementById("row");
			container.addEventListener("click", function(e) {
				var friend = e.srcElement.textContent;
				updateFriendName(friend);
				var jsonObj = {
						"type" : "history",
						"sender" : self,
						"receiver" : friend,
						"message" : ""
					};
				webSocket.send(JSON.stringify(jsonObj));
			});
		}
		
		function disconnect() {
			webSocket.close();
			document.getElementById('sendMessage').disabled = true;
			document.getElementById('connect').disabled = false;
			document.getElementById('disconnect').disabled = true;
		}
		
		function updateFriendName(name) {
			statusOutput.innerHTML = name;
		}
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	
	
	
	
	
	</script>
</body>
</html>

