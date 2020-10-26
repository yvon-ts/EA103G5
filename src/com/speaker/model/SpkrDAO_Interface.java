package com.speaker.model;

import java.util.*;

public interface SpkrDAO_Interface {
	
	public void insert(SpkrVO spkrVO);
	public void insertNoPic(SpkrVO spkrVO);
	public void update(SpkrVO spkrVO);
	public void updateNoPic(SpkrVO spkrVO);
	public void delete(String spkrno);
	public SpkrVO findByPK(String spkrno);
	public List<SpkrVO> getAll();

}
