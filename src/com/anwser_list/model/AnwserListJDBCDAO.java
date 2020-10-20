package com.anwser_list.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.question_bank.model.QuestionBankVO;

public class AnwserListJDBCDAO implements AnwserListDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "XDU";
	String passwd = "123456";

	private static final String INSERT_STMT = "INSERT INTO ANSWER_LIST(ANSNO,TESTNO,QBANKNO,QUNO,OPORDER,TESTANS) VALUES('ANS' || LPAD(SEQ_ANS.NEXTVAL, 4, 0),?,?,?,?,?)";
	private static final String SUBMIT_STMT = "UPDATE ANSWER_LIST SET STUDENTANS=? WHERE QUNO=? AND TESTNO= ?";
	private static final String FINDALL_STMT = "SELECT * FROM ANSWER_LIST WHERE TESTNO=?";
	private static final String COMPARETOANS_STMT = "SELECT COUNT(*) FROM ANSWER_LIST WHERE TESTANS=STUDENTANS AND TESTNO= ?";
	private static final String GETONEBYQBNO_STMT = "SELECT * FROM ANSWER_LIST WHERE QBANKNO= ? AND TESTNO= ?";
	
	@Override
	public void insert(AnwserListVO anwserListvo,Connection con) {
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
	public void submitAns(Map<String, String> studentAns,String testno) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(SUBMIT_STMT);

			for (String s : studentAns.keySet()) {

				pstmt.setString(1, studentAns.get(s));
				pstmt.setString(2, s);
				pstmt.setString(3,testno);

				pstmt.addBatch();
			}

			pstmt.executeBatch();

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

	}

	@Override
	public List<AnwserListVO> getByTestNO(String testno) {
		List<AnwserListVO> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		AnwserListVO vo = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(FINDALL_STMT);
			pstmt.setString(1, testno);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				vo = new AnwserListVO();
				vo.setAnsno(rs.getString(1));
				vo.setTestno(rs.getString(2));
				vo.setQbankno(rs.getString(3));
				vo.setQuno(rs.getInt(4));
				vo.setTestans(rs.getString(5));
				vo.setOporder(rs.getString(6));

				list.add(vo);
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
	public int compareToAns(String testno) {
		Connection con =  null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(COMPARETOANS_STMT);
			pstmt.setString(1,testno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				return rs.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
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
		return 0;
	}

	@Override
	public AnwserListVO getOneByQBNO(String qbankno,String testno ) {
		// TODO Auto-generated method stub
		Connection con =  null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		AnwserListVO vo= null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
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
		return 	vo;
	}

}
