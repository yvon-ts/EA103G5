package com.tests.model;

import java.io.Serializable;
import java.sql.Timestamp ;

public class TestsVO implements Serializable{
	private String testno;
	private String courseno;
	private String memno;
	private String testscope;
	private Double score;
	private Timestamp testtime;
	
	public TestsVO() {
		super();
	}

	public TestsVO(String testno, String courseno, String memno, String testscope, Double score, Timestamp testtime) {
		super();
		this.testno = testno;
		this.courseno = courseno;
		this.memno = memno;
		this.testscope = testscope;
		this.score = score;
		this.testtime = testtime;
	}
	
	

	@Override
	public String toString() {
		return "TestVO [testno=" + testno + ", courseno=" + courseno + ", memno=" + memno + ", testscope=" + testscope
				+ ", score=" + score + ", testtime=" + testtime + "]";
	}

	public String getTestno() {
		return testno;
	}

	public void setTestno(String testno) {
		this.testno = testno;
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

	public String getTestscope() {
		return testscope;
	}

	public void setTestscope(String testscope) {
		this.testscope = testscope;
	}

	public double getScore() {
		return score;
	}

	public void setScore(Double score) {
		this.score = score;
	}

	public Timestamp getTesttime() {
		return testtime;
	}

	public void setTesttime(Timestamp testtime) {
		this.testtime = testtime;
	}
	
	
	
}
