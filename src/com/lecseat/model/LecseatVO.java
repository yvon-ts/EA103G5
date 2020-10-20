package com.lecseat.model;

public class LecseatVO implements java.io.Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String lodrno;
	private String seatno;
	private String seatstatus;
	
	public String getLodrno() {
		return lodrno;
	}
	public void setLodrno(String lodrno) {
		this.lodrno = lodrno;
	}
	public String getSeatno() {
		return seatno;
	}
	public void setSeatno(String seatno) {
		this.seatno = seatno;
	}
	public String getSeatstatus() {
		return seatstatus;
	}
	public void setSeatstatus(String seatstatus) {
		this.seatstatus = seatstatus;
	}
}
