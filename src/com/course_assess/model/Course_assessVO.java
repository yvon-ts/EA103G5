package com.course_assess.model;
import java.sql.*;

public class Course_assessVO implements java.io.Serializable {
	private String asesno;
	private String courseno;
	private String memno;
	private Integer coursescore;
	private String comments;
	private Timestamp commenttime;
	
	public Course_assessVO() {
		
	}
	
	
	public String getAsesno() {
		return asesno;
	}
	public void setAsesno(String asesno) {
		this.asesno = asesno;
	}
	public String getCourseno() {
		return courseno;
	}
	public void setCourseno(String courseno) {
		this.courseno = courseno;
	}
	public String getMemno() {
		return memno;
	}
	public void setMemno(String memno) {
		this.memno = memno;
	}
	public Integer getCoursescore() {
		return coursescore;
	}
	public void setCoursescore(Integer coursescore) {
		this.coursescore = coursescore;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public Timestamp getCommenttime() {
		return commenttime;
	}
	public void setCommenttime(Timestamp commenttime) {
		this.commenttime = commenttime;
	}

}
