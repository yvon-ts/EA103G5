

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class InitializeBLOB {
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "XDU";
	private static final String PASSWORD = "123456";
	private static final String SQL = "UPDATE video SET video = ? WHERE videono = ?";
	
	public static void main(String[] args) {
		uploadCourseImg();
		uploadVideo();
		uploadempImg();
	}
	
	public static void uploadVideo() {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement("UPDATE video SET video = ? WHERE videono = ?");

			for (int i = 1; i <= 9; i++) {
				String videoName = "VID" + ( i < 10 ? "000" + i: "00" + i );
//				byte[] pic = getUpdateFileByteArray("C:\\GD_NCKU\\EA103_javaclass\\專題用假資料\\HTML課程影片\\720P\\" + videoName + ".mp4");
//				byte[] pic = getPictureByteArray("C:\\GD_NCKU\\EA103_javaclass\\專題用假資料\\HTML課程影片\\" + videoName + ".mp4");
				byte[] video = getUpdateFileByteArray("blobpool/VideoFile/" + videoName + ".mp4");
				//windows: "C:/Users/Big data/Desktop/lecimg/img" + i + ".jpg"
				//mac: "/Users/yvon/Desktop/lecimg/img" + i + ".jpg"
				pstmt.setBytes(1, video);
				pstmt.setString(2, videoName);
				pstmt.executeUpdate();
				System.out.println(videoName + " 上傳成功");
			}
		
		} catch (SQLException se) {
			se.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
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
	
	
	public static void uploadCourseImg() {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement("UPDATE course SET courseimg = ? WHERE courseno = ?");

			for (int i = 1; i <= 16; i++) {
				String imgName = "COUR" + ( i < 10 ? "000" + i: "00" + i );
				// 超過 0099 需再另外寫
				byte[] pic = getUpdateFileByteArray("blobpool/CourseImgs/" + imgName + ".png");
				//windows: "C:/Users/Big data/Desktop/lecimg/img" + i + ".jpg"
				//mac: "/Users/yvon/Desktop/lecimg/img" + i + ".jpg"
				pstmt.setBytes(1, pic);
				pstmt.setString(2, imgName);
				pstmt.executeUpdate();
				System.out.println(imgName + " 上傳成功");
			}
		
		} catch (SQLException se) {
			System.out.println(se);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
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
	
	public static void uploadempImg() {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement("UPDATE employee SET emppic = ? WHERE empno = ?");

			for (int i = 1; i <= 7; i++) {
				String empimg = "EMP" + ( i < 10 ? "000" + i : "00" + i );
				byte[] pic = getUpdateFileByteArray("blobpool/empimg/" + empimg + ".jpg");
				pstmt.setBytes(1, pic);
				pstmt.setString(2, empimg);
				pstmt.executeUpdate();
				System.out.println(empimg + " 上傳成功");
			}
		
		} catch (SQLException se) {
			System.out.println(se);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
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
	
	
	
	
	public static byte[] getUpdateFileByteArray(String path) throws IOException {
		File file = new File(path);
		FileInputStream fis = new FileInputStream(file);
		byte[] buffer = new byte[fis.available()];
		fis.read(buffer);
		fis.close();
		return buffer;
	}

}
