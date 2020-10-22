package com.course.controller;

import java.io.*;
import java.sql.*;
import javax.naming.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

public class CoursePictureReaderFromDB extends HttpServlet {

	private final static String LOAD_COURSE_IMAGE = "SELECT courseimg FROM course WHERE courseno = ?";

	Connection con;

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();

		try {
			String courseno = req.getParameter("courseno");
			PreparedStatement pstmt = con.prepareStatement(LOAD_COURSE_IMAGE);
			pstmt.setString(1, courseno);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				BufferedInputStream bin = new BufferedInputStream(rs.getBinaryStream("courseimg"));
				byte[] buf = new byte[4 * 1024 * 1024];
				int len;
				while ((len = bin.read(buf)) != -1) {
					out.write(buf, 0, len);
					out.flush();
				}
				bin.close();
			} 
			else {
				// 展示預設錯誤圖片
				InputStream in = getServletContext().getResourceAsStream("/front-end/course/image/CourseNoPicture.PNG");
				byte[] b = new byte[in.available()];
				in.read(b);
				out.write(b);
				in.close();
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
//			e.printStackTrace();
//			System.out.println("課程圖片錯誤");
			// 展示預設錯誤圖片
			InputStream in = getServletContext().getResourceAsStream("/front-end/course/image/CourseNoPicture.PNG");
			byte[] b = new byte[in.available()];
			in.read(b);
			out.write(b);
			in.close();
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
