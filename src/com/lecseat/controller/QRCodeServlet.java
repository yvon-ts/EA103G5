package com.lecseat.controller;

import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

import com.lecorder.model.*;
import com.lecture.model.*;

public class QRCodeServlet extends HttpServlet {
	private static final String UPDATE_SEAT = "UPDATE LEC_SEAT SET SEATSTATUS = '已報到' WHERE (LODRNO = ? AND SEATNO = ?)";
	private static final String UPDATE_LAYOUT = "UPDATE LEC_ORDER SET LODRSEAT = ?, LODRLMOD = ? WHERE LODRNO = ?";
	private static final String UPDATE_SIGNALL = "UPDATE LEC_ORDER SET LODRSTATUS = '已結單', LODRLMOD = ? WHERE LODRNO = ?";
	private static final String UPDATE_LEC = "UPDATE LECTURE SET CURRSEAT = ?, LECLMOD = ? WHERE LECNO = ?";
	Connection con;

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		
		PreparedStatement pstmt = null;
		int updateCount_Seats = 0;

		try {
			con.setAutoCommit(false);

			String lodrno = req.getParameter("lodrno");
			String seatno = req.getParameter("seatno");
			String newseat = req.getParameter("newseat");
			boolean signAll = false;
			if (newseat.indexOf("2") == -1)
				signAll = true;
			System.out.println(lodrno + " " + seatno + "開始報到");
			System.out.println(newseat);
			
			// 更新座位狀態
			pstmt = con.prepareStatement(UPDATE_SEAT);
			pstmt.setString(1, lodrno);
			pstmt.setString(2, seatno);

			updateCount_Seats = pstmt.executeUpdate();
			System.out.println("更新" + updateCount_Seats + "筆座位(" + seatno + "報到)");
			
			// 更新訂單座位圖
			pstmt = con.prepareStatement(UPDATE_LAYOUT);
			pstmt.setString(1, newseat);
			//get lmod
			Timestamp lodrlmod = new Timestamp(System.currentTimeMillis());
			pstmt.setTimestamp(2, lodrlmod);
			pstmt.setString(3, lodrno);
			pstmt.executeUpdate();
			System.out.println("更新" + lodrno + "訂單座位圖");
			
			if (signAll == true) {
				pstmt = con.prepareStatement(UPDATE_SIGNALL);
				//get lmod
				lodrlmod = new Timestamp(System.currentTimeMillis());
				pstmt.setTimestamp(1, lodrlmod);
				pstmt.setString(2, lodrno);
				pstmt.executeUpdate();
				System.out.println("更新" + lodrno + "狀態已結單");
			}
			
			// 從訂單取得講座編號
			LodrService lodrSvc = new LodrService();
			LodrVO lodrVO = lodrSvc.getOne(lodrno);
			String lecno = lodrVO.getLecno();
			LecService lecSvc = new LecService();
			LecVO lecVO = lecSvc.getOne(lecno);
			String oldseat = lecVO.getCurrseat();
			String head = oldseat.substring(0, newseat.indexOf("3"));
			String foot = oldseat.substring(newseat.indexOf("3") + 1);
			String newLecSeat = head + "3" + foot;
			
			// 更新講座座位圖
			pstmt = con.prepareStatement(UPDATE_LEC);
			pstmt.setString(1, newLecSeat);
			//get lmod
			Timestamp leclmod = new Timestamp(System.currentTimeMillis());
			pstmt.setTimestamp(2, leclmod);
			pstmt.setString(3, lecno);
			pstmt.executeUpdate();
			System.out.println("更新" + lecno + "講座座位圖");
			System.out.println("原座位圖=" + oldseat);
			System.out.println("新座位圖=" + newLecSeat);
			
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
