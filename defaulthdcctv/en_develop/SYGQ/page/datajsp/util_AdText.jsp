<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="net.sf.json.JSONArray"%>
<%@ page import="net.sf.json.JSONObject"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>

<%
    JSONArray stringArray = null; //节目列表
	MetaData metaData = new MetaData(request);
	String SDintroduce = "";
	HashMap SDinfomap = new HashMap();
	SDinfomap = metaData.getTypeInfoByTypeId("10000100000000090000000000034874"); 
	if(null!=SDinfomap)
	{ 
	    SDintroduce = (String)SDinfomap.get("TYPE_INTRODUCE");
	}

	String tempString = "";
	String[] strList = SDintroduce.split("@");
	int rollsize = 0;
	int strSize = 0;
	int textSize = 30;
		
	ArrayList<String> arrList = new ArrayList<String>();
		
	for(int i = 0;i < strList.length;i++){
		if(strList[i].length() > textSize*(i+1)){
			if((strList[i].length() % textSize) >0){
				strSize = strList[i].length()/textSize +1;
			}else{
				strSize = strList[i].length()/textSize;
			}
			for(int j = 0;j < strSize;j++){
				if(textSize * (j+1) < strList[i].length()){
					tempString = strList[i].substring(0 + textSize *j, textSize * (j+1));
					arrList.add(tempString);
				}else{
					tempString = strList[i].substring(0 + textSize *j, strList[i].length());
					arrList.add(tempString);
				}
			}
		}else{
			arrList.add(strList[i]);
		}
	}
	rollsize = arrList.size();
	ArrayList rollText = new ArrayList();
	for(int k = 0 ; k < rollsize ; k++){
		rollText.add(arrList.get(k).toString());
	}
	
	        
			
	stringArray = JSONArray.fromObject(rollText);
%>
