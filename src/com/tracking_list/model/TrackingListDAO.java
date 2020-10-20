package com.tracking_list.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.report_detail.model.ReportDetailVO;

public class TrackingListDAO implements TrackingListDAO_interface {
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	private static final String INSERT_STMT = "INSERT INTO TRACKING_LIST (MEMNO, COURSENO) VALUES (?, ?)";
	private static final String DELETE_STMT = "DELETE FROM TRACKING_LIST WHERE MEMNO = ? AND COURSENO = ?";
	private static final String GET_ALL_STMT = "SELECT MEMNO, COURSENO FROM TRACKING_LIST ORDER BY MEMNO";
	
	private static final String GETMEMTRACKING = "SELECT * FROM TRACKING_LIST WHERE MEMNO = ?";
	
	
	@Override
	public void insert(TrackingListVO trackVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, trackVO.getMemno());
			pstmt.setString(2, trackVO.getCourseno());
		

			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
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
		
	}

	@Override
	public void delete(TrackingListVO trackVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_STMT);

			pstmt.setString(1, trackVO.getMemno());
			pstmt.setString(2, trackVO.getCourseno());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
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
		
	}

	@Override
	public List<TrackingListVO> findByMemno(String memno) {
		List<TrackingListVO> list = new ArrayList<TrackingListVO>();
		TrackingListVO trackinglistVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GETMEMTRACKING);

			pstmt.setString(1, memno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// trackVO 也稱為 Domain objects
				trackinglistVO= new TrackingListVO();
				trackinglistVO.setMemno(rs.getString("memno"));
				trackinglistVO.setCourseno(rs.getString("courseno"));
			}

			// Handle any driver errors
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

	@Override
	public List<TrackingListVO> getAll() {
		List<TrackingListVO> list = new ArrayList<TrackingListVO>();
		TrackingListVO trackinglistVO;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// trackVO 也稱為 Domain objects
				trackinglistVO = new TrackingListVO();
				trackinglistVO.setMemno(rs.getString("memno"));
				trackinglistVO.setCourseno(rs.getString("courseno"));
				

				list.add(trackinglistVO); // Store the row in the list

				
			}

			// Handle any driver errors
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

}
