package com.teacher.model;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.members.model.*;

public class TeacherDAO implements TeacherDAO_interface {
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/xduDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "XDU";
	String passwd = "123456";

	private static final String INSERT_STMT = "INSERT INTO TEACHER(TCHRNO,MEMNO,TCHRINTRO,TCHRCERT1,TCHRCERT2,BANKACC) VALUES ('TCHR' || LPAD(SEQ_TCHR.NEXTVAL, 4, 0),?,?,?,?,?)";
	private static final String GET_ALL_STMT = "SELECT TCHRNO,MEMNO,TCHRINTRO,TCHRCERT1,TCHRCERT2,BANKACC,TCHRSTATUS,REJREASON FROM TEACHER ORDER BY TCHRNO";
	private static final String GET_ONE_STMT = "SELECT TCHRNO,MEMNO,TCHRINTRO,TCHRCERT1,TCHRCERT2,BANKACC,TCHRSTATUS,REJREASON FROM TEACHER WHERE TCHRNO = ?";
	private static final String UPDATE = "UPDATE TEACHER SET TCHRINTRO=?,TCHRCERT1=?,TCHRCERT2=?,BANKACC=?,TCHRSTATUS = ? WHERE TCHRNO =?";
	private static final String UPDATESTATUS = "UPDATE TEACHER SET TCHRSTATUS = ?,REJREASON = ? WHERE TCHRNO=?";
	//private static final String GET_STATUS = "SELECT TCHRSTATUS,TCHRNO FROM TEACHER WHERE MEMNO = ?";
	private static final String GET_STATUS = "SELECT TCHRSTATUS,TCHRNO FROM TEACHER WHERE MEMNO = ?";

	@Override
	public void insert(TeacherVO teacherVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
			con = ds.getConnection();
			con.setAutoCommit(false);
			
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, teacherVO.getMemno());
			pstmt.setString(2, teacherVO.getTchrintro());
			pstmt.setBytes(3, teacherVO.getTchrcert1());
			pstmt.setBytes(4, teacherVO.getTchrcert2());
			pstmt.setString(5, teacherVO.getBankacc());

			pstmt.executeUpdate();
			con.commit();
			System.out.println("TeacherDAO成功新增一老師資料");

		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
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
	public void update(TeacherVO teacherVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
//			con = ds.getConnection();
			
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setString(1, teacherVO.getTchrintro());
			pstmt.setBytes(2, teacherVO.getTchrcert1());
			pstmt.setBytes(3, teacherVO.getTchrcert2());
			pstmt.setString(4, teacherVO.getBankacc());
			pstmt.setString(5, "待審核");
			pstmt.setString(6, teacherVO.getTchrno());

			pstmt.executeUpdate();
			System.out.println("有執行到更新");

		} catch (SQLException se) {
				// TODO Auto-generated catch block
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	public void updateStatus(String tchrno,String tchrstatus,String rejreason) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATESTATUS);
			if("已通過".equals(tchrstatus)) {
				pstmt.setString(1, tchrstatus);
				pstmt.setString(2, "無");
				pstmt.setString(3, tchrno);
				
				
			}else {
				pstmt.setString(1, tchrstatus);
				pstmt.setString(2, rejreason);
				pstmt.setString(3, tchrno);

			}

			
			pstmt.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
			System.out.println("TeacherDAO成功修改老師狀態");

		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
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
					
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public TeacherVO findByPrimaryKey(String tchrno) {
		TeacherVO teacherVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, tchrno);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				
				teacherVO = new TeacherVO();
				teacherVO.setTchrno(rs.getString("tchrno"));
				teacherVO.setMemno(rs.getString("memno"));
				teacherVO.setTchrintro(rs.getString("tchrintro"));
				teacherVO.setTchrcert1(rs.getBytes("tchrcert1"));
				teacherVO.setTchrcert2(rs.getBytes("tchrcert2"));
				teacherVO.setBankacc(rs.getString("bankacc"));
				teacherVO.setTchrstatus(rs.getString("tchrstatus"));
				teacherVO.setRejreason(rs.getString("rejreason"));
			}

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
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return teacherVO;
	}

	@Override
	public List<TeacherVO> getAll() {
		List<TeacherVO> list = new ArrayList<TeacherVO>();
		TeacherVO teacherVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				teacherVO = new TeacherVO();
				teacherVO.setTchrno(rs.getString("tchrno"));
				teacherVO.setMemno(rs.getString("memno"));
				teacherVO.setTchrintro(rs.getString("tchrintro"));
				teacherVO.setTchrcert1(rs.getBytes("tchrcert1"));
				teacherVO.setTchrcert2(rs.getBytes("tchrcert2"));
				teacherVO.setBankacc(rs.getString("bankacc"));
				teacherVO.setTchrstatus(rs.getString("tchrstatus"));
				teacherVO.setRejreason(rs.getString("rejreason"));
				list.add(teacherVO);
			}

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
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

	@Override
	public TeacherVO getStatus(String memno) {
		TeacherVO teacherVO=null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
		
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_STATUS);
			
			pstmt.setString(1, memno);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				teacherVO = new TeacherVO();
				teacherVO.setTchrstatus(rs.getString("tchrstatus"));
				teacherVO.setTchrno(rs.getString("tchrno"));
			
			}
			
			
		}  catch (SQLException se) {
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
		
		return teacherVO;
	}
	
	
	public static void main(String[] args) {
//		TeacherDAO td = new TeacherDAO();
//		TeacherVO tv = new TeacherVO();
//		tv.setBankacc("123456789");
//		tv.setTchrcert1(null);
//		tv.setTchrcert2(null);
//		tv.setTchrintro("我是送外賣的");
//		tv.setTchrno("TCHR0054");
//		td.update(tv);

	}
}
