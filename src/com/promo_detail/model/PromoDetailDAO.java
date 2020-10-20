package com.promo_detail.model;

import java.sql.*;
import java.util.*;

public class PromoDetailDAO implements PromoDetailDAO_interface {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "XDU";
	String passwd = "123456";

	private static final String INSERT_STMT = "INSERT INTO promo_detail(promono, cstypeno, percentage) VALUES (?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM promo_detail order by promono";
	private static final String GET_ONE_STMT = "SELECT promono, cstypeno, percentage FROM promo_detail where promono = ? and cstypeno = ?";
	private static final String DELETE = "DELETE FROM promo_detail where promono = ? and cstypeno = ?";
	private static final String UPDATE = "UPDATE promo_detail set percentage = ? where promono = ? and cstypeno = ?";

	@Override
	public void insert(PromoDetailVO promoDetailVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, promoDetailVO.getPromono());
			pstmt.setString(2, promoDetailVO.getCstypeno());
			pstmt.setInt(3, promoDetailVO.getPercentage());

			pstmt.executeUpdate();
			con.commit();

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	public void update(PromoDetailVO promoDetailVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(2, promoDetailVO.getPromono());
			pstmt.setString(3, promoDetailVO.getCstypeno());
			pstmt.setInt(1, promoDetailVO.getPercentage());

			pstmt.executeUpdate();
			con.commit();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
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
	public void delete(String promono, String cstypeno) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, promono);
			pstmt.setString(2, cstypeno);
			pstmt.executeUpdate();
			con.commit();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
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
	public PromoDetailVO findByPrimaryKey(String promono, String cstypeno) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PromoDetailVO promoDetailVO = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, promono);
			pstmt.setString(2, cstypeno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				promoDetailVO = new PromoDetailVO();
				promoDetailVO.setPromono(rs.getString("promono"));
				promoDetailVO.setCstypeno(rs.getString("cstypeno"));
				promoDetailVO.setPercentage(rs.getInt("percentage"));
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
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
		return promoDetailVO;
	}

	@Override
	public List<PromoDetailVO> getAll() {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<PromoDetailVO> list = new ArrayList<PromoDetailVO>();
		PromoDetailVO promoDetailVO = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				promoDetailVO = new PromoDetailVO();
				promoDetailVO.setPromono(rs.getString("promono"));
				promoDetailVO.setCstypeno(rs.getString("cstypeno"));
				promoDetailVO.setPercentage(rs.getInt("percentage"));
				list.add(promoDetailVO);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
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

		PromoDetailDAO dao = new PromoDetailDAO();
		// 新增
//		PromoDetailVO vo = new PromoDetailVO();
//		vo.setPromono("PROM0001");
//		vo.setCstypeno("TYPE0002");
//		vo.setPercentage(80);
//		dao.insert(vo);

		// 修改
//		PromoDetailVO vo2 = new PromoDetailVO();
//		vo2.setPromono("PROM0001");
//		vo2.setCstypeno("TYPE0004");
//		vo2.setPercentage(50);
//		dao.update(vo2);

		// 查詢單一
//		PromoDetailVO vo3 = dao.findByPrimaryKey("PROM0001", "TYPE0002");
//		System.out.print(vo3.getPromono() + ",");
//		System.out.print(vo3.getCstypeno() + ",");
//		System.out.print(vo3.getPercentage());
//		System.out.println("\n-------------------------------");
//		

		// 查詢全部

		List<PromoDetailVO> list = dao.getAll();
		for (PromoDetailVO vo4 : list) {

			System.out.print(vo4.getPromono() + ",");
			System.out.print(vo4.getCstypeno() + ",");
			System.out.println(vo4.getPercentage());
		}

		// 刪除
//			dao.delete("PROM0001", "TYPE0002");
	}

}
