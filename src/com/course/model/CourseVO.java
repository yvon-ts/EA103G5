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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((courlmod == null) ? 0 : courlmod.hashCode());
		result = prime * result + Arrays.hashCode(courseimg);
		result = prime * result + ((courseinfo == null) ? 0 : courseinfo.hashCode());
		result = prime * result + ((coursename == null) ? 0 : coursename.hashCode());
		result = prime * result + ((courseno == null) ? 0 : courseno.hashCode());
		result = prime * result + ((courseprice == null) ? 0 : courseprice.hashCode());
		result = prime * result + ((csscore == null) ? 0 : csscore.hashCode());
		result = prime * result + ((csscoretimes == null) ? 0 : csscoretimes.hashCode());
		result = prime * result + ((csstatus == null) ? 0 : csstatus.hashCode());
		result = prime * result + ((cstypeno == null) ? 0 : cstypeno.hashCode());
		result = prime * result + ((tchrno == null) ? 0 : tchrno.hashCode());
		result = prime * result + ((ttltime == null) ? 0 : ttltime.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CourseVO other = (CourseVO) obj;
		if (courlmod == null) {
			if (other.courlmod != null)
				return false;
		} else if (!courlmod.equals(other.courlmod))
			return false;
		if (!Arrays.equals(courseimg, other.courseimg))
			return false;
		if (courseinfo == null) {
			if (other.courseinfo != null)
				return false;
		} else if (!courseinfo.equals(other.courseinfo))
			return false;
		if (coursename == null) {
			if (other.coursename != null)
				return false;
		} else if (!coursename.equals(other.coursename))
			return false;
		if (courseno == null) {
			if (other.courseno != null)
				return false;
		} else if (!courseno.equals(other.courseno))
			return false;
		if (courseprice == null) {
			if (other.courseprice != null)
				return false;
		} else if (!courseprice.equals(other.courseprice))
			return false;
		if (csscore == null) {
			if (other.csscore != null)
				return false;
		} else if (!csscore.equals(other.csscore))
			return false;
		if (csscoretimes == null) {
			if (other.csscoretimes != null)
				return false;
		} else if (!csscoretimes.equals(other.csscoretimes))
			return false;
		if (csstatus == null) {
			if (other.csstatus != null)
				return false;
		} else if (!csstatus.equals(other.csstatus))
			return false;
		if (cstypeno == null) {
			if (other.cstypeno != null)
				return false;
		} else if (!cstypeno.equals(other.cstypeno))
			return false;
		if (tchrno == null) {
			if (other.tchrno != null)
				return false;
		} else if (!tchrno.equals(other.tchrno))
			return false;
		if (ttltime == null) {
			if (other.ttltime != null)
				return false;
		} else if (!ttltime.equals(other.ttltime))
			return false;
		return true;
	}

	
	
}
