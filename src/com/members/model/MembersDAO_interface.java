package com.members.model;

import java.util.*;

public interface MembersDAO_interface {
	public void insert(MembersVO membersVO);
	public Integer updateStatus(String memno);
	public MembersVO findByPrimaryKey(String memno);
	public MembersVO signIn(String memacc,String mempwd);
	public List<MembersVO> getAll();
	public Integer checkMemacc(String memacc);
	public MembersVO checkMemail(String memail);
	public void updateMembers(MembersVO membersVO);
	public void photo(MembersVO membersVO);
}
