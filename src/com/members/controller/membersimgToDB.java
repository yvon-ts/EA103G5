package com.members.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class membersimgToDB extends HttpServlet {
	/**
	 * 什麼都不用做 直接執行就好
	 */
	private static final long serialVersionUID = 1L;
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "XDU";
	private static final String PASSWORD = "123456";
	private static final String SQL = "UPDATE MEMBERS SET MPROFILE = ? WHERE MEMNO = ?";
	private static final String SQL2 = "UPDATE TEACHER SET TCHRCERT1 = ?,TCHRCERT2 = ? WHERE MEMNO = ?";
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Connection con = null;
		Connection con2 = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 =null;
		PrintWriter out = res.getWriter();
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/plain; charset=UTF-8");
		try {
		ServletContext ct = req.getServletContext();
	
		
		

	
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			
			pstmt = con.prepareStatement(SQL);
			
			for (int i = 1; i <= 30; i++) {
				if(i >= 10) {
					byte[] pic = getPictureByteArray(ct.getRealPath("/front-end/members/addMembers_css/images/m00" + i + ".jpg"));
					pstmt.setBytes(1, pic);
					pstmt.setString(2, "MEM00"+ i);
					pstmt.executeUpdate();
					System.out.println("已上傳" + i);
				}else {
					 byte[] pic = getPictureByteArray(ct.getRealPath("/front-end/members/addMembers_css/images/m000" + i + ".jpg"));
						//windows: "C:/Users/Big data/Desktop/lecimg/img" + i + ".jpg"
						//mac: "/Users/yvon/Desktop/lecimg/img" + i + ".jpg"
						pstmt.setBytes(1, pic);
						pstmt.setString(2, "MEM000"+ i);
						pstmt.executeUpdate();
						System.out.println("已上傳" + i);
				}
				
				}
			pstmt.close();
			con.close();
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(SQL2);
				byte[] pic1 = getPictureByteArray(ct.getRealPath("/front-end/members/addMembers_css/images/lisense" + 2 + ".jpg"));
				byte[] pic2 = getPictureByteArray(ct.getRealPath("/front-end/members/addMembers_css/images/lisense" + 3 + ".jpg"));
				pstmt.setBytes(1, pic1);
				pstmt.setBytes(2, pic2);
				pstmt.setString(3, "MEM0001");
				pstmt.executeUpdate();
				
			
			
			
			
			out.println("success!!");
			
			
		} catch (ClassNotFoundException ce) {
			System.out.println(ce);
		} catch (SQLException se) {
			System.out.println(se);
		} catch (IOException ie) {
			System.out.println(ie);
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					System.out.println(se);
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					System.out.println(se);
				}
			}
		}
	}

	public static InputStream getPictureStream(String path) throws IOException {
		File file = new File(path);
		FileInputStream fis = new FileInputStream(file);
		return fis;
	}

	public static byte[] getPictureByteArray(String path) throws IOException {
		File file = new File(path);
		FileInputStream fis = new FileInputStream(file);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buffer = new byte[8192];
		int i;
		while ((i = fis.read(buffer)) != -1) {
			baos.write(buffer, 0, i);
		}
		baos.close();
		fis.close();

		return baos.toByteArray();
	}
}
