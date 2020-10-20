package com.members.model;

import java.io.InputStream;
import java.sql.*;

public class MembersVO implements java.io.Serializable{
	private String memno;
	private String memacc;
	private String mempwd;
	private String memname;
	private String nkname;
	private Date membday;
	private String memail;
	private String mphone;
	private byte[] mprofile;
	private Timestamp regdate;
	private Integer memdelete;
	
	public MembersVO() {
		
	}
	
	public String getMemno() {
		return memno;
	}
	public void setMemno(String memno) {
		this.memno = memno;
	}
	public String getMemacc() {
		return memacc;
	}
	public void setMemacc(String memacc) {
		this.memacc = memacc;
	}
	public String getMempwd() {
		return mempwd;
	}
	public void setMempwd(String mempwd) {
		this.mempwd = mempwd;
	}
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
	public String getNkname() {
		return nkname;
	}
	public void setNkname(String nkname) {
		this.nkname = nkname;
	}
	public Date getMembday() {
		return membday;
	}
	public void setMembday(Date membday) {
		this.membday = membday;
	}
	public String getMemail() {
		return memail;
	}
	public void setMemail(String memail) {
		this.memail = memail;
	}
	public String getMphone() {
		return mphone;
	}
	public void setMphone(String mphone) {
		this.mphone = mphone;
	}
	public byte[] getMprofile() {
		return mprofile;
	}
	public void setMprofile(byte[] mprofile) {
		this.mprofile = mprofile;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	public Integer getMemdelete() {
		return memdelete;
	}
	public void setMemdelete(Integer memdelete) {
		this.memdelete = memdelete;
	}
	
	
	
	

}
