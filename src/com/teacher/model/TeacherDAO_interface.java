package com.teacher.model;
import java.util.*;

public interface TeacherDAO_interface {
	public void insert(TeacherVO teacherVO);
	public void update(TeacherVO teacherVO);
	public void updateStatus(String tchrno,String tchrstatus,String rejreason);
	public TeacherVO findByPrimaryKey(String tchrno);
	public List<TeacherVO>getAll();
	public List<TeacherVO>getAll(Map<String,String[]>map);
	public TeacherVO getStatus(String memno);
	public TeacherVO getOneTeacherByMemno(String memno);

}
