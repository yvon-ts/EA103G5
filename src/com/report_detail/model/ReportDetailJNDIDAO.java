package com.report_detail.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;



public class ReportDetailJNDIDAO implements ReportDetailDAO_interface {
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	private static final String INSERT_STMT = "INSERT INTO REPORT_DETAIL(REPORTNO, MEMNO, POSTNO, EMPNO, REPORTLMOD = CURRENT_TIMESTAMP)"
			+ "VALUES ('REPO'|| LPAD(SEQ_REPORTNO.NEXTVAL, 4, 0), ?, ?, ?)";
	// poststatus 狀態更新 (未處理 (預設?)、不隱藏、隱藏)
	private static final String UPDATE_STMT = "UPDATE REPORT_DETAIL SET POSTSTATUS = '隱藏', REPORTLMOD = CURRENT_TIMESTAMP WHERE REPORTNO = ?";
	private static final String GET_ALL_STMT = "SELECT REPORTNO, MEMNO, POSTNO, POSTSTATUS, EMPNO, REPORTLMOD FROM REPORT_DETAIL ORDER BY REPORTNO";
	private static final String GET_ONE_STMT = "SELECT REPORTNO, MEMNO, POSTNO, POSTSTATUS, EMPNO, REPORTLMOD FROM REPORT_DETAIL WHERE REPORTNO = ?";
	private static final String GET_MEMNO = "SELECT * FROM REPORT_DETAIL WHERE MEMNO = ?";
	private static final String GET_EMPNO = "SELECT * FROM REPORT_DETAIL WHERE EMPNO = ?";
	private static final String GET_PENDING_REPORT = "SELECT REPORTNO, MEMNO, POSTNO, POSTSTATUS, EMPNO, REPORTLMOD FROM REPORT_DETAIL WHERE POSTSTATUS ='未處理' ORDER BY REPORTNO";
	private static final String REMOVE_REPORT = "UPDATE REPORT_DETAIL SET POSTSTATUS = '不隱藏', REPORTLMOD = CURRENT_TIMESTAMP WHERE REPORTNO = ?";
	private static final String DELETE_REPORT = "DELETE FROM REPORT_DETAIL REPORTNO = ?";
	private static final String GET_SETTLED_REPORT = "SELECT REPORTNO, MEMNO, POSTNO, POSTSTATUS, EMPNO, REPORTLMOD FROM REPORT_DETAIL WHERE POSTSTATUS ='隱藏' OR POSTSTATUS = '不隱藏' ORDER BY REPORTNO";
	@Override
	public ReportDetailVO insert(ReportDetailVO reportdetailVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String reportno = null;
		try {

			con = ds.getConnection();
			con.setAutoCommit(false);
			String col[] = { "reportno" };
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, reportdetailVO.getMemno());
			pstmt.setString(2, reportdetailVO.getPostno());
			pstmt.setString(3, reportdetailVO.getEmpno());

			pstmt.executeUpdate();
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				reportno = rs.getString(1);
				reportdetailVO.setReportno(reportno);
				System.out.println("自增主鍵" + reportno);
			}
			con.commit();
			return reportdetailVO;
			// Handle any SQL errors
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public void update(ReportDetailVO reportdetailVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, reportdetailVO.getPoststatus());
			pstmt.setString(2, reportdetailVO.getReportno());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public ReportDetailVO findByPrimaryKey(String reportno) {

		ReportDetailVO reportdetailVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, reportno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// reportdetailVO 也稱為 Domain objects
				reportdetailVO = new ReportDetailVO();

				reportdetailVO.setReportno(rs.getString("reportno"));
				reportdetailVO.setMemno(rs.getString("memno"));
				reportdetailVO.setPostno(rs.getString("postno"));
				reportdetailVO.setPoststatus(rs.getString("poststatus"));
				reportdetailVO.setEmpno(rs.getString("empno"));
				reportdetailVO.setReportlmod(rs.getTimestamp("reportlmod"));
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
		return reportdetailVO;
	}

	@Override
	public List<ReportDetailVO> getAll() {
		List<ReportDetailVO> list = new ArrayList<ReportDetailVO>();
		ReportDetailVO reportdetailVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// reportdetailVO 也稱為 Domain objects
				reportdetailVO = new ReportDetailVO();
				reportdetailVO.setReportno(rs.getString("reportno"));
				reportdetailVO.setMemno(rs.getString("memno"));
				reportdetailVO.setPostno(rs.getString("postno"));
				reportdetailVO.setPoststatus(rs.getString("poststatus"));
				reportdetailVO.setEmpno(rs.getString("empno"));
				reportdetailVO.setReportlmod(rs.getTimestamp("reportlmod"));

				list.add(reportdetailVO); // Store the row in the list

				
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
	public List<ReportDetailVO> findByMemno(String memno) {
		List<ReportDetailVO> list = new ArrayList<ReportDetailVO>();
		ReportDetailVO reportdetailVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_MEMNO);
			pstmt.setString(1, memno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// reportdetailVO 也稱為 Domain objects
				reportdetailVO = new ReportDetailVO();
				reportdetailVO.setReportno(rs.getString("reportno"));
				reportdetailVO.setMemno(rs.getString("memno"));
				reportdetailVO.setPostno(rs.getString("postno"));
				reportdetailVO.setPoststatus(rs.getString("poststatus"));
				reportdetailVO.setEmpno(rs.getString("empno"));
				reportdetailVO.setReportlmod(rs.getTimestamp("reportlmod"));

				list.add(reportdetailVO); // Store the row in the list

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
	public List<ReportDetailVO> findByEmpno(String empno) {
		List<ReportDetailVO> list = new ArrayList<ReportDetailVO>();
		ReportDetailVO reportdetailVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_EMPNO);
			pstmt.setString(1, empno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// reportdetailVO 也稱為 Domain objects
				reportdetailVO = new ReportDetailVO();
				reportdetailVO.setReportno(rs.getString("reportno"));
				reportdetailVO.setMemno(rs.getString("memno"));
				reportdetailVO.setPostno(rs.getString("postno"));
				reportdetailVO.setPoststatus(rs.getString("poststatus"));
				reportdetailVO.setEmpno(rs.getString("empno"));
				reportdetailVO.setReportlmod(rs.getTimestamp("reportlmod"));

				list.add(reportdetailVO); // Store the row in the list

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
	public List<ReportDetailVO> getPending() {
		List<ReportDetailVO> list = new ArrayList<ReportDetailVO>();
		ReportDetailVO reportdetailVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_PENDING_REPORT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// reportdetailVO 也稱為 Domain objects
				reportdetailVO = new ReportDetailVO();
				reportdetailVO.setReportno(rs.getString("reportno"));
				reportdetailVO.setMemno(rs.getString("memno"));
				reportdetailVO.setPostno(rs.getString("postno"));
				reportdetailVO.setPoststatus(rs.getString("poststatus"));
				reportdetailVO.setEmpno(rs.getString("empno"));
				reportdetailVO.setReportlmod(rs.getTimestamp("reportlmod"));

				list.add(reportdetailVO); // Store the row in the list

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
	public List<ReportDetailVO> getSettled() {
		List<ReportDetailVO> list = new ArrayList<ReportDetailVO>();
		ReportDetailVO reportdetailVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_SETTLED_REPORT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// reportdetailVO 也稱為 Domain objects
				reportdetailVO = new ReportDetailVO();
				reportdetailVO.setReportno(rs.getString("reportno"));
				reportdetailVO.setMemno(rs.getString("memno"));
				reportdetailVO.setPostno(rs.getString("postno"));
				reportdetailVO.setPoststatus(rs.getString("poststatus"));
				reportdetailVO.setEmpno(rs.getString("empno"));
				reportdetailVO.setReportlmod(rs.getTimestamp("reportlmod"));

				list.add(reportdetailVO); // Store the row in the list

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
	public void removeReport(ReportDetailVO reportdetailVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(REMOVE_REPORT);

			pstmt.setString(1, reportdetailVO.getReportno());

			pstmt.executeUpdate();
			con.commit();

			// Handle any driver errors
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public void deleteReport(ReportDetailVO reportdetailVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(DELETE_REPORT);

			pstmt.setString(1, reportdetailVO.getReportno());

			pstmt.executeUpdate();
			con.commit();

			// Handle any driver errors
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
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

}
