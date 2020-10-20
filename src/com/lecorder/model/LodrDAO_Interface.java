package com.lecorder.model;

import java.sql.Connection;
import java.util.*;

import com.lecseat.model.LecseatVO;
import com.lecture.model.LecVO;

public interface LodrDAO_Interface {

	public void update(LodrVO lodrVO);
	public void delete(String lodrno);
	public LodrVO findByPK(String lodrno);
	public List<LodrVO> getAll();
	
	public void insertSeatAndLayout(LodrVO lodrVO, List<LecseatVO> list, LecVO lecVO);
	public List<LodrVO> findByMemno(String memno);
	public void updateOne(LodrVO lodrVO, List<LecseatVO> seatList, LecVO lecVO);
	
}
