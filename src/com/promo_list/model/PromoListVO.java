package com.promo_list.model;

import java.io.Serializable;
import java.sql.Date;

public class PromoListVO implements Serializable{
	
	private String promono;
	private String promoname;
	private Date startdate;
	private Date enddate;
	private String promoinfo;
	public PromoListVO() {
		super();
	}
	public String getPromono() {
		return promono;
	}
	public void setPromono(String promono) {
		this.promono = promono;
	}
	public String getPromoname() {
		return promoname;
	}
	public void setPromoname(String promoname) {
		this.promoname = promoname;
	}
	public Date getStartdate() {
		return startdate;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	public Date getEnddate() {
		return enddate;
	}
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}
	public String getPromoinfo() {
		return promoinfo;
	}
	public void setPromoinfo(String promoinfo) {
		this.promoinfo = promoinfo;
	}
	
}
