package com.order_master.model;

import java.io.Serializable;
import java.sql.Date;

public class OrderMasterVO implements Serializable{
	
	private String orderno;
	private String memno;
	private Date orderdate;
	private String orderstatus;
	private Integer orderamt;
	private String coupno;
	private String payby;
	
	
	
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	public String getMemno() {
		return memno;
	}
	public void setMemno(String memno) {
		this.memno = memno;
	}
	public Date getOrderdate() {
		return orderdate;
	}
	public void setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
	}
	public String getOrderstatus() {
		return orderstatus;
	}
	public void setOrderstatus(String orderstatus) {
		this.orderstatus = orderstatus;
	}
	public Integer getOrderamt() {
		return orderamt;
	}
	public void setOrderamt(Integer orderamt) {
		this.orderamt = orderamt;
	}
	public String getCoupno() {
		return coupno;
	}
	public void setCoupno(String coupno) {
		this.coupno = coupno;
	}
	public String getPayby() {
		return payby;
	}
	public void setPayby(String payby) {
		this.payby = payby;
	}
	public OrderMasterVO() {
		super();
	}
	@Override
	public String toString() {
		return "OrderMasterVO [orderno=" + orderno + ", memno=" + memno + ", orderdate=" + orderdate + ", orderstatus="
				+ orderstatus + ", orderamt=" + orderamt + ", coupno=" + coupno + ", payby=" + payby + "]";
	}
	
	
}
