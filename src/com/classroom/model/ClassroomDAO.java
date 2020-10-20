package com.classroom.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ClassroomDAO implements ClassroomDAO_interface {

	// JNDI version
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO classroom (roomno,roomname,roomrow,roomcolumn,defaultseat,roomdelete) VALUES ('ROOM' || LPAD(SEQ_roomno.NEXTVAL, 4, 0), ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT roomno,roomname,roomrow,roomcolumn,defaultseat,roomdelete,roomlastmod FROM classroom order by roomno";
	private static final String GET_ONE_STMT = "SELECT roomno,roomname,roomrow,roomcolumn,defaultseat,roomdelete,roomlastmod FROM classroom where roomno = ?";
	private static final String UPDATE = "UPDATE classroom SET roomname=?, roomrow=?, roomcolumn=?, defaultseat=?,  roomdelete=? ,roomlastmod=CURRENT_TIMESTAMP where roomno = ?";

	@Override
	public void insert(ClassroomVO classroomVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, classroomVO.getRoomname());
			pstmt.setInt(2, classroomVO.getRoomrow());
			pstmt.setInt(3, classroomVO.getRoomcolumn());
			pstmt.setString(4, classroomVO.getDefaultseat());
			pstmt.setBoolean(5, classroomVO.getRoomdelete());

			pstmt.executeUpdate();

			con.commit();
			// Handle any SQL errors
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
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
	public void update(ClassroomVO classroomVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			String[] col = { "roomlastmod" };
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE, col);

			pstmt.setString(1, classroomVO.getRoomname());
			pstmt.setInt(2, classroomVO.getRoomrow());
			pstmt.setInt(3, classroomVO.getRoomcolumn());
			pstmt.setString(4, classroomVO.getDefaultseat());
			pstmt.setBoolean(5, classroomVO.getRoomdelete());
			pstmt.setString(6, classroomVO.getRoomno());

			pstmt.executeUpdate();
			
			con.commit();

//			ResultSet rs = pstmt.getGeneratedKeys();
//			return rs.getTimestamp(1);

		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
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
	public ClassroomVO findByPrimaryKey(String roomno) {

		ClassroomVO classroomVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, roomno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				classroomVO = new ClassroomVO();
				classroomVO.setRoomno(rs.getString("roomno"));
				classroomVO.setRoomname(rs.getString("roomname"));
				classroomVO.setRoomrow(rs.getInt("roomrow"));
				classroomVO.setRoomcolumn(rs.getInt("roomcolumn"));
				classroomVO.setDefaultseat(rs.getString("defaultseat"));
				classroomVO.setRoomdelete(rs.getBoolean("roomdelete"));
				classroomVO.setRoomlastmod(rs.getTimestamp("roomlastmod"));
			}

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

		return classroomVO;
	}

	@Override
	public List<ClassroomVO> getAll() {

		List<ClassroomVO> list = new ArrayList<ClassroomVO>();
		ClassroomVO classroomVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				classroomVO = new ClassroomVO();
				classroomVO.setRoomno(rs.getString("roomno"));
				classroomVO.setRoomname(rs.getString("roomname"));
				classroomVO.setRoomrow(rs.getInt("roomrow"));
				classroomVO.setRoomcolumn(rs.getInt("roomcolumn"));
				classroomVO.setDefaultseat(rs.getString("defaultseat"));
				classroomVO.setRoomdelete(rs.getBoolean("roomdelete"));
				classroomVO.setRoomlastmod(rs.getTimestamp("roomlastmod"));
				list.add(classroomVO); // Store the row in the list
			}

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
}
