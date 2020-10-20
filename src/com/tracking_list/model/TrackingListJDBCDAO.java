package com.tracking_list.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.posts.model.PostsJDBCDAO;
import com.posts.model.PostsVO;
/*
 * delete方法測試有問題 console沒跳錯 但資料庫資料沒被刪除
 * 課程編號只有一個欄位是只能加入一門課嗎?
 * 
 * */
public class TrackingListJDBCDAO implements TrackingListDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userId = "XDU";
	String passwd = "123456";

	private static final String INSERT_STMT = "INSERT INTO TRACKING_LIST (MEMNO, COURSENO) VALUES (?, ?)";
	private static final String DELETE_STMT = "DELETE FROM TRACKING_LIST WHERE MEMNO = ? AND COURSENO = ?";
	private static final String GETMEMTRACKING = "SELECT * FROM TRACKING_LIST WHERE MEMNO = ?";
	private static final String GET_ALL_STMT = "SELECT MEMNO, COURSENO FROM TRACKING_LIST ORDER BY MEMNO";
	
	@Override
	public void insert(TrackingListVO trackVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userId, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, trackVO.getMemno());
			pstmt.setString(2, trackVO.getCourseno());

			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();

		} catch (SQLException se) {
			throw new RuntimeException(se.getMessage());
		}

	}

	@Override
	public void delete(TrackingListVO trackVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userId, passwd);
			pstmt = con.prepareStatement(DELETE_STMT);

			pstmt.setString(1, trackVO.getMemno());
			pstmt.setString(2, trackVO.getCourseno());

			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();

		} catch (SQLException se) {
			throw new RuntimeException(se.getMessage());
		}

	}

	@Override
	public List<TrackingListVO> findByMemno(String memno) {
		List<TrackingListVO> list = new ArrayList<TrackingListVO>();
		TrackingListVO trackinglistVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userId, passwd);
			pstmt = con.prepareStatement(GETMEMTRACKING);

			pstmt.setString(1, memno);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				trackinglistVO= new TrackingListVO();
				trackinglistVO.setMemno(rs.getString("memno"));
				trackinglistVO.setCourseno(rs.getString("courseno"));
			}

		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();

		} catch (SQLException se) {
			throw new RuntimeException(se.getMessage());
		}

		return list;
	}

	@Override
	public List<TrackingListVO> getAll() {
		List<TrackingListVO> list = new ArrayList<TrackingListVO>();
		TrackingListVO trackinglistVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userId, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// postsVO 也稱為 Domain objects

				trackinglistVO = new TrackingListVO();
				trackinglistVO.setMemno(rs.getString("memno"));
				trackinglistVO.setCourseno(rs.getString("courseno"));
				

				list.add(trackinglistVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

		return list;
		
		
		
	
	}
	
	public static void main(String[] args) {

		TrackingListJDBCDAO dao = new TrackingListJDBCDAO();

		// 新增
//		TrackingListVO trackingVO1 = new TrackingListVO();
//		
//		trackingVO1.setMemno("MEM0006");
//		trackingVO1.setCourseno("COUR0007");
//
//		dao.insert(trackingVO1);



		// 刪除
		TrackingListVO trackingVO2 = new TrackingListVO();
		
		trackingVO2.setMemno("MEM0004");
		trackingVO2.setCourseno("COUR0001");
		
		dao.delete(trackingVO2);

//
//		// 查詢
//		TrackingListVO trackingVO3 = dao.findByMemNo("MEM0005");
//		System.out.print(trackingVO3.getMemno() + ",");
//		System.out.print(trackingVO3.getCourseno() + "\n");
//		System.out.println("---------------------");
	
	

//
//		// 查詢
//		List<TrackingListVO> list = dao.getAll();
//		for (TrackingListVO trackingVO4 : list) {
//			System.out.print(trackingVO4.getMemno() + ",");
//			System.out.print(trackingVO4.getCourseno());
//			
//
//			System.out.println();
//		}
	}
	
	

}
