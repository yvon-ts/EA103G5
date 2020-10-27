package com.lecorder.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.lecseat.model.*;
import com.lecture.model.*;

public class LodrDAO implements LodrDAO_Interface{
	public static DataSource ds = null;
	
	private static final String INSERT_STMT =
			"INSERT INTO LEC_ORDER (LODRNO, MEMNO, LECNO, LECAMT, LODRSEAT)"
			+ "VALUES ('LODR' || LPAD(SEQ_LODRNO.NEXTVAL, 4, 0), ?, ?, ?, ?)";
	
	private static final String GETALL_BY_MEMNO = "SELECT * FROM LEC_ORDER WHERE MEMNO = ? ORDER BY LODRNO";
	
	private static final String CANCEL_SEAT = "UPDATE LEC_ORDER SET LECAMT = ?, LODRSEAT = ?, LODRSTATUS = '已變更', LODRLMOD = ? WHERE LODRNO = ?";
	/////////////////////////////////////////////////////////////////////////////
	private static final String UPDATE_STMT =
			"UPDATE LEC_ORDER SET LECAMT = ?, LODRSTATUS = ?, LODRLMOD = ? WHERE LODRNO = ?";
	
	private static final String DELETE_SEAT =
			"UPDATE LEC_SEAT SET SEATSTATUS = ? WHERE LODRNO = ?";
	private static final String DELETE_LODR =
			"UPDATE LEC_ORDER SET LODRSTATUS = ?, LODRLMOD = ? WHERE LODRNO = ?";
	
	private static final String GETONE_STMT =
			"SELECT * FROM LEC_ORDER WHERE LODRNO = ?";
	private static final String GETALL_STMT =
			"SELECT * FROM LEC_ORDER ORDER BY LODRNO DESC";
	
	
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void update(LodrVO lodrVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);
			
			
			pstmt.setInt(1, lodrVO.getLecamt());
			pstmt.setString(2, lodrVO.getLodrstatus());
			pstmt.setTimestamp(3, lodrVO.getLodrlmod());
			pstmt.setString(4, lodrVO.getLodrno());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
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
	}
	
	@Override
	public void delete(String lodrno) {
		int updateCount_Seats = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			
			pstmt = con.prepareStatement(DELETE_SEAT);
			pstmt.setString(1, "已取消");
			pstmt.setString(2, lodrno);
			updateCount_Seats = pstmt.executeUpdate();
			
			pstmt = con.prepareStatement(DELETE_LODR);
			pstmt.setString(1, "已取消");
			//get lmod
			Timestamp lodrlmod = new Timestamp(System.currentTimeMillis());
			pstmt.setTimestamp(2, lodrlmod);
			pstmt.setString(3, lodrno);
			pstmt.executeUpdate();
			
			con.commit();
			con.setAutoCommit(true);
			System.out.println("刪除訂單主檔編號" + lodrno + "及" + updateCount_Seats + "筆座位資料");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
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
	}
	
	@Override
	public LodrVO findByPK(String lodrno) {
		
		LodrVO lodrVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GETONE_STMT);
			
			pstmt.setString(1, lodrno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				lodrVO = new LodrVO();
				lodrVO.setLodrno(rs.getString("LODRNO"));
				lodrVO.setMemno(rs.getString("MEMNO"));
				lodrVO.setLecno(rs.getString("LECNO"));
				lodrVO.setLecamt(rs.getInt("LECAMT"));
				lodrVO.setLodrseat(rs.getString("LODRSEAT"));
				lodrVO.setLodrstatus(rs.getString("LODRSTATUS"));
				lodrVO.setLodrtime(rs.getTimestamp("LODRTIME"));
				lodrVO.setLodrlmod(rs.getTimestamp("LODRLMOD"));
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
		return lodrVO;
	}
	
	
	@Override
	public List<LodrVO> getAll() {
		
		List<LodrVO> list = new ArrayList<LodrVO>();
		LodrVO lodrVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GETALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				lodrVO = new LodrVO();
				lodrVO.setLodrno(rs.getString("LODRNO"));
				lodrVO.setMemno(rs.getString("MEMNO"));
				lodrVO.setLecamt(rs.getInt("LECAMT"));
				lodrVO.setLodrstatus(rs.getString("LODRSTATUS"));
				lodrVO.setLodrtime(rs.getTimestamp("LODRTIME"));
				lodrVO.setLodrlmod(rs.getTimestamp("LODRLMOD"));
				list.add(lodrVO);
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
	//以下ok/////////////////////////////////////////////////////////////////////////////////
	@Override
	public void insertSeatAndLayout(LodrVO lodrVO, List<LecseatVO> list, LecVO lecVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			
			String cols[] = {"LODRNO"};
			pstmt = con.prepareStatement(INSERT_STMT, cols);
			pstmt.setString(1, lodrVO.getMemno());
			pstmt.setString(2, lodrVO.getLecno());
			pstmt.setInt(3, lodrVO.getLecamt());
			pstmt.setString(4, lodrVO.getLodrseat());
			pstmt.executeUpdate();
			
			String next_lodrno = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_lodrno = rs.getString(1);
				System.out.println("自增主鍵=" + next_lodrno);
			} else {
				System.out.println("No keys were generated");
			}
			rs.close();
			
			//call seat dao insert method
			LecseatDAO daoSeat = new LecseatDAO();
			System.out.println("list.size()-欲新增座位數量=" + list.size());
			for (LecseatVO aSeat : list) {
				aSeat.setLodrno(next_lodrno);
				daoSeat.insert(aSeat, con);
			}
			
			//call lec dao update method
			LecDAO daoLec = new LecDAO();
			//String currseat = lecVO.getCurrseat();
			//String lecno = lecVO.getLecno();
			System.out.println(lecVO.getLecno() + "座位圖欲修改成" + lecVO.getCurrseat());
			daoLec.updateSeats(lecVO, con);
			
			con.commit();
			con.setAutoCommit(true);
			System.out.println("list.size()-成功新增座位數量=" + list.size());
			System.out.println("自增主鍵=" + next_lodrno + "有" + list.size() + "筆座位明細生成");
			System.out.println(lecVO.getLecno() + "已修改座位圖");
			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					System.out.println("Transaction is being");
					System.out.println("rolled back from lodr");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up resources
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
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
	
	@Override
	public List<LodrVO> findByMemno(String memno) {
		
		List<LodrVO> list = new ArrayList<LodrVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GETALL_BY_MEMNO);
			
			pstmt.setString(1, memno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				LodrVO lodrVO = new LodrVO();
				lodrVO.setLodrno(rs.getString("LODRNO"));
				lodrVO.setLecno(rs.getString("LECNO"));
				lodrVO.setLecamt(rs.getInt("LECAMT"));
				lodrVO.setLodrseat(rs.getString("LODRSEAT"));
				lodrVO.setLodrstatus(rs.getString("LODRSTATUS"));
				lodrVO.setLodrtime(rs.getTimestamp("LODRTIME"));
				list.add(lodrVO);
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
	
	public void cancelSeat(LodrVO lodrVO, Connection con) {
		
		//與lecseat共用連線
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(CANCEL_SEAT);
			
			pstmt.setInt(1, lodrVO.getLecamt());
			pstmt.setString(2, lodrVO.getLodrseat());
			pstmt.setTimestamp(3, lodrVO.getLodrlmod());
			pstmt.setString(4, lodrVO.getLodrno());
			
			pstmt.executeUpdate();
			
		} catch (SQLException se) {
			if (con != null) {
				try {
					System.err.println("Transaction is being");
					System.err.println("rolled back from lodr");
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
	public void updateOne(LodrVO lodrVO, List<LecseatVO> list, LecVO lecVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			
			pstmt = con.prepareStatement(CANCEL_SEAT);
			
			pstmt.setInt(1, lodrVO.getLecamt());
			pstmt.setString(2, lodrVO.getLodrseat());
			pstmt.setTimestamp(3, lodrVO.getLodrlmod());
			pstmt.setString(4, lodrVO.getLodrno());
			
			pstmt.executeUpdate();
						
			//call seat dao insert method
			LecseatDAO daoSeat = new LecseatDAO();
			System.out.println("list.size()-欲取消座位數量=" + list.size());
			for (LecseatVO aSeat : list) {
				daoSeat.updateStatus(aSeat, con);
			}
			
			//call lec dao update method
			LecDAO daoLec = new LecDAO();
			System.out.println(lecVO.getLecno() + "座位圖欲修改成" + lecVO.getCurrseat());
			daoLec.updateSeats(lecVO, con);
			
			con.commit();
			con.setAutoCommit(true);
			System.out.println("list.size()-成功刪除座位數量=" + list.size());
			System.out.println(lecVO.getLecno() + "已修改座位圖");
			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					System.out.println("Transaction is being");
					System.out.println("rolled back from lodr");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up resources
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
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
}
