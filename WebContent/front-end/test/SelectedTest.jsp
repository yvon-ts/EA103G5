  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>

<c:if test="${not empty errorMsgs}">
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
	<ul>
	 	<li><form action='<%= request.getContextPath()%>/question/questionTest.do' method='post'>
        <select name='level'>
            <option value="-1">請選擇考題難易度</option>
            <option value="simple">簡單</option>
            <option value="medium">中等</option>
            <option value="hard">困難</option>
        </select>
        
        <input type="hidden" name="action" value="printPaper">
        <input type="submit" value='生成考卷'>
    	</form></li>
    	
    	<li>
    		<a href='<%= request.getContextPath()%>/front-end/test/ListAllTestRecord.jsp'>查看</a>考試紀錄<br><br>
    	</li>
    </ul>
    
</body>
</html>