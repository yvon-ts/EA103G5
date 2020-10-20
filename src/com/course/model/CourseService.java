package com.course.model;

import java.util.List;
import java.util.Map;

public class CourseService {

		private CourseDAO_interface dao;
		
		public CourseService() {
			dao = new CourseDAO();
		}
		
		public CourseVO addCourse(String cstypeno, String tchrno, String coursename, String courseinfo, Integer courseprice, Integer ttltime, String csstatus, Integer csscore, Integer csscoretimes,byte[] courseimg) {
			
			CourseVO courseVO = new CourseVO();
			
			courseVO.setCstypeno(cstypeno);
			courseVO.setTchrno(tchrno);
			courseVO.setCoursename(coursename);
			courseVO.setCourseinfo(courseinfo);
			courseVO.setCourseprice(courseprice);
			courseVO.setTtltime(ttltime);
			courseVO.setCsstatus(csstatus);
			courseVO.setCsscore(csscore);
			courseVO.setCsscoretimes(csscoretimes);
			courseVO.setCourseimg(courseimg);
			dao.insert(courseVO);
			
			return courseVO;
		}
		
		public CourseVO updateCourse(String courseno, String cstypeno, String tchrno, String coursename, String courseinfo, Integer courseprice, Integer ttltime, String csstatus, Integer csscore, Integer csscoretimes,byte[] courseimg) {
			
			CourseVO courseVO = new CourseVO();
			
			courseVO.setCourseno(courseno);
			courseVO.setCstypeno(cstypeno);
			courseVO.setTchrno(tchrno);
			courseVO.setCoursename(coursename);
			courseVO.setCourseinfo(courseinfo);
			courseVO.setCourseprice(courseprice);
			courseVO.setTtltime(ttltime);
			courseVO.setCsstatus(csstatus);
			courseVO.setCsscore(csscore);
			courseVO.setCsscoretimes(csscoretimes);
			courseVO.setCourseimg(courseimg);
			dao.update(courseVO);
			
			return courseVO;	
		}
		
		public CourseVO getOneCourse(String courseno) {
			return dao.findPrimaryKey(courseno);
		}
		
		public List<CourseVO> getAllForUser() {
			return dao.getAllForUser();
		}
		
		public List<CourseVO> getAllForEmployee() {
			return dao.getAllForEmployee();
		}
		
		// 複合查詢，須要再升級
		public List<CourseVO> getAll(Map<String, String[]> map) {
			return dao.getAll(map);
		}
}
