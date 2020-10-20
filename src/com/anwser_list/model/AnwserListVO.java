package com.anwser_list.model;

import java.io.Serializable;

public class AnwserListVO implements Serializable{
	private String ansno;
	private String testno;
	private String qbankno;
	private Integer quno;
	private String testans;
	private String oporder;
	private String studentans;
	
	public AnwserListVO() {
		super();
	}

	public AnwserListVO(String ansno, String testno, String qbankno, Integer quno, String testans, String oporder,
			String studentans) {
		super();
		this.ansno = ansno;
		this.testno = testno;
		this.qbankno = qbankno;
		this.quno = quno;
		this.testans = testans;
		this.oporder = oporder;
		this.studentans = studentans;
	}
	
	

	

	public AnwserListVO(String testno, String qbankno, Integer quno, String testans, String oporder) {
		super();
		this.testno = testno;
		this.qbankno = qbankno;
		this.quno = quno;
		this.testans = testans;
		this.oporder = oporder;
	}

	@Override
	public String toString() {
		return "AnwserListVO [ansno=" + ansno + ", testno=" + testno + ", qbankno=" + qbankno + ", quno=" + quno
				+ ", testans=" + testans + ", oporder=" + oporder + ", studentans=" + studentans + "]";
	}

	public String getAnsno() {
		return ansno;
	}

	public void setAnsno(String ansno) {
		this.ansno = ansno;
	}

	public String getTestno() {
		return testno;
	}

	public void setTestno(String testno) {
		this.testno = testno;
	}

	public String getQbankno() {
		return qbankno;
	}

	public void setQbankno(String qbankno) {
		this.qbankno = qbankno;
	}

	public int getQuno() {
		return quno;
	}

	public void setQuno(Integer quno) {
		this.quno = quno;
	}

	public String getTestans() {
		return testans;
	}

	public void setTestans(String testans) {
		this.testans = testans;
	}

	public String getOporder() {
		return oporder;
	}

	public void setOporder(String oporder) {
		this.oporder = oporder;
	}

	public String getStudentans() {
		return studentans;
	}

	public void setStudentans(String studentans) {
		this.studentans = studentans;
	}
	
	
}
