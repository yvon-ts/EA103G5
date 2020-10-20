package com.video.controller;

import java.io.*;
import java.sql.*;
import javax.naming.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

public class VideoReaderFromDB extends HttpServlet {

	private final static String LOAD_BYTE = "SELECT video FROM video WHERE videono = ?";

	Connection con;

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

	// 尚未測試!!!!!!!
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("video/mp4");
		ServletOutputStream out = res.getOutputStream();

		try {
			String videono = req.getParameter("videono");
			PreparedStatement pstmt = con.prepareStatement(LOAD_BYTE);
			pstmt.setString(1, videono);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream("video"));
				byte[] buf = new byte[30 * 1024 * 1024]; // 8K Buffer
				int len;
				while ((len = in.read(buf)) != -1) {
					out.write(buf, 0, len);
					out.flush();
				}
				in.close();
			}
//			else {
//				// 展示預設錯誤圖片
//				InputStream in = getServletContext().getResourceAsStream("/NoData/none2.jpg");
//				byte[] b = new byte[in.available()];
//				in.read(b);
//				out.write(b);
//				in.close();
//			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
//			// 展示預設錯誤圖片
//			InputStream in = getServletContext().getResourceAsStream("/NoData/null.jpg");
//			byte[] b = new byte[in.available()];
//			in.read(b);
//			out.write(b);
//			in.close();
		}
	}

	@Override
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

	@Override
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
