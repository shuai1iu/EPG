<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="database.jsp"%>
<script>
<%
//String[][] imgs={{"TYPE_PICPATH","images/temp/13.jpg"}};
//String[] texts={"TYPE_NAME","TYPE_INTRODUCE"};
MetaData metadata = new MetaData(request);
ArrayList array=new MyUtil(request).getVasListData("10000100000000090000000000032090",6);
ArrayList array1=new MyUtil(request).getVasListData(shouyetuijiancoe,6);
ArrayList array2=new MyUtil(request).getVasListData("10000100000000090000000000029041",2);
ArrayList array3=new MyUtil(request).getVodListData("10000100000000090000000000029550",2);
ArrayList array3_vas=new MyUtil(request).getVasListData("10000100000000090000000000032091",1);
ArrayList array4=new MyUtil(request).getVasListData(shouyetuijiancoe1,1);//zhibogangaotai
/////////////////////////////////////////////////////////////////////////
//
String[] indexiframePic = new String[1];
String vasurl = "";

ArrayList tmpiframeVas=(ArrayList)metadata.getVasListByTypeId(indexiframecode, 1, 0);
if(tmpiframeVas!=null && tmpiframeVas.size()>1)
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

System.out.println("defaultsdcctv-----------------------------------------------vasurl="+vasurl);
System.out.println("defaultsdcctv----------------------------------------------indexiframePic[0]="+indexiframePic[0]);
//
////////////////////////////////////////////////////////////////////////////

//ArrayList array=new MyUtil(request).getTypeListSimulateData(texts,imgs,3);
//专题海报
String[] zhuantipic=new String[2];
ArrayList tmpvas=(ArrayList)metadata.getVasListByTypeId("10000100000000090000000000029041", 2, 0);
if(tmpvas!=null && tmpvas.size()>1)
{
	ArrayList zt=(ArrayList)tmpvas.get(1);
	if(zt!=null&&zt.size()>0)
	{	
		for(int i=0;i<zt.size();i++)
		{
			HashMap mapx=(HashMap)zt.get(i);
			int tempvasid=(Integer)mapx.get("VASID");
			Map map = metadata.getVasDetailInfo(tempvasid);
			zhuantipic[i]=map.get("POSTERPATH").toString();
		}
	}
}
String[] array3_vasPic=new String[1];
ArrayList tmpimgVas=(ArrayList)metadata.getVasListByTypeId(shouyezhuanticode1, 1, 0);
if(tmpimgVas!=null && tmpimgVas.size()>1 )
{
	ArrayList tmpVasList=(ArrayList)tmpimgVas.get(1);
	if(tmpVasList!=null&&tmpVasList.size()>0)
	{
			HashMap mapx=(HashMap)tmpVasList.get(0);
			int tempvasid=(Integer)mapx.get("VASID");
			Map map = metadata.getVasDetailInfo(tempvasid);
			//array3_vasPic[0]=map.get("POSTERPATH").toString();
			
			
			//Map map = metadata.getVasDetailInfo(tempvasid);
			HashMap postersMap = (HashMap)map.get("POSTERPATHS");
			String postpath = (String)map.get("POSTERPATH");
			array3_vasPic[0] =  getPosterPath(postersMap,request,postpath,"0").toString();
			
	
	}
}


//中间图片获取及滚动字幕
/*
HashMap map = (HashMap)metadata.getTypeInfoByTypeId(index_mid);
//String introduce = (String)map.get("INTRODUCE");
HashMap posterPathMap = (HashMap)map.get("POSTERPATHS");
String postertype = "2";
String picPath="";
picPath =  getPosterPath(posterPathMap,request,"absolute",postertype).toString();
*/
String picPath="";
%>
var list=eval('('+'<%=array.get(0)%>'+')');
var list1=eval('('+'<%=array1.get(0)%>'+')');
var list2=eval('('+'<%=array2.get(0)%>'+')');
var list3=eval('('+'<%=array3.get(0)%>'+')');
var list3_vas=eval('('+'<%=array3_vas.get(0)%>'+')');
var list4=eval('('+'<%=array4.get(0)%>'+')');
var indexiframeUrl = '<%=vasurl %>';
var indexiframePic = new Array();
indexiframePic[0]='<%=indexiframePic[0]%>';

var picpath="<%=picPath %>";
var zhuantipic=new Array();
<%for(int i=0;i<zhuantipic.length;i++)
 {%>
	zhuantipic[<%=i%>]='<%=zhuantipic[i]%>';
<%}%>
var array3_vasPic = new Array();
array3_vasPic[0] = '<%=array3_vasPic[0]%>';

</script>
