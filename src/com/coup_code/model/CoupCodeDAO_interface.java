package com.coup_code.model;

import java.sql.Connection;
import java.util.List;;

public interface CoupCodeDAO_interface {
	
	public void insert(CoupCodeVO coupCodeVO);
	public void update(CoupCodeVO coupCodeVO);
	public CoupCodeVO findByPrimaryKey(String coupno);
	public List<CoupCodeVO> getAll();
	public List<CoupCodeVO> findByMemno(String memno);
	public void autogive(CoupCodeVO coupCodeVO, Connection con);
	public Integer findForCheckout(String coupno);

}
