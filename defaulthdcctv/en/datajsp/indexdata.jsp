<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="../util/util_getPosterPaths.jsp"%>
<%@ include file="database.jsp"%>
<script>
<%
MetaData metadata = new MetaData(request);

ArrayList array = new ArrayList();
ArrayList sdfivearray = new ArrayList();
ArrayList sdtwoarray = new ArrayList();
ArrayList hdfourarray = new ArrayList();
ArrayList hdtwoarray = new ArrayList();
ArrayList array1 = new ArrayList();
ArrayList array2 = new ArrayList();
ArrayList array3 = new ArrayList();

try{
    array=new MyUtil(request).getVasListData(shouyetuijian1code,17);
}catch(Exception e){
}

try{
    sdfivearray=new MyUtil(request).getVasListData(sdfivecode,1);
}catch(Exception e){
}

try{
    sdtwoarray=new MyUtil(request).getVasListData(sdtwocode,3);
}catch(Exception e){
}

try{
    hdfourarray=new MyUtil(request).getVasListData(hdfourcode,4);
}catch(Exception e){
}

try{
    hdtwoarray=new MyUtil(request).getVasListData(hdtwocode,12);
}catch(Exception e){
}

try{
    array1=new MyUtil(request).getVodListData(shouyetuijian2code,2);
}catch(Exception e){
}

try{
    array2=new MyUtil(request).getVasListData(shouyetuijian3code,1);
}catch(Exception e){
}

try{
    array3=new MyUtil(request).getVasListData(shouyetuijian4code,1);
}catch(Exception e){
}


ArrayList arrayVod2 = new ArrayList();
ArrayList array11 = new ArrayList();
ArrayList array12 = new ArrayList();

try
{
    arrayVod2 =new MyUtil(request).getVodListData(shouyetuijian2code2,2);//高清首页右侧推荐位前两个（第二组）
}
catch(Exception e){
}

try
{
    array11=new MyUtil(request).getVasListData("10000100000000090000000000032170",1);//高清首页右侧推荐位第三个（第二组）
}
catch(Exception e){
}

try
{
    array12=new MyUtil(request).getVasListData("10000100000000090000000000032171",1);//高清首页右侧推荐位第四个（第二组）
}
catch(Exception e){
}

ArrayList array3rd_right1 = new ArrayList();
ArrayList array3rd_right2 = new ArrayList();
ArrayList array3rd_right3 = new ArrayList();
ArrayList array3rd_right4 = new ArrayList();


try
{
    array3rd_right1 = new MyUtil(request).getVasListData("10000100000000090000000000040858",1);//高清首页右侧推荐位第一个（第三组）
}
catch(Exception e){
}

try
{
    array3rd_right2 = new MyUtil(request).getVasListData("10000100000000090000000000040859",1);//高清首页右侧推荐位第二个（第三组）
}
catch(Exception e){
}

try
{
    array3rd_right3 = new MyUtil(request).getVasListData("10000100000000090000000000042170",1);//高清首页右侧推荐位第3个（第三组）
}
catch(Exception e){
}

try
{
    array3rd_right4 = new MyUtil(request).getVasListData("10000100000000090000000000042171",1);//高清首页右侧推荐位第4个（第三组）
}
catch(Exception e){
}

/////////////////////////////////////////////////////////////////////////
////

String[] indexiframePic = new String[1];
String[] vasList2Pic=new String[1];
String[] vasList3Pic=new String[1];
String[] vasList11Pic=new String[1];
String[] vasList12Pic=new String[1];
String[] vasList3rd_right1Pic=new String[1];
String[] vasList3rd_right2Pic=new String[1];
String[] vasList3rd_right3Pic=new String[1];
String[] vasList3rd_right4Pic=new String[1];
String vasurl = "";


ArrayList tmpiframeVas = new ArrayList();
try{
    tmpiframeVas=(ArrayList)metadata.getVasListByTypeId(indexiframecode, 1, 0);
}
catch(Exception e){
}

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


ArrayList tmpimgVas11 = new ArrayList();
try{
tmpimgVas11 = (ArrayList)metadata.getVasListByTypeId("10000100000000090000000000032170", 1, 0);
}
catch(Exception e){
}

if(tmpimgVas11!=null && tmpimgVas11.size()>1){
	ArrayList tmpVasList = (ArrayList)tmpimgVas11.get(1);
	if(tmpVasList!=null && tmpVasList.size()>0){
		for(int i=0;i<tmpVasList.size() ;i++){
			HashMap mapindexx=(HashMap)tmpVasList.get(i);
			int tempindexvasid=(Integer)mapindexx.get("VASID");
			Map mapindex = metadata.getVasDetailInfo(tempindexvasid);
			HashMap postersMap = (HashMap)mapindex.get("POSTERPATHS");
			String postpath = (String)mapindex.get("POSTERPATH");
			vasList11Pic[i] =  getPosterPath(postersMap,request,postpath,"1").toString();
		}
	}
}


ArrayList tmpimgVas12 = new ArrayList();
try{
    tmpimgVas12=(ArrayList)metadata.getVasListByTypeId("10000100000000090000000000032171", 1, 0);
}
catch(Exception e){
}

if(tmpimgVas12!=null && tmpimgVas12.size()>1){
	ArrayList tmpVasList = (ArrayList)tmpimgVas12.get(1);
	if(tmpVasList!=null && tmpVasList.size()>0){
		for(int i=0;i<tmpVasList.size() ;i++){
			HashMap mapindexx=(HashMap)tmpVasList.get(i);
			int tempindexvasid=(Integer)mapindexx.get("VASID");
			Map mapindex = metadata.getVasDetailInfo(tempindexvasid);
			HashMap postersMap = (HashMap)mapindex.get("POSTERPATHS");
			String postpath = (String)mapindex.get("POSTERPATH");
			vasList12Pic[i] =  getPosterPath(postersMap,request,postpath,"1").toString();
		}
	}
}

ArrayList tmpimgVas3rd_right1 = new ArrayList();
try{
tmpimgVas3rd_right1 = (ArrayList)metadata.getVasListByTypeId("10000100000000090000000000040858", 1, 0);
}
catch(Exception e){
}

if(tmpimgVas3rd_right1!=null && tmpimgVas3rd_right1.size()>1){
	ArrayList tmpVasList = (ArrayList)tmpimgVas3rd_right1.get(1);
	if(tmpVasList!=null && tmpVasList.size()>0){
		for(int i=0;i<tmpVasList.size() ;i++){
			HashMap mapindexx=(HashMap)tmpVasList.get(i);
			int tempindexvasid=(Integer)mapindexx.get("VASID");
			Map mapindex = metadata.getVasDetailInfo(tempindexvasid);
			HashMap postersMap = (HashMap)mapindex.get("POSTERPATHS");
			String postpath = (String)mapindex.get("POSTERPATH");
			vasList3rd_right1Pic[i] =  getPosterPath(postersMap,request,postpath,"1").toString();
		}
	}
}


ArrayList tmpimgVas3rd_right2 = new ArrayList();
try{
    tmpimgVas3rd_right2=(ArrayList)metadata.getVasListByTypeId("10000100000000090000000000040859", 1, 0);
}
catch(Exception e){
}

if(tmpimgVas3rd_right2!=null && tmpimgVas3rd_right2.size()>1){
	ArrayList tmpVasList = (ArrayList)tmpimgVas3rd_right2.get(1);
	if(tmpVasList!=null && tmpVasList.size()>0){
		for(int i=0;i<tmpVasList.size() ;i++){
			HashMap mapindexx=(HashMap)tmpVasList.get(i);
			int tempindexvasid=(Integer)mapindexx.get("VASID");
			Map mapindex = metadata.getVasDetailInfo(tempindexvasid);
			HashMap postersMap = (HashMap)mapindex.get("POSTERPATHS");
			String postpath = (String)mapindex.get("POSTERPATH");
			vasList3rd_right2Pic[i] =  getPosterPath(postersMap,request,postpath,"1").toString();
		}
	}
}

ArrayList tmpimgVas3rd_right3 = new ArrayList();
try{
tmpimgVas3rd_right3 = (ArrayList)metadata.getVasListByTypeId("10000100000000090000000000042170", 1, 0);
}
catch(Exception e){
}

if(tmpimgVas3rd_right3!=null && tmpimgVas3rd_right3.size()>1){
	ArrayList tmpVasList = (ArrayList)tmpimgVas3rd_right3.get(1);
	if(tmpVasList!=null && tmpVasList.size()>0){
		for(int i=0;i<tmpVasList.size() ;i++){
			HashMap mapindexx=(HashMap)tmpVasList.get(i);
			int tempindexvasid=(Integer)mapindexx.get("VASID");
			Map mapindex = metadata.getVasDetailInfo(tempindexvasid);
			HashMap postersMap = (HashMap)mapindex.get("POSTERPATHS");
			String postpath = (String)mapindex.get("POSTERPATH");
			vasList3rd_right3Pic[i] =  getPosterPath(postersMap,request,postpath,"1").toString();
		}
	}
}


ArrayList tmpimgVas3rd_right4 = new ArrayList();
try{
    tmpimgVas3rd_right4=(ArrayList)metadata.getVasListByTypeId("10000100000000090000000000042171", 1, 0);
}
catch(Exception e){
}

if(tmpimgVas3rd_right4!=null && tmpimgVas3rd_right4.size()>1){
	ArrayList tmpVasList = (ArrayList)tmpimgVas3rd_right4.get(1);
	if(tmpVasList!=null && tmpVasList.size()>0){
		for(int i=0;i<tmpVasList.size() ;i++){
			HashMap mapindexx=(HashMap)tmpVasList.get(i);
			int tempindexvasid=(Integer)mapindexx.get("VASID");
			Map mapindex = metadata.getVasDetailInfo(tempindexvasid);
			HashMap postersMap = (HashMap)mapindex.get("POSTERPATHS");
			String postpath = (String)mapindex.get("POSTERPATH");
			vasList3rd_right4Pic[i] =  getPosterPath(postersMap,request,postpath,"1").toString();
		}
	}
}






ArrayList tmpimgVas = new ArrayList();
try{
    tmpimgVas=(ArrayList)metadata.getVasListByTypeId(shouyetuijian3code, 1, 0);
}
catch(Exception e){
}	
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


ArrayList tmpimgVas3 = new ArrayList();
try{
    tmpimgVas3=(ArrayList)metadata.getVasListByTypeId(shouyetuijian4code, 1, 0);
}
catch(Exception e){
}	
if(tmpimgVas3!=null && tmpimgVas3.size()>1){
	ArrayList tmpVasList = (ArrayList)tmpimgVas3.get(1);
	if(tmpVasList!=null && tmpVasList.size()>0){
		for(int i=0;i<tmpVasList.size() ;i++){
			HashMap mapindexx=(HashMap)tmpVasList.get(i);
			int tempindexvasid=(Integer)mapindexx.get("VASID");
			Map mapindex = metadata.getVasDetailInfo(tempindexvasid);
			//vasList2Pic[i]=mapindex.get("POSTERPATH").toString();

			HashMap postersMap = (HashMap)mapindex.get("POSTERPATHS");
			String postpath = (String)mapindex.get("POSTERPATH");
			vasList3Pic[i] =  getPosterPath(postersMap,request,postpath,"1").toString();

		}
	}
}


String picPath="";	

Object arrayTmp = new Object();
Object array1Tmp = new Object();
Object array2Tmp = new Object();
Object array3Tmp = new Object();
Object array11Tmp = new Object();
Object array12Tmp = new Object();
Object arrayVod2Tmp = new Object();
Object array3rd_right1Tmp = new Object();
Object array3rd_right2Tmp = new Object();
Object array3rd_right3Tmp = new Object();
Object array3rd_right4Tmp = new Object();
Object sdfivearrayTmp = new Object();
Object sdtwoarrayTmp = new Object();
Object hdfourarrayTmp = new Object();
Object hdtwoarrayTmp = new Object();

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
	array3Tmp = array3.get(0);
}catch(Exception e){
	array3Tmp = "null";
}

try{
	array11Tmp = array11.get(0);
}catch(Exception e){
	array11Tmp = "null";
}

try{
	array12Tmp = array12.get(0);
}catch(Exception e){
	array12Tmp = "null";
}

try{
	arrayVod2Tmp = arrayVod2.get(0);
}catch(Exception e){
	arrayVod2Tmp = "null";
}

try{
	array3rd_right1Tmp = array3rd_right1.get(0);
}catch(Exception e){
	array3rd_right1Tmp = "null";
}


try{
	array3rd_right2Tmp = array3rd_right2.get(0);
}catch(Exception e){
	array3rd_right2Tmp = "null";
}


try{
	array3rd_right3Tmp = array3rd_right3.get(0);
}catch(Exception e){
	array3rd_right3Tmp = "null";
}


try{
	array3rd_right4Tmp = array3rd_right4.get(0);
}catch(Exception e){
	array3rd_right4Tmp = "null";
}

try{
	sdfivearrayTmp = sdfivearray.get(0);
}catch(Exception e){
	sdfivearrayTmp = "null";
}

try{
	sdtwoarrayTmp = sdtwoarray.get(0);
}catch(Exception e){
	sdtwoarrayTmp= "null";
}

try{
	hdfourarrayTmp = hdfourarray.get(0);
}catch(Exception e){
	hdfourarrayTmp = "null";
}

try{
	hdtwoarrayTmp = hdtwoarray.get(0);
}catch(Exception e){
	hdtwoarrayTmp = "null";
}

%>

var list = null;
var list1 = null;
var list2 = null;
var list3 = null;

var list=eval('('+'<%=array.get(0)%>'+')');
var list1=eval('('+'<%=array1.get(0)%>'+')');
var list2=eval('('+'<%=array2.get(0)%>'+')');
var list3=eval('('+'<%=array3.get(0)%>'+')');


var list11 = null;
var list12 = null;
var listVod2 = null;

var list11=eval('('+'<%=array11.get(0)%>'+')');
var list12=eval('('+'<%=array12.get(0)%>'+')');
var listVod2 = eval('('+'<%=arrayVod2.get(0)%>'+')');


var list3rd_right1 = null;
var list3rd_right2 = null;
var list3rd_right3 = null;
var list3rd_right4 = null;

var list3rd_right1=eval('('+'<%=array3rd_right1Tmp%>'+')');
var list3rd_right2=eval('('+'<%=array3rd_right2Tmp%>'+')');
var list3rd_right3=eval('('+'<%=array3rd_right3Tmp%>'+')');
var list3rd_right4=eval('('+'<%=array3rd_right4Tmp%>'+')');

var fivelist = null;
var sdtwolist = null;
var fourlist = null;
var hdtwolist = null;

var fivelist=eval('('+'<%=sdfivearray.get(0)%>'+')');
var sdtwolist=eval('('+'<%=sdtwoarray.get(0)%>'+')');
var fourlist=eval('('+'<%=hdfourarray.get(0)%>'+')');
var hdtwolist=eval('('+'<%=hdtwoarray.get(0)%>'+')');

var picpath = null;
var vaslength = null;
var indexiframeUrl = null;
var indexiframePic = null;

picpath="<%=picPath %>";
vaslength=<%=vaslength%>;
indexiframeUrl = '<%=vasurl %>';
indexiframePic = new Array();
indexiframePic[0]='<%=indexiframePic[0]%>';


var vasList11Pic=new Array();
vasList11Pic[0] = '<%=vasList11Pic[0]%>';
var vasList12Pic=new Array();
vasList12Pic[0] = '<%=vasList12Pic[0]%>';

var vasList2Pic=new Array();
vasList2Pic[0] = '<%=vasList2Pic[0]%>';
var vasList3Pic=new Array();
vasList3Pic[0] = '<%=vasList3Pic[0]%>';

var vasList3rd_right1Pic = new Array();
var vasList3rd_right2Pic = new Array();
var vasList3rd_right3Pic = new Array();
var vasList3rd_right4Pic = new Array();

vasList3rd_right1Pic[0] = '<%=vasList3rd_right1Pic[0]%>';
vasList3rd_right2Pic[0] = '<%=vasList3rd_right2Pic[0]%>';
vasList3rd_right3Pic[0] = '<%=vasList3rd_right3Pic[0]%>';
vasList3rd_right4Pic[0] = '<%=vasList3rd_right4Pic[0]%>';
</script>
