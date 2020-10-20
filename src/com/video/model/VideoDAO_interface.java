package com.video.model;

import java.util.List;
import java.util.Map;

public interface VideoDAO_interface {
	
	public void insert(VideoVO videoVO);
	public void update(VideoVO videoVO);
	public void update(VideoVO videoVO, Boolean updateVideo);
	public void delete(String videono);
	public VideoVO findByPrimaryKey(String videono);
	public List<VideoVO> getAll();
	
	// 萬用複合查詢
	public List<VideoVO> getAll(Map<String, String[]> map);
}
