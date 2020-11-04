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
import java.util.List;

public class blobToDB {
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "XDU";
	private static final String PASSWORD = "123456";
	private static final String INFO_SQL = "UPDATE LECTURE SET LECINFO = ? WHERE LECNO = ?";
	private static final String PIC_SQL = "UPDATE LECTURE SET LECPIC = ? WHERE LECNO = ?";
	private static final String SPKR_SQL = "UPDATE SPEAKER SET SPKRICON = ? WHERE SPKRNO = ?";

	public static void main(String[] args) {
		
		String[] lecinfo = {
				"一支平底鍋和長柄雨傘，再也不需要防狼噴霧劑",
				"現場示範6道法式經典料理 X 法國飲食文化分享",
				"讓一代名車閃電麥坤教您如何挑選第一台跑車",
				"跟著專業裁縫設計師一起發掘生活靈感",
				"筆記怎麼寫最省時清晰，讓你一心多用也不怕",
				"用程式建構出一個世界，需要哪些軟體和語言",
				"把插花置入辦公環境，帶來好心情和工作效率",
				"如何跨出舒適圈，用比旅行更刺激的方式面對生活",
				"自己當寵物溝通師，分享寵物與人的關係與情感建立",
				"不藏私、無業配、正港吃貨的巷弄美食清單",
				"比埋頭苦幹更快、也更快樂的秘訣全部都給你",
				"一口就能喝出幾年哪一款，到底是怎麼做到的",
				"那些股票大亨沒教你、但最該注意的投資細節"
		};
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			
			pstmt = con.prepareStatement(INFO_SQL);
			
			for (int i = 0; i < lecinfo.length; i++) {
				byte[] info = lecinfo[i].getBytes();
				if(i < 9) {
					pstmt.setBytes(1, info);
					pstmt.setString(2, "LEC000" + (i+1));
					pstmt.executeUpdate();
					System.out.println("已上傳info" + (i+1));
					}
					else {
						pstmt.setBytes(1, info);
						pstmt.setString(2, "LEC00"+ (i+1));
						pstmt.executeUpdate();
						System.out.println("已上傳info" + (i+1));
					}
				
			}
//
//			for (int i = 1; i <= 13; i++) {
//				byte[] info = getByteArray("C:/Users/Big data/Desktop/lecimg/lecinfo" + i + ".txt");
//				
//				if(i < 10) {
//				pstmt.setBytes(1, info);
//				pstmt.setString(2, "LEC000" + i);
//				pstmt.executeUpdate();
//				System.out.println("已上傳info" + i);
//				}
//				else {
//					pstmt.setBytes(1, info);
//					pstmt.setString(2, "LEC00"+ i);
//					pstmt.executeUpdate();
//					System.out.println("已上傳info" + i);
//				}
//			}
			
//			pstmt = con.prepareStatement(PIC_SQL);
//			
//			for (int i = 1; i <= 13; i++) {
//				byte[] pic = getByteArray("C:/Users/Big data/Desktop/lecimg/img" + i + ".jpg");
//				//windows: "C:/Users/Big data/Desktop/lecimg/img" + i + ".jpg"
//				//mac: "/Users/yvon/Desktop/lecimg/img" + i + ".jpg"
//				
//				if(i < 10) {
//				pstmt.setBytes(1, pic);
//				pstmt.setString(2, "LEC000"+ i);
//				pstmt.executeUpdate();
//				System.out.println("已上傳lecpic" + i);
//				} else {
//					pstmt.setBytes(1, pic);
//					pstmt.setString(2, "LEC00"+ i);
//					pstmt.executeUpdate();
//					System.out.println("已上傳lecpic" + i);
//				}
//			}
			
//			pstmt = con.prepareStatement(SPKR_SQL);
//			for (int i = 1; i <= 10; i++) {
//			byte[] pic = getByteArray("C:/Users/Big data/Desktop/lecimg/spkr" + i + ".jpg");
//			if(i < 10) {
//			pstmt.setBytes(1, pic);
//			pstmt.setString(2, "SPKR000"+ i);
//			pstmt.executeUpdate();
//			System.out.println("已上傳spkr" + i);
//			} else {
//				pstmt.setBytes(1, pic);
//				pstmt.setString(2, "SPKR00"+ i);
//				pstmt.executeUpdate();
//				System.out.println("已上傳spkr" + i);
//			}
//			}
		
		} catch (ClassNotFoundException ce) {
			System.out.println(ce);
		} catch (SQLException se) {
			System.out.println(se);
		}
//		} catch (IOException ie) {
//			System.out.println(ie);
//		} finally {
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
	//}

	public static InputStream getPictureStream(String path) throws IOException {
		File file = new File(path);
		FileInputStream fis = new FileInputStream(file);
		return fis;
	}

	public static byte[] getByteArray(String path) throws IOException {
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
