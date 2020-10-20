package com.promo_list.model;

import java.util.List;

public interface PromoListDAO_interface {
	
	public void insert(PromoListVO promoListVO);
	public void update(PromoListVO promoListVO);
	public void delete(String promono);
	public PromoListVO findByPrimaryKey(String promono);
	public List<PromoListVO> getAll();
}
