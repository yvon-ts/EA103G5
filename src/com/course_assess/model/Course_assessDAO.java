package com.course_assess.model;

import java.sql.*;
import java.text.DecimalFormat;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;
import java.math.*;



public class Course_assessDAO implements Course_assessDAO_interface {
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "XDU";
	String passwd = "123456";
	
	private static final String INSERT_STMT = "INSERT INTO COURSE_ASSESS(ASESNO,COURSENO,MEMNO,COURSESCORE,COMMENTS) VALUES ('ASES' || LPAD(SEQ_ASESNO.NEXTVAL, 4, 0),?,?,?,?)";
	private static final String GET_ALL_STMT = "SELECT ASESNO,COURSENO,MEMNO,COURSESCORE,COMMENTS,COMMENTTIME FROM COURSE_ASSESS WHERE COURSENO = ? ORDER BY ASESNO DESC";
	private static final String GET_ONE_STMT = "SELECT ASESNO,COURSENO,MEMNO,COURSESCORE,COMMENTS,COMMENTTIME FROM COURSE_ASSESS WHERE MEMNO = ?";
	private static final String UPDATE = "UPDATE COURSE_ASSESS SET COURSESCORE=?,COMMENTS=? WHERE ASESNO =?";
	private static final String DELETE = "DELETE FROM COURSE_ASSESS WHERE ASESNO=?";
	private static final String AVG_SCORE = "SELECT courseno, AVG(COURSESCORE)  FROM COURSE_ASSESS where courseno = ? group by courseno  ";
    private static final String getAllForAjax ="select * from (select c.*,rownum r from course_assess c where c.courseno = ? ORDER BY c.ASESNO desc ) where r between ? and ?";
	

	@Override
	public void insert(Course_assessVO course_assessVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			
			pstmt.setString(1, course_assessVO.getCourseno());
			pstmt.setString(2, course_assessVO.getMemno());
			pstmt.setInt(3, course_assessVO.getCoursescore());
			pstmt.setString(4, course_assessVO.getComments());
		

			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public void update(Course_assessVO course_assessVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, course_assessVO.getCoursescore());
			pstmt.setString(2, course_assessVO.getComments());
			pstmt.setString(3, course_assessVO.getAsesno());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public void delete(String asesno) {
		Connection con = null;
		PreparedStatement pstmt = null;		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, asesno);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public String avgScore(String courseno) {
		float avg = 0f;
		String str =null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

//			con = ds.getConnection();
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);

			pstmt = con.prepareStatement(AVG_SCORE);

			pstmt.setString(1, courseno);

			rs = pstmt.executeQuery();
			if(rs.next()) {
				
				avg = rs.getFloat("AVG(COURSESCORE)");
				
			}
			   
			  DecimalFormat   fnum   =   new   DecimalFormat("##0.0");  
			   str = fnum.format(avg);      
			
			
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
				// Clean up JDBC resources
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
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
		
		
		
		
		
		return str;
	}
	
	
	
	
	
	@Override
	public Course_assessVO findByPrimaryKey(String memno) {
		Course_assessVO course_assessVO =null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, memno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				course_assessVO = new Course_assessVO();
				course_assessVO.setAsesno(rs.getString("asesno"));
				course_assessVO.setCourseno(rs.getString("courseno"));
				course_assessVO.setMemno(rs.getString("memno"));
				course_assessVO.setCoursescore(rs.getInt("coursescore"));
				course_assessVO.setComments(rs.getString("comments"));
				course_assessVO.setCommenttime(rs.getTimestamp("commenttime"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
		return course_assessVO;
	}

	@Override
	public List<Course_assessVO> getAll(String courseno) {
		List<Course_assessVO> list = new ArrayList<Course_assessVO>();
		Course_assessVO course_assessVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			pstmt.setString(1, courseno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				course_assessVO = new Course_assessVO();
				course_assessVO.setAsesno(rs.getString("asesno"));
				course_assessVO.setCourseno(rs.getString("courseno"));
				course_assessVO.setMemno(rs.getString("memno"));
				course_assessVO.setCoursescore(rs.getInt("coursescore"));
				course_assessVO.setComments(rs.getString("comments"));
				course_assessVO.setCommenttime(rs.getTimestamp("commenttime"));
				list.add(course_assessVO); // Store the row in the list
				
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
//		Course_assessDAO dao = new Course_assessDAO();
//		Course_assessService sv = new Course_assessService();
//		System.out.println(sv.avgScore("COUR0001"));
//		
//			
		}



	@Override
	public Course_assessVO checkMembers(String memno, String courseno) {
		Course_assessVO course_assessVO =null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String str=null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement("SELECT ASESNO,COURSENO,MEMNO,COURSESCORE,COMMENTS,COMMENTTIME FROM COURSE_ASSESS WHERE MEMNO = ? AND COURSENO = ?");

			pstmt.setString(1, memno);
			pstmt.setString(2, courseno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				course_assessVO = new Course_assessVO();
				course_assessVO.setAsesno(rs.getString("asesno"));
				course_assessVO.setCourseno(rs.getString("courseno"));
				course_assessVO.setMemno(rs.getString("memno"));
				course_assessVO.setCoursescore(rs.getInt("coursescore"));
				course_assessVO.setComments(rs.getString("comments"));
				course_assessVO.setCommenttime(rs.getTimestamp("commenttime"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
		return course_assessVO;
	}



	@Override
	public List<Course_assessVO> getAllForAjax(String courseno,Integer pagesize) {
		List<Course_assessVO> list = new ArrayList<Course_assessVO>();
		Course_assessVO course_assessVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
			con = ds.getConnection();
			pstmt = con.prepareStatement(getAllForAjax);
			pstmt.setString(1, courseno);
			pstmt.setInt(2, pagesize-4);
			pstmt.setInt(3, pagesize);	
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				course_assessVO = new Course_assessVO();
				course_assessVO.setAsesno(rs.getString("asesno"));
				course_assessVO.setCourseno(rs.getString("courseno"));
				course_assessVO.setMemno(rs.getString("memno"));
				course_assessVO.setCoursescore(rs.getInt("coursescore"));
				course_assessVO.setComments(rs.getString("comments"));
				course_assessVO.setCommenttime(rs.getTimestamp("commenttime"));
				list.add(course_assessVO); // Store the row in the list
				
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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


