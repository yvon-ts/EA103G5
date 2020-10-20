package com.report_detail.model;

import java.sql.Timestamp;
import java.util.List;

public class ReportDetailService {

	private ReportDetailDAO_interface dao;

	public ReportDetailService() {
		dao = new ReportDetailDAO();
	}

	// insert-addReport
	public ReportDetailVO addReport(String memno, String postno) {

		ReportDetailVO reportdetailVO = new ReportDetailVO();

		reportdetailVO.setMemno(memno);
		reportdetailVO.setPostno(postno);
		dao.insert(reportdetailVO);
		return reportdetailVO;

	}

	// update 員工檢查若有不當言論將postatus 改成隱藏(下架)
	public ReportDetailVO updateReport(String reportno) {

		ReportDetailVO reportdetailVO = new ReportDetailVO();

		reportdetailVO.setReportno(reportno);

		dao.update(reportdetailVO);
		return reportdetailVO;

	}

	// getOne-用reportno 去查詢
	public ReportDetailVO getOneReport(String reportno) {
		return dao.findByPrimaryKey(reportno);
	}

	// getAll
	public List<ReportDetailVO> getAll() {
		return dao.getAll();
	}

	// getPending
	public List<ReportDetailVO> getPending() {
		return dao.getPending();
	}

	// getSettled
	public List<ReportDetailVO> getSettled() {
		return dao.getSettled();
	}

	// removeReport 上架
	public ReportDetailVO removeReport(String reportno) {

		ReportDetailVO reportdetailVO = new ReportDetailVO();

		reportdetailVO.setReportno(reportno);

		dao.removeReport(reportdetailVO);
		return reportdetailVO;

	}

	// getByMemNo
	public List<ReportDetailVO> findByMemno(String memno) {
		return dao.findByMemno(memno);
	}

	// getByEmpNo
	public List<ReportDetailVO> findByEmpno(String empno) {
		return dao.findByEmpno(empno);
	}
	//會員移除檢舉
	public ReportDetailVO deleteReport(String reportno) {

		ReportDetailVO reportdetailVO = new ReportDetailVO();

		reportdetailVO.setReportno(reportno);

		dao.deleteReport(reportdetailVO);
		return reportdetailVO;

	}
	
		
		
		
	}
	
	
	

