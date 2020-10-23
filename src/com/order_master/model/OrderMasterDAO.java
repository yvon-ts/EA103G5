package com.order_master.model;

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

import com.order_detail.model.OrderDetailDAO;
import com.order_detail.model.OrderDetailVO;


public class OrderMasterDAO implements OrderMasterDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = "INSERT INTO order_master(orderno, memno, orderamt, coupno, payby) VALUES ('ORD' || LPAD(SEQ_ORDER_MASTER.NEXTVAL, 4, 0), ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT orderno, memno,to_char(orderdate,'yyyy-mm-dd') orderdate, orderstatus, orderamt, coupno, payby FROM order_master order by orderno";
	private static final String GET_ONE_STMT_ORDERNO = "SELECT orderno, memno,to_char(orderdate,'yyyy-mm-dd') orderdate, orderstatus, orderamt, coupno, payby FROM order_master where orderno = ?";
	private static final String GET_ONE_STMT_MEMNO = "SELECT orderno, memno,to_char(orderdate,'yyyy-mm-dd') orderdate, orderstatus, orderamt, coupno, payby FROM order_master where memno = ?";
	private static final String UPDATE = "UPDATE order_master set orderstatus=? where orderno = ?";

	@Override
	public void insert(OrderMasterVO orderMasterVO, List<OrderDetailVO> detailList) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		String ord_next_no = null;
		System.out.println("DAO");
		
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			
			String[] col = { "orderno" };
			pstmt = con.prepareStatement(INSERT_STMT, col);
			
			pstmt.setString(1, orderMasterVO.getMemno());
			pstmt.setInt(2, orderMasterVO.getOrderamt());
			pstmt.setString(3, orderMasterVO.getCoupno());
			pstmt.setString(4, orderMasterVO.getPayby());
			System.out.println("here");
			pstmt.executeUpdate();
			
			ResultSet rs = pstmt.getGeneratedKeys();
			
			if (rs.next()) {
			ord_next_no = rs.getString(1);
			System.out.println("orderno = " + ord_next_no);
			}
			System.out.println("here1");
			OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
			
			for (OrderDetailVO orderDetailVO : detailList) {
				orderDetailVO.setOrderno(ord_next_no);
				System.out.println(orderDetailVO.getOrderno());
				orderDetailDAO.insert(orderDetailVO, con);
			}
			System.out.println("訂單成立成功");
			con.commit();
			
		} catch (Exception se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
					con.setAutoCommit(false);
					con.close();
				}
					
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

	@Override
	public void update(OrderMasterVO orderMasterVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
//			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, orderMasterVO.getOrderstatus());
			pstmt.setString(2, orderMasterVO.getOrderno());

			pstmt.executeUpdate();
			
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public OrderMasterVO findByPrimaryKey(String orderNo) {

		OrderMasterVO orderMasterVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

//			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT_ORDERNO);

			pstmt.setString(1, orderNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				orderMasterVO = new OrderMasterVO();
				orderMasterVO.setOrderno(rs.getString("orderno"));
				orderMasterVO.setMemno(rs.getString("memno"));
				orderMasterVO.setOrderdate(rs.getDate("orderdate"));
				orderMasterVO.setOrderstatus(rs.getString("orderstatus"));
				orderMasterVO.setOrderamt(rs.getInt("orderamt"));
				orderMasterVO.setCoupno(rs.getString("coupno"));
				orderMasterVO.setPayby(rs.getString("payby"));
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
		return orderMasterVO;
	}

	@Override
	public List<OrderMasterVO> getAll() {
		List<OrderMasterVO> list = new ArrayList<OrderMasterVO>();
		OrderMasterVO orderMasterVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

//			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				orderMasterVO = new OrderMasterVO();
				orderMasterVO.setOrderno(rs.getString("orderNo"));
				orderMasterVO.setMemno(rs.getString("memNo"));
				orderMasterVO.setOrderdate(rs.getDate("orderDate"));
				orderMasterVO.setOrderstatus(rs.getString("orderStatus"));
				orderMasterVO.setOrderamt(rs.getInt("orderAmt"));
				orderMasterVO.setCoupno(rs.getString("coupNo"));
				orderMasterVO.setPayby(rs.getString("payBy"));
				list.add(orderMasterVO);
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
	public List<OrderMasterVO> findByMemno(String memno) {

		List<OrderMasterVO> list = new ArrayList<OrderMasterVO>();
		OrderMasterVO orderMasterVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

//			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT_MEMNO);

			pstmt.setString(1, memno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				orderMasterVO = new OrderMasterVO();
				orderMasterVO.setOrderno(rs.getString("orderno"));
				orderMasterVO.setMemno(rs.getString("memno"));
				orderMasterVO.setOrderdate(rs.getDate("orderdate"));
				orderMasterVO.setOrderstatus(rs.getString("orderstatus"));
				orderMasterVO.setOrderamt(rs.getInt("orderamt"));
				orderMasterVO.setCoupno(rs.getString("coupno"));
				orderMasterVO.setPayby(rs.getString("payby"));
				list.add(orderMasterVO);
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
}
