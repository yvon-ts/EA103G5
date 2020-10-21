package com.lecture.model;

import java.sql.Timestamp;
import java.util.List;

public class LecService {
	
	private LecDAO_Interface dao;
	
	public LecService() {
		dao = new LecDAO();
	}
	
	public LecVO addLec(String lecname, Integer lecprice, String spkrno, String roomno, 
			Timestamp lecstart, Timestamp lecend, Timestamp signstart, Timestamp signend, 
			String initseat, String currseat, byte[] lecinfo, byte[] lecpic) {
		
		LecVO lecVO = new LecVO();
		lecVO.setLecname(lecname);
		lecVO.setLecprice(lecprice);
		lecVO.setSpkrno(spkrno);
		lecVO.setRoomno(roomno);
		lecVO.setLecstart(lecstart);
		lecVO.setLecend(lecend);
		lecVO.setSignstart(signstart);
		lecVO.setSignend(signend);
		lecVO.setInitseat(initseat);
		lecVO.setCurrseat(currseat);
		lecVO.setLecinfo(lecinfo);
		lecVO.setLecpic(lecpic);
		dao.insert(lecVO);
		
		return lecVO;
	}
	
	public LecVO addLecText(String lecname, Integer lecprice, String spkrno, String roomno, 
			Timestamp lecstart, Timestamp lecend, Timestamp signstart, Timestamp signend, 
			String initseat, String currseat, byte[] lecinfo) {
		
		LecVO lecVO = new LecVO();
		lecVO.setLecname(lecname);
		lecVO.setLecprice(lecprice);
		lecVO.setSpkrno(spkrno);
		lecVO.setRoomno(roomno);
		lecVO.setLecstart(lecstart);
		lecVO.setLecend(lecend);
		lecVO.setSignstart(signstart);
		lecVO.setSignend(signend);
		lecVO.setInitseat(initseat);
		lecVO.setCurrseat(currseat);
		lecVO.setLecinfo(lecinfo);
		dao.insertNoPic(lecVO);
		
		return lecVO;
	}
	
public LecVO updateLec(String lecno, String lecname, Integer lecprice, String spkrno, String roomno, Timestamp lecstart, Timestamp lecend, Timestamp signstart, Timestamp signend, String initseat, String currseat, Integer lecstatus, byte[] lecinfo, byte[] lecpic) {
		
		LecVO lecVO = new LecVO();
		lecVO.setLecno(lecno);
		lecVO.setLecname(lecname);
		lecVO.setLecprice(lecprice);
		lecVO.setSpkrno(spkrno);
		lecVO.setRoomno(roomno);
		lecVO.setLecstart(lecstart);
		lecVO.setLecend(lecend);
		lecVO.setSignstart(signstart);
		lecVO.setSignend(signend);
		lecVO.setInitseat(initseat);
		lecVO.setCurrseat(currseat);
		lecVO.setLecstatus(lecstatus);
		lecVO.setLecinfo(lecinfo);
		lecVO.setLecpic(lecpic);
		dao.update(lecVO);
		
		return lecVO;
	}

	public LecVO updateText(String lecno, String lecname, Integer lecprice, String spkrno, String roomno, Timestamp lecstart, Timestamp lecend, Timestamp signstart, Timestamp signend, String initseat, String currseat, Integer lecstatus, byte[] lecinfo) {
		
		LecVO lecVO = new LecVO();
		lecVO.setLecno(lecno);
		lecVO.setLecname(lecname);
		lecVO.setLecprice(lecprice);
		lecVO.setSpkrno(spkrno);
		lecVO.setRoomno(roomno);
		lecVO.setLecstart(lecstart);
		lecVO.setLecend(lecend);
		lecVO.setSignstart(signstart);
		lecVO.setSignend(signend);
		lecVO.setInitseat(initseat);
		lecVO.setCurrseat(currseat);
		lecVO.setLecstatus(lecstatus);
		lecVO.setLecinfo(lecinfo);
		dao.updateNoPic(lecVO);
		
		return lecVO;
	}
	
	public LecVO getOne(String lecno){
		return dao.findByPK(lecno);
	}
	
	public List<LecVO> getList(){
		return dao.getAll();
	}
}
