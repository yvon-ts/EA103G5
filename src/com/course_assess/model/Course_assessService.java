package com.course_assess.model;

import java.io.*;
import java.sql.*;
import java.util.List;

public class Course_assessService {
	private Course_assessDAO_interface dao;
	public Course_assessService() {
		dao = new Course_assessDAO();
	}
	
	public Course_assessVO addCourse_assess(String courseno,String memno,Integer coursescore,String comments) {
		Course_assessVO course_assessVO = new Course_assessVO();
		course_assessVO.setCourseno(courseno);
		course_assessVO.setMemno(memno);
		course_assessVO.setCoursescore(coursescore);
		course_assessVO.setComments(comments);
		dao.insert(course_assessVO);
		
		return course_assessVO;
	}
	public Course_assessVO updateCourse_assess(Integer coursescore,String comments) {
		Course_assessVO course_assessVO = new Course_assessVO();
		course_assessVO.setCoursescore(coursescore);
		course_assessVO.setComments(comments);
		dao.update(course_assessVO);
		return course_assessVO;
		
	}
	
	public Course_assessVO getOneCourse_assess(String asesno) {
		return dao.findByPrimaryKey(asesno);
		
	}
	public List<Course_assessVO> getAll(){
		return dao.getAll();
	}
    
	public void deleteCourse_assess(String asesno) {
		dao.delete(asesno);
	}
}
