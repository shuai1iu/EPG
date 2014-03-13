<%
/**********************
* FileName:util_AdText.jsp
* Time:20130909 9:30
* Author:ZSZ
* description:标清首页跑
* 马灯，按字数要求进行切
* 割后显示
**********************/
%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>

<%
	MetaData metaData = new MetaData(request);
	String SDintroduce = "";
	HashMap SDinfomap = new HashMap();
	try{
//		SDinfomap = metaData.getTypeInfoByTypeId("10000100000000090000000000034874"); 
		SDinfomap = metaData.getTypeInfoByTypeId("10000100000000090000000000037174");//������
		SDintroduce = (String)SDinfomap.get("TYPE_INTRODUCE");
	}catch(Exception e){
		SDintroduce = "直播港澳台专区集港澳台三地最新资讯，精彩不容错过！@果果乐园、天年乐、快乐学堂专区现已上线，欢迎收看！@";//这里请填写出现异常时需要显示的默认跑马灯提示
	}
//	SDintroduce = "直播港澳台专区集港澳台三地最新资讯，精彩不容错过！@果果乐园、天年乐、快乐学堂专区现已上线，欢迎收看！@";

	String tempList = "";
	String[] strList = SDintroduce.split("@");
	int rollsize = 0;
	int strSize = 0;
	int textSize = 26;
		
	ArrayList<String> arrList = new ArrayList<String>();
		
	for(int i = 0;i < strList.length;i++){
		if(strList[i].length() > textSize){
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

	if(arrList.size() >0){
		tempList = arrList.get(0).toString();
		arrList.add(tempList);//实现虚拟无缝滚动
	}

	rollsize = arrList.size();
	String[] rollText = new String[rollsize];
	for(int k = 0 ; k < (rollsize + 1) ; k++){
		if( k < rollsize){
			rollText[k] = arrList.get(k).toString();
		}
	}
%>
