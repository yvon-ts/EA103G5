package com.course.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jdbcUtil_CompositeQuery.*;

public class CourseDAO implements CourseDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO course(courseno, cstypeno, tchrno, coursename, courseinfo, courseprice, ttltime, csscore, csscoretimes,courseimg,courlmod) VALUES ('COUR' || LPAD(SEQ_CS.NEXTVAL, 4, 0), ?, ?, ?, ?, ?, ?, ?, ?, ? , CURRENT_TIMESTAMP)";
	private static final String GET_ALL_FOR_EMPLOYEE_STMT = "SELECT courseno, cstypeno, tchrno, coursename, courseinfo, courseprice, ttltime, csstatus, csscore, csscoretimes ,courseimg ,courlmod FROM course order by courseno";
	private static final String GET_ALL_FOR_USER_STMT = "SELECT courseno, cstypeno, tchrno, coursename, courseinfo, courseprice, ttltime, csstatus, csscore, csscoretimes ,courseimg ,courlmod FROM course order by courlmod desc";

	private static final String GET_ONE_STMT = "SELECT courseno, cstypeno, tchrno, coursename, courseinfo, courseprice, ttltime, csstatus, csscore, csscoretimes ,courseimg ,courlmod FROM course where courseno = ?";
	private static final String UPDATE = "UPDATE course set cstypeno=?, tchrno=?, coursename=?, courseinfo=?, courseprice=?, ttltime=?, csstatus=?, csscore=?, csscoretimes=? , courseimg=? , courlmod=CURRENT_TIMESTAMP where courseno = ?";
	private static final String UPDATE_NO_PICTURE = "UPDATE course set cstypeno=?, tchrno=?, coursename=?, courseinfo=?, courseprice=?, ttltime=?, csstatus=?, csscore=?, csscoretimes=? , courlmod=CURRENT_TIMESTAMP where courseno = ?";

	@Override
	public String insert(CourseVO courseVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// 掘取對應的自增主鍵值
		String next_courseno = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);

			// 指定自增主鍵
			String cols[] = { "courseno" };
			pstmt = con.prepareStatement(INSERT_STMT, cols);

			pstmt.setString(1, courseVO.getCstypeno());
			pstmt.setString(2, courseVO.getTchrno());
			pstmt.setString(3, courseVO.getCoursename());
			pstmt.setString(4, courseVO.getCourseinfo());
			pstmt.setInt(5, courseVO.getCourseprice());
			pstmt.setInt(6, courseVO.getTtltime());
			pstmt.setInt(7, courseVO.getCsscore());
			pstmt.setInt(8, courseVO.getCsscoretimes());
			pstmt.setBytes(9, courseVO.getCourseimg());

			pstmt.executeUpdate();

			// 掘取對應的自增主鍵值
			rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_courseno = rs.getString(1);
				System.out.println("自增主鍵值= " + next_courseno + "(剛新增成功的課程編號)");
			} else {
				System.out.println("未取得自增主鍵值");
			}
//			rs.close();

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
		return next_courseno;
	}

	@Override
	public void update(CourseVO courseVO) {
		update(courseVO, true);
	}

	@Override
	public void update(CourseVO courseVO, Boolean updatePicture) {// 更新

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);

			if (updatePicture) {
				pstmt = con.prepareStatement(UPDATE);

				pstmt.setString(1, courseVO.getCstypeno());
				pstmt.setString(2, courseVO.getTchrno());
				pstmt.setString(3, courseVO.getCoursename());
				pstmt.setString(4, courseVO.getCourseinfo());
				pstmt.setInt(5, courseVO.getCourseprice());
				pstmt.setInt(6, courseVO.getTtltime());
				pstmt.setString(7, courseVO.getCsstatus());
				pstmt.setInt(8, courseVO.getCsscore());
				pstmt.setInt(9, courseVO.getCsscoretimes());
				pstmt.setBytes(10, courseVO.getCourseimg());
				pstmt.setString(11, courseVO.getCourseno());
			} else {
				pstmt = con.prepareStatement(UPDATE_NO_PICTURE);

				pstmt.setString(1, courseVO.getCstypeno());
				pstmt.setString(2, courseVO.getTchrno());
				pstmt.setString(3, courseVO.getCoursename());
				pstmt.setString(4, courseVO.getCourseinfo());
				pstmt.setInt(5, courseVO.getCourseprice());
				pstmt.setInt(6, courseVO.getTtltime());
				pstmt.setString(7, courseVO.getCsstatus());
				pstmt.setInt(8, courseVO.getCsscore());
				pstmt.setInt(9, courseVO.getCsscoretimes());
				
				pstmt.setString(10, courseVO.getCourseno());
			}

			pstmt.executeUpdate();

			con.commit();
			// Handle any driver errors
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
	public CourseVO findPrimaryKey(String courseno) {// 查特定
		CourseVO courseVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, courseno);

			rs = pstmt.executeQuery();
			// SELECT courseno, cstypeno, tchrno, coursename, courseinfo,
			// courseprice, ttltime, csstatus, csscore, csscoretimes
			// FROM course where courseno = ?";
			while (rs.next()) {
				courseVO = new CourseVO();
				courseVO.setCourseno(rs.getString("courseno"));
				courseVO.setCstypeno(rs.getString("cstypeno"));
				courseVO.setTchrno(rs.getString("tchrno"));
				courseVO.setCoursename(rs.getString("coursename"));
				courseVO.setCourseinfo(rs.getString("courseinfo"));
				courseVO.setCourseprice(rs.getInt("courseprice"));
				courseVO.setTtltime(rs.getInt("ttltime"));
				courseVO.setCsstatus(rs.getString("csstatus"));
				courseVO.setCsscore(rs.getInt("csscore"));
				courseVO.setCsscoretimes(rs.getInt("csscoretimes"));
				courseVO.setCourseimg(rs.getBytes("courseimg"));
				courseVO.setCourlmod(rs.getTimestamp("courlmod"));

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
		return courseVO;
	}

	@Override
	public List<CourseVO> getAllForUser() {// 查全部 ---使用者前端預設查新的

		List<CourseVO> list = new ArrayList<CourseVO>();
		CourseVO courseVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_FOR_USER_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				courseVO = new CourseVO();
				courseVO.setCourseno(rs.getString("courseno"));
				courseVO.setCstypeno(rs.getString("cstypeno"));
				courseVO.setTchrno(rs.getString("tchrno"));
				courseVO.setCoursename(rs.getString("coursename"));
				courseVO.setCourseinfo(rs.getString("courseinfo"));
				courseVO.setCourseprice(rs.getInt("courseprice"));
				courseVO.setTtltime(rs.getInt("ttltime"));
				courseVO.setCsstatus(rs.getString("csstatus"));
				courseVO.setCsscore(rs.getInt("csscore"));
				courseVO.setCsscoretimes(rs.getInt("csscoretimes"));
				courseVO.setCourseimg(rs.getBytes("courseimg"));
				courseVO.setCourlmod(rs.getTimestamp("courlmod"));
				list.add(courseVO);
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
	public List<CourseVO> getAll(Map<String, String[]> map) { // 複合查詢

		List<CourseVO> list = new ArrayList<CourseVO>();
		CourseVO courseVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();

			String finalSQL = "select * from course " + jdbcUtil_CompositeQuery_course.get_WhereCondition(map);

			pstmt = con.prepareStatement(finalSQL);
			System.out.println(finalSQL);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				courseVO = new CourseVO();
				courseVO.setCourseno(rs.getString("courseno"));
				courseVO.setCstypeno(rs.getString("cstypeno"));
				courseVO.setTchrno(rs.getString("tchrno"));
				courseVO.setCoursename(rs.getString("coursename"));
				courseVO.setCourseinfo(rs.getString("courseinfo"));
				courseVO.setCourseprice(rs.getInt("courseprice"));
				courseVO.setTtltime(rs.getInt("ttltime"));
				courseVO.setCsstatus(rs.getString("csstatus"));
				courseVO.setCsscore(rs.getInt("csscore"));
				courseVO.setCsscoretimes(rs.getInt("csscoretimes"));
				courseVO.setCourseimg(rs.getBytes("courseimg"));
				courseVO.setCourlmod(rs.getTimestamp("courlmod"));
				list.add(courseVO);
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
	public List<CourseVO> getAllForEmployee() {
		// TODO Auto-generated method stub
		List<CourseVO> list = new ArrayList<CourseVO>();
		CourseVO courseVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_FOR_EMPLOYEE_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				courseVO = new CourseVO();
				courseVO.setCourseno(rs.getString("courseno"));
				courseVO.setCstypeno(rs.getString("cstypeno"));
				courseVO.setTchrno(rs.getString("tchrno"));
				courseVO.setCoursename(rs.getString("coursename"));
				courseVO.setCourseinfo(rs.getString("courseinfo"));
				courseVO.setCourseprice(rs.getInt("courseprice"));
				courseVO.setTtltime(rs.getInt("ttltime"));
				courseVO.setCsstatus(rs.getString("csstatus"));
				courseVO.setCsscore(rs.getInt("csscore"));
				courseVO.setCsscoretimes(rs.getInt("csscoretimes"));
				courseVO.setCourseimg(rs.getBytes("courseimg"));
				courseVO.setCourlmod(rs.getTimestamp("courlmod"));
				list.add(courseVO);
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
