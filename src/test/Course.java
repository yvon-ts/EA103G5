package test;

import java.io.Serializable;

public class Course implements Serializable{
	
	public Course() {
		courseno = "";
		sellprice = 0;
	}
	
	private String courseno;
	private Integer sellprice;

	public Integer getSellprice() {
		return sellprice;
	}

	public void setSellprice(Integer sellprice) {
		this.sellprice = sellprice;
	}

	public String getCourseno() {
		return courseno;
	}

	public void setCourseno(String courseno) {
		this.courseno = courseno;
	}
	
	
}
