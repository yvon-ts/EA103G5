package com.lecorder.model;

import java.sql.Timestamp;

public class LodrVO implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private String lodrno;
	private String memno;
	private String lecno;
	private Integer lecamt;
	private String lodrseat;
	private String lodrstatus;
	private Timestamp lodrtime;
	private Timestamp lodrlmod;
	
	public String getLodrno() {
		return lodrno;
	}
	public void setLodrno(String lodrno) {
		this.lodrno = lodrno;
	}
	public String getMemno() {
		return memno;
	}
	public void setMemno(String memno) {
		this.memno = memno;
	}
	public String getLecno() {
		return lecno;
	}
	public void setLecno(String lecno) {
		this.lecno = lecno;
	}
	public Integer getLecamt() {
		return lecamt;
	}
	public void setLecamt(Integer lecamt) {
		this.lecamt = lecamt;
	}
	public String getLodrseat() {
		return lodrseat;
	}
	public void setLodrseat(String lodrseat) {
		this.lodrseat = lodrseat;
	}
	public String getLodrstatus() {
		return lodrstatus;
	}
	public void setLodrstatus(String lodrstatus) {
		this.lodrstatus = lodrstatus;
	}
	public Timestamp getLodrtime() {
		return lodrtime;
	}
	public void setLodrtime(Timestamp lodrtime) {
		this.lodrtime = lodrtime;
	}
	public Timestamp getLodrlmod() {
		return lodrlmod;
	}
	public void setLodrlmod(Timestamp lodrlmod) {
		this.lodrlmod = lodrlmod;
	}

	

}
