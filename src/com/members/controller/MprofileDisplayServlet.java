package com.members.controller;

import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.DataSource;

import com.course_assess.controller.ImageUtil;


public class MprofileDisplayServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private final static String SQL = "SELECT MPROFILE FROM MEMBERS WHERE MEMNO = ?";

	Connection con;

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		
		try {
			String memno = req.getParameter("MEMNO");
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, memno);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				BufferedInputStream bin = new BufferedInputStream(rs.getBinaryStream("mprofile"));
				byte[] buf = new byte[4 * 1024 * 1024];
				int len;
				while ((len = bin.read(buf)) != -1) {
					out.write(buf, 0, len);
					out.flush();
				}
				bin.close();
			
			} else {
				res.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e);
		}
	}

	public void init() throws ServletException {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
			con = ds.getConnection();
		} catch (NamingException e) {
			throw new UnavailableException("Couldn't load OracleDriver");
		} catch (SQLException e) {
			throw new UnavailableException("Couldn't get db connection");
		}
	}

	public void destroy() {
		try {
			if (con != null) {
				con.close();
			}
		} catch (SQLException se) {
			se.printStackTrace();
		}
	}

}