package com.promo_detail.model;

import java.util.List;

public interface PromoDetailDAO_interface {
	
	public void insert(PromoDetailVO promoDetailVO);
	public void update(PromoDetailVO promoDetailVO);
	public void delete(String promono, String cstypeno);
	public PromoDetailVO findByPrimaryKey(String promono, String cstypeno);
	public List<PromoDetailVO> getAll();
	
}
