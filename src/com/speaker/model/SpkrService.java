package com.speaker.model;

import java.util.List;

public class SpkrService {
	
	private SpkrDAO_Interface dao;
	
	public SpkrService() {
		dao = new SpkrDAO();
	}
	
	public SpkrVO addSpkr(String spkrname, String spkrphone, String spkremail, byte[] spkrinfo, byte[] spkricon) {
		
		SpkrVO spkrVO = new SpkrVO();
		
		spkrVO.setSpkrname(spkrname);
		spkrVO.setSpkrphone(spkrphone);
		spkrVO.setSpkremail(spkremail);
		spkrVO.setSpkrinfo(spkrinfo);
		spkrVO.setSpkricon(spkricon);
		dao.insert(spkrVO);
		
		return spkrVO;
	}

	public SpkrVO updateSpkr(String spkrno, String spkrname, String spkrphone, String spkremail, byte[] spkrinfo, byte[] spkricon) {
		
		SpkrVO spkrVO = new SpkrVO();
		
		spkrVO.setSpkrno(spkrno);
		spkrVO.setSpkrname(spkrname);
		spkrVO.setSpkrphone(spkrphone);
		spkrVO.setSpkremail(spkremail);
		spkrVO.setSpkrinfo(spkrinfo);
		spkrVO.setSpkricon(spkricon);
		dao.update(spkrVO);
		
		return spkrVO;
	}
	
	public void deleteSpkr(String spkrno) {
		dao.delete(spkrno);
	}
	
	public SpkrVO getOne(String spkrno) {
		return dao.findByPK(spkrno);
	}
	
	public List<SpkrVO> getList(){
		return dao.getAll();
	}
	
}
