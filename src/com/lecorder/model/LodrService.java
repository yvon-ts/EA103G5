package com.lecorder.model;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.List;
import com.lecseat.model.*;
import com.lecture.model.*;

public class LodrService {
	
	private LodrDAO_Interface dao;
	
	public LodrService() {
		dao = new LodrDAO();
	}
	
	public void addLodr(LodrVO lodrVO, List<LecseatVO> seatList, LecVO lecVO) {
		
		dao.insertSeatAndLayout(lodrVO, seatList, lecVO);
	}
	
	public List<LodrVO> getListByMem(String memno) {
		 return dao.findByMemno(memno);
	}
	
	public void updateLodr(LodrVO lodrVO, List<LecseatVO> seatList, LecVO lecVO) {
		
		dao.updateOne(lodrVO, seatList, lecVO);
	}
	
	public LodrVO addLodr2(String memno, Integer lecamt, String lodrstatus, Timestamp lodrtime) {
		
		LodrVO lodrVO1 = new LodrVO();
		
		lodrVO1.setMemno(memno);
		lodrVO1.setLecamt(lecamt);
		lodrVO1.setLodrstatus(lodrstatus);
		lodrVO1.setLodrtime(lodrtime);
		//dao.insert(lodrVO);
		
		return lodrVO1;
	}
	
	public LodrVO updateLodr(String lodrno, String memno, Integer lecamt, String lodrstatus, Timestamp lodrtime) {
		
		LodrVO lodrVO = new LodrVO();
		
		lodrVO.setLodrno(lodrno);
		lodrVO.setMemno(memno);
		lodrVO.setLecamt(lecamt);
		lodrVO.setLodrstatus(lodrstatus);
		lodrVO.setLodrtime(lodrtime);
		dao.update(lodrVO);
		
		return lodrVO;
	}
	
	public void deleteLodr(String lodrno) {
		dao.delete(lodrno);
	}
	
	public LodrVO getOne(String lodrno) {
		return dao.findByPK(lodrno);
	} 
	
	public List<LodrVO> getList() {
		return dao.getAll();
	}

}
