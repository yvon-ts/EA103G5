package com.lecture.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class LecDAO implements LecDAO_Interface {

	private static DataSource ds = null;

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "XDU";
	String passwd = "123456";

	private static final String INSERT_STMT = "INSERT INTO LECTURE (lecno, lecname, lecprice, spkrno, roomno, lecstart, lecend, signstart, signend, initseat, currseat, lecinfo, lecpic)"
			+ "VALUES ('LEC' || LPAD(SEQ_LECNO.NEXTVAL, 4, 0), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String INSERT_NO_PIC = "INSERT INTO LECTURE (lecno, lecname, lecprice, spkrno, roomno, lecstart, lecend, signstart, signend, initseat, currseat, lecinfo)"
			+ "VALUES ('LEC' || LPAD(SEQ_LECNO.NEXTVAL, 4, 0), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String UPDATE_STMT = "UPDATE LECTURE SET lecname = ?, lecprice = ?, spkrno = ?, roomno = ?, lecstart = ?, lecend = ?, signstart = ?, signend = ?,"
			+ " initseat = ?,currseat = ?, lecinfo = ?, lecpic = ?, lecstatus = ?, leclmod = ? WHERE lecno = ?";
	private static final String UPDATE_NO_PIC = "UPDATE LECTURE SET lecname = ?, lecprice = ?, spkrno = ?, roomno = ?, lecstart = ?, lecend = ?, signstart = ?, signend = ?,"
			+ " initseat = ?, currseat = ?, lecinfo = ?, lecstatus = ?, leclmod = ? WHERE lecno = ?";

	private static final String GETONE_STMT = "SELECT * FROM LECTURE WHERE lecno = ?";
	private static final String GETALL_STMT = "SELECT * FROM LECTURE ORDER BY LECNO";

	private static final String UPDATE_SEAT = "UPDATE LECTURE SET currseat = ?, leclmod = ? WHERE lecno = ?";

	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void insert(LecVO lecVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, lecVO.getLecname());
			pstmt.setInt(2, lecVO.getLecprice());
			pstmt.setString(3, lecVO.getSpkrno());
			pstmt.setString(4, lecVO.getRoomno());
			pstmt.setTimestamp(5, lecVO.getLecstart());
			pstmt.setTimestamp(6, lecVO.getLecend());
			pstmt.setTimestamp(7, lecVO.getSignstart());
			pstmt.setTimestamp(8, lecVO.getSignend());
			pstmt.setString(9, lecVO.getInitseat());
			pstmt.setString(10, lecVO.getCurrseat());
			pstmt.setBytes(11, lecVO.getLecinfo());
			pstmt.setBytes(12, lecVO.getLecpic());

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
	public void insertNoPic(LecVO lecVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(INSERT_NO_PIC);

			pstmt.setString(1, lecVO.getLecname());
			pstmt.setInt(2, lecVO.getLecprice());
			pstmt.setString(3, lecVO.getSpkrno());
			pstmt.setString(4, lecVO.getRoomno());
			pstmt.setTimestamp(5, lecVO.getLecstart());
			pstmt.setTimestamp(6, lecVO.getLecend());
			pstmt.setTimestamp(7, lecVO.getSignstart());
			pstmt.setTimestamp(8, lecVO.getSignend());
			pstmt.setString(9, lecVO.getInitseat());
			pstmt.setString(10, lecVO.getCurrseat());
			pstmt.setBytes(11, lecVO.getLecinfo());

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
	public void update(LecVO lecVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, lecVO.getLecname());
			pstmt.setInt(2, lecVO.getLecprice());
			pstmt.setString(3, lecVO.getSpkrno());
			pstmt.setString(4, lecVO.getRoomno());
			pstmt.setTimestamp(5, lecVO.getLecstart());
			pstmt.setTimestamp(6, lecVO.getLecend());
			pstmt.setTimestamp(7, lecVO.getSignstart());
			pstmt.setTimestamp(8, lecVO.getSignend());
			pstmt.setString(9, lecVO.getInitseat());
			pstmt.setString(10, lecVO.getCurrseat());
			pstmt.setBytes(11, lecVO.getLecinfo());
			pstmt.setBytes(12, lecVO.getLecpic());
			pstmt.setInt(13, lecVO.getLecstatus());
			// get lmod
			Timestamp leclmod = new Timestamp(System.currentTimeMillis());
			pstmt.setTimestamp(14, leclmod);
			pstmt.setString(15, lecVO.getLecno());

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
	public void updateNoPic(LecVO lecVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE_NO_PIC);

			pstmt.setString(1, lecVO.getLecname());
			pstmt.setInt(2, lecVO.getLecprice());
			pstmt.setString(3, lecVO.getSpkrno());
			pstmt.setString(4, lecVO.getRoomno());
			pstmt.setTimestamp(5, lecVO.getLecstart());
			pstmt.setTimestamp(6, lecVO.getLecend());
			pstmt.setTimestamp(7, lecVO.getSignstart());
			pstmt.setTimestamp(8, lecVO.getSignend());
			pstmt.setString(9, lecVO.getInitseat());
			pstmt.setString(10, lecVO.getCurrseat());
			pstmt.setBytes(11, lecVO.getLecinfo());
			pstmt.setInt(12, lecVO.getLecstatus());
			// get lmod
			Timestamp leclmod = new Timestamp(System.currentTimeMillis());
			pstmt.setTimestamp(13, leclmod);
			pstmt.setString(14, lecVO.getLecno());

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
	public void updateSeats(LecVO lecVO, Connection con) {

		// 與訂單主檔共用連線
		PreparedStatement pstmt = null;

		try {
			pstmt = con.prepareStatement(UPDATE_SEAT);

			pstmt.setString(1, lecVO.getCurrseat());
			// get lmod
			Timestamp leclmod = new Timestamp(System.currentTimeMillis());
			pstmt.setTimestamp(2, leclmod);
			pstmt.setString(3, lecVO.getLecno());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			try {
				System.err.println("Transaction is being");
				System.err.println("rolled back from lecture");
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			throw new RuntimeException("Database error." + se.getMessage());

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
	public LecVO findByPK(String lecno) {

		LecVO lecVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GETONE_STMT);

			pstmt.setString(1, lecno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				lecVO = new LecVO();
				lecVO.setLecno(rs.getString("lecno"));
				lecVO.setLecname(rs.getString("lecname"));
				lecVO.setLecprice(rs.getInt("lecprice"));
				lecVO.setSpkrno(rs.getString("spkrno"));
				lecVO.setRoomno(rs.getString("roomno"));
				lecVO.setLecstart(rs.getTimestamp("lecstart"));
				lecVO.setLecend(rs.getTimestamp("lecend"));
				lecVO.setSignstart(rs.getTimestamp("signstart"));
				lecVO.setSignend(rs.getTimestamp("signend"));
				lecVO.setInitseat(rs.getString("initseat"));
				lecVO.setCurrseat(rs.getString("currseat"));
				lecVO.setLecstatus(rs.getInt("lecstatus"));
				lecVO.setLecinfo(rs.getBytes("lecinfo"));
				lecVO.setLeclmod(rs.getTimestamp("leclmod"));
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
		return lecVO;
	}

	@Override
	public List<LecVO> getAll() {

		List<LecVO> list = new ArrayList<LecVO>();
		LecVO lecVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GETALL_STMT);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				lecVO = new LecVO();
				lecVO.setLecno(rs.getString("lecno"));
				lecVO.setLecname(rs.getString("lecname"));
				lecVO.setLecprice(rs.getInt("lecprice"));
				lecVO.setSpkrno(rs.getString("spkrno"));
				lecVO.setRoomno(rs.getString("roomno"));
				lecVO.setLecstart(rs.getTimestamp("lecstart"));
				lecVO.setLecend(rs.getTimestamp("lecend"));
				lecVO.setSignstart(rs.getTimestamp("signstart"));
				lecVO.setSignend(rs.getTimestamp("signend"));
				lecVO.setInitseat(rs.getString("initseat"));
				lecVO.setCurrseat(rs.getString("currseat"));
				lecVO.setLecstatus(rs.getInt("lecstatus"));
				lecVO.setLeclmod(rs.getTimestamp("leclmod"));
				lecVO.setLecinfo(rs.getBytes("lecinfo"));
				list.add(lecVO);
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

	@Override
	public List<LecVO> getTextQuery(String query, String orderBy) {
		
		String sqlHead = "SELECT * FROM (SELECT * FROM LECTURE JOIN SPEAKER ON LECTURE.SPKRNO = SPEAKER.SPKRNO)";
		
		String where = "";
		
		if (query.length() == 0)
			where = " ";
		else
			where = " WHERE LECNAME LIKE '%"+ query +"%' OR SPKRNAME LIKE '%"+ query +"%' ";
		
		String condition = "";

		if ("priceAsc".contentEquals(orderBy))
			condition = " ORDER BY LECPRICE ASC";
		else if ("priceDesc".contentEquals(orderBy))
			condition = " ORDER BY LECPRICE DESC";
		else if ("timeAsc".contentEquals(orderBy))
			condition = " ORDER BY LECSTART ASC";
		else if ("timeDesc".contentEquals(orderBy))
			condition = " ORDER BY LECSTART DESC";
		else
			condition = "";
	
	String sql = sqlHead + where + condition;
	System.out.println("where=" + where + ", con=" + condition);
	System.out.println(sql);
		
		List<LecVO> list = new ArrayList<LecVO>();
		LecVO lecVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				lecVO = new LecVO();
				lecVO.setLecno(rs.getString("lecno"));
				lecVO.setLecname(rs.getString("lecname"));
				lecVO.setLecprice(rs.getInt("lecprice"));
				lecVO.setSpkrno(rs.getString("spkrno"));
				lecVO.setRoomno(rs.getString("roomno"));
				lecVO.setLecstart(rs.getTimestamp("lecstart"));
				lecVO.setLecend(rs.getTimestamp("lecend"));
				lecVO.setSignstart(rs.getTimestamp("signstart"));
				lecVO.setSignend(rs.getTimestamp("signend"));
				lecVO.setInitseat(rs.getString("initseat"));
				lecVO.setCurrseat(rs.getString("currseat"));
				lecVO.setLecstatus(rs.getInt("lecstatus"));
				lecVO.setLecinfo(rs.getBytes("lecinfo"));
				lecVO.setLecpic(rs.getBytes("lecpic"));
				lecVO.setLeclmod(rs.getTimestamp("leclmod"));
				list.add(lecVO);
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

	@Override
	public List<LecVO> queryOrderBy(String query) {
		
		String condition = "";
		String sqlHead = "SELECT * FROM LECTURE ORDER BY ";
		
		switch(query) {
			case "price_asc":
				condition = " PRICE ASC";
			case "price_desc":
				condition = " PRICE DESC";
			case "time_asc":
				condition = " LECSTART ASC";
			case "time_desc":
				condition = " LECSTART DESC";
		}
		
		String sql = sqlHead + condition;
		
		List<LecVO> list = new ArrayList<LecVO>();
		LecVO lecVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				lecVO = new LecVO();
				lecVO.setLecno(rs.getString("lecno"));
				lecVO.setLecname(rs.getString("lecname"));
				lecVO.setLecprice(rs.getInt("lecprice"));
				lecVO.setSpkrno(rs.getString("spkrno"));
				lecVO.setRoomno(rs.getString("roomno"));
				lecVO.setLecstart(rs.getTimestamp("lecstart"));
				lecVO.setLecend(rs.getTimestamp("lecend"));
				lecVO.setSignstart(rs.getTimestamp("signstart"));
				lecVO.setSignend(rs.getTimestamp("signend"));
				lecVO.setInitseat(rs.getString("initseat"));
				lecVO.setCurrseat(rs.getString("currseat"));
				lecVO.setLecstatus(rs.getInt("lecstatus"));
				lecVO.setLecinfo(rs.getBytes("lecinfo"));
				lecVO.setLecpic(rs.getBytes("lecpic"));
				lecVO.setLeclmod(rs.getTimestamp("leclmod"));
				list.add(lecVO);
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