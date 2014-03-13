<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="../util/util_getPosterPaths.jsp"%>
<%@ include file="database.jsp"%>
<script>
<%
//String[][] imgs={{"TYPE_PICPATH","images/temp/13.jpg"}};
//String[] texts={"TYPE_NAME","TYPE_INTRODUCE"};
ArrayList array=new MyUtil(request).getVasListData("10000100000000090000000000029042",12);

ArrayList sdfivearray=new MyUtil(request).getVasListData(sdfivecode,1);
if(sdfivearray == null){sdfivearray = new ArrayList();}
ArrayList sdtwoarray=new MyUtil(request).getVasListData(sdtwocode,3);
if(sdtwoarray == null){sdtwoarray = new ArrayList();}
ArrayList hdfourarray=new MyUtil(request).getVasListData("10000100000000090000000000029042",4);
if(hdfourarray == null){hdfourarray = new ArrayList();}
ArrayList hdtwoarray=new MyUtil(request).getVasListData("10000100000000090000000000029042",12);
if(hdtwoarray == null){hdtwoarray = new ArrayList();}

ArrayList array1=new MyUtil(request).getVodListData("10000100000000090000000000029036",4);
ArrayList array2=new MyUtil(request).getVasListData("10000100000000090000000000029040",8);

MetaData metadata = new MetaData(request);
/////////////////////////////////////////////////////////////////////////
////
String[] indexiframePic = new String[1];
String[] vasList2Pic=new String[8];
String vasurl = "";


ArrayList tmpiframeVas=(ArrayList)metadata.getVasListByTypeId(indexiframecode, 1, 0);
if(tmpiframeVas!=null)
{
	ArrayList tmpiframeVasInfo = (ArrayList)tmpiframeVas.get(1);
	if(tmpiframeVasInfo!=null&&tmpiframeVasInfo.size()>0)
	{
		HashMap mapindexx=(HashMap)tmpiframeVasInfo.get(0);
		int tempindexvasid=(Integer)mapindexx.get("VASID");

		ServiceHelp serviceHelpxx = new ServiceHelp(request);
		if(serviceHelpxx!=null)
		{
			vasurl=serviceHelpxx.getVasUrl(tempindexvasid);
			Map mapindex = metadata.getVasDetailInfo(tempindexvasid);
			indexiframePic[0]=mapindex.get("POSTERPATH").toString();
		}
	}
}

ArrayList tmpimgVas=(ArrayList)metadata.getVasListByTypeId("10000100000000090000000000029040", 8, 0);
int vaslength=0;
if(tmpimgVas!=null && tmpimgVas.size()>1){
	ArrayList tmpVasList = (ArrayList)tmpimgVas.get(1);
	if(tmpVasList!=null && tmpVasList.size()>0){
		vaslength=tmpVasList.size();
		for(int i=0;i<tmpVasList.size() ;i++){
			HashMap mapindexx=(HashMap)tmpVasList.get(i);
			int tempindexvasid=(Integer)mapindexx.get("VASID");
			Map mapindex = metadata.getVasDetailInfo(tempindexvasid);
			//vasList2Pic[i]=mapindex.get("POSTERPATH").toString();
			
			HashMap postersMap = (HashMap)mapindex.get("POSTERPATHS");
			String postpath = (String)mapindex.get("POSTERPATH");
			vasList2Pic[i] =  getPosterPath(postersMap,request,postpath,"1").toString();
			
		}
	}
}


System.out.println("defaultcctvhd-----------------------------------------------vasurl="+vasurl);
System.out.println("defaultcctvhd----------------------------------------------indexiframePic[0]="+indexiframePic[0]);
////
////////////////////////////////////////////////////////////////////////////
//  ArrayList array_mid=new MyUtil(request).getTypeListData(index_mid,1);

//中间图片获取及滚动字幕
/*
   HashMap map = (HashMap)metadata.getTypeInfoByTypeId(index_mid);
   String introduce = (String)map.get("INTRODUCE");
   HashMap posterPathMap = (HashMap)map.get("POSTERPATHS");
   String postertype = "0";
   String picPath="";
   picPath =  getPosterPath(posterPathMap,request,"absolute",postertype).toString();
   */
String picPath="";	
//ArrayList array=new MyUtil(request).getTypeListSimulateData(texts,imgs,3);
%>
	var list=eval('('+'<%=array.get(0)%>'+')');
	var list1=eval('('+'<%=array1.get(0)%>'+')');
	var list2=eval('('+'<%=array2.get(0)%>'+')');
	
	var fivelist=eval('('+'<%=sdfivearray.get(0)%>'+')');
	var sdtwolist=eval('('+'<%=sdtwoarray.get(0)%>'+')');
	var fourlist=eval('('+'<%=hdfourarray.get(0)%>'+')');
	var hdtwolist=eval('('+'<%=hdtwoarray.get(0)%>'+')');
		
	var picpath="<%=picPath %>";
    var vaslength=<%=vaslength%>;
	var indexiframeUrl = '<%=vasurl %>';
	var indexiframePic = new Array();
	indexiframePic[0]='<%=indexiframePic[0]%>';
	
	var vasList2Pic=new Array();
	
	vasList2Pic[0] = '<%=vasList2Pic[0]%>';
	vasList2Pic[1] = '<%=vasList2Pic[1]%>';	
	vasList2Pic[2] = '<%=vasList2Pic[2]%>';
	vasList2Pic[3] = '<%=vasList2Pic[3]%>';
	vasList2Pic[4] = '<%=vasList2Pic[4]%>';
	vasList2Pic[5] = '<%=vasList2Pic[5]%>';
	vasList2Pic[6] = '<%=vasList2Pic[6]%>';
	vasList2Pic[7] = '<%=vasList2Pic[7]%>';
	</script>
