package com.order_detail.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class OrderDetailVO implements Serializable {
	
	private String orderno;
	private String courseno;
	private Integer sellprice;
	private String odstatus;
	private String promono;
	
	
	public OrderDetailVO() {
		super();
	}
	public String getPromono() {
		return promono;
	}
	public void setPromono(String promono) {
		this.promono = promono;
	}
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	public String getCourseno() {
		return courseno;
	}
	public void setCourseno(String courseno) {
		this.courseno = courseno;
	}
	public Integer getSellprice() {
		return sellprice;
	}
	public void setSellprice(Integer sellprice) {
		this.sellprice = sellprice;
	}
	public String getOdstatus() {
		return odstatus;
	}
	public void setOdstatus(String odstatus) {
		this.odstatus = odstatus;
	}
	@Override
	public String toString() {
		return "OrderDetailVO [orderno=" + orderno + ", courseno=" + courseno + ", sellprice=" + sellprice
				+ ", odstatus=" + odstatus + ", promono=" + promono + "]";
	}
	
	
}
