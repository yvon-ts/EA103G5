package com.course_assess.model;

import java.util.List;

public interface Course_assessDAO_interface {
	public void insert(Course_assessVO course_assessVO);
	public void update(Course_assessVO course_assessVO);
	public void delete(String asesno);
	public Course_assessVO findByPrimaryKey(String memno);
	public List<Course_assessVO> getAll(String courseno);
	public String avgScore(String courseno);
	public Course_assessVO checkMembers(String memno,String courseno);
	public List<Course_assessVO> getAllForAjax(String courseno,Integer pagesize);
	

}
