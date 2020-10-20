package jdbcUtil_CompositeQuery;

import java.util.*;

public class jdbcUtil_CompositeQuery_course {
	public static String get_aCondition_For_Oracle(String columnName, String value) {
		
		System.out.println(columnName + " , " + value);
		
		StringBuilder aCondition = new StringBuilder();
		
		if("cstypeno".equals(columnName) ) {
			aCondition.append( columnName + "='" +  value + "'");
		}
		else if ("tchrno".equals(columnName) || "ccstatus".equals(columnName) || "courseno".equals(columnName)) 
			aCondition.append(columnName + " like '%" + value + "%'");
		else if( "searchText".equals(columnName) ) {
			aCondition.append("(upper(coursename)" + " like upper('%" + value + "%')");
			aCondition.append("or upper( courseinfo)" + " like upper('%" + value + "%'))");
		}
		
		
		
			
		
			
//		else if ("hiredate".equals(columnName))                          // ��Oracle��ate
//			aCondition = "to_char(" + columnName + ",'yyyy-mm-dd')='" + value + "'";

		return aCondition.toString() +" ";
	}

	public static String get_WhereCondition(Map<String, String[]> map) {
		
		
		Map<String,String> priceRange = new HashMap<>();//價錢範圍
		
		for(String s : map.keySet()) {
			System.out.println(s + " , " + map.get(s)[0]);
		}
		
		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		
		int count = 0;
		String orderBy = " order by ";
		for (String key : keys) {
			String value = map.get(key)[0];
			if (value != null && value.trim().length() != 0	&& !"action".equals(key)) {
				
				if("order".equals(key)) {
					if("coursepriceLow".equals(value)) {
						orderBy += "courseprice";
					}else {
						orderBy += value + " DESC";
					}
					
				}else if("min".equals(key) ||"max".equals(key)){
					priceRange.put(key, value);
				}else {
					count++;
					String aCondition = get_aCondition_For_Oracle(key, value.trim());

					if (count == 1)
						whereCondition.append(" where " + aCondition);
					else
					whereCondition.append(" and " + aCondition);	

				}
				
			}
			
		}
		
		if(priceRange.size()==2) {
			if(map.size()==3) {
				whereCondition.append(" where courseprice between " + priceRange.get("min") + " and " +  priceRange.get("max") + " ");
			}else {
				whereCondition.append(" and courseprice between " + priceRange.get("min") + " and " +  priceRange.get("max") + " ");
			}
			
		}
		if(orderBy.length() >10)
			return whereCondition.append(orderBy).toString();
		else
			return whereCondition.toString(); //For 首頁搜尋
	}
		

	
	public static void main(String argv[]) {

		// ���� req.getParameterMap()�瘜� �� java.util.Map<java.lang.String,java.lang.String[]> 銋葫閰�
		Map<String, String[]> map = new TreeMap<String, String[]>();
//		map.put("courseno", new String[] { "COUR0001" });
		map.put("cstypeno", new String[] { "TYPE0001" });
//		map.put("job", new String[] { "PRESIDENT" });
//		map.put("hiredate", new String[] { "1981-11-17" });
//		map.put("sal", new String[] { "5000.5" });
//		map.put("comm", new String[] { "0.0" });
//		map.put("deptno", new String[] { "10" });
		map.put("action", new String[] { "getXXX" }); // 瘜冽�ap鋆⊿����ction��ey

		String finalSQL = "select * from course "
				          + jdbcUtil_CompositeQuery_course.get_WhereCondition(map)
				          + "order by courseno";
		System.out.println("���inalSQL = " + finalSQL);

	}
}
