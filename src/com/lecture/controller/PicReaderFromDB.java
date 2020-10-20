package com.lecture.controller;

import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

public class PicReaderFromDB extends HttpServlet {
	private static final String LOAD_LECPIC = "SELECT LECPIC FROM LECTURE WHERE LECNO = ?";
	Connection con;

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			String spkrno = req.getParameter("lecno");
			pstmt = con.prepareStatement(LOAD_LECPIC);
			pstmt.setString(1, spkrno);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream("LECPIC"));
				byte[] b = new byte[8192];
				int len;
				while ((len = in.read(b)) != -1) {
					out.write(b, 0, len);
					out.flush();
				}
				in.close();
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
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
