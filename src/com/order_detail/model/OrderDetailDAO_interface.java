package com.order_detail.model;

import java.sql.Connection;
import java.util.List;

public interface OrderDetailDAO_interface {
	public void insert(OrderDetailVO orderDetailVO, Connection con);
	public void update(OrderDetailVO orderDetailVO);
	public List<OrderDetailVO> getAll();
	public List<OrderDetailVO> findByOrderNo(String orderno);
	public OrderDetailVO findByPrimaryKey(String orderno, String courseno);
	
}
