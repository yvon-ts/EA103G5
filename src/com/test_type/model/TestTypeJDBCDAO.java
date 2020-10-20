package com.test_type.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.question_bank.model.QuestionBankVO;

public class TestTypeJDBCDAO implements TestTypeDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "XDU";
	String passwd = "123456";
	
	private final static String INSERT_STMT = "INSERT INTO TEST_TYPE VALUES(SEQ_TSTYPE.NEXTVAL,?,?)";
	private final static String UPDATE_STMT = "UPDATE TEST_TYPE SET TESTTYPE=?,TESTDGEE=? WHERE TESTTYPENO = ?";
	private final static String FINDBYID_STMT = "SELECT * FROM TEST_TYPE WHERE TESTTYPENO =?";
	private final static String FINDALL_STMT = "SELECT * FROM TEST_TYPE ";
	
	@Override
	public void update(TestTypeVO testTypeVO) {
		// TODO Auto-generated method stub
		Connection con =  null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(UPDATE_STMT);
			pstmt.setString(1, testTypeVO.getTesttype());
			pstmt.setString(2, testTypeVO.getTestdgee());
			pstmt.setInt(3, testTypeVO.getTesttypeno());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)
					pstmt.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(con!=null)
					con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	@Override
	public void insert(TestTypeVO testTypeVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			
			
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, testTypeVO.getTesttype());
			pstmt.setString(2, testTypeVO.getTestdgee());
			
			pstmt.executeUpdate();
			
			
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)
					pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(con!=null)
					con.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	

	@Override
	public TestTypeVO findByPrimaryKey(int testtypeno) {
		Connection con =  null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		TestTypeVO vo= null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(FINDBYID_STMT);
			pstmt.setInt(1, testtypeno);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				vo = new TestTypeVO();
				vo.setTesttypeno(rs.getInt(1));
				vo.setTesttype(rs.getString(2));
				vo.setTestdgee(rs.getString(3));
			}
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)
					rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(pstmt!=null)
					pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(con!=null)
					con.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return vo;
	}

	@Override
	public List<TestTypeVO> findAll() {
		Connection con =  null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		TestTypeVO vo= null;
		List<TestTypeVO> list= new ArrayList<>();;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(FINDALL_STMT);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				vo = new TestTypeVO();
				vo.setTesttypeno(rs.getInt(1));
				vo.setTesttype(rs.getString(2));
				vo.setTestdgee(rs.getString(3));
				
				list.add(vo);
			}
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)
					rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(pstmt!=null)
					pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(con!=null)
					con.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

}
