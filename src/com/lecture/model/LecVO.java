package com.lecture.model;

import java.sql.Timestamp;

public class LecVO implements java.io.Serializable{
	
	private static final long serialVersionUID = 1L;
	private String lecno;
	private String lecname;
	private Integer lecprice;
	private String spkrno;
	private String roomno;
	private Timestamp lecstart;
	private Timestamp lecend;
	private Timestamp signstart;
	private Timestamp signend;
	private String initseat;
	private String currseat;
	private byte[] lecpic;
	private byte[] lecinfo;
	private Integer lecstatus;
	private Timestamp leclmod;
	
	public String getLecno() {
		return lecno;
	}
	public void setLecno(String lecno) {
		this.lecno = lecno;
	}
	public String getLecname() {
		return lecname;
	}
	public void setLecname(String lecname) {
		this.lecname = lecname;
	}
	
	public Integer getLecprice() {
		return lecprice;
	}
	public void setLecprice(Integer lecprice) {
		this.lecprice = lecprice;
	}
	
	public String getSpkrno() {
		return spkrno;
	}
	public void setSpkrno(String spkrno) {
		this.spkrno = spkrno;
	}
	public String getRoomno() {
		return roomno;
	}
	public void setRoomno(String roomno) {
		this.roomno = roomno;
	}
	public Timestamp getLecstart() {
		return lecstart;
	}
	public void setLecstart(Timestamp lecstart) {
		this.lecstart = lecstart;
	}
	public Timestamp getLecend() {
		return lecend;
	}
	public void setLecend(Timestamp lecend) {
		this.lecend = lecend;
	}
	public Timestamp getSignstart() {
		return signstart;
	}
	public void setSignstart(Timestamp signstart) {
		this.signstart = signstart;
	}
	public Timestamp getSignend() {
		return signend;
	}
	public void setSignend(Timestamp signend) {
		this.signend = signend;
	}
	public String getInitseat() {
		return initseat;
	}
	public void setInitseat(String initseat) {
		this.initseat = initseat;
	}
	public String getCurrseat() {
		return currseat;
	}
	public void setCurrseat(String currseat) {
		this.currseat = currseat;
	}
	
	public byte[] getLecpic() {
		return lecpic;
	}
	public void setLecpic(byte[] lecpic) {
		this.lecpic = lecpic;
	}
	public byte[] getLecinfo() {
		return lecinfo;
	}
	public void setLecinfo(byte[] lecinfo) {
		this.lecinfo = lecinfo;
	}
	public Integer getLecstatus() {
		return lecstatus;
	}
	public void setLecstatus(Integer lecstatus) {
		this.lecstatus = lecstatus;
	}
	public Timestamp getLeclmod() {
		return leclmod;
	}
	public void setLeclmod(Timestamp leclmod) {
		this.leclmod = leclmod;
	}
	
	
}
