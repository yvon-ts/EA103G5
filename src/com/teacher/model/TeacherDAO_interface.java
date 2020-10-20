package com.teacher.model;
import java.util.*;

public interface TeacherDAO_interface {
	public void insert(TeacherVO teacherVO);
	public void update(TeacherVO teacherVO);
	public void updateStatus(String tchrno,String tchrstatus,String rejreason);
	public TeacherVO findByPrimaryKey(String tchrno);
	public List<TeacherVO>getAll();
	public TeacherVO getStatus(String memno);

}
