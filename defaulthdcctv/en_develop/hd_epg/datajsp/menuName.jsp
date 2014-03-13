<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%
	MetaData metadata1 = new MetaData(request);
	HashMap nameMap1 = (HashMap)metadata1.getTypeInfoByTypeId(dongzuo);
	HashMap nameMap2 = (HashMap)metadata1.getTypeInfoByTypeId(xiju);
	HashMap nameMap3 = (HashMap)metadata1.getTypeInfoByTypeId(aiqing);
	HashMap nameMap4 = (HashMap)metadata1.getTypeInfoByTypeId(jingsong);
	HashMap nameMap5 = (HashMap)metadata1.getTypeInfoByTypeId(qita);
	HashMap nameMap6 = (HashMap)metadata1.getTypeInfoByTypeId(pianku);
	HashMap nameMap7 = (HashMap)metadata1.getTypeInfoByTypeId(pianhua);
	HashMap allName = new HashMap();
	JSONObject jsonTypeInfo = null;
	if(nameMap1 != null && nameMap1.get("TYPENAME").toString() != null){
		allName.put("name1",nameMap1.get("TYPENAME").toString());
		}else{
			allName.put("name1","动作");
			}
	if(nameMap2 != null && nameMap2.get("TYPENAME").toString() != null){
		allName.put("name2",nameMap2.get("TYPENAME").toString());
		}else{
			allName.put("name2","喜剧");
			}
	if(nameMap3 != null && nameMap3.get("TYPENAME").toString() != null){
		allName.put("name3",nameMap3.get("TYPENAME").toString());
		}else{
			allName.put("name3","爱情");
			}
	if(nameMap4 != null && nameMap4.get("TYPENAME").toString() != null){
		allName.put("name4",nameMap4.get("TYPENAME").toString());
		}else{
			allName.put("name4","惊悚");
			}
	if(nameMap5 != null && nameMap5.get("TYPENAME").toString() != null){
		allName.put("name5",nameMap5.get("TYPENAME").toString());
		}else{
			allName.put("name5","其它");
			}
	if(nameMap6 != null && nameMap6.get("TYPENAME").toString() != null){
		allName.put("name6",nameMap6.get("TYPENAME").toString());
		}else{
			allName.put("name6","片库");
			}
	if(nameMap7 != null && nameMap7.get("TYPENAME").toString() != null){
		allName.put("name7",nameMap7.get("TYPENAME").toString());
		}else{
			allName.put("name7","片花");
			}
			
	 jsonTypeInfo = JSONObject.fromObject(allName);
%>
