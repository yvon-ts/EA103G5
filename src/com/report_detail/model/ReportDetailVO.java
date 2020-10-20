package com.report_detail.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class ReportDetailVO implements Serializable {
	
	
	private static final long serialVersionUID = 1L;
	private String reportno;
	private String memno;
	private String postno;
	private String poststatus;
	private String empno;
	private Timestamp reportlmod;
	
	
	public String getReportno() {
		return reportno;
	}
	public void setReportno(String reportno) {
		this.reportno = reportno;
	}
	public String getMemno() {
		return memno;
	}
	public void setMemno(String memno) {
		this.memno = memno;
	}
	public String getPostno() {
		return postno;
	}
	public void setPostno(String postno) {
		this.postno = postno;
	}
	public String getPoststatus() {
		return poststatus;
	}
	public void setPoststatus(String poststatus) {
		this.poststatus = poststatus;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public Timestamp getReportlmod() {
		return reportlmod;
	}
	public void setReportlmod(Timestamp reportlmod) {
		this.reportlmod = reportlmod;
	}
	
	
	
	
	

}
