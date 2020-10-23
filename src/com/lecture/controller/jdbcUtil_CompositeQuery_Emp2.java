package com.lecture.controller;

import java.util.*;

public class jdbcUtil_CompositeQuery_Emp2 {

	public static String get_aCondition_For_Oracle(String columnName, String value) {
		String aCondition = null;

		if ("lecstatus".equals(columnName)) {
			aCondition = columnName + "=" + value;
		} else if ("lecno".equals(columnName) || "lecname".equals(columnName) || "spkrno".equals(columnName) || "roomno".equals(columnName)) {
			aCondition = columnName + " like '%" + value + "%'";
		} else if ("lecpriceMin".equals(columnName)) {
			aCondition = columnName + ">=" + value;
		} else if ("lecpriceMax".equals(columnName)) {
			aCondition = columnName + "<" + value;
		} else if ("lecstartMin".equals(columnName)) {
			aCondition = "to_char(" + columnName + ",'yyyy-mm-dd')>='" + value + "'";
		} else if ("lecstartMax".equals(columnName)) {
			aCondition = "to_char(" + columnName + ",'yyyy-mm-dd')<'" + value + "'";
		}
			return aCondition + " ";
		}
		
	
	public static String get_aRange_For_Oracle(String columnName, String value) {

		String aCondition = null;
		
		if ("lecstatus".equals(columnName)) {
			aCondition = columnName + "=" + value;
		} else if ("lecno".equals(columnName) || "lecname".equals(columnName) || "spkrno".equals(columnName) || "roomno".equals(columnName)) {
			aCondition = columnName + " like '%" + value + "%'";
		} else if ("lecpriceMin".equals(columnName)) {
			aCondition = columnName + ">=" + value;
		} else if ("lecpriceMax".equals(columnName)) {
			aCondition = columnName + "<" + value;
		} else if ("lecstartMin".equals(columnName)) {
			aCondition = "to_char(" + columnName + ",'yyyy-mm-dd')>='" + value + "'";
		} else if ("lecstartMax".equals(columnName)) {
			aCondition = "to_char(" + columnName + ",'yyyy-mm-dd')<'" + value + "'";
		}
			return aCondition + " ";
		}

//		if ("start".equals(column1) && "end".equals(column2))
//			aCondition = "to_char(" + column1 + ",'yyyy-mm-dd')>='" + value1 + "and" + "to_char(" + column2 + ",'yyyy-mm-dd')<'" + value2 + "'";
//		
//		("lecstatus".equals(columnName)) {
//			aCondition = columnName + "=" + value;
//		} else if ("lecprice".equals(columnName)) {
//			int price = Integer.parseInt(columnName) - 200;
//			String priceMin = Integer.toString(price);
//			aCondition = columnName + "<" + value + "and" + columnName + ">=" + priceMin;
//		} else if ("lecno".equals(columnName) || "lecname".equals(columnName) || "spkrno".equals(columnName) || "roomno".equals(columnName))
//			aCondition = columnName + " like '%" + value + "%'";
//
//		return aCondition + " ";
//	}

	public static String get_WhereCondition(Map<String, String[]> map) {
		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		for (String key : keys) {
			String value = map.get(key)[0];
			if (value != null && value.trim().length() != 0	&& !"action".equals(key)) {
				count++;
				String aCondition = get_aCondition_For_Oracle(key, value.trim());

				if (count == 1)
					whereCondition.append(" where " + aCondition); //前後多放空格防呆
				else
					whereCondition.append(" and " + aCondition);

				System.out.println("���e�X�d�߸�ƪ�����count = " + count);
			}
		}
		
		return whereCondition.toString();
	}
	
	

	public static void main(String argv[]) {

		// 配合 req.getParameterMap()方法 回傳 java.util.Map<java.lang.String,java.lang.String[]> 之測試
		Map<String, String[]> map = new TreeMap<String, String[]>(); //HashMap也可以
		
		//匿名陣列取代以下寫法
		//寫法一：
		//String[] empno = new String[1];
		//empno[0] = "7001";
		
		map.put("empno", new String[] { "7001" });
		map.put("ename", new String[] { "KING" });
		map.put("job", new String[] { "PRESIDENT" });
		map.put("hiredate", new String[] { "1981-11-17" });
		map.put("sal", new String[] { "5000.5" });
		map.put("comm", new String[] { "0.0" });
		map.put("deptno", new String[] { "10" });
		map.put("action", new String[] { "getXXX" }); // 注意Map裡面會含有action的key

		String finalSQL = "select * from emp2 "
				          + jdbcUtil_CompositeQuery_Emp2.get_WhereCondition(map)
				          + "order by empno";
		System.out.println("����finalSQL = " + finalSQL);

	}
}
