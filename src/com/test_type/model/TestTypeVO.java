package com.test_type.model;

import java.io.Serializable;

public class TestTypeVO implements Serializable{
	private int testtypeno;
	private String testtype;
	private String testdgee;
	
	public TestTypeVO() {
		super();
	}

	public TestTypeVO(int testtypeno, String testtype, String testdgee) {
		super();
		this.testtypeno = testtypeno;
		this.testtype = testtype;
		this.testdgee = testdgee;
	}

	public int getTesttypeno() {
		return testtypeno;
	}

	public void setTesttypeno(int testtypeno) {
		this.testtypeno = testtypeno;
	}

	public String getTesttype() {
		return testtype;
	}

	public void setTesttype(String testtype) {
		this.testtype = testtype;
	}

	public String getTestdgee() {
		return testdgee;
	}

	public void setTestdgee(String testdgee) {
		this.testdgee = testdgee;
	}

	@Override
	public String toString() {
		return "TestTypeVO [testtypeno=" + testtypeno + ", testtype=" + testtype + ", testdgee=" + testdgee + "]";
	}
	
	
	
	
}
