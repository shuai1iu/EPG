<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ include file="SubStringFunction.jsp"%>
<%@ page import="java.util.Map"%>

<script language="javascript"  type="text/javascript">
<%
int curpage=1;
int indexid=8;
int areaid=0;
int pagecount=1;
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
	pagecount=(int)Math.ceil(countTotal/11.0);
}
    //收藏超过上限
	if(countTotal>favLimit)
	{
%>		
	<jsp:forward page="query_FavoriteOutOfLimit.jsp" />
<%
	}
%>
   var scrollText = "汪森山的空间";
   var collentList =new Array();
   var favList=new Array();					
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
 if(parseInt(jscurpage)==0) jscurpage=1;
//ZTE
//		 area2.curpage = parseInt(jscurpage);
         if(area2 != undefined){
             area2.curpage = parseInt(jscurpage);
         } 

 var indexid=<%=indexid%>;
 var areaid=<%=areaid%>;
 var pos = parseInt(jscurpage) * 11 - 11;

 for (var i = pos; i < favList.length && i<(pos+11); i++)
 { 
    var collentObTmpj = {};
    collentObTmpj.progId = favList[i].progId;
	collentObTmpj.progType = favList[i].progType;
	collentObTmpj.progName = favList[i].progName;
    collentObTmpj.isValid = favList[i].isValid;
	collentObTmpj.progTime = favList[i].progTime;
	collentObTmpj.collentObjType=1;
    collentList.push(collentObTmpj);
    var collentObTmpjDel = {};
    collentObTmpjDel.progId = favList[i].progId;
	collentObTmpjDel.progType = favList[i].progType;
	collentObTmpjDel.progName = "删除";
    collentObTmpjDel.isValid = favList[i].isValid;
	collentObTmpjDel.progTime = favList[i].progTime;
	collentObTmpjDel.collentObjType=2;
    collentList.push(collentObTmpjDel);
 }

 if(collentList.length==0)
 {
    var collentObTmpjNull = {};
    collentObTmpjNull.progId = 0;
	collentObTmpjNull.progType = 0;
	collentObTmpjNull.progName = "暂无记录";
    collentObTmpjNull.isValid = 0;
	collentObTmpjNull.progTime = "";
	collentObTmpjNull.collentObjType=3;
	collentList.push(collentObTmpjNull);
 }
</script>
