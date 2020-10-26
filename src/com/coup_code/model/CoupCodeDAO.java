package com.coup_code.model;

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

import com.order_master.model.OrderMasterVO;
import com.promo_detail.model.PromoDetailDAO;
import com.promo_detail.model.PromoDetailVO;

public class CoupCodeDAO implements CoupCodeDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO coup_code(coupno, memno, coupcode, discamt, coupexp) VALUES ('COUP' || LPAD(SEQ_COUP_CODE.NEXTVAL, 4, 0), ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM coup_code order by coupno";
	private static final String GET_ONE_STMT = "SELECT * FROM coup_code where coupno = ?";
	private static final String UPDATE = "UPDATE coup_code set discstatus = ? where coupno = ?";
	private static final String GET_ONE_STMT_BYNAME = "SELECT * FROM coup_code where coupcode = ?";
	private static final String GET_ONE_STMT_BYMEMBER = "SELECT * FROM coup_code where memno = ? and discstatus = 0";

	@Override
	public void insert(CoupCodeVO coupCodeVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			con = ds.getConnection();
			con.setAutoCommit(false);

			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, coupCodeVO.getMemno());
			pstmt.setString(2, coupCodeVO.getCoupcode());
			pstmt.setInt(3, coupCodeVO.getDiscamt());
			pstmt.setDate(4, coupCodeVO.getCoupexp());

			pstmt.executeUpdate();
			con.commit();

		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
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

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	@Override
	public void update(CoupCodeVO coupCodeVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, coupCodeVO.getDiscstatus());
			pstmt.setString(2, coupCodeVO.getCoupno());

			pstmt.executeUpdate();
			con.commit();

		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (con != null) {
					con.setAutoCommit(true);
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public CoupCodeVO findByPrimaryKey(String coupno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CoupCodeVO coupCodeVO = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, coupno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				coupCodeVO = new CoupCodeVO();
				coupCodeVO.setCoupno(rs.getString("coupno"));
				coupCodeVO.setCoupno(rs.getString("coupno"));
				coupCodeVO.setMemno(rs.getString("memno"));
				coupCodeVO.setCoupcode(rs.getString("coupcode"));
				coupCodeVO.setDiscamt(rs.getInt("discamt"));
				coupCodeVO.setDiscstatus(rs.getInt("discstatus"));
				coupCodeVO.setCouptime(rs.getDate("couptime"));
				coupCodeVO.setCoupexp(rs.getDate("coupexp"));
			}
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
		return coupCodeVO;
	}
	
	public CoupCodeVO findByCoupCode(String coupname) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CoupCodeVO coupCodeVO = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT_BYNAME);

			pstmt.setString(1, coupname);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				coupCodeVO = new CoupCodeVO();
				coupCodeVO.setCoupno(rs.getString("coupno"));
				coupCodeVO.setCoupno(rs.getString("coupno"));
				coupCodeVO.setMemno(rs.getString("memno"));
				coupCodeVO.setCoupcode(rs.getString("coupcode"));
				coupCodeVO.setDiscamt(rs.getInt("discamt"));
				coupCodeVO.setDiscstatus(rs.getInt("discstatus"));
				coupCodeVO.setCouptime(rs.getDate("couptime"));
				coupCodeVO.setCoupexp(rs.getDate("coupexp"));
			}
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
		return coupCodeVO;
	}

	@Override
	public List<CoupCodeVO> getAll() {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CoupCodeVO> list = new ArrayList<CoupCodeVO>();
		CoupCodeVO coupCodeVO = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				coupCodeVO = new CoupCodeVO();
				coupCodeVO.setCoupno(rs.getString("coupno"));
				coupCodeVO.setMemno(rs.getString("memno"));
				coupCodeVO.setCoupcode(rs.getString("coupcode"));
				coupCodeVO.setDiscamt(rs.getInt("discamt"));
				coupCodeVO.setDiscstatus(rs.getInt("discstatus"));
				coupCodeVO.setCouptime(rs.getDate("couptime"));
				coupCodeVO.setCoupexp(rs.getDate("coupexp"));

				list.add(coupCodeVO);
			}
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
	
	public List<CoupCodeVO> findByMemno(String memno) {

		List<CoupCodeVO> list = new ArrayList<CoupCodeVO>();
		CoupCodeVO coupCodeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT_BYMEMBER);

			pstmt.setString(1, memno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				coupCodeVO = new CoupCodeVO();
				coupCodeVO.setCoupno(rs.getString("coupno"));
				coupCodeVO.setCoupcode(rs.getString("coupcode"));
				coupCodeVO.setDiscamt(rs.getInt("discamt"));
				coupCodeVO.setCouptime(rs.getDate("couptime"));
				coupCodeVO.setCoupexp(rs.getDate("coupexp"));
				list.add(coupCodeVO);
			}
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

	public static void main(String[] args) {

		CoupCodeDAO dao = new CoupCodeDAO();
		// 新增
//		CoupCodeVO vo = new CoupCodeVO();
//		vo.setMemno("MEM0002");
//		vo.setCoupcode("NNNN-NNNN");
//		vo.setDiscamt(100);
//		vo.setCoupexp(java.sql.Date.valueOf("2020-11-20"));
//		dao.insert(vo);
//
//		// 修改
//		CoupCodeVO vo2 = new CoupCodeVO();
//		vo2.setCoupno("COUP0002");
//		vo2.setDiscstatus(0);
//		dao.update(vo2);
//
//		// 查詢單一
//		CoupCodeVO vo3 = dao.findByPrimaryKey("COUP0001");
//		System.out.print(vo3.getCoupno() + ",");
//		System.out.print(vo3.getMemno() + ",");
//		System.out.print(vo3.getCoupcode() + ",");
//		System.out.print(vo3.getDiscamt() + ",");
//		System.out.print(vo3.getDiscstatus() + ",");
//		System.out.print(vo3.getCouptime() + ",");
//		System.out.print(vo3.getCoupexp());
//		System.out.println("\n-------------------------------");
//		
//
//		// 查詢全部
//
//		List<CoupCodeVO> list = dao.getAll();
//		for (CoupCodeVO vo4 : list) {
//			
//			System.out.print(vo4.getCoupno() + ",");
//			System.out.print(vo4.getMemno() + ",");
//			System.out.print(vo4.getCoupcode() + ",");
//			System.out.print(vo4.getDiscamt() + ",");
//			System.out.print(vo4.getDiscstatus() + ",");
//			System.out.print(vo4.getCouptime() + ",");
//			System.out.println(vo4.getCoupexp());
//		}

	}

}
