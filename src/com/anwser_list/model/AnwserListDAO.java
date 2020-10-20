package com.anwser_list.model;

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

import com.question_bank.model.QuestionBankVO;

public class AnwserListDAO implements AnwserListDAO_interface {
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	} 
	
	private static final String INSERT_STMT = "INSERT INTO ANSWER_LIST(ANSNO,TESTNO,QBANKNO,QUNO,OPORDER,TESTANS) VALUES('ANS' || LPAD(SEQ_ANS.NEXTVAL, 4, 0),?,?,?,?,?)";//新增考題進此紀錄
	private static final String SUBMIT_STMT = "UPDATE ANSWER_LIST SET STUDENTANS=? WHERE QBANKNO=? AND TESTNO= ?"; //繳交答案
	private static final String FINDALL_STMT = "SELECT * FROM ANSWER_LIST WHERE TESTNO=?";//列出某一考卷編號所有題目
	private static final String COMPARETOANS_STMT = "SELECT COUNT(*) FROM ANSWER_LIST WHERE TESTANS=STUDENTANS AND TESTNO= ?";//比對答案
	private static final String GETONEBYQBNO_STMT = "SELECT * FROM ANSWER_LIST WHERE QBANKNO=? AND TESTNO= ?";//列出某考卷某題的紀錄
	
	@Override
	public void insert(AnwserListVO anwserListvo ,Connection con) {//新增考卷明細內容，尚無學生答案(未繳交)
		// TODO Auto-generated method stub
		PreparedStatement pstmt = null;
		try {
			
			
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1,anwserListvo.getTestno());
			pstmt.setString(2,anwserListvo.getQbankno());
			pstmt.setInt(3, anwserListvo.getQuno());
			pstmt.setString(4, anwserListvo.getOporder());
			pstmt.setString(5, anwserListvo.getTestans());
			
			pstmt.executeUpdate();
			
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-emp");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		}finally {
			try {
				if(pstmt!=null)
					pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
	}

	@Override
	public void submitAns(Map<String,String> studentAns,String testno) {//學生繳交答案紀錄
		// TODO Auto-generated method stub
		Connection con = null ;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(SUBMIT_STMT);
			
			for (String s : studentAns.keySet()) {

				pstmt.setString(1, studentAns.get(s));
				pstmt.setString(2, s);
				pstmt.setString(3, testno);

				pstmt.addBatch();
			}

			pstmt.executeBatch();
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
	public List<AnwserListVO> getByTestNO(String testno) {//查找某次測驗編號的所有內容
		List<AnwserListVO> list = new ArrayList<>();
		Connection con =  null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		AnwserListVO vo= null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FINDALL_STMT);
			pstmt.setString(1,testno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				vo = new AnwserListVO();
				vo.setAnsno(rs.getString(1));
				vo.setTestno(rs.getString(2));
				vo.setQbankno(rs.getString(3));
				vo.setQuno(rs.getInt(4));
				vo.setOporder(rs.getString(5));
				vo.setTestans(rs.getString(6));
				vo.setStudentans(rs.getString(7));
				
				list.add(vo);
			}
			
		} catch (SQLException se) {
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

	@Override
	public int compareToAns(String testno) {//比對試卷答案與學生答案
		// TODO Auto-generated method stub
		Connection con =  null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		int count = 0;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(COMPARETOANS_STMT);
			pstmt.setString(1,testno);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				count =  rs.getInt(1);
			}
			
		} catch (SQLException se) {
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
		return count;
	}

	@Override
	public AnwserListVO getOneByQBNO(String qbankno,String testno) {//取得某次考試的某一題為了重現考試紀錄
		// TODO Auto-generated method stub
		Connection con =  null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		AnwserListVO vo= null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GETONEBYQBNO_STMT);
			pstmt.setString(1,qbankno);
			pstmt.setString(2,testno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				vo = new AnwserListVO();
				vo.setAnsno(rs.getString(1));
				vo.setTestno(rs.getString(2));
				vo.setQbankno(rs.getString(3));
				vo.setQuno(rs.getInt(4));
				vo.setOporder(rs.getString(5));
				vo.setTestans(rs.getString(6));
				vo.setStudentans(rs.getString(7));
				
			}
			
		} catch (SQLException se) {
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
		return 	vo;
	}

}
