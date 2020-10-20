package com.coup_code.model;

import java.util.List;;

public interface CoupCodeDAO_interface {
	
	public void insert(CoupCodeVO coupCodeVO);
	public void update(CoupCodeVO coupCodeVO);
	public CoupCodeVO findByPrimaryKey(String coupno);
	public List<CoupCodeVO> getAll();

}
