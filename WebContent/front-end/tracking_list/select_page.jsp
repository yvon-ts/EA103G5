<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>TrackingList</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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

</head>
<body bgcolor='white'>



<h3>追蹤查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='listAllTrackingFront.jsp'>List</a> all Tracking.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/posts/posts.do">
        <b>輸入欲修改貼文編號 (如POST0001):</b>
        <input type="text" name="postno">
        <input type="hidden" name="action" value="getOne_For_Update">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="postsSvc" scope="page" class="com.posts.model.PostsService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/posts/posts.do">
       <b>後台-選擇欲查詢貼文編號:</b>
       <select size="1" name="postno">
         <c:forEach var="postsVO" items="${postsSvc.all}" > 
          <option value="${postsVO.postno}">${postsVO.postno}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/posts/posts.do">
       <b>後台-選擇會員編號:</b>
       <select size="1" name="memno">
         <c:forEach var="postsVO" items="${postsSvc.all}" > 
          <option value="${postsVO.memno}">${postsVO.memno}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="findByMemno">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>
X`


<!-- <ul> -->
<!-- 	<li> -->
<%--      <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/posts/posts.do"> --%>
       
<!--        <input type="hidden" name="action" value="getOne_For_Update"> -->
<!--        <input type="submit" value="修改文章"> -->
<!--      </FORM> -->
<!--   	</li> -->
<!-- </ul> -->

<h3>前台-修改貼文</h3>
 <li> 
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/posts/posts.do">
        <h4>先給值(之後用session取)-修改貼文編號 (如POST0001):</h4>
        <input type="text" name="postno">
        <input type="hidden" name="action" value="getOne_For_Update">
        <input type="submit" value="送出">
    </FORM>
  </li>


<h3>前台-新增貼文</h3>
<ul>
  <li><a href='<%= request.getContextPath()%>/front-end/posts/addPosts.jsp'>新增留言</a></li>
</ul>

<h3>前台-移除貼文</h3>

<ul>
  <li><a href='<%= request.getContextPath()%>/front-end/posts/deletePosts.jsp'>刪除留言</a></li>
</ul>


<li> 
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/posts/posts.do">
        <h4>先給值(之後用session取)-移除貼文編號 (如POST0002):</h4>
        <input type="text" name="postno">
        <input type="hidden" name="action" value="update_Status_Remove">
        <input type="submit" value="送出">
    </FORM>
  </li>

</body>
</html>