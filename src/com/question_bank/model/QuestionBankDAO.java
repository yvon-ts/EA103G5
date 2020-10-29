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

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;



import jdbcUtil_CompositeQuery.jdbcUtil_CompositeQuery_question;

public class QuestionBankDAO implements QuestionBankDAO_interface {

	private static DataSource ds = null;
	static {

		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private static final String INSERTMULTIPLE_STMT = "INSERT INTO QUESTION_BANK(QBANKNO,COURSENO,TESTTYPENO,TESTSCOPE,QUSTMT,OP1,OP2,OP3,OP4,QUANS) VALUES('QNBK' || LPAD(SEQ_QBANK.NEXTVAL, 4, 0),?,?,?,?,?,?,?,?,?) ";
	private static final String DELETE_STMT = "DELETE FROM QUESTION_BANK WHERE QBANKNO = ? ";
	private static final String UPDATE_STMT = "UPDATE QUESTION_BANK SET COURSENO=?,TESTTYPENO=?,TESTSCOPE=?,QUSTMT=?,OP1=?,OP2=?,OP3=?,OP4=?,QUANS=? WHERE QBANKNO = ?";
	private static final String FINDBYNO_STMT = "SELECT * FROM QUESTION_BANK WHERE QBANKNO=? and QUSTATUS = 1";
	private static final String FINDALL_STMT = "SELECT * FROM QUESTION_BANK ORDER BY QBANKNO";
	private static final String FINDALLBYCOURSENO_STMT = "SELECT * FROM QUESTION_BANK  WHERE COURSENO=? ORDER BY QBANKNO";
	private static final String FINDAREA_STMT = "SELECT * FROM QUESTION_BANK WHERE TESTTYPENO = ? and QUSTATUS = 1 ";

	@Override
	public QuestionBankVO insertQuestion(QuestionBankVO questionVO) {// 新增題目
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		QuestionBankVO insertedvo = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);

			String[] col = { "QBANKNO" };

			pstmt = con.prepareStatement(INSERTMULTIPLE_STMT, col);
			pstmt.setString(1, questionVO.getCourseno());
			pstmt.setInt(2, questionVO.getTypeno());
			pstmt.setString(3, questionVO.getTestscope());
			pstmt.setString(4, questionVO.getQustmt());
			pstmt.setString(5, questionVO.getOp1());
			pstmt.setString(6, questionVO.getOp2());
			pstmt.setString(7, questionVO.getOp3());
			pstmt.setString(8, questionVO.getOp4());
			pstmt.setString(9, questionVO.getQuans());

			pstmt.executeUpdate();

			rs = pstmt.getGeneratedKeys();
			while (rs.next()) {
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
		return insertedvo;
	}

	@Override
	public void delete(String qbankno) {// 刪除
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);

			pstmt = con.prepareStatement(DELETE_STMT);
			pstmt.setString(1, qbankno);
			pstmt.executeUpdate();

			con.commit();

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
	public QuestionBankVO update(QuestionBankVO questionVO) {// 更新題目
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		QuestionBankVO updatedVo = null;
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);

			pstmt = con.prepareStatement(UPDATE_STMT);
			pstmt.setString(1, questionVO.getCourseno());
			pstmt.setInt(2, questionVO.getTypeno());
			pstmt.setString(3, questionVO.getTestscope());
			pstmt.setString(4, questionVO.getQustmt());
			pstmt.setString(5, questionVO.getOp1());
			pstmt.setString(6, questionVO.getOp2());
			pstmt.setString(7, questionVO.getOp3());
			pstmt.setString(8, questionVO.getOp4());
			pstmt.setString(9, questionVO.getQuans());
			pstmt.setString(10, questionVO.getQbankno());

			pstmt.executeUpdate();

			con.commit();

			updatedVo = this.findByNO(questionVO.getQbankno());

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			try {
				con.rollback();
			} catch (SQLException se) {
				// TODO Auto-generated catch block
				se.printStackTrace();
			}
			throw new RuntimeException("A database error occured. " + e.getMessage());
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if (con != null) {
					con.setAutoCommit(true);
					con.close();
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return updatedVo;
	}

	@Override
	public QuestionBankVO findByNO(String qbankno) {// 找到某題
		// TODO Auto-generated method stub

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QuestionBankVO vo = null;
		try {
			con = ds.getConnection();

			pstmt = con.prepareStatement(FINDBYNO_STMT);
			pstmt.setString(1, qbankno);

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
		return vo;
	}

	@Override
	public List<QuestionBankVO> findAll(String courseno) {// 查全部題目

		List<QuestionBankVO> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QuestionBankVO vo = null;

		try {
			con = ds.getConnection();
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

	public List<QuestionBankVO> findArea(int testtypeno) { // 找某範圍題目

		List<QuestionBankVO> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QuestionBankVO vo = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FINDAREA_STMT);
			pstmt.setInt(1, testtypeno);

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
				list.add(vo);
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
	public List<QuestionBankVO> findAll(Map<String, String[]> map) {
		// TODO Auto-generated method stub
		List<QuestionBankVO> list = new ArrayList<QuestionBankVO>();

		QuestionBankVO QuestionBankvo = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			String finalSQL = "select * from QUESTION_BANK " + jdbcUtil_CompositeQuery_question.get_WhereCondition(map)
					+ "order by QBANKNO";
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
