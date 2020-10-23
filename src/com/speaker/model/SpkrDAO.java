package com.speaker.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class SpkrDAO implements SpkrDAO_Interface {
	
	private static DataSource ds = null;
		
	private static final String INSERT_STMT =
			"INSERT INTO SPEAKER (SPKRNO, SPKRNAME, SPKRPHONE, SPKREMAIL, SPKRINFO, SPKRICON)"
			+ "VALUES ('SPKR' || LPAD(SEQ_SPKRNO.NEXTVAL, 4, 0), ?, ?, ?, ?, ?)";
	private static final String UPDATE_STMT =
			"UPDATE SPEAKER SET SPKRNAME = ?, SPKRPHONE = ?, SPKREMAIL = ?, SPKRINFO = ?, SPKRICON = ? WHERE SPKRNO = ?";
	private static final String DELETE_STMT =
			"DELETE FROM SPEAKER WHERE SPKRNO = ?";
	private static final String GETONE_STMT =
			"SELECT * FROM SPEAKER WHERE SPKRNO = ?";
	private static final String GETALL_STMT =
			"SELECT * FROM SPEAKER ORDER BY SPKRNO";
	
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void insert(SpkrVO spkrVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, spkrVO.getSpkrname());
			pstmt.setString(2, spkrVO.getSpkrphone());
			pstmt.setString(3, spkrVO.getSpkremail());
			pstmt.setBytes(4, spkrVO.getSpkrinfo());
			pstmt.setBytes(5, spkrVO.getSpkricon());

			pstmt.executeUpdate();
			con.commit();
			
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			throw new RuntimeException("Database error." + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se){
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
	public void update(SpkrVO spkrVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE_STMT);
			
			pstmt.setString(1, spkrVO.getSpkrname());
			pstmt.setString(2, spkrVO.getSpkrphone());
			pstmt.setString(3, spkrVO.getSpkremail());
			pstmt.setBytes(4, spkrVO.getSpkrinfo());
			pstmt.setBytes(5, spkrVO.getSpkricon());
			pstmt.setString(6, spkrVO.getSpkrno());
			
			pstmt.executeUpdate();
			con.commit();
			
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			throw new RuntimeException("Database error." + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se){
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
	public void delete(String spkrno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(DELETE_STMT);
			
			pstmt.setString(1, spkrno);
			
			pstmt.executeUpdate();
			con.commit();
			
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			throw new RuntimeException("Database error." + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se){
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
	public SpkrVO findByPK(String spkrno) {
		
		SpkrVO spkrVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GETONE_STMT);
			
			pstmt.setString(1, spkrno);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				spkrVO = new SpkrVO();
				spkrVO.setSpkrno(rs.getString("SPKRNO"));
				spkrVO.setSpkrname(rs.getString("SPKRNAME"));
				spkrVO.setSpkrphone(rs.getString("SPKRPHONE"));
				spkrVO.setSpkremail(rs.getString("SPKREMAIL"));
				spkrVO.setSpkrinfo(rs.getBytes("SPKRINFO"));
				spkrVO.setSpkricon(rs.getBytes("SPKRICON"));
			}
			
		} catch (SQLException se) {
			throw new RuntimeException("Database error." + se.getMessage());
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
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return spkrVO;
	}
	
	@Override
	public List<SpkrVO> getAll(){
		
		List<SpkrVO> list = new ArrayList<SpkrVO>();
		SpkrVO spkrVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GETALL_STMT);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				spkrVO = new SpkrVO();
				spkrVO.setSpkrno(rs.getString("SPKRNO"));
				spkrVO.setSpkrname(rs.getString("SPKRNAME"));
				spkrVO.setSpkrphone(rs.getString("SPKRPHONE"));
				spkrVO.setSpkremail(rs.getString("SPKREMAIL"));
				spkrVO.setSpkrinfo(rs.getBytes("SPKRINFO"));
				spkrVO.setSpkricon(rs.getBytes("SPKRICON"));
				list.add(spkrVO);
			}
		} catch (SQLException se) {
			throw new RuntimeException("Database error." + se.getMessage());
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
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
}
