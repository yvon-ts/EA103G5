<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Promo_List : Home</title>
</head>
<body>
<table id="table-1">
   <tr><td><h3>Promo_List: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>Home page</p>

<h3>資料查詢:</h3>
	
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
  <li><a href='<%=request.getContextPath()%>/back-end/Promo_List/listAllPromoList.jsp'>List</a> all Promo_List.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Promo_List/Promo_List.do" >
        <b>輸入優惠活動編號 (如PROM0001):</b>
        <input type="text" name="promono">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="promoSvc" scope="page" class="com.promo_list.model.PromoListService" />
</ul>
<h3>員工管理</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/back-end/Promo_List/addPromoList.jsp'>Add</a> a new Promo_List.</li>
</ul>

</body>
</html>