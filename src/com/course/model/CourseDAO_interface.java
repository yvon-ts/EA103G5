package com.course.model;

import java.util.List;
import java.util.Map;

public interface CourseDAO_interface {
	public String insert(CourseVO courseVO);

	public void update(CourseVO courseVO);
	public void update(CourseVO courseVO, Boolean updatePicture);
	public void updateStatus(CourseVO courseVO);

	public CourseVO findPrimaryKey(String courseno);

	public List<CourseVO> getAllForUser();
	
	public List<CourseVO> getAllForEmployee();
	
	public List<CourseVO> getAll(Map<String, String[]> map);
}
