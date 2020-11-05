package com.tests.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.anwser_list.model.*;

public class TestsDAO implements TestsDAO_interface {
	
	private AnwserListDAO_interface dao = null;
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	private final static String INSERT_STMT = "INSERT INTO TESTS(TESTNO,COURSENO,MEMNO,TESTSCOPE) VALUES('TEST' || LPAD(SEQ_TESTS.NEXTVAL, 4, 0),?,?,?)";// 新增考試
	private final static String FINDBYID_STMT = "SELECT * FROM TESTS WHERE TESTNO =?";// 查詢某次考試
	private final static String FINDALL_STMT = "SELECT * FROM TESTS WHERE MEMNO = ? and COURSENO = ?";// 查某會員的考試紀錄
	private final static String UPDATESCORE_STMT = "UPDATE  TESTS SET SCORE=? WHERE TESTNO=?";// 將計算後的分數放進此次的分數欄位

	@Override
	public String insert(TestsVO test) { // 新增考試
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);

			String[] col = { "TESTNO" };

			pstmt = con.prepareStatement(INSERT_STMT, col);
			pstmt.setString(1, test.getCourseno());
			pstmt.setString(2, test.getMemno());
			pstmt.setString(3, test.getTestscope());

			pstmt.executeUpdate();

			rs = pstmt.getGeneratedKeys();
			while (rs.next()) {
				sb.append(rs.getString(1));
			}

			con.commit();

		} catch (SQLException se) {
			// TODO Auto-generated catch block
			try {
				con.rollback();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if (con != null) {
					con.setAutoCommit(true);
					con.close();
				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return sb.toString();
	}

	@Override
	public TestsVO findById(String testno) { // 查詢某次考試
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		TestsVO testvo = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FINDBYID_STMT);
			pstmt.setString(1, testno);

			pstmt.executeQuery();

			rs = pstmt.getResultSet();
			while (rs.next()) {
				testvo = new TestsVO();
				testvo.setTestno(rs.getString(1));
				testvo.setCourseno(rs.getString(2));
				testvo.setMemno(rs.getString(3));
				testvo.setTestscope(rs.getString(4));
				testvo.setScore(rs.getDouble(5));
				testvo.setTesttime(rs.getTimestamp(6));
			}

		} catch (SQLException se) {
			// TODO Auto-generated catch block
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if (con != null)
					con.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return testvo;
	}

	@Override
	public List<TestsVO> findByAll(String memno,String courseno) {// 查某會員的考試紀錄
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TestsVO> list = new ArrayList<>();
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FINDALL_STMT);
			pstmt.setString(1, memno);
			pstmt.setString(2, courseno);

			pstmt.executeQuery();

			rs = pstmt.getResultSet();
			while (rs.next()) {
				TestsVO testvo = new TestsVO();
				testvo.setTestno(rs.getString(1));
				testvo.setCourseno(rs.getString(2));
				testvo.setMemno(rs.getString(3));
				testvo.setTestscope(rs.getString(4));
				testvo.setScore(rs.getDouble(5));
				testvo.setTesttime(rs.getTimestamp(6));
				list.add(testvo);
			}

		} catch (SQLException se) {
			// TODO Auto-generated catch block
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if (con != null)
					con.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	@Override
	public void updateScore(int correctNumber, String testno) { // 將計算後的分數放進此次的分數欄位
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);

			pstmt = con.prepareStatement(UPDATESCORE_STMT);
			pstmt.setDouble(1, correctNumber * 5);
			pstmt.setString(2, testno);

			pstmt.executeUpdate();
			con.commit();

		} catch (SQLException se) {
			// TODO Auto-generated catch block
			try {
				con.rollback();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {

			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if (con != null) {
					con.setAutoCommit(true);
					con.close();
				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	@Override
	public String insertToAnwserList(TestsVO test, List<AnwserListVO> list) {
		String testno =null;
		
		
		// TODO Auto-generated method stub
		dao = new AnwserListDAO();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);

			String[] col = { "TESTNO" };

			pstmt = con.prepareStatement(INSERT_STMT, col);
			pstmt.setString(1, test.getCourseno());
			pstmt.setString(2, test.getMemno());
			pstmt.setString(3, test.getTestscope());

			pstmt.executeUpdate();
			
			rs = pstmt.getGeneratedKeys();
			
			
			rs.next();
			testno = rs.getString(1);
			
			 
			for(AnwserListVO vo : list) {
				vo.setTestno(testno);
				dao.insert(vo,con);
			}
			
			con.commit();

		} catch (SQLException se) {
			// TODO Auto-generated catch block
			try {
				con.rollback();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if (con != null) {
					con.setAutoCommit(true);
					con.close();
				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return testno ;
	}
}
