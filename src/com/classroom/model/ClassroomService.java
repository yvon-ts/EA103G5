package com.classroom.model;

import java.util.List;

public class ClassroomService {

	private ClassroomDAO_interface dao;

	public ClassroomService() {
		dao = new ClassroomDAO();
	}

	public ClassroomVO addClassroom(String roomname, Integer roomrow, Integer roomcolumn, String defaultseat,
			Boolean roomdelete) {

		ClassroomVO classroomVO = new ClassroomVO();

		classroomVO.setRoomname(roomname);
		classroomVO.setRoomrow(roomrow);
		classroomVO.setRoomcolumn(roomcolumn);
		classroomVO.setDefaultseat(defaultseat);
		classroomVO.setRoomdelete(roomdelete);
		dao.insert(classroomVO);

		return classroomVO;
	}

	// 預留給 Structs 2
	public void addClassroom(ClassroomVO classroomVO) {
		dao.insert(classroomVO);
	}

	public ClassroomVO updateClassroom(String roomno, String roomname, Integer roomrow, Integer roomcolumn,
			String defaultseat, Boolean roomdelete) {

		ClassroomVO classroomVO = new ClassroomVO();

		classroomVO.setRoomno(roomno);
		classroomVO.setRoomname(roomname);
		classroomVO.setRoomrow(roomrow);
		classroomVO.setRoomcolumn(roomcolumn);
		classroomVO.setDefaultseat(defaultseat);
		classroomVO.setRoomdelete(roomdelete);
		dao.update(classroomVO);
//		classroomVO.setRoomlastmod(dao.update(classroomVO));

		return classroomVO;
	}

	public ClassroomVO getOneClassroom(String roomno) {
		return dao.findByPrimaryKey(roomno);
	}

	public List<ClassroomVO> getAll() {
		return dao.getAll();
	}
}
