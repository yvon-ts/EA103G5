package com.course_attach.model;

import java.util.List;


public interface Course_attachDAO_interface {
	public void insert(Course_attachVO course_attachVO);
	public void update(Course_attachVO course_attachVO);
	public void delete(String attno);
	public Course_attachVO findByPrimaryKey(String attno);
	public List<Course_attachVO> getAll();

}
