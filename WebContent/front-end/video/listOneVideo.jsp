<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.video.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
// 	VideoVO videoVO = (VideoVO) request.getAttribute("videoVO");
%>

<html>
<head>
<title>影片資料 - listOneVideo.jsp</title>

<style>
table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
</style>

<style>
table {
	width: 600px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
}
</style>

</head>
<body bgcolor='white'>

	<h1>影片資料 - ListOneVideo.jsp</h1>
	<p>
		<a href="<%=request.getContextPath()%>/front-end/video/select_page.jsp">回首頁</a>
	</p>

	<table>
		<tr>
			<th>影片編號</th>
			<th>課程編號</th>
			<th>範圍編號</th>
			<th>單元編號</th>
			<th>單元名稱</th>
			<th>單元長度</th>
			<th>影片內容</th>
		</tr>
		<tr>
			<td>${videoVO.videono}</td>
			<td>${videoVO.courseno}</td>
			<td>${videoVO.testscope}</td>
			<td>${videoVO.chapterno}</td>
			<td>${videoVO.chaptername}</td>
			<td>${videoVO.chapterlen}</td>
			<td>
				<video width="320" height="240" controls muted poster="<%=request.getContextPath()%>/NoData/none2.jpg">
  					<source src="<%=request.getContextPath()%>/video/VideoReaderFromDB?videono=${videoVO.videono}" type="video/mp4">
  					萬一瀏覽器未支援時顯示訊息
				</video>
			</td>
		</tr>
	</table>
	
<!-- 	<iframe width="560" height="315" src="https://www.youtube.com/embed/1n_i0JupwRA" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> -->
<!-- 	<iframe width="560" height="315" src="https://www.youtube.com/embed/1n_i0JupwRA?controls=0" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> -->

</body>
</html>