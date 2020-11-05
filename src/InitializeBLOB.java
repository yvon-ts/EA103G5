
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

public class InitializeBLOB {
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "XDU";
	private static final String PASSWORD = "123456";
	private static final String SQL = "UPDATE video SET video = ? WHERE videono = ?";

	public static void main(String[] args) {
		uploadCourseImg();
		uploadVideo();
		//講座部分
		updateSpkricon();
		updateLecinfo();
		updateLecpic();
		updateSpkrinfo();
		//會員&老師證照
		uploadMembersAndTeacherCert();
		//員工
		uploadempImg();
		
	}

	private static void uploadMembersAndTeacherCert() {
		 String SQLmembers = "UPDATE MEMBERS SET MPROFILE = ? WHERE MEMNO = ?";
		 String SQLteacher = "UPDATE TEACHER SET TCHRCERT1 = ?,TCHRCERT2 = ? WHERE MEMNO = ?";
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(SQLmembers);
			for (int i = 1; i <= 30; i++) {
				if(i >= 10) {
					byte[] pic = getUpdateFileByteArray("blobpool/membersPic/m00" + i + ".jpg");
					pstmt.setBytes(1, pic);
					pstmt.setString(2, "MEM00"+ i);
					pstmt.executeUpdate();
					System.out.println("MEM00"+i+"已上傳");
				}else {
					 byte[] pic = getUpdateFileByteArray("blobpool/membersPic/m000" + i + ".jpg");
						//windows: "C:/Users/Big data/Desktop/lecimg/img" + i + ".jpg"
						//mac: "/Users/yvon/Desktop/lecimg/img" + i + ".jpg"
						pstmt.setBytes(1, pic);
						pstmt.setString(2, "MEM000"+ i);
						pstmt.executeUpdate();
						System.out.println("MEM000"+i+"已上傳");
				}
				}
			pstmt.close();
			con.close();
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(SQLteacher);
				byte[] pic1 = getUpdateFileByteArray("blobpool/membersPic/java" + 1 + ".jpg");
				byte[] pic2 = getUpdateFileByteArray("blobpool/membersPic/java" + 2 + ".jpg");
				pstmt.setBytes(1, pic1);
				pstmt.setBytes(2, pic2);
				pstmt.setString(3, "MEM0001");
				pstmt.executeUpdate();
				System.out.println("老師證照1已上傳");
				System.out.println("老師證照2已上傳");
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

	public static void uploadVideo() {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement("UPDATE video SET video = ? WHERE videono = ?");

			for (int i = 1; i <= 9; i++) {
				String videoName = "VID" + (i < 10 ? "000" + i : "00" + i);
//				byte[] pic = getUpdateFileByteArray("C:\\GD_NCKU\\EA103_javaclass\\專題用假資料\\HTML課程影片\\720P\\" + videoName + ".mp4");
//				byte[] pic = getPictureByteArray("C:\\GD_NCKU\\EA103_javaclass\\專題用假資料\\HTML課程影片\\" + videoName + ".mp4");
				byte[] video = getUpdateFileByteArray("blobpool/VideoFile/" + videoName + ".mp4");
				// windows: "C:/Users/Big data/Desktop/lecimg/img" + i + ".jpg"
				// mac: "/Users/yvon/Desktop/lecimg/img" + i + ".jpg"
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
				String imgName = "COUR" + (i < 10 ? "000" + i : "00" + i);
				// 超過 0099 需再另外寫
				byte[] pic = getUpdateFileByteArray("blobpool/CourseImgs/" + imgName + ".png");
				// windows: "C:/Users/Big data/Desktop/lecimg/img" + i + ".jpg"
				// mac: "/Users/yvon/Desktop/lecimg/img" + i + ".jpg"
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

	public static void updateLecinfo() {
		Connection con = null;
		PreparedStatement pstmt = null;

		String INFO_SQL = "UPDATE LECTURE SET LECINFO = ? WHERE LECNO = ?";

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

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(URL, USER, PASSWORD);

			pstmt = con.prepareStatement(INFO_SQL);

			for (int i = 0; i < lecinfo.length; i++) {
				byte[] info = lecinfo[i].getBytes();
				if (i < 9) {
					pstmt.setBytes(1, info);
					pstmt.setString(2, "LEC000" + (i + 1));
					pstmt.executeUpdate();
					System.out.println("已上傳info" + (i + 1));
				} else {
					pstmt.setBytes(1, info);
					pstmt.setString(2, "LEC00" + (i + 1));
					pstmt.executeUpdate();
					System.out.println("已上傳info" + (i + 1));
				}

			}
		} catch (SQLException se) {
			System.out.println(se);
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
	public static void updateLecpic() {
		Connection con = null;
		PreparedStatement pstmt = null;

		String PIC_SQL = "UPDATE LECTURE SET LECPIC = ? WHERE LECNO = ?";

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(URL, USER, PASSWORD);

			pstmt = con.prepareStatement(PIC_SQL);

			for (int i = 0; i < 13; i++) {
				byte[] pic = getUpdateFileByteArray("blobpool/lecimg/img" + (i+1) + ".jpg");
				if (i < 9) {
					pstmt.setBytes(1, pic);
					pstmt.setString(2, "LEC000" + (i + 1));
					pstmt.executeUpdate();
					System.out.println("已上傳lecpic" + (i + 1));
				} else {
					pstmt.setBytes(1, pic);
					pstmt.setString(2, "LEC00" + (i + 1));
					pstmt.executeUpdate();
					System.out.println("已上傳lecpic" + (i + 1));
				}

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
	
	public static void updateSpkrinfo() {
		Connection con = null;
		PreparedStatement pstmt = null;

		String SPKRINFO_SQL = "UPDATE SPEAKER SET SPKRINFO = ? WHERE SPKRNO = ?";

		String[] spkrinfo = {
				"【 Rapunzel | Tangled 】<br>關在高塔裡的長髮公主樂佩",
				"【 Gusteau | Ratatouille 】<br>食神餐廳主廚古斯托",
				"【 McQueen | Cars 】<br>一代名車閃電麥坤",
				"【 Edna | The Incredibles 】<br>超人特攻隊首席裁縫衣夫人",
				"【 Fear | Inside Out 】<br>住在大腦裡的驚驚",
				"【 Buzz Lightyear | Toy Story 】<br>飛向宇宙浩瀚無垠的巴斯",
				"【 Tinkerbell | Peter Pan 】<br>喜歡在彼得潘旁邊飛來飛去的小精靈",
				"【 Penelope | Wreck It Ralph 】<br>國民賽車手潘妮",
				"【 Roger | 101 Dalmatians 】<br>家裡養101隻狗的羅傑",
				"【 Officer Clawhauser | Zootopia 】<br>脖子下藏著一個甜甜圈的洪金豹",
				"【 Mike Wazowski | Monsters, Inc.】<br>張大眼睛看世界的麥克華斯基",
				"【 Alice | Alice in Wonderland】<br>微醺愛麗絲",
				"【 Russell | Up】<br>喜歡幫助老人的小羅"
				};

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(URL, USER, PASSWORD);

			pstmt = con.prepareStatement(SPKRINFO_SQL);

			for (int i = 0; i < spkrinfo.length; i++) {
				byte[] info = spkrinfo[i].getBytes();
				if (i < 9) {
					pstmt.setBytes(1, info);
					pstmt.setString(2, "SPKR000" + (i + 1));
					pstmt.executeUpdate();
					System.out.println("已上傳spkrinfo" + (i + 1));
				} else {
					pstmt.setBytes(1, info);
					pstmt.setString(2, "SPKR00" + (i + 1));
					pstmt.executeUpdate();
					System.out.println("已上傳spkrinfo" + (i + 1));
				}

			}
		} catch (SQLException se) {
			System.out.println(se);
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
	
	public static void updateSpkricon() {
		Connection con = null;
		PreparedStatement pstmt = null;

		String SPKR_SQL = "UPDATE SPEAKER SET SPKRICON = ? WHERE SPKRNO = ?";

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(URL, USER, PASSWORD);

			pstmt = con.prepareStatement(SPKR_SQL);

			for (int i = 0; i < 13; i++) {
				byte[] pic = getUpdateFileByteArray("blobpool/lecimg/spkr" + (i+1) + ".jpg");
				if (i < 9) {
					pstmt.setBytes(1, pic);
					pstmt.setString(2, "SPKR000" + (i + 1));
					pstmt.executeUpdate();
					System.out.println("已上傳spkricon" + (i + 1));
				} else {
					pstmt.setBytes(1, pic);
					pstmt.setString(2, "SPKR00" + (i + 1));
					pstmt.executeUpdate();
					System.out.println("已上傳spkricon" + (i + 1));
				}

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
