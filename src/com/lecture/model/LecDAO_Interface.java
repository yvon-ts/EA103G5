package com.lecture.model;

import java.sql.Connection;
import java.util.List;

public interface LecDAO_Interface {
	
	public void insert(LecVO lecVO);
	public void insertNoPic(LecVO lecVO);
	public void update(LecVO lecVO);
	public void updateNoPic(LecVO lecVO);
	public LecVO findByPK(String lecno);
	public List<LecVO> getAll();
	
	public void updateSeats(LecVO lecVO, Connection con);
	public List<LecVO> getTextQuery(String query, String orderBy);
	public List<LecVO> queryOrderBy(String query);
	
}