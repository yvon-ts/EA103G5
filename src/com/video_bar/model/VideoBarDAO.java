package com.video_bar.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class VideoBarDAO implements VideoBarDAO_interface {

	// JNDI version
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO video_bar (memno,videono,videosec,videottltime) VALUES (?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT memno,videono,videosec,videottltime,videolasttime FROM video_bar order by memno, videono";
	private static final String GET_ONE_STMT = "SELECT memno,videono,videosec,videottltime,videolasttime FROM video_bar WHERE memno = ? AND videono = ?";
	private static final String UPDATE = "UPDATE video_bar SET videosec=?,videottltime=?,videolasttime=CURRENT_TIMESTAMP WHERE memno = ? AND videono = ?";

	@Override
	public void insert(VideoBarVO videoBarVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, videoBarVO.getMemno());
			pstmt.setString(2, videoBarVO.getVideono());
			pstmt.setInt(3, videoBarVO.getVideosec());
			pstmt.setInt(4, videoBarVO.getVideottltime());

			pstmt.executeUpdate();
			
			con.commit();
			// Handle any SQL errors
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
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
					con.setAutoCommit(true);
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void update(VideoBarVO videoBarVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, videoBarVO.getVideosec());
			pstmt.setInt(2, videoBarVO.getVideottltime());
			pstmt.setString(3, videoBarVO.getMemno());
			pstmt.setString(4, videoBarVO.getVideono());

			pstmt.executeUpdate();

			con.commit();
			// Handle any SQL errors
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
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
					con.setAutoCommit(true);
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public VideoBarVO findByPrimaryKey(String memno, String videono) {
		VideoBarVO videoBarVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, memno);
			pstmt.setString(2, videono);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				videoBarVO = new VideoBarVO();
				videoBarVO.setMemno(rs.getString("memno"));
				videoBarVO.setVideono(rs.getString("videono"));
				videoBarVO.setVideosec(rs.getInt("videosec"));
				videoBarVO.setVideottltime(rs.getInt("videottltime"));
				videoBarVO.setVideolasttime(rs.getDate("videolasttime"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
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

		return videoBarVO;
	}

	@Override
	public List<VideoBarVO> getAll() {
		List<VideoBarVO> list = new ArrayList<VideoBarVO>();
		VideoBarVO videoBarVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();

			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				videoBarVO = new VideoBarVO();
				videoBarVO.setMemno(rs.getString("memno"));
				videoBarVO.setVideono(rs.getString("videono"));
				videoBarVO.setVideosec(rs.getInt("videosec"));
				videoBarVO.setVideottltime(rs.getInt("videottltime"));
				videoBarVO.setVideolasttime(rs.getDate("videolasttime"));
				list.add(videoBarVO);
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
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
