package com.lecseat.controller;

import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

import com.lecseat.model.LecseatVO;

public class QRCodeServlet extends HttpServlet {
	private static final String UPDATE_SEAT = "UPDATE LEC_SEAT SET SEATSTATUS = '已報到' WHERE (LODRNO = ? AND SEATNO = ?)";
	Connection con;

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		System.out.println("有進來QRcode Servlet");

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		
		PreparedStatement pstmt = null;

		try {
			con.setAutoCommit(false);

			String lodrno = req.getParameter("lodrno");
			String seatno = req.getParameter("seatno");
			System.out.println(lodrno + " " + seatno + "報到成功");

			pstmt = con.prepareStatement(UPDATE_SEAT);
			pstmt.setString(1, lodrno);
			pstmt.setString(2, seatno);

			pstmt.executeUpdate();
			
			con.commit();
			out.println(seatno + "報到成功");


		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			throw new RuntimeException("Database error." + se.getMessage());

		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			
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
		if (con != null) {
			try {
				con.setAutoCommit(true);
				con.close();
			} catch (Exception e) {
				e.printStackTrace(System.err);
			}
		}
	}

}
