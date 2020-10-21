package com.lecseat.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class LecseatDAO implements LecseatDAO_Interface{
	
	private static DataSource ds = null;
	
	private static final String INSERT_STMT = "INSERT INTO LEC_SEAT (LODRNO, SEATNO) VALUES (?, ?)";
	private static final String UPDATE_STATUS = "UPDATE LEC_SEAT SET SEATSTATUS = '取消' WHERE (SEATNO = ? AND LODRNO = ?)";
	private static final String GET_ORDER_DETAILS = "SELECT * FROM LEC_SEAT WHERE LODRNO = ?";
	
	//////////////////////////////////////////////////////////////////////////////////////////////////
	
	private static final String GETONE_STMT = "SELECT * FROM LEC_SEAT WHERE (LODRNO = ? AND LECNO = ?)";
	private static final String GETALL_STMT = "SELECT * FROM LEC_SEAT ORDER BY LODRNO";
	
	
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void insert (LecseatVO lecseatVO, Connection con) {
		
		//與訂單主檔共用連線
		PreparedStatement pstmt = null;
		
		try {
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, lecseatVO.getLodrno());
			pstmt.setString(2, lecseatVO.getSeatno());
			pstmt.executeUpdate();
			
		} catch (SQLException se) {
			if (con != null) {
				try {
					System.err.println("Transaction is being");
					System.err.println("rolled back from seat");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		}
	}
	
	@Override
	public List<LecseatVO> getOrderDetails(String lodrno) {
		
		List<LecseatVO> list = new ArrayList<LecseatVO>();
		LecseatVO lecseatVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ORDER_DETAILS);
			pstmt.setString(1, lodrno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				lecseatVO = new LecseatVO();
				lecseatVO.setLodrno(lodrno);
				lecseatVO.setSeatno(rs.getString("SEATNO"));
				lecseatVO.setSeatstatus(rs.getString("SEATSTATUS"));
				list.add(lecseatVO);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
					} catch (SQLException se) {
						se.printStackTrace();
					}
				}
			if (pstmt != null) {
				try {
				pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
		}
		return list;
	}
	
	@Override
	public void updateStatus (LecseatVO lecseatVO, Connection con) {
		
		//與訂單主檔共用連線
		PreparedStatement pstmt = null;
		
		try {
			pstmt = con.prepareStatement(UPDATE_STATUS);
			
			pstmt.setString(1, lecseatVO.getSeatno());
			pstmt.setString(2, lecseatVO.getLodrno());
			pstmt.executeUpdate();
			
		} catch (SQLException se) {
			if (con != null) {
				try {
					System.err.println("Transaction is being");
					System.err.println("rolled back from seat");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		}
		
	}
		

}
