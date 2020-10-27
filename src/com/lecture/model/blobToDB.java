package com.lecture.model;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class blobToDB {
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "XDU";
	private static final String PASSWORD = "123456";
	private static final String SQL = "UPDATE LECTURE SET LECPIC = ? WHERE LECNO = ?";

	public static void main(String[] args) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(SQL);

			for (int i = 1; i <= 10; i++) {
				byte[] pic = getPictureByteArray("C:/Users/Big data/Desktop/lecimg/img" + i + ".jpg");
				//windows: "C:/Users/Big data/Desktop/lecimg/img" + i + ".jpg"
				//mac: "/Users/yvon/Desktop/lecimg/img" + i + ".jpg"
				pstmt.setBytes(1, pic);
				pstmt.setString(2, "LEC000"+ i);
				pstmt.executeUpdate();
				System.out.println("已上傳" + i);
				if(i == 10) {
					pstmt.setBytes(1, pic);
					pstmt.setString(2, "LEC00"+ i);
					pstmt.executeUpdate();
					System.out.println("已上傳" + i);
				}
			}
		
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
