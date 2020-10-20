package com.report_detail.model;

import java.util.List;


public interface ReportDetailDAO_interface {
	
	
	public ReportDetailVO insert(ReportDetailVO reportdetailVO);//新增檢舉
	public void update(ReportDetailVO reportdetailVO);//下架
	public ReportDetailVO findByPrimaryKey(String reportno);
	public List<ReportDetailVO> getAll();
	public List<ReportDetailVO> findByMemno(String memno); 
	public List<ReportDetailVO> findByEmpno(String empno);
	public List<ReportDetailVO> getPending();//未處理
	public List<ReportDetailVO> getSettled();//已處理
	public void removeReport(ReportDetailVO reportdetailVO); //上架
	public void deleteReport(ReportDetailVO reportdetailVO);//會員移除檢舉

}
