<%
/**********************
* FileName:indexdata.jsp
* Time:20130909 9:30
* Author:ZSZ
* description:标清首页获取数据，
* 部分借用上一版本源码
**********************/
%>
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

/***************20130910 15:00 ZSZ 新增异常处理*****************/
ArrayList array			= new ArrayList();
ArrayList array1		= new ArrayList();
ArrayList array2		= new ArrayList();
ArrayList array2_sec            = new ArrayList();
ArrayList array3		= new ArrayList();
ArrayList array3_vas	        = new ArrayList();
ArrayList array3_vas_sec        = new ArrayList();
ArrayList array4		= new ArrayList();

try{
	array = new MyUtil(request).getVasListData(shouyetuijiancoe,14);//推荐
}catch(Exception e){
}

try{
	array1 = new MyUtil(request).getVasListData(shouyerediancode,6);//热点
}catch(Exception e){
}

try{
	array2 = new MyUtil(request).getVasListData(shouyezhuanticode,2);//专题 右侧2张图
}catch(Exception e){
}

try{
	array2_sec = new MyUtil(request).getVasListData("10000100000000090000000000040860",2);//专题 右侧2张图 第二组切换
}catch(Exception e){
}
try{
	array3 = new MyUtil(request).getVodListData(shouyetuijiancode,2);
}catch(Exception e){
}

try{
	array3_vas = new MyUtil(request).getVasListData(shouyezhuanticode1,1);//电影 下侧3张图
}catch(Exception e){
}

try{
        array3_vas_sec = new MyUtil(request).getVasListData("10000100000000090000000000040861",1);//右下角VAS位 第二组切换
}catch(Exception e){
}
try{    
	array4 = new MyUtil(request).getVasListData(shouyetuijiancoe1,1);//直播港澳台
}catch(Exception e){
}

/***************20130910 15:00 ZSZ 新增异常处理*****************/

/////////////////////////////////////////////////////////////////////////
//
String[] indexiframePic = new String[1];
String vasurl = "";

/***************20130910 15:00 ZSZ 新增异常处理*****************/
ArrayList tmpiframeVas = new ArrayList();
try{
	tmpiframeVas=(ArrayList)metadata.getVasListByTypeId(indexiframecode, 1, 0);
}catch(Exception e){
}
/***************20130910 15:00 ZSZ 新增异常处理*****************/

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

//
////////////////////////////////////////////////////////////////////////////

//ArrayList array=new MyUtil(request).getTypeListSimulateData(texts,imgs,3);


//专题海报
String[] zhuantipic=new String[2];

/***************20130910 15:00 ZSZ 新增异常处理*****************/
ArrayList tmpvas = new ArrayList();
try{
	tmpvas=(ArrayList)metadata.getVasListByTypeId(shouyezhuanticode, 2, 0);
}catch(Exception e){
}
/***************20130910 15:00 ZSZ 新增异常处理*****************/

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

//专题第二组海报array2_sec

String[] zhuantipic_sec=new String[2];

/***************20131031 23:00 Ls 新增异常处理*****************/
ArrayList tmpvas_sec = new ArrayList();
try{
	tmpvas_sec=(ArrayList)metadata.getVasListByTypeId("10000100000000090000000000040860", 2, 0);
}catch(Exception e){
}
/***************20131031 23:00 Ls 新增异常处理*****************/
if(tmpvas_sec!=null && tmpvas_sec.size()>1)
{
	ArrayList zt_sec=(ArrayList)tmpvas_sec.get(1);
	if(zt_sec!=null&&zt_sec.size()>0)
	{	
		for(int i=0;i<zt_sec.size();i++)
		{
			HashMap mapx=(HashMap)zt_sec.get(i);
			int tempvasid=(Integer)mapx.get("VASID");
			Map map = metadata.getVasDetailInfo(tempvasid);
			zhuantipic_sec[i]=map.get("POSTERPATH").toString();
			System.out.println("PosterPath== "+zhuantipic_sec[i]);
		}
	}
}


//右下角VAS位信息获取
String[] array3_vasPic=new String[1];

/***************20130910 15:00 ZSZ 新增异常处理*****************/
ArrayList tmpimgVas = new ArrayList();
try{
	tmpimgVas=(ArrayList)metadata.getVasListByTypeId(shouyezhuanticode1, 1, 0);
}catch(Exception e){
}
/***************20130910 15:00 ZSZ 新增异常处理*****************/

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

//右下角VAS位（第二组）海报获取
String[] array3_vasPic_sec=new String[1];

/***************20130910 15:00 ZSZ 新增异常处理*****************/
ArrayList tmpimgVas_sec = new ArrayList();
try{
	tmpimgVas_sec=(ArrayList)metadata.getVasListByTypeId("10000100000000090000000000040861", 1, 0);
}catch(Exception e){
}
/***************20130910 15:00 ZSZ 新增异常处理*****************/

if(tmpimgVas_sec!=null && tmpimgVas_sec.size()>1 )
{
	ArrayList tmpVasList=(ArrayList)tmpimgVas_sec.get(1);
	if(tmpVasList!=null&&tmpVasList.size()>0)
	{
			HashMap mapx=(HashMap)tmpVasList.get(0);
			int tempvasid=(Integer)mapx.get("VASID");
			Map map = metadata.getVasDetailInfo(tempvasid);
			HashMap postersMap = (HashMap)map.get("POSTERPATHS");
			String postpath = (String)map.get("POSTERPATH");
			array3_vasPic_sec[0] =  getPosterPath(postersMap,request,postpath,"0").toString();
		        System.out.println("array3_vasPic_sec======"+array3_vasPic_sec[0]);	
	
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

/**********20130913 16:15 ZSZ 增加异常保护*********/
Object arrayTmp = new Object();
Object array1Tmp = new Object();
Object array2Tmp = new Object();
Object array2Tmp_sec = new Object();
Object array3Tmp = new Object();
Object array3_vasTmp = new Object();
Object array3_vasTmp_sec = new Object();
Object array4Tmp = new Object();

try{
	arrayTmp = array.get(0);
}catch(Exception e){
	arrayTmp = "null";
}

try{
	array1Tmp = array1.get(0);
}catch(Exception e){
	array1Tmp = "null";
}


try{
	array2Tmp = array2.get(0);
}catch(Exception e){
	array2Tmp = "null";
}

try{
	array2Tmp_sec = array2_sec.get(0);
}catch(Exception e){
	array2Tmp_sec = "null";
}


try{
	array3Tmp = array3.get(0);
}catch(Exception e){
	array3Tmp = "null";
}

try{
	array3_vasTmp = array3_vas.get(0);
}catch(Exception e){
	array3_vasTmp = "null";
}

try{
	array3_vasTmp_sec = array3_vas_sec.get(0);
}catch(Exception e){
	array3_vasTmp_sec = "null";
}



try{
	array4Tmp = array4.get(0);
}catch(Exception e){
	array4Tmp = "null";
}
/**********20130913 16:15 ZSZ 增加异常保护*********/
%>

var list = null;
var list1 = null;
var list2 = null;
var list2_sec = null;
var list3 = null;
var list3_vas = null;
var list3_vas_sec = null;
var list4 = null;
var indexiframeUrl = null;
var indexiframePic = new Array();
var picpath = null;
var zhuantipic = new Array();
var zhuantipic_sec = new Array();
var array3_vasPic = new Array();
var array3_vasPic_sec = new Array();


list=eval('('+'<%=arrayTmp%>'+')');
list1=eval('('+'<%=array1Tmp%>'+')');
list2=eval('('+'<%=array2Tmp%>'+')');
list2_sec=eval('('+'<%=array2Tmp_sec%>'+')');
list3=eval('('+'<%=array3Tmp%>'+')');
list3_vas=eval('('+'<%=array3_vasTmp%>'+')');
list3_vas_sec=eval('('+'<%=array3_vasTmp_sec%>'+')');
list4=eval('('+'<%=array4Tmp%>'+')');
indexiframeUrl = '<%=vasurl %>';

indexiframePic[0]='<%=indexiframePic[0]%>';

picpath="<%=picPath %>";

<%for(int i=0;i<zhuantipic.length;i++)
 {%>
	zhuantipic[<%=i%>]='<%=zhuantipic[i]%>';
<%}%>

<%for(int i=0;i<zhuantipic_sec.length;i++)
 {%>
	zhuantipic_sec[<%=i%>]='<%=zhuantipic_sec[i]%>';
<%}%>

array3_vasPic[0] = '<%=array3_vasPic[0]%>';
array3_vasPic_sec[0] = '<%=array3_vasPic_sec[0]%>';
</script>
