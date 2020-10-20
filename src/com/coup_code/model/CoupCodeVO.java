package com.coup_code.model;

import java.io.Serializable;
import java.sql.Date;
import oracle.sql.DATE;

public class CoupCodeVO implements Serializable {

	private String coupno;
	private String memno;
	private String coupcode;
	private Integer discamt;
	private Integer discstatus;
	private Date couptime;
	private Date coupexp;
	
	
	
	public CoupCodeVO() {
		super();
	}
	public String getCoupno() {
		return coupno;
	}
	public void setCoupno(String coupno) {
		this.coupno = coupno;
	}
	public String getMemno() {
		return memno;
	}
	public void setMemno(String memno) {
		this.memno = memno;
	}
	public String getCoupcode() {
		return coupcode;
	}
	public void setCoupcode(String coupcode) {
		this.coupcode = coupcode;
	}
	public Integer getDiscamt() {
		return discamt;
	}
	public void setDiscamt(Integer discamt) {
		this.discamt = discamt;
	}
	public Integer getDiscstatus() {
		return discstatus;
	}
	public void setDiscstatus(Integer discstatus) {
		this.discstatus = discstatus;
	}
	public Date getCouptime() {
		return couptime;
	}
	public void setCouptime(Date couptime) {
		this.couptime = couptime;
	}
	public Date getCoupexp() {
		return coupexp;
	}
	public void setCoupexp(Date coupexp) {
		this.coupexp = coupexp;
	}
	@Override
	public String toString() {
		return "CoupCodeVO [coupno=" + coupno + ", memno=" + memno + ", coupcode=" + coupcode + ", discamt=" + discamt
				+ ", discstatus=" + discstatus + ", couptime=" + couptime + ", coupexp=" + coupexp + "]";
	}
	
	
	
}