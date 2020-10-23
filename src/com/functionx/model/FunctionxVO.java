package com.functionx.model;

import java.io.Serializable;
import java.sql.Date;

public class FunctionxVO implements Serializable{

	private String funcno;
	private String funcname;
	private String urls;
	private Date funclmod;
	
	
	public String getFuncno() {
		return funcno;
	}
	public void setFuncno(String funcno) {
		this.funcno = funcno;
	}
	public String getFuncname() {
		return funcname;
	}
	public String getUrl() {
		return urls;
	}
	public void setUrl(String urls) {
		this.urls = urls;
	}
	public void setFuncname(String funcname) {
		this.funcname = funcname;
	}
	public Date getFunclmod() {
		return funclmod;
	}
	public void setFunclmod(Date funclmod) {
		this.funclmod = funclmod;
	}
	
}
