package com.posts.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;



public class PostsJDBCDAO implements PostsDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userId = "XDU";
	String passwd = "123456";
	//CURRENT_TIMESTAMP
	private static final String INSERT_STMT = "INSERT INTO POSTS (POSTNO, SUPERPOSTNO, COURSENO, MEMNO, POSTCONTENT)"
			+ "VALUES ('POST'||LPAD(SEQ_POSTNO.NEXTVAL, 4, 0), ?, ?, ?, ?)";
	// private static final String DELETE_STNT = "DELETE FROM POSTS WHERE POSTNO = ?";
	private static final String UPDATE_STATUS1 = "UPDATE POSTS SET ISHIDDEN = 1 WHERE POSTNO = ?";
	private static final String UPDATE_STATUS2 = "UPDATE POSTS SET ISHIDDEN = 0 WHERE POSTNO = ?";
	private static final String UPDATE_STMT = "UPDATE POSTS SET POSTCONTENT = ?, POSTTIME = CURRENT_TIMESTAMP WHERE POSTNO=?";
	private static final String GET_ALL_STMT = "SELECT * FROM POSTS ORDER BY POSTNO";
	private static final String GET_ONE_STMT = "SELECT * FROM POSTS WHERE POSTNO = ?";
	private static final String GET_MEMNO = "SELECT * FROM POSTS WHERE MEMNO = ?";
	
	@Override
	public PostsVO insert(PostsVO postsVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String postno = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userId, passwd);
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

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
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
	public void updateStatusRemove (String postno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userId, passwd);
			pstmt = con.prepareStatement(UPDATE_STATUS1);

			pstmt.setString(1, postno);

			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();

		} catch (SQLException se) {
			throw new RuntimeException(se.getMessage());
		}

	}

	@Override
	public void update(PostsVO postsVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userId, passwd);
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, postsVO.getPostcontent());
			pstmt.setString(2, postsVO.getPostno());
			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
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
	public PostsVO findByPrimaryKey(String postno) {

		PostsVO postsVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userId, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, postno);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// postsVo 也稱為 Domain objects
				postsVO = new PostsVO();
				postsVO.setPostno(rs.getString("postno"));
				postsVO.setSuperpostno(rs.getString("superpostno"));
				postsVO.setCourseno(rs.getString("courseno"));
				postsVO.setMemno(rs.getString("memno"));
				postsVO.setPostcontent(rs.getString("postcontent"));
				postsVO.setPosttime(rs.getTimestamp("posttime"));

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

			Class.forName(driver);
			con = DriverManager.getConnection(url, userId, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// postsVO 也稱為 Domain objects

				postsVO = new PostsVO();
				postsVO.setPostno(rs.getString("postno"));
				postsVO.setSuperpostno(rs.getString("superpostno"));
				postsVO.setCourseno(rs.getString("courseno"));
				postsVO.setMemno(rs.getString("memno"));
				postsVO.setPostcontent(rs.getString("postcontent"));
				postsVO.setPosttime(rs.getTimestamp("posttime"));

				list.add(postsVO); // Store the row in the list
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
	@Override
	public void updateStatusAdd(String postno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userId, passwd);
			pstmt = con.prepareStatement(UPDATE_STATUS2);

			pstmt.setString(1, postno);

			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();

		} catch (SQLException se) {
			throw new RuntimeException(se.getMessage());
		}

	
		
	}

	@Override
	public PostsVO findByMemno(String memno) {
		PostsVO postsVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userId, passwd);
			pstmt = con.prepareStatement(GET_MEMNO);

			pstmt.setString(1, memno);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// postsVo 也稱為 Domain objects
				postsVO = new PostsVO();
				postsVO.setPostno(rs.getString("postno"));
				postsVO.setSuperpostno(rs.getString("superpostno"));
				postsVO.setCourseno(rs.getString("courseno"));
				postsVO.setMemno(rs.getString("memno"));
				postsVO.setPostcontent(rs.getString("postcontent"));
				postsVO.setPosttime(rs.getTimestamp("posttime"));

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

		return postsVO;
	
	}

//	public static void main(String[] args) {
//
//		PostsJDBCDAO dao = new PostsJDBCDAO();

		// 新增
//		PostsVO postsVO1 = new PostsVO();
//		
//		postsVO1.setSuperpostno("POST0001");
//		postsVO1.setCourseno("COUR0002");
//		postsVO1.setMemno("MEM0002");
//		postsVO1.setPostcontent("123456");
//		dao.insert(postsVO1);

//		// 修改
//		PostsVO postsVO2 = new PostsVO();
//		postsVO2.setPostno("POST0003");
//		postsVO2.setPostcontent("4321567");
//		dao.update(postsVO2);
//
//		// 刪除
//		dao.delete("POST0003");
//
//		// 查詢
//		PostsVO postsVO3 = dao.findByPrimaryKey("POST0001");
//		System.out.print(postsVO3.getPostno() + ",");
//		System.out.print(postsVO3.getSuperpostno() + ",");
//		System.out.print(postsVO3.getCourseno() + ",");
//		System.out.print(postsVO3.getMemno() + ",");
//		System.out.print(postsVO3.getPostcontent() + "," );
//		System.out.print(postsVO3.getPosttime() + "\n" );
//		System.out.println("---------------------");

//
//		// 查詢
//		List<PostsVO> list = dao.getAll();
//		for (PostsVO postsVO4 : list) {
//			System.out.print(postsVO4.getPostno() + ",");
//			System.out.print(postsVO4.getSuperpostno() + ",");
//			System.out.print(postsVO4.getCourseno() + ",");
//			System.out.print(postsVO4.getMemno() + ",");
//			System.out.print(postsVO4.getPostcontent() + ",");
//			System.out.print(postsVO4.getPosttime() + ",");
//
//			System.out.println();
		}

	

	
	
	

