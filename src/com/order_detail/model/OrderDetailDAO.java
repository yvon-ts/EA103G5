package com.order_detail.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jdbcUtil_CompositeQuery.jdbcUtil_CompositeQuery_orderdetail;

public class OrderDetailDAO implements OrderDetailDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO order_detail(orderno, courseno, sellprice, promono) VALUES (?, ?, ?, ?)";
	private static final String UPDATE = "UPDATE order_detail set odstatus=? where orderno = ? and courseno = ?";
	private static final String UPDATE_REFUND = "UPDATE order_detail set odstatus = '申請退款' where orderno = ? and courseno = ?";
	private static final String GET_SPE_STMT = "SELECT * FROM order_detail where orderno = ?";
	private static final String GET_SPEM_STMT = "SELECT * FROM order_detail od JOIN order_master om ON od.orderno = om.orderno WHERE memno = ? AND odstatus IN ('鑑賞期', '申請退款', '交易完成')";
	private static final String GET_ONE_STMT = "SELECT * FROM order_detail where orderno = ? and courseno = ?";

	@Override
	public void insert(OrderDetailVO orderDetailVO, Connection con) {
		PreparedStatement pstmt = null;

		try {
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, orderDetailVO.getOrderno());
			pstmt.setString(2, orderDetailVO.getCourseno());
			pstmt.setInt(3, orderDetailVO.getSellprice());
			pstmt.setString(4, orderDetailVO.getPromono());
			pstmt.executeUpdate();

		} catch (Exception e) {
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

		}
	}

	@Override
	public void update(OrderDetailVO orderDetailVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			con.setAutoCommit(false);

			pstmt = con.prepareStatement(UPDATE);
			pstmt.setString(1, orderDetailVO.getOdstatus());
			pstmt.setString(2, orderDetailVO.getOrderno());
			pstmt.setString(3, orderDetailVO.getCourseno());
			pstmt.executeUpdate();
			con.commit();
			
		} catch (Exception se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				try {
					con.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
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
	public void refund(OrderDetailVO orderDetailVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			con.setAutoCommit(false);

			pstmt = con.prepareStatement(UPDATE_REFUND);
			pstmt.setString(1, orderDetailVO.getOrderno());
			pstmt.setString(2, orderDetailVO.getCourseno());
			pstmt.executeUpdate();
			con.commit();

		} catch (Exception se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				try {
					con.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
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

//	@Override
	public List<OrderDetailVO> getAll(Map<String, String[]> map) { // 複合查詢

		List<OrderDetailVO> list = new ArrayList<OrderDetailVO>();
		OrderDetailVO OrderDetailVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();

			String finalSQL = "select * from order_detail " + jdbcUtil_CompositeQuery_orderdetail.get_WhereCondition(map);
			System.out.println("SQL = " + finalSQL);

			pstmt = con.prepareStatement(finalSQL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				OrderDetailVO = new OrderDetailVO();
				OrderDetailVO.setCourseno(rs.getString("courseno"));
				OrderDetailVO.setOrderno(rs.getString("orderno"));
				OrderDetailVO.setSellprice(rs.getInt("sellprice"));
				OrderDetailVO.setOdstatus(rs.getString("odstatus"));
				OrderDetailVO.setPromono(rs.getString("promono"));
				list.add(OrderDetailVO);
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
	public List<OrderDetailVO> findByOrderNo(String orderno) {

		List<OrderDetailVO> list = new ArrayList<OrderDetailVO>();
		OrderDetailVO orderDetailVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_SPE_STMT);
			pstmt.setString(1, orderno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				orderDetailVO = new OrderDetailVO();
				orderDetailVO.setOrderno(rs.getString("orderNo"));
				orderDetailVO.setCourseno(rs.getString("courseNo"));
				orderDetailVO.setSellprice(rs.getInt("sellprice"));
				orderDetailVO.setOdstatus(rs.getString("odstatus"));
				orderDetailVO.setPromono(rs.getString("promoNo"));
				list.add(orderDetailVO);
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
	
	@Override
	public List<OrderDetailVO> findByMemberNo(String memno) {

		List<OrderDetailVO> list = new ArrayList<OrderDetailVO>();
		OrderDetailVO orderDetailVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_SPEM_STMT);
			pstmt.setString(1, memno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				orderDetailVO = new OrderDetailVO();
				orderDetailVO.setOrderno(rs.getString("orderNo"));
				orderDetailVO.setCourseno(rs.getString("courseNo"));
				orderDetailVO.setSellprice(rs.getInt("sellprice"));
				orderDetailVO.setOdstatus(rs.getString("odstatus"));
				orderDetailVO.setPromono(rs.getString("promoNo"));
				list.add(orderDetailVO);
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

	public OrderDetailVO findByPrimaryKey(String orderno, String courseno) {

		OrderDetailVO orderDetailVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, orderno);
			pstmt.setString(2, courseno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				orderDetailVO = new OrderDetailVO();
				System.out.println(rs.getString("odstatus"));
				orderDetailVO.setOrderno(rs.getString("orderNo"));
				orderDetailVO.setCourseno(rs.getString("courseNo"));
				orderDetailVO.setSellprice(rs.getInt("sellprice"));
				orderDetailVO.setOdstatus(rs.getString("odstatus"));
				orderDetailVO.setPromono(rs.getString("promoNo"));
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
		return orderDetailVO;
	}
//	public static void main(String[] args) {
//		OrderDetailDAO dao = new OrderDetailDAO();
	// 新增
//		OrderDetailVO vo = new OrderDetailVO();
//		vo.setOrderno("ORD0005");
//		vo.setCourseno("COUR0002");
//		vo.setPromono("");
//		vo.setSellprice(22400);
//		dao.insert(vo);

	// 修改
//		OrderDetailVO vo2 = new OrderDetailVO();
//		vo2.setOrderno("ORD0005");
//		vo2.setCourseno("COUR0005");
//		vo2.setPromono("");
//		vo2.setSellprice(2400);
//		vo2.setOdstatus("申請退款");
//		dao.update(vo2);
//		
	// 查詢單一
//		List<OrderDetailVO> list = dao.findByOrderNo("ORD0001");
//		for (OrderDetailVO vo3:list) {
//		System.out.print(vo3.getOrderno() + ",");
//		System.out.print(vo3.getCourseno() + ",");
//		System.out.print(vo3.getSellprice() + ",");
//		System.out.print(vo3.getOdstatus() + ",");
//		System.out.println(vo3.getPromono());
//		}
//	}
}
