package com.members.model;

import java.util.*;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;

import javax.naming.*;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.coup_code.model.CoupCodeService;
import com.members.model.MembersVO;
import com.order_detail.model.OrderDetailDAO;
import com.order_detail.model.OrderDetailVO;

public class MembersDAO implements MembersDAO_interface {
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

	private static final String INSERT_STMT = "INSERT INTO MEMBERS(MEMNO,MEMACC,MEMPWD,MEMNAME,NKNAME,MEMBDAY,MEMAIL,MPHONE,MPROFILE) VALUES ('MEM' || LPAD(SEQ_MEMBERS.NEXTVAL, 4, 0),?,?,?,?,?,?,?,?)";
	private static final String GET_ALL_STMT = "SELECT MEMNO,MEMACC,MEMPWD,MEMNAME,NKNAME,TO_CHAR(MEMBDAY,'YYYY-MM-DD')MEMBDAY,MEMAIL,MPHONE,MPROFILE,REGDATE,MEMDELETE FROM MEMBERS ORDER BY MEMNO";
	private static final String GET_ONE_STMT = "SELECT MEMNO,MEMACC,MEMPWD,MEMNAME,NKNAME,TO_CHAR(MEMBDAY,'YYYY-MM-DD')MEMBDAY,MEMAIL,MPHONE,MPROFILE,REGDATE,MEMDELETE FROM MEMBERS WHERE MEMNO = ?";
	private static final String UPDATE = "UPDATE MEMBERS SET MEMPWD=?,NKNAME=?,MPROFILE=? WHERE MEMNO =?";
	private static final String UPDATESTATUS = "UPDATE MEMBERS SET MEMDELETE = ? WHERE MEMNO=?";
	private static final String SIGNIN = "SELECT MEMNO,MEMACC,MEMPWD,MEMNAME,NKNAME,TO_CHAR(MEMBDAY,'YYYY-MM-DD')MEMBDAY,MEMAIL,MPHONE,MPROFILE,REGDATE,MEMDELETE FROM MEMBERS WHERE MEMACC = ? AND MEMPWD = ?";
    
	@Override
	public MembersVO insert(MembersVO membersVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String mem_next_no = null;
	

		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
			con = ds.getConnection();
			con.setAutoCommit(false);
			
			String[] col = { "memno" };
			
			pstmt = con.prepareStatement(INSERT_STMT, col);

			pstmt.setString(1, membersVO.getMemacc());
			pstmt.setString(2, membersVO.getMempwd());
			pstmt.setString(3, membersVO.getMemname());
			pstmt.setString(4, membersVO.getNkname());
			pstmt.setDate(5, membersVO.getMembday());
			pstmt.setString(6, membersVO.getMemail());
			pstmt.setString(7, membersVO.getMphone());
			pstmt.setBytes(8, membersVO.getMprofile());
			

			int a = pstmt.executeUpdate();
			
			ResultSet rs = pstmt.getGeneratedKeys();
			
			if (rs.next()) {
				mem_next_no = rs.getString(1);
				System.out.println("memno = " + mem_next_no);
				}
				
				CoupCodeService coupcode = new CoupCodeService();
				
				coupcode.welcome1(mem_next_no, con);
				coupcode.welcome2(mem_next_no, con);
			
			con.commit();
			MembersService membersSvc = new MembersService();
			membersVO = membersSvc.getOneMembers(mem_next_no);
			
			System.out.println(a+"新增一筆資料到資料庫");

		} catch (Exception se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			throw new RuntimeException("Email重複");
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
		return membersVO;

	}

	@Override
	public void updateMembers(MembersVO membersVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, membersVO.getMempwd());
			pstmt.setString(2, membersVO.getNkname());
			pstmt.setBytes(3, membersVO.getMprofile());
			pstmt.setString(4, membersVO.getMemno());

			 pstmt.executeUpdate();
			 con.commit();
		} catch (Exception se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public MembersVO findByPrimaryKey(String memno) {
		MembersVO membersVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, memno);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				membersVO = new MembersVO();
				membersVO.setMemno(rs.getString("memno"));
				membersVO.setMemacc(rs.getString("memacc"));
				membersVO.setMempwd(rs.getString("mempwd"));
				membersVO.setMemname(rs.getString("memname"));
				membersVO.setNkname(rs.getString("nkname"));
				membersVO.setMembday(rs.getDate("membday"));
				membersVO.setMemail(rs.getString("memail"));
				membersVO.setMphone(rs.getString("mphone"));
				membersVO.setMprofile(rs.getBytes("mprofile"));
				membersVO.setRegdate(rs.getTimestamp("regdate"));
				membersVO.setMemdelete(rs.getInt("memdelete"));
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
		return membersVO;
	}

	@Override
	public List<MembersVO> getAll() {
		List<MembersVO> list = new ArrayList<MembersVO>();
		MembersVO membersVO = null;
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
				membersVO = new MembersVO();
				membersVO.setMemno(rs.getString("memno"));
				membersVO.setMemacc(rs.getString("memacc"));
				membersVO.setMempwd(rs.getString("mempwd"));
				membersVO.setMemname(rs.getString("memname"));
				membersVO.setNkname(rs.getString("nkname"));
				membersVO.setMembday(rs.getDate("membday"));
				membersVO.setMemail(rs.getString("memail"));
				membersVO.setMphone(rs.getString("mphone"));
				membersVO.setMprofile(rs.getBytes("mprofile"));
				membersVO.setRegdate(rs.getTimestamp("regdate"));
				membersVO.setMemdelete(rs.getInt("memdelete"));
				list.add(membersVO);
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
	public MembersVO signIn(String memacc, String mempwd) {
		MembersVO membersVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
			con = ds.getConnection();
			pstmt = con.prepareStatement(SIGNIN);

			pstmt.setString(1, memacc);
			pstmt.setString(2, mempwd);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				membersVO = new MembersVO();
				membersVO.setMemno(rs.getString("memno"));
				membersVO.setMemacc(rs.getString("memacc"));
				membersVO.setMempwd(rs.getString("mempwd"));
				membersVO.setMemname(rs.getString("memname"));
				membersVO.setNkname(rs.getString("nkname"));
				membersVO.setMembday(rs.getDate("membday"));
				membersVO.setMemail(rs.getString("memail"));
				membersVO.setMphone(rs.getString("mphone"));
				membersVO.setMprofile(rs.getBytes("mprofile"));
				membersVO.setRegdate(rs.getTimestamp("regdate"));
				membersVO.setMemdelete(rs.getInt("memdelete"));
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
		return membersVO;

	}

	
	public Integer checkMemacc(String memacc) {
		MembersVO membersVO = new MembersVO();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Integer a =null;
		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
			con = ds.getConnection();
			pstmt = con.prepareStatement("SELECT MEMACC FROM MEMBERS WHERE MEMACC = ? ORDER BY MEMACC");
			pstmt.setString(1, memacc);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				membersVO = new MembersVO();
				membersVO.setMemacc(rs.getString("memacc"));
				
			
			}
			if(membersVO.getMemacc()==null) {
				a = 0;
				return a;
			}else{
				a=1;
				return a;
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
		
	}
	
	
	
	
	

	@Override
	public Integer checkMemail(String memail) {
		MembersVO membersVO = new MembersVO();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Integer a =null;
		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
			con = ds.getConnection();
			pstmt = con.prepareStatement("SELECT MEMAIL FROM MEMBERS WHERE MEMAIL = ? ORDER BY MEMAIL");
			pstmt.setString(1, memail);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				membersVO = new MembersVO();
				membersVO.setMemail(rs.getString("memail"));
				
			
			}
			if(membersVO.getMemail()==null) {
				a = 0;
				return a;
			}else{
				a=1;
				return a;
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
	}

	
	public Integer updateStatus(String memno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement p1 = null;
		ResultSet rs = null;
		Integer a =null;
		Integer memdelete = null;
		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);

			con = ds.getConnection();
			con.setAutoCommit(false);
			
			p1 = con.prepareStatement("SELECT MEMDELETE FROM MEMBERS WHERE MEMNO = ?");
			p1.setString(1, memno);
			rs =p1.executeQuery();
			
			while(rs.next()) {
				 memdelete = rs.getInt("memdelete");
			}	
			
			if(memdelete.equals(0)) {
				pstmt = con.prepareStatement(UPDATESTATUS);


				pstmt.setInt(1, 1);
				pstmt.setString(2, memno);
				pstmt.executeUpdate();
				con.commit();
				a=1;
				return a;
				
			}else {
				pstmt = con.prepareStatement(UPDATESTATUS);


				pstmt.setInt(1, 0);
				pstmt.setString(2, memno);

				pstmt.executeUpdate();
				con.commit();
				a=0;
				return a;
			}
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
			if (p1 != null) {
				try {
					p1.close();
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
	public static void main(String[] args) {
		MembersDAO dao = new MembersDAO();
//		int a = dao.checkMemacc("MEM0001");
//		System.out.println(a);
		
//	int a = dao.updateStatus("MEM0001");
//	
//			
//		System.out.println(a);	
			
//			MembersService ms = new MembersService();
//			 int b = ms.updateStatusMembers("MEM0001");
//		System.out.println(b);
		
	}

	@Override
	public MembersVO getpwd(String memacc, String memail) {
		MembersVO membersVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
			con = ds.getConnection();
			pstmt = con.prepareStatement("SELECT MEMPWD,MEMNAME FROM MEMBERS WHERE MEMACC = ? AND MEMAIL = ?");

			pstmt.setString(1, memacc);
			pstmt.setString(2, memail);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				membersVO = new MembersVO();
				membersVO.setMempwd(rs.getString("mempwd"));
				membersVO.setMemname(rs.getString("memname"));
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
		return membersVO;

	}


	

	
	
	
	}
	
	
	
	


