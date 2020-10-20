package com.course_attach.model;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;

import com.course_assess.model.Course_assessVO;


public class Course_attachDAO implements Course_attachDAO_interface{
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
	
	private static final String INSERT_STMT = "INSERT INTO COURSE_ATTACH(ATTNO,COURSENO,ATTNAME,ATTFILE) VALUES ('ATT' || LPAD(TCH_SEQ.NEXTVAL, 4, 0),?,?,?)";
	private static final String GET_ALL_STMT = "SELECT ATTNO,COURSENO,ATTNAME,ATTFILE FROM COURSE_ATTACH ORDER BY ATTNO";
	private static final String GET_ONE_STMT = "SELECT ATTNO,COURSENO,ATTNAME,ATTFILE FROM COURSE_ATTACH WHERE ATTNO = ?";
	private static final String UPDATE = "UPDATE COURSE_ATTACH SET ATTNAME=?,ATTFILE=? WHERE ATTNO =?";
	private static final String DELETE = "DELETE FROM COURSE_ATTACH WHERE ATTNO=?";


	@Override
	public void insert(Course_attachVO course_attachVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			
			pstmt.setString(1, course_attachVO.getCourseno());
			pstmt.setString(2, course_attachVO.getAttname());
			pstmt.setBytes(3, course_attachVO.getAttfile());
		

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
	public void update(Course_attachVO course_attachVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, course_attachVO.getAttname());
			pstmt.setBytes(2, course_attachVO.getAttfile());
			pstmt.setString(3, course_attachVO.getAttno());

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
	public void delete(String attno) {
		Connection con = null;
		PreparedStatement pstmt = null;		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, attno);

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
	public Course_attachVO findByPrimaryKey(String attno) {
		Course_attachVO course_attachVO =null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, attno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				course_attachVO = new Course_attachVO();
				course_attachVO.setAttno(rs.getString("attno"));
				course_attachVO.setCourseno(rs.getString("courseno"));
				course_attachVO.setAttname(rs.getString("attname"));
				course_attachVO.setAttfile(rs.getBytes("attfile"));
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
		return course_attachVO;
	}

	@Override
	public List<Course_attachVO> getAll() {
		List<Course_attachVO> list = new ArrayList<Course_attachVO>();
		Course_attachVO course_attachVO =null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				course_attachVO = new Course_attachVO();
				course_attachVO.setAttno(rs.getString("attno"));
				course_attachVO.setCourseno(rs.getString("courseno"));
				course_attachVO.setAttname(rs.getString("attname"));
				course_attachVO.setAttfile(rs.getBytes("attfile"));
				list.add(course_attachVO);
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
