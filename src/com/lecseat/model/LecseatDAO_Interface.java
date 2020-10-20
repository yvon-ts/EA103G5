package com.lecseat.model;

import java.util.*;

import com.lecorder.model.LodrVO;

import java.sql.Connection;


public interface LecseatDAO_Interface {
	
//	public void insert1(LecseatVO lecseatVO);
//	public void delete1(String lodrno, String lecno);
//	public LecseatVO findByPK(String lodrno, String lecno);
//	public List<LecseatVO> getAll();
	
	public void insert (LecseatVO lecseatVO , Connection con);
	public List<LecseatVO> getOrderDetails(String lodrno);
	public void updateStatus (LecseatVO lecseatVO, Connection con);
	
}
