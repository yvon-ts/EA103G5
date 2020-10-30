package com.lecseat.model;

import java.util.*;

import com.lecorder.model.LodrVO;

import java.sql.Connection;


public interface LecseatDAO_Interface {
	
	public void insert (LecseatVO lecseatVO , Connection con);
	public List<LecseatVO> getOrderDetails(String lodrno);
	public void updateStatus (LecseatVO lecseatVO, Connection con);
	public int countMemSeats(String memno, String lecno);
}
