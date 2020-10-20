package com.speaker.model;


public class SpkrVO implements java.io.Serializable{
	
	private static final long serialVersionUID = 1L;
	private String spkrno;
	private String spkrname;
	private String spkrphone;
	private String spkremail;
	private byte[] spkrinfo;
	private byte[] spkricon;
	
	public String getSpkrno() {
		return spkrno;
	}
	public void setSpkrno(String spkrno) {
		this.spkrno = spkrno;
	}
	public String getSpkrname() {
		return spkrname;
	}
	public void setSpkrname(String spkrname) {
		this.spkrname = spkrname;
	}
	public String getSpkrphone() {
		return spkrphone;
	}
	public void setSpkrphone(String spkrphone) {
		this.spkrphone = spkrphone;
	}
	public String getSpkremail() {
		return spkremail;
	}
	public void setSpkremail(String spkremail) {
		this.spkremail = spkremail;
	}
	public byte[] getSpkrinfo() {
		return spkrinfo;
	}
	public void setSpkrinfo(byte[] spkrinfo) {
		this.spkrinfo = spkrinfo;
	}
	
	public byte[] getSpkricon() {
		return spkricon;
	}
	
	public void setSpkricon(byte[] spkricon) {
		this.spkricon = spkricon;
	}
	
}
