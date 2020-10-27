/*
 * 1.萬用複合查詢-可由客戶端隨意增減任何想查詢的欄位
 * 2.為了避免影響效能:所以動態產生萬用SQL的部分,本範例無意採用MetaData的方式,也只針對個別的Table自行視需要而個別製作之
 * 
 * 
 * */





package com.teacher.model;

import java.util.*;

public class jdbcUtil_CompositeQuery_Teacher {

	public static String get_aCondition_For_Oracle(String columnName, String value) {

		String aCondition = null;

		if ("TCHRINTRO".equals(columnName) || "TCHRCERT1".equals(columnName) || "TCHRCERT2".equals(columnName)) // 用於其他
			aCondition = columnName + "=" + value;
		else if ("TCHRNO".equals(columnName) || "MEMNO".equals(columnName)|| "TCHRSTATUS".equals(columnName)|| "REJREASON".equals(columnName)|| "BANKACC".equals(columnName)) // 用於varchar
			aCondition = columnName + " like '%" + value + "%'";
//		else if ("hiredate".equals(columnName))                          // 用於Oracle的date
//			aCondition = "to_char(" + columnName + ",'yyyy-mm-dd')='" + value + "'";

		return aCondition + " ";
	}

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
					whereCondition.append(" where " + aCondition);
				else
					whereCondition.append(" and " + aCondition);

				System.out.println("有送出查詢資料的欄位數count = " + count);
			}
		}
		
		return whereCondition.toString();
	}

	public static void main(String argv[]) {

		// 配合req.getParameterMap()的方法java.util.Map<java.lang.String,java.lang.String[]> 之測試
		Map<String, String[]> map = new TreeMap<String, String[]>();
		map.put("empno", new String[] { "7001" });
		map.put("ename", new String[] { "KING" });
		map.put("job", new String[] { "PRESIDENT" });
		map.put("hiredate", new String[] { "1981-11-17" });
		map.put("sal", new String[] { "5000.5" });
		map.put("comm", new String[] { "0.0" });
		map.put("deptno", new String[] { "10" });
		map.put("action", new String[] { "getXXX" }); // 注意Map裡面會含有action的key

		String finalSQL = "select * from emp2 "
				          + jdbcUtil_CompositeQuery_Teacher.get_WhereCondition(map)
				          + "order by empno";
		System.out.println("����finalSQL = " + finalSQL);

	}
}
