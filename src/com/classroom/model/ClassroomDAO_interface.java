package com.classroom.model;

import java.sql.Timestamp;
import java.util.*;

public interface ClassroomDAO_interface {
	public void insert(ClassroomVO classroomVO);

	public void update(ClassroomVO classroomVO);

	public ClassroomVO findByPrimaryKey(String roomno);

	public List<ClassroomVO> getAll();
}