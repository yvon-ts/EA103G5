package com.teacher.model;

import java.io.*;
import java.sql.*;
import java.util.List;

public class TeacherService {
	private TeacherDAO_interface dao ;
	public TeacherService() {
		dao = new TeacherDAO();
	}
	public TeacherVO addTeacher(String memno,String tchrintro,byte[] tchrcert2,byte[]tchrcert1,String bankacc) {
		TeacherVO teacherVO = new TeacherVO();
		teacherVO.setMemno(memno);
		teacherVO.setTchrintro(tchrintro);
		teacherVO.setTchrcert1(tchrcert1);
		teacherVO.setTchrcert2(tchrcert2);
		teacherVO.setBankacc(bankacc);
		dao.insert(teacherVO);
		
		return teacherVO ;
		
	}
	
	public TeacherVO updateTeacher(String tchrno,String tchrintro,String bankacc,byte[]tchrcert1,byte[]tchrcert2) {
		TeacherVO teacherVO = new TeacherVO();
		teacherVO.setTchrno(tchrno);
		teacherVO.setTchrintro(tchrintro);
		teacherVO.setBankacc(bankacc);
		teacherVO.setTchrcert1(tchrcert1);
		teacherVO.setTchrcert2(tchrcert2);
		
		dao.update(teacherVO);
		return teacherVO;
		
	}
	public TeacherVO getOneTeacher(String tchrno) {
		return dao.findByPrimaryKey(tchrno);
	}
	public List<TeacherVO> getAll(){
		return dao.getAll();
	}
	public void updateStatusTeacher(String tchrno,String tchrstatus,String rejreason) {
		dao.updateStatus(tchrno,tchrstatus,rejreason);
	}
	
	public TeacherVO getStatus(String memno) {
		
		return dao.getStatus(memno);
		
		
	}
	
	
	

}
