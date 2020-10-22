package com.members.model;

import java.io.*;
import java.sql.*;
import java.util.List;

public class MembersService {
	private MembersDAO_interface dao;

	public MembersService() {
		dao = new MembersDAO();
	}

	public MembersVO addMembers(String memacc, String mempwd, String memname, String nkname, Date membday,
			String memail, String mphone, byte[] mprofile) {
		MembersVO membersVO = new MembersVO();

		membersVO.setMemacc(memacc);
		membersVO.setMempwd(mempwd);
		membersVO.setMemname(memname);
		membersVO.setNkname(nkname);
		membersVO.setMembday(membday);
		membersVO.setMemail(memail);
		membersVO.setMphone(mphone);
		membersVO.setMprofile(mprofile);
		dao.insert(membersVO);

		return membersVO;
	}

	public MembersVO updateMembers(String mempwd, String nkname, byte[] mprofile,
			String memno) {
		MembersVO membersVO = new MembersVO();
		membersVO.setMempwd(mempwd);
		membersVO.setNkname(nkname);
		membersVO.setMprofile(mprofile);
		membersVO.setMemno(memno);

		dao.updateMembers(membersVO);
		return membersVO;
	}



	public MembersVO getOneMembers(String memno) {
		return dao.findByPrimaryKey(memno);

	}

	public MembersVO signIn(String memacc, String mempwd) {
		return dao.signIn(memacc, mempwd);
	}

	public List<MembersVO> getAll() {
		return dao.getAll();
	}
	
	public Integer updateStatusMembers(String memno) {
		int a = dao.updateStatus(memno);
		return a;
	}

	public Integer checkMemacc(String memacc) {
		int a = dao.checkMemacc(memacc);
		return a;
	}
	

}
