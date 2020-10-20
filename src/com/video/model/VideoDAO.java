package com.video.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jdbcUtil_CompositeQuery.jdbcUtil_CompositeQuery_video;

public class VideoDAO implements VideoDAO_interface {

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

	private static final String INSERT_STMT = "INSERT INTO video (videono, courseno, testscope, chapterno, chaptername, chapterlen, video) VALUES ('VID' || LPAD(SEQ_VIDEO.NEXTVAL, 4, 0), ?, ?, ?, ?, ?, ?)";
//	private static final String GET_ALL_STMT = "SELECT videono, courseno, testscope, chapterno, chaptername, chapterlen, video FROM video order by videono";
//	private static final String GET_ONE_STMT = "SELECT videono, courseno, testscope, chapterno, chaptername, chapterlen, video FROM video where videono = ?";
	private static final String DELETE = "DELETE FROM video where videono = ?";
	private static final String UPDATE = "UPDATE video set courseno=?, testscope=?, chapterno=?, chaptername=?, chapterlen=?, video=? where videono = ?";
	private static final String UPDATE_NO_FILE = "UPDATE video set courseno=?, testscope=?, chapterno=?, chaptername=? where videono = ?";

	private static final String GET_ALL_STMT = "SELECT videono, courseno, testscope, chapterno, chaptername, chapterlen FROM video order by videono";
	private static final String GET_ONE_STMT = "SELECT videono, courseno, testscope, chapterno, chaptername, chapterlen FROM video where videono = ?";

	@Override
	public void insert(VideoVO videoVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, videoVO.getCourseno());
			pstmt.setInt(2, videoVO.getTestscope());
			pstmt.setInt(3, videoVO.getChapterno());
			pstmt.setString(4, videoVO.getChaptername());
			pstmt.setInt(5, videoVO.getChapterlen());
			pstmt.setBytes(6, videoVO.getVideo());

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
	public void update(VideoVO videoVO) {
		update(videoVO ,true);
	}

	@Override
	public void update(VideoVO videoVO, Boolean updateVideoFile) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			con.setAutoCommit(false);

			if (updateVideoFile) {
				pstmt = con.prepareStatement(UPDATE);

				pstmt.setString(1, videoVO.getCourseno());
				pstmt.setInt(2, videoVO.getTestscope());
				pstmt.setInt(3, videoVO.getChapterno());
				pstmt.setString(4, videoVO.getChaptername());
				pstmt.setInt(5, videoVO.getChapterlen());
				pstmt.setBytes(6, videoVO.getVideo());
				pstmt.setString(7, videoVO.getVideono());
			} else {
				pstmt = con.prepareStatement(UPDATE_NO_FILE);

				pstmt.setString(1, videoVO.getCourseno());
				pstmt.setInt(2, videoVO.getTestscope());
				pstmt.setInt(3, videoVO.getChapterno());
				pstmt.setString(4, videoVO.getChaptername());
				
				
				pstmt.setString(5, videoVO.getVideono());
			}

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
	public void delete(String videono) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, videono);

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
	public VideoVO findByPrimaryKey(String videono) {
		VideoVO videoVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, videono);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				videoVO = new VideoVO();
				videoVO.setVideono(rs.getString("videono"));
				videoVO.setCourseno(rs.getString("courseno"));
				videoVO.setTestscope(rs.getInt("testscope"));
				videoVO.setChapterno(rs.getInt("chapterno"));
				videoVO.setChaptername(rs.getString("chaptername"));
				videoVO.setChapterlen(rs.getInt("chapterlen"));
//				videoVO.setVideo(rs.getBytes("video"));
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

		return videoVO;
	}

	@Override
	public List<VideoVO> getAll() {

		List<VideoVO> list = new ArrayList<VideoVO>();
		VideoVO videoVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				videoVO = new VideoVO();
				videoVO.setVideono(rs.getString("videono"));
				videoVO.setCourseno(rs.getString("courseno"));
				videoVO.setTestscope(rs.getInt("testscope"));
				videoVO.setChapterno(rs.getInt("chapterno"));
				videoVO.setChaptername(rs.getString("chaptername"));
				videoVO.setChapterlen(rs.getInt("chapterlen"));
//				videoVO.setVideo(rs.getBytes("video"));
				list.add(videoVO);
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

	@Override
	public List<VideoVO> getAll(Map<String, String[]> map) {
		// 萬用複合查詢

		List<VideoVO> list = new ArrayList<VideoVO>();
		VideoVO videoVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();

			String finalSQL = "select * from video " + jdbcUtil_CompositeQuery_video.get_WhereCondition(map)
					+ "order by chapterno";
			;
			pstmt = con.prepareStatement(finalSQL);
			System.out.println(finalSQL);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				videoVO = new VideoVO();
				videoVO.setVideono(rs.getString("videono"));
				videoVO.setCourseno(rs.getString("courseno"));
				videoVO.setTestscope(rs.getInt("testscope"));
				videoVO.setChapterno(rs.getInt("chapterno"));
				videoVO.setChaptername(rs.getString("chaptername"));
				videoVO.setChapterlen(rs.getInt("chapterlen"));
//				videoVO.setVideo(rs.getBytes("video"));
				list.add(videoVO);
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
