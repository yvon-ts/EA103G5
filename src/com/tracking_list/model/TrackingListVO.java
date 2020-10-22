package com.tracking_list.model;

import java.io.Serializable;

public class TrackingListVO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String memno;
	private String courseno;
	
	
	
	public TrackingListVO() {
		super();
	}
	public String getMemno() {
		return memno;
	}
	public void setMemno(String memno) {
		this.memno = memno;
	}
	public String getCourseno() {
		return courseno;
	}
	public void setCourseno(String courseno) {
		this.courseno = courseno;
	}
	@Override
	public String toString() {
		return "TrackingListVO [memno=" + memno + ", courseno=" + courseno + "]";
	}
	
	
	
}
