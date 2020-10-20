<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5" import="java.sql.*,javax.naming.*,javax.sql.DataSource"%>

    <%
    	String  qbankno = request.getParameter("qbankno");
    	String  status = request.getParameter("status");
    	Connection con = null;
    	DataSource ds = null;
    	PreparedStatement pstmt = null;
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
			con = ds.getConnection();
			
			
			pstmt = con.prepareStatement("update QUESTION_BANK set QUSTATUS = ? where QBANKNO = ?");
			pstmt.setString(1,status);
			pstmt.setString(2,qbankno);
			
			pstmt.executeUpdate();
			
			con.close();
		} catch (SQLException se) {
			// TODO Auto-generated catch block
			
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}
		response.getWriter().print("123");
    %>