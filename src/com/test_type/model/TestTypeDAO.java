package com.test_type.model;

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

import com.question_bank.model.QuestionBankVO;

public class TestTypeDAO implements TestTypeDAO_interface {
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	} 
	
	private final static String INSERT_STMT = "INSERT INTO TEST_TYPE VALUES(SEQ_TSTYPE.NEXTVAL,?,?)";//新增題型
	private final static String UPDATE_STMT = "UPDATE TEST_TYPE SET TESTTYPE=?,TESTDGEE=? WHERE TESTTYPENO = ?";//更新題型
	private final static String FINDBYID_STMT = "SELECT * FROM TEST_TYPE WHERE TESTTYPENO =?";//查找某一題型
	private final static String FINDALL_STMT = "SELECT * FROM TEST_TYPE ";//尋找所有題型
	
	@Override
	public void update(TestTypeVO testTypeVO) {//更新題型
		// TODO Auto-generated method stub
		Connection con =  null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			
			pstmt = con.prepareStatement(UPDATE_STMT);
			pstmt.setString(1, testTypeVO.getTesttype());
			pstmt.setString(2, testTypeVO.getTestdgee());
			pstmt.setInt(3, testTypeVO.getTesttypeno());
			
			pstmt.executeUpdate();
			con.commit();
			
		}  catch (SQLException se) {
			// TODO Auto-generated catch block
			try {
				con.rollback();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
			try {
				if(pstmt!=null)
					pstmt.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(con!=null) {
					con.setAutoCommit(true);
					con.close();
				}
					
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	@Override
	public void insert(TestTypeVO testTypeVO) {//新增題型
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, testTypeVO.getTesttype());
			pstmt.setString(2, testTypeVO.getTestdgee());
			
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
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
			try {
				if(pstmt!=null)
					pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(con!=null) {
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
	public TestTypeVO findByPrimaryKey(int testtypeno) { //查找某一題型
		Connection con =  null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		TestTypeVO vo= null;
		try {
			con = ds.getConnection();
			
			pstmt = con.prepareStatement(FINDBYID_STMT);
			pstmt.setInt(1, testtypeno);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				vo = new TestTypeVO();
				vo.setTesttypeno(rs.getInt(1));
				vo.setTesttype(rs.getString(2));
				vo.setTestdgee(rs.getString(3));
			}
			
		}  catch (SQLException se) {
			// TODO Auto-generated catch block
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public List<TestTypeVO> findAll() { //尋找所有題型
		Connection con =  null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		TestTypeVO vo= null;
		List<TestTypeVO> list= new ArrayList<>();;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FINDALL_STMT);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				vo = new TestTypeVO();
				vo.setTesttypeno(rs.getInt(1));
				vo.setTesttype(rs.getString(2));
				vo.setTestdgee(rs.getString(3));
				
				list.add(vo);
			}
			
		}  catch (SQLException se) {
			// TODO Auto-generated catch block
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
