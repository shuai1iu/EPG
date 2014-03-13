<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>

<%
	MetaData metaData = new MetaData(request);
	String SDintroduce = "";
	HashMap SDinfomap = new HashMap();
	SDinfomap = metaData.getTypeInfoByTypeId("10000100000000090000000000032751"); 
	SDintroduce = (String)SDinfomap.get("TYPE_INTRODUCE");

	String tempList = "";
	String[] strList = SDintroduce.split("@");
	int rollsize = 0;
	int strSize = 0;
	int textSize = 22;
		
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
					tempList = strList[i].substring(0 + textSize *j, textSize * (j+1));
					arrList.add(tempList);
				}else{
					tempList = strList[i].substring(0 + textSize *j, strList[i].length());
					arrList.add(tempList);
				}
			}
		}else{
			arrList.add(strList[i]);
		}
	}
	rollsize = arrList.size();
	String[] rollText = new String[rollsize];
	for(int k = 0 ; k < rollsize ; k++){
		rollText[k] = arrList.get(k).toString();
	}
%>
