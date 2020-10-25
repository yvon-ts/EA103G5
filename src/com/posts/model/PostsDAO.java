package com.posts.model;

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

public class PostsDAO implements PostsDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	private static final String INSERT_STMT = "INSERT INTO POSTS (POSTNO, SUPERPOSTNO, COURSENO, MEMNO, POSTCONTENT, POSTTIME)"
			+ "VALUES ('POST'||LPAD(SEQ_POSTNO.NEXTVAL, 4, 0), ?, ?, ?, ?, CURRENT_TIMESTAMP)";

	private static final String UPDATE_STATUS1 = "UPDATE POSTS SET ISHIDDEN = 1 WHERE POSTNO = ?"; // 更改poststatus
	private static final String UPDATE_STATUS2 = "UPDATE POSTS SET ISHIDDEN = 0 WHERE POSTNO = ?"; // 更改poststatus
	private static final String UPDATE_STMT = "UPDATE POSTS SET POSTCONTENT = ?, POSTTIME = CURRENT_TIMESTAMP WHERE POSTNO=?";// 會員修改內容
	private static final String GET_ALL_STMT = "SELECT * FROM POSTS WHERE ISHIDDEN != 1 ORDER BY POSTNO DESC";
	private static final String GET_ONE_STMT = "SELECT * FROM POSTS WHERE  ISHIDDEN != 1  AND POSTNO = ?";
	private static final String GET_MEMNO = "SELECT * FROM POSTS WHERE ISHIDDEN != 1  AND MEMNO = ?";

//	private static final String DELETE_STNT = "DELETE FROM POSTS WHERE POSTNO =?";  //給會員刪除

	@Override
	public PostsVO insert(PostsVO postsVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String postno = null;
		try {

			con = ds.getConnection();
			con.setAutoCommit(false);
			String col[] = { "postno" };
			pstmt = con.prepareStatement(INSERT_STMT, col);

			pstmt.setString(1, postsVO.getSuperpostno());
			pstmt.setString(2, postsVO.getCourseno());
			pstmt.setString(3, postsVO.getMemno());
			pstmt.setString(4, postsVO.getPostcontent());

			pstmt.executeUpdate();
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				postno = rs.getString(1);
				postsVO.setPostno(postno);
				System.out.println("自增主鍵" + postno);
			}
			con.commit();
			return postsVO;

			// Handle any SQL errors
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
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

	public void updateStatusRemove(String postno) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE_STATUS1);

			pstmt.setString(1, postno);

			pstmt.executeUpdate();
			con.commit();

			// Handle any driver errors
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public void update(PostsVO postsVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, postsVO.getPostcontent());
			pstmt.setString(2, postsVO.getPostno());

			pstmt.executeUpdate();

			con.commit();

			// Handle any driver errors
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public PostsVO findByPrimaryKey(String postno) {
		PostsVO postsVO = null;
		Connection con = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, postno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				postsVO = new PostsVO();
				postsVO.setPostno(rs.getString("postno"));
				postsVO.setSuperpostno(rs.getString("superpostno"));
				postsVO.setCourseno(rs.getString("courseno"));
				postsVO.setMemno(rs.getString("memno"));
				postsVO.setPostcontent(rs.getString("postcontent"));
				postsVO.setPosttime(rs.getTimestamp("posttime"));
				postsVO.setIshidden(rs.getInt("ishidden"));
			}
			con.commit();
			// Handle any driver errors
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
			}
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
					con.setAutoCommit(true);
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return postsVO;

	}

	@Override
	public List<PostsVO> getAll() {
		List<PostsVO> list = new ArrayList<PostsVO>();
		PostsVO postsVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				postsVO = new PostsVO();
				postsVO.setPostno(rs.getString("postno"));
				postsVO.setSuperpostno(rs.getString("superpostno"));
				postsVO.setCourseno(rs.getString("courseno"));
				postsVO.setMemno(rs.getString("memno"));
				postsVO.setPostcontent(rs.getString("postcontent"));
				postsVO.setPosttime(rs.getTimestamp("posttime"));
				postsVO.setIshidden(rs.getInt("ishidden"));
				list.add(postsVO); // Store the row in the list
			}
			con.commit();
			// Handle any driver errors
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
			}
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
					con.setAutoCommit(true);
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
	public void updateStatusAdd(String postno) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE_STATUS2);

			pstmt.setString(1, postno);

			pstmt.executeUpdate();
			con.commit();

			// Handle any driver errors
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public PostsVO findByMemno(String memno) {
		PostsVO postsVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(GET_MEMNO);

			pstmt.setString(1, memno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				postsVO = new PostsVO();
				postsVO.setPostno(rs.getString("postno"));
				postsVO.setSuperpostno(rs.getString("superpostno"));
				postsVO.setCourseno(rs.getString("courseno"));
				postsVO.setMemno(rs.getString("memno"));
				postsVO.setPostcontent(rs.getString("postcontent"));
				postsVO.setPosttime(rs.getTimestamp("posttime"));
				postsVO.setIshidden(rs.getInt("ishidden"));
			}
			con.commit();
			// Handle any driver errors
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
			}
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
					con.setAutoCommit(true);
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return postsVO;

	}

}
