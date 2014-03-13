<%
/******
*生成访问日志文件的
*页面
******/
%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date" %>

<%
UserProfile forGetUserID = new UserProfile(request);
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
String timeStr = sdf.format(new Date());
String userID1 = forGetUserID.getUserId();
HashMap useForLog = new HashMap();

HashMap useForLogInput_Type = new HashMap();
useForLogInput_Type.put("AREA_0","INPUT");
useForLogInput_Type.put("AREA_1","INPUT");
useForLogInput_Type.put("AREA_2","INPUT");
useForLogInput_Type.put("AREA_3","INPUT");

useForLog.put("Log",useForLogInput_Type);
useForLog.put("TIME",timeStr);
useForLog.put("USERID",userID1);
String filename = "Log_"+new SimpleDateFormat("yyyyMMdd").format(new Date())+".txt";

try {
         File file = new File("/home/epg/epg-tomcat/tomcat-6.0.18/logs/visitLogs/"+filename);
	}
catch(FileNotFoundException e)
    {
    }
	if(!file.exists())
	    {
			file.createNewFile();
		}
	
try{
    FileWriter fw = new FileWriter(file,true);
    PrintWriter out1 = new PrintWriter(fw);
    out1.write(useForLog.toString());
    out1.close();
    }
catch(IOException e)
    {
	out.close();
    }
%>
