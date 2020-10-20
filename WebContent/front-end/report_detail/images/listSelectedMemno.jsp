<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.posts.model.*"%>


<%
  PostsVO postsVO = (PostsVO) request.getAttribute("postsVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>

<html>
<head>
<title>listOnePosts.jsp</title>


<style type="text/css">
table {
	border-collapse: collapse
}

td, th {
	padding: 5px 20px;
	border: 1px solid #ccc
}

th {
	background-color: #fce8e2
}
</style>

</head>
<body bgcolor='white'>



<table>
	<tr>
		<th><h4><a href="<%= request.getContextPath() %>/back-end/posts/select_page.jsp"><img src="<%= request.getContextPath() %>/back-end/posts/images/back1.gif" width="100" height="32" border="0"></a></h4></th>
		<th>文章編號</th>
		<th>父文章編號</th>
		<th>課程編號</th>
		<th>會員編號</th>
		<th>內容</th>
		<th>發布時間</th>
		
	</tr>
	<tr>
		<td><h4><a href="<%= request.getContextPath() %>/back-end/posts/select_page.jsp">回首頁</a></h4></td>
		<td><%=postsVO.getPostno()%></td>
		<td><%=postsVO.getSuperpostno()%></td>
		<td><%=postsVO.getCourseno()%></td>
		<td><%=postsVO.getMemno()%></td>
		<td><%=postsVO.getPostcontent()%></td>
		<td><%=postsVO.getPosttime()%></td>
		
	</tr>
</table>

</body>
</html>