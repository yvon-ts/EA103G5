package com.question_bank.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import jdbcUtil_CompositeQuery.jdbcUtil_CompositeQuery_question;

public class QuestionBankJDBCDAO implements QuestionBankDAO_interface{
//	private static DataSource ds = null;
//	static {
//		
//		try {
//			Context ctx = new InitialContext();
//			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/XDUDB");
//		} catch (NamingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "XDU";
	String passwd = "123456";
	private static final String INSERTMULTIPLE_STMT = "INSERT INTO QUESTION_BANK VALUES('QNBK' || LPAD(SEQ_QBANK.NEXTVAL, 4, 0),?,?,?,?,?,?,?,?,?) ";
//	private static final String INSERTFULL_STMT = "INSERT INTO QUESTION_BANK(QBANKNO,COURSENO,TESTTYPENO,QUSTMT,QUANS)VALUES('QNBK' || LPAD(SEQ_QBANK.NEXTVAL, 4, 0),?,?,?,?) ";
	private static final String DELETE_STMT = "DELETE FROM QUESTION_BANK WHERE QBANKNO = ? ";
	private static final String UPDATE_STMT = "UPDATE QUESTION_BANK SET COURSENO=?,TESTTYPENO=?,QUSTMT=?,OP1=?,OP2=?,OP3=?,OP4=?,QUANS=? WHERE QBANKNO = ?";
	private static final String FINDBYNO_STMT = "SELECT * FROM QUESTION_BANK WHERE QBANKNO=? and QUSTATUS = 1 ";
	private static final String FINDALL_STMT = "SELECT * FROM QUESTION_BANK";
	private static final String FINDAREA_STMT = "SELECT * FROM QUESTION_BANK WHERE TESTTYPENO = ? and COURSENO = ? and QUSTATUS = 1  ";
	private static final String FINDALLBYCOURSENO_STMT = "SELECT * FROM QUESTION_BANK  WHERE COURSENO=? ORDER BY QBANKNO";

	@Override
	public QuestionBankVO insertQuestion(QuestionBankVO questionVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb= new StringBuilder();
		QuestionBankVO insertedvo = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			con.setAutoCommit(false);
			
			String[] col = { "QBANKNO"};
			
			pstmt = con.prepareStatement(INSERTMULTIPLE_STMT,col);
			pstmt.setString(1, questionVO.getCourseno());
			pstmt.setInt(2, questionVO.getTypeno());
			pstmt.setString(3,questionVO.getTestscope() );
			pstmt.setString(4,questionVO.getQustmt());
			pstmt.setString(5,questionVO.getOp1());
			pstmt.setString(6,questionVO.getOp2());
			pstmt.setString(7,questionVO.getOp3());
			pstmt.setString(8,questionVO.getOp4());
			pstmt.setString(9,questionVO.getQuans());
			
			
			pstmt.executeUpdate();
			
			rs = pstmt.getGeneratedKeys();
			while(rs.next()) {
				sb.append(rs.getString(1));
			}
			
			con.commit();
			
			insertedvo = this.findByNO(sb.toString());
			
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
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
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
				if(con!=null) {
					con.setAutoCommit(true);
					con.close();
				}	
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
			return insertedvo ; 
	}

	@Override
	public void delete(String qbankno) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE_STMT);
			pstmt.setString(1, qbankno);
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
	public QuestionBankVO update(QuestionBankVO questionVO) {
		// TODO Auto-generated method stub
		Connection con =  null;
		PreparedStatement pstmt = null;
		QuestionBankVO updatedVo = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(UPDATE_STMT);
			pstmt.setString(1, questionVO.getCourseno());
			pstmt.setInt(2, questionVO.getTypeno());
			pstmt.setString(3, questionVO.getTestscope() );
			pstmt.setString(4, questionVO.getQustmt());
			pstmt.setString(5, questionVO.getOp1());
			pstmt.setString(6, questionVO.getOp2());
			pstmt.setString(7, questionVO.getOp3());
			pstmt.setString(8, questionVO.getOp4());
			pstmt.setString(9, questionVO.getQuans());
			pstmt.setString(10,questionVO.getQbankno());
			
			
			pstmt.executeUpdate();
			
			updatedVo= this.findByNO(questionVO.getQbankno()) ;
					
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
		return updatedVo;
	}

	@Override
	public QuestionBankVO findByNO(String qbankno) {
		// TODO Auto-generated method stub

		Connection con =  null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		QuestionBankVO vo= null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(FINDBYNO_STMT);
			pstmt.setString(1, qbankno);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				vo = new QuestionBankVO();
				vo.setQbankno(rs.getString(1));
				vo.setCourseno(rs.getString(2));
				vo.setTypeno(rs.getInt(3));
				vo.setQustmt(rs.getString(4));
				vo.setOp1(rs.getString(5));
				vo.setOp2(rs.getString(6));
				vo.setOp3(rs.getString(7));
				vo.setOp4(rs.getString(8));
				vo.setQuans(rs.getString(9));
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
	public List<QuestionBankVO> findAll(String courseno) {
		
		List<QuestionBankVO> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QuestionBankVO vo = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userid,passwd);
			if(courseno == null) {
				pstmt = con.prepareStatement(FINDALL_STMT);
			}
			else {
				pstmt = con.prepareStatement(FINDALLBYCOURSENO_STMT);
				pstmt.setString(1, courseno);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {

				vo = new QuestionBankVO();
				vo.setQbankno(rs.getString(1));
				vo.setCourseno(rs.getString(2));
				vo.setTypeno(rs.getInt(3));
				vo.setTestscope(rs.getString(4));
				vo.setQustmt(rs.getString(5));
				vo.setOp1(rs.getString(6));
				vo.setOp2(rs.getString(7));
				vo.setOp3(rs.getString(8));
				vo.setOp4(rs.getString(9));
				vo.setQuans(rs.getString(10));
				vo.setQustatus(rs.getInt(11));
				list.add(vo);
			}

		} catch (SQLException se) {
			// TODO Auto-generated catch block

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
				if (con != null)
					con.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}
	
public List<QuestionBankVO> findArea(int testtypeno,String courseno) {
		
		List<QuestionBankVO> list = new ArrayList<>();
		Connection con =  null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		QuestionBankVO vo= null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(FINDAREA_STMT);
			pstmt.setInt(1, testtypeno);
			pstmt.setString(2, courseno);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				vo = new QuestionBankVO();
				vo.setQbankno(rs.getString(1));
				vo.setCourseno(rs.getString(2));
				vo.setTypeno(rs.getInt(3));
				vo.setQustmt(rs.getString(4));
				vo.setOp1(rs.getString(5));
				vo.setOp2(rs.getString(6));
				vo.setOp3(rs.getString(7));
				vo.setOp4(rs.getString(8));
				vo.setQuans(rs.getString(9));
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

@Override
public List<QuestionBankVO> findAll(Map<String, String[]> map) {
	List<QuestionBankVO> list = new ArrayList<QuestionBankVO>();

	QuestionBankVO QuestionBankvo = null;

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName(driver);
		con = DriverManager.getConnection(url,userid,passwd);
		String finalSQL = "select * from emp2 " + jdbcUtil_CompositeQuery_question.get_WhereCondition(map)
				+ "order by empno";
		pstmt = con.prepareStatement(finalSQL);
		System.out.println("●●finalSQL(by DAO) = " + finalSQL);
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
			QuestionBankvo = new QuestionBankVO();
			QuestionBankvo.setQbankno(rs.getString("QBANKNO"));
			QuestionBankvo.setCourseno(rs.getString("COURSENO"));
			QuestionBankvo.setTypeno(rs.getInt("TESTTYPENO"));
			QuestionBankvo.setTestscope(rs.getString("TESTSCOPE"));
			QuestionBankvo.setQustmt(rs.getString("QUSTMT"));
			QuestionBankvo.setOp1(rs.getString("OP1"));
			QuestionBankvo.setOp2(rs.getString("OP2"));
			QuestionBankvo.setOp3(rs.getString("OP3"));
			QuestionBankvo.setOp4(rs.getString("OP4"));
			QuestionBankvo.setQuans(rs.getString("QUANS"));
			QuestionBankvo.setQustatus(rs.getInt("QUSTATUS"));
			list.add(QuestionBankvo); // Store the row in the List
		}
		
	} catch (SQLException se) {
		throw new RuntimeException("A database error occured. " + se.getMessage());
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
	return list;
}

}
	


