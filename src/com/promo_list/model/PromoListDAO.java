package com.promo_list.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.promo_detail.model.PromoDetailDAO;
import com.promo_detail.model.PromoDetailVO;

public class PromoListDAO implements PromoListDAO_interface {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "XDU";
	String passwd = "123456";

	private static final String INSERT_STMT = "INSERT INTO promo_list(promono, promoname, startdate, enddate, promoinfo) VALUES ('PROM' || LPAD(SEQ_PROM.NEXTVAL, 4, 0), ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM promo_list order by promono";
	private static final String GET_ONE_STMT = "SELECT * FROM promo_list where promono = ?";
	private static final String DELETE = "DELETE FROM promo_list where promono = ?";
	private static final String UPDATE = "UPDATE promo_list set promoname=?, startdate=?, enddate=?, promoinfo=? where promono = ?";

	@Override
	public void insert(PromoListVO promoListVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, promoListVO.getPromoname());
			pstmt.setDate(2, promoListVO.getStartdate());
			pstmt.setDate(3, promoListVO.getEnddate());
			pstmt.setString(4, promoListVO.getPromoinfo());

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
	public void update(PromoListVO promoListVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, promoListVO.getPromoname());
			pstmt.setDate(2, promoListVO.getStartdate());
			pstmt.setDate(3, promoListVO.getEnddate());
			pstmt.setString(4, promoListVO.getPromoinfo());
			pstmt.setString(5, promoListVO.getPromono());

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
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	@Override
	public void delete(String promono) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, promono);
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
	public PromoListVO findByPrimaryKey(String promono) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PromoListVO promoListVO = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, promono);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				promoListVO = new PromoListVO();
				promoListVO.setPromono(rs.getString("promono"));
				promoListVO.setPromoname(rs.getString("promoname"));
				promoListVO.setStartdate(rs.getDate("startdate"));
				promoListVO.setEnddate(rs.getDate("enddate"));
				promoListVO.setPromoinfo(rs.getString("promoinfo"));
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
		return promoListVO;
	}

	@Override
	public List<PromoListVO> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<PromoListVO> list = new ArrayList<PromoListVO>();
		PromoListVO promoListVO = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				promoListVO = new PromoListVO();
				promoListVO.setPromono(rs.getString("promono"));
				promoListVO.setPromoname(rs.getString("promoname"));
				promoListVO.setStartdate(rs.getDate("startdate"));
				promoListVO.setEnddate(rs.getDate("enddate"));
				promoListVO.setPromoinfo(rs.getString("promoinfo"));
				list.add(promoListVO);
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

		PromoListDAO dao = new PromoListDAO();
		// 新增
//		PromoListVO vo = new PromoListVO();
//		vo.setPromoname("111");
//		vo.setStartdate(java.sql.Date.valueOf("2020-11-20"));
//		vo.setEnddate(java.sql.Date.valueOf("2020-11-20"));
//		vo.setPromoinfo("111");
//		dao.insert(vo);

		// 修改
//		PromoListVO vo2 = new PromoListVO();
//		vo2.setPromoname("111");
//		vo2.setStartdate(java.sql.Date.valueOf("2020-11-20"));
//		vo2.setEnddate(java.sql.Date.valueOf("2020-11-20"));
//		vo2.setPromoinfo("222");
//		vo2.setPromono("PROM0004");
//		dao.update(vo2);

		// 查詢單一
		PromoListVO vo3 = dao.findByPrimaryKey("PROM0001");
		System.out.print(vo3.getPromono() + ",");
		System.out.print(vo3.getPromoname() + ",");
		System.out.print(vo3.getStartdate() + ",");
		System.out.print(vo3.getEnddate() + ",");
		System.out.println(vo3.getPromoinfo());
		System.out.println("\n-------------------------------");

		// 查詢全部

		List<PromoListVO> list = dao.getAll();
		for (PromoListVO vo4 : list) {

			System.out.print(vo4.getPromono() + ",");
			System.out.print(vo4.getPromoname() + ",");
			System.out.print(vo4.getStartdate() + ",");
			System.out.print(vo4.getEnddate() + ",");
			System.out.println(vo4.getPromoinfo());
		}

		// 刪除
		dao.delete("PROM0004");
	}
}
