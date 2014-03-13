<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ include file="SubStringFunction.jsp"%>
<%@ include file="database.jsp"%>

<script language="javascript"  type="text/javascript">
var collentList =new Array();
var favList=new Array();	

<%
ArrayList array=new MyUtil(request).getVodListData(shoucangcode,3);
int curpage=1;
int indexid=0;
int areaid=0;
int pagecount=1;
double pagesize=7.0;
if(request.getParameter("curpage")!=null)
{
	curpage = Integer.parseInt(request.getParameter("curpage"));
}

if(request.getParameter("indexid")!=null)
{
	indexid = Integer.parseInt(request.getParameter("indexid"));
}
if(request.getParameter("areaid")!=null)
{
	areaid = Integer.parseInt(request.getParameter("areaid"));
}
MetaData metaData = new MetaData(request);
ServiceHelp serviceHelp = new ServiceHelp(request);
//得到收藏列表的数目
int favLimit = serviceHelp.getFavouriteLimit();	
ArrayList result = null;
int countTotal = 0;
ArrayList favList = serviceHelp.getFavList();
if(favList == null)
{
   countTotal = 0;
}
else
{ 
   //收藏总数
	countTotal = ((Integer)((HashMap)favList.get(0)).get("COUNTTOTAL")).intValue();
	result = (ArrayList)favList.get(1);
	pagecount=(int)Math.ceil(countTotal/pagesize);
}
    //收藏超过上限
	if(countTotal>favLimit)
	{
%>		
	<jsp:forward page="query_FavoriteOutOfLimit.jsp" />
<%
	}
%>
   
   				
 <%
   
	if(countTotal >0)  
	{
		for(int i=0;i<countTotal;i++)
		{
			int tempProgId = ((Integer)((HashMap)result.get(i)).get("PROG_ID")).intValue();
			int tempProgType = ((Integer)((HashMap)result.get(i)).get("PROG_TYPE")).intValue();
			String tempProgName = (String)((HashMap)result.get(i)).get("PROG_NAME");
			String progTime = "";
			//影片是否有效，如果后台去激活后会出现
			String isValid = "1" ;
			//影片无效，给用户提示
			if("".equals(tempProgName))
			{
				isValid = "-1" ;
				tempProgName = "该影片已经过期，请删除";
			}
			else
			{
				Map filmInfoMap = metaData.getVodDetailInfo(tempProgId); 
				if (filmInfoMap != null)
				{
					progTime = String.valueOf(filmInfoMap.get("ELAPSETIME")) + "分钟";
				}
			}
			
%>
			var tempObj ={};
			tempObj.progId = <%=tempProgId%>;
			tempObj.progType = <%=tempProgType%>;
			tempObj.progName = "<%=tempProgName%>";
		    tempObj.isValid = <%=isValid%>;
			tempObj.progTime = "<%=progTime%>";
			favList[<%=i%>] = tempObj;
<%
		}
	}
%>
 var jscurpage=<%=curpage%>;
 if(parseInt(jscurpage)>parseInt(<%=pagecount%>))
 {
   jscurpage=<%=pagecount%>;
 }
 var indexid=<%=indexid%>;
 var areaid=<%=areaid%>;
 var collentNum=0;
 if(favList.length==0)
 {
    var collentObTmpjNull = {};
    collentObTmpjNull.progId = 0;
	collentObTmpjNull.progType = 0;
	collentObTmpjNull.progName = "暂无记录";
    collentObTmpjNull.isValid = 0;
	collentObTmpjNull.progTime = "";
	collentObTmpjNull.collentObjType=3;
	favList.push(collentObTmpjNull);
	collentNum=0;
}
else
{
	collentNum=favList.length;
}

var tjList=eval('('+'<%=array.get(0)%>'+')');
</script>