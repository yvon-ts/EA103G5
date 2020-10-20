package com.lecture.model;

import java.sql.Connection;
import java.util.List;

public interface LecDAO_Interface {
	
	public void insert(LecVO lecVO);
	public void update(LecVO lecVO);
	public LecVO findByPK(String lecno);
	public List<LecVO> getAll();
	
	public void updateSeats(LecVO lecVO, Connection con);
	
}