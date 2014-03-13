<!-- 文件名：util_GetShortcut.jsp -->
<!-- 描  述：四个快捷按键 -->
<!-- 修改人：zhanglingjun -->
<!-- 修改时间：2010-8-11 -->
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ include file = "../config/config_Shortcut.jsp"%>
<script>

var typeName = new Array(); //栏目名称
var tnameStr_Temp = new Array(); // 栏目名2字符截取
var typeId = new Array(); //栏目编号
var isSelSuc = false;
var isShortcut=0;
<%    
    //获取父栏目编号
   // String strTypeId = PARENTID;
    
    //获取所有栏目
	String typeIdList[]={TYPEID_NEWFILM,TYPEID_HOTFILM,TYPEID_SPORT,TYPEID_FINANCE};
	
	int isShortcut=0;
	for(int i=0;i<4;i++)
	{
	    String vodName=new MetaData(request).getTypeNameByTypeId(typeIdList[i]);
		String tnameStr_Temp="";
		String typeID="";
		if(null!=vodName)
		{
			if (vodName.length() > 2)
			{
				tnameStr_Temp = vodName.substring(0,2);
			}
			else
			{
				tnameStr_Temp = vodName;
			}
			
            typeID=typeIdList[i];
			
            
%>
            isSelSuc=true;	
            typeName[<%=isShortcut%>] = '<%=vodName%>';
			tnameStr_Temp[<%=isShortcut%>] = '<%=tnameStr_Temp%>';
			typeId[<%=isShortcut%>] = '<%=typeID%>';

<%		
            isShortcut++;
		}
	}
	
%>
	typeName = ["新片","热剧","体育","财经"];
	tnameStr_Temp = ["新片","热剧","体育","财经"];
	isShortcut=<%=isShortcut%>;

</script>