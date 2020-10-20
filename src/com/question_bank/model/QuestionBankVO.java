package com.question_bank.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import oracle.sql.CLOB;

public class QuestionBankVO implements Serializable{
	private String  qbankno;
	private String courseno;
	private Integer typeno;
	private String testscope;
	private String qustmt;
	private String op1;
	private String op2;
	private String op3;
	private String op4;
	private String quans;
	private Integer qustatus;
	private List<String> optionList = null;
	


	public List<String> getOptionList() {
		return optionList;
	}

	public void setOptionList(List<String> optionList) {
		this.optionList = optionList;
		this.setOp1(optionList.get(0));
		this.setOp2(optionList.get(1));
		this.setOp3(optionList.get(2));
		this.setOp4(optionList.get(3));
	}



	public QuestionBankVO() {
		super();
	}

	public String getQbankno() {
		return qbankno;
	}

	public void setQbankno(String qbankno) {
		this.qbankno = qbankno;
	}

	public String getCourseno() {
		return courseno;
	}

	public void setCourseno(String courseno) {
		this.courseno = courseno;
	}

	public Integer getTypeno() {
		return typeno;
	}

	public void setTypeno(Integer typeno) {
		this.typeno = typeno;
	}

	public String getTestscope() {
		return testscope;
	}

	public void setTestscope(String testscope) {
		this.testscope = testscope;
	}

	public String getQustmt() {
		return qustmt;
	}

	public void setQustmt(String qustmt) {
		this.qustmt = qustmt;
	}

	public String getOp1() {
		return op1;
	}

	public void setOp1(String op1) {
		optionList = new ArrayList<>();
		this.op1 = op1;
		optionList.add(op1);
	}

	public String getOp2() {
		return op2;
	}

	public void setOp2(String op2) {
		this.op2 = op2;
		optionList.add(op2);
	}

	public String getOp3() {
		return op3;
	}

	public void setOp3(String op3) {
		this.op3 = op3;
		optionList.add(op3);
	}

	public String getOp4() {
		return op4;
	}

	public void setOp4(String op4) {
		this.op4 = op4;
		optionList.add(op4);
	}

	public String getQuans() {
		return quans;
	}

	public void setQuans(String quans) {
		this.quans = quans;
	}

	public Integer getQustatus() {
		return qustatus;
	}

	public void setQustatus(Integer qustatus) {
		this.qustatus = qustatus;
	}

	@Override
	public String toString() {
		return "QuestionBankVO [qbankno=" + qbankno + ", courseno=" + courseno + ", typeno=" + typeno + ", testscope="
				+ testscope + ", qustmt=" + qustmt + ", op1=" + op1 + ", op2=" + op2 + ", op3=" + op3 + ", op4=" + op4
				+ ", quans=" + quans + ", qustatus=" + qustatus + ", optionList=" + optionList + "]";
	}


	
	
	
}
