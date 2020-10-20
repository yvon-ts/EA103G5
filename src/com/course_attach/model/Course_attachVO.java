package com.course_attach.model;

public class Course_attachVO implements java.io.Serializable {
	private String attno = null;
	private String courseno = null;
	private String attname = null;
	private byte[] attfile = null;

	public Course_attachVO() {

	}

	public String getAttno() {
		return attno;
	}

	public void setAttno(String attno) {
		this.attno = attno;
	}

	public String getCourseno() {
		return courseno;
	}

	public void setCourseno(String courseno) {
		this.courseno = courseno;
	}

	public String getAttname() {
		return attname;
	}

	public void setAttname(String attname) {
		this.attname = attname;
	}

	public byte[] getAttfile() {
		return attfile;
	}

	public void setAttfile(byte[] attfile) {
		this.attfile = attfile;
	}
}
