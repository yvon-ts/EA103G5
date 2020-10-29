/*
 *  1. �U�νƦX�d��-�i�ѫȤ���H�N�W�����Q�d�ߪ����
 *  2. ���F�קK�v�T�į�:
 *        �ҥH�ʺA���͸U��SQL������,���d�ҵL�N�ĥ�MetaData���覡,�]�u�w��ӧO��Table�ۦ���ݭn�ӭӧO�s�@��
 * */


package jdbcUtil_CompositeQuery;

import java.util.*;

public class jdbcUtil_CompositeQuery_question {

	public static String get_aCondition_For_Oracle(String columnName, String value) {
		
		
		System.out.println(columnName + " , " +  value) ;
		StringBuilder aCondition = new StringBuilder();

		if ( "courseno".equals(columnName) || "testscope".equals(columnName)) // �Ω��L
			aCondition.append(columnName + "=" + "'" + value  + "'");
		else if ("qustmt".equals(columnName) ) 
			aCondition.append(columnName + " like '%" + value + "%'");
		else if("testtypeno".equals(columnName) )
			aCondition.append(columnName + "=" + value  );
		return aCondition.append(" ").toString();
	}

	public static String get_WhereCondition(Map <String, String[]> map) {

		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		for (String key : map.keySet()) {
			String value = map.get(key)[0];
			
			if (value != null && value.trim().length() != 0	&& !"action".equals(key) && !"coursename".equals(key)) {
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

//	public static void main(String argv[]) {
//
//		// �t�X req.getParameterMap()��k �^�� java.util.Map<java.lang.String,java.lang.String[]> ������
//		Map<String, String[]> map = new TreeMap<String, String[]>();
//		map.put("empno", new String[] { "7001" });
//		map.put("ename", new String[] { "KING" });
//		map.put("job", new String[] { "PRESIDENT" });
//		map.put("hiredate", new String[] { "1981-11-17" });
//		map.put("sal", new String[] { "5000.5" });
//		map.put("comm", new String[] { "0.0" });
//		map.put("deptno", new String[] { "10" });
//		map.put("action", new String[] { "getXXX" }); // �`�NMap�̭��|�t��action��key
//
//		String finalSQL = "select * from emp2 "
//				          + jdbcUtil_CompositeQuery_Emp2.get_WhereCondition(map)
//				          + "order by empno";
//		System.out.println("����finalSQL = " + finalSQL);
//
//	}
}
