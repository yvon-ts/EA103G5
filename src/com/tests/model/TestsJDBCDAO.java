package com.tests.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.anwser_list.model.AnwserListDAO;
import com.anwser_list.model.AnwserListDAO_interface;
import com.anwser_list.model.AnwserListVO;

public class TestsJDBCDAO implements TestsDAO_interface {
	private AnwserListDAO_interface dao = null;
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "XDU";
	String passwd = "123456";
	private final static String INSERT_STMT = "INSERT INTO TESTS(TESTNO,COURSENO,MEMNO,TESTSCOPE) VALUES('TEST' || LPAD(SEQ_TESTS.NEXTVAL, 4, 0),?,?,?)";
	private final static String FINDBYID_STMT = "SELECT * FROM TESTS WHERE TESTNO =?";
	private final static String FINDALL_STMT = "SELECT * FROM TESTS WHERE MEMNO=? ";
	private final static String UPDATESCORE_STMT = "UPDATE  TESTS SET SCORE=? WHERE TESTNO=?";

	@Override
	public String insert(TestsVO test) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sb = new StringBuilder();
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);

			String[] col = { "TESTNO" };

			pstmt = con.prepareStatement(INSERT_STMT, col);
			pstmt.setString(1, test.getCourseno());
			pstmt.setString(2, test.getMemno());
			pstmt.setString(3, test.getTestscope());

			pstmt.executeUpdate();

			ResultSet rs = pstmt.getGeneratedKeys();
			while (rs.next()) {
				sb.append(rs.getString(1));
			}

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
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
		return sb.toString();
	}

	@Override
	public TestsVO findById(String testno) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		TestsVO testvo = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	public List<TestsVO> findByAll(String memno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TestsVO> list = new ArrayList<>();
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(FINDALL_STMT);
			pstmt.setString(1, memno);

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

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	public void updateScore(int correctNumber, String testno) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATESCORE_STMT);
			pstmt.setDouble(1, correctNumber * 5);
			pstmt.setString(2, testno);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {

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
	}

	@Override
	public String  insertToAnwserList(TestsVO test, List<AnwserListVO> list) {
		// TODO Auto-generated method stub
		String testno  = null;
		dao = new AnwserListDAO();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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

			for (AnwserListVO vo : list) {
				vo.setTestno(testno);
				dao.insert(vo, con);
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
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		return  testno;
	}
}
