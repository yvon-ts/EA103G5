package com.course_attach.model;
import java.io.*;
import java.sql.*;
import java.util.List;



public class Course_attachService {
	private Course_attachDAO_interface dao;
	public Course_attachService() {
		dao = new Course_attachDAO();
	}
	
	public Course_attachVO addCourse_attach(String courseno,String attname,byte[] attfile) {
		Course_attachVO course_attachVO = new Course_attachVO();
		course_attachVO.setCourseno(courseno);
		course_attachVO.setAttname(attname);
		course_attachVO.setAttfile(attfile);
		dao.insert(course_attachVO);
		
		return course_attachVO;

}
	public Course_attachVO updateCourse_attach(String attname,byte[] attfile) {
		Course_attachVO course_attachVO = new Course_attachVO();
		course_attachVO.setAttname(attname);
		course_attachVO.setAttfile(attfile);
		dao.update(course_attachVO);
		return course_attachVO;
		
	}
	public Course_attachVO getOneCourse_attach(String attno) {
		return dao.findByPrimaryKey(attno);
		
	}
	
	public List<Course_attachVO> getAll(){
		return dao.getAll();
	}
	
	public void deleteCourse_assess(String attno) {
		dao.delete(attno);
	}
	
	
}