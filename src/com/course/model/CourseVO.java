package com.course.model;

import java.io.Serializable;
import java.sql.Clob;
import java.sql.Timestamp;
import java.util.Arrays;

import oracle.sql.BLOB;

public class CourseVO implements Serializable {

	private String courseno;
	private String cstypeno;
	private String tchrno;
	private String coursename;
	private String courseinfo;
	private Integer courseprice;
	private Integer ttltime;
	private String csstatus;
	private Integer csscore;
	private Integer csscoretimes;
	private byte[] courseimg;
	private Timestamp courlmod;

	public String getCsstatus() {
		return csstatus;
	}

	public void setCsstatus(String csstatus) {
		this.csstatus = csstatus;
	}

	public Integer getCsscore() {
		return csscore;
	}

	public void setCsscore(Integer csscore) {
		this.csscore = csscore;
	}

	public Integer getCsscoretimes() {
		return csscoretimes;
	}

	public void setCsscoretimes(Integer csscoretimes) {
		this.csscoretimes = csscoretimes;
	}

	public String getCourseno() {
		return courseno;
	}

	public void setCourseno(String courseno) {
		this.courseno = courseno;
	}

	public String getCstypeno() {
		return cstypeno;
	}

	public void setCstypeno(String cstypeno) {
		this.cstypeno = cstypeno;
	}

	public String getTchrno() {
		return tchrno;
	}

	public void setTchrno(String tchrno) {
		this.tchrno = tchrno;
	}

	public String getCoursename() {
		return coursename;
	}

	public void setCoursename(String coursename) {
		this.coursename = coursename;
	}

	public String getCourseinfo() {
		return courseinfo;
	}

	public void setCourseinfo(String courseinfo) {
		this.courseinfo = courseinfo;
	}

	public Integer getCourseprice() {
		return courseprice;
	}

	public void setCourseprice(Integer courseprice) {
		this.courseprice = courseprice;
	}

	public Integer getTtltime() {
		return ttltime;
	}

	public void setTtltime(Integer ttltime) {
		this.ttltime = ttltime;
	}

	public byte[] getCourseimg() {
		return courseimg;
	}

	public void setCourseimg(byte[] courseimg) {
		this.courseimg = courseimg;
	}

	
	public Timestamp getCourlmod() {
		return courlmod;
	}

	public void setCourlmod(Timestamp courlmod) {
		this.courlmod = courlmod;
	}

	@Override
	public String toString() {
		return "CourseVO [courseno=" + courseno + ", cstypeno=" + cstypeno + ", tchrno=" + tchrno + ", coursename="
				+ coursename + ", courseinfo=" + courseinfo + ", courseprice=" + courseprice + ", ttltime=" + ttltime
				+ ", csstatus=" + csstatus + ", csscore=" + csscore + ", csscoretimes=" + csscoretimes + ", courseimg="
				+ Arrays.toString(courseimg) + ", courlmod=" + courlmod + "]";
	}

	
	
}
