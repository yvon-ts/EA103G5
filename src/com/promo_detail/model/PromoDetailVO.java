package com.promo_detail.model;

import java.io.Serializable;

public class PromoDetailVO implements Serializable {
	
	private String promono;
	private String cstypeno;
	private Integer percentage;
	
	public PromoDetailVO() {
		super();
	}
	public String getPromono() {
		return promono;
	}
	public void setPromono(String promono) {
		this.promono = promono;
	}
	public String getCstypeno() {
		return cstypeno;
	}
	public void setCstypeno(String cstypeno) {
		this.cstypeno = cstypeno;
	}
	public Integer getPercentage() {
		return percentage;
	}
	public void setPercentage(Integer percentage) {
		this.percentage = percentage;
	}
	
}
