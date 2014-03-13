<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<%@ include file="../util/util_getPosterPaths.jsp" %>

<script type="text/javascript">
 //绑定初始化第一个栏目下面的数据
var cateids = new Array();
	var catenames = new Array();
	var catePagecount = 0;
        //绑定大栏目的数据
        function BindCateLeft() {
			var ids = new Array();
			var names = new Array();
			<%
			    
			    int indexid=-1;
				int curpage=1;
				int curindex=0;
				String sindexid=request.getParameter("indexid");
				if(sindexid!=null){
				    indexid=Integer.parseInt(sindexid);
				    curpage=indexid/9+1;
				    curindex=indexid%9;
				}
          		String TypeID = request.getParameter("typeid");
				String str="";
				String CateFrist=null;
				MetaData metaData = new MetaData(request);
    			int[] intSubjectType = {10,0,4,9999};
				
				int catepagesize = 9;
				ArrayList resultList = metaData.getTypeListByTypeId(TypeID,-1,0,intSubjectType);
				if(resultList == null || resultList.size() < 2 || ((ArrayList)resultList.get(1)).size() == 0)
				{
					 str ="空";
				}
				else
				{
					String focObj = String.valueOf(getState(analyticFocStr(focstr),"0","curpage"));
					int catecurpage = (focObj==null||focObj.equals("null"))?1:Integer.parseInt(focObj);
					focObj = String.valueOf(getState(analyticFocStr(focstr),"0","curindex"));
					int catecurindex = (focObj==null||focObj.equals("null"))?0:Integer.parseInt(focObj);
					int prevCateindex = catepagesize*(catecurpage-1)+catecurindex;
					ArrayList typeList = (ArrayList)resultList.get(1);
					int typeSize = typeList.isEmpty()? 0: typeList.size();
					//int todayCountTotal = 0 ;
					for(int i = 0; i < typeSize; i++)
					{
						HashMap typeMap = (HashMap)typeList.get(i);
						String vodNames = typeMap.get("TYPE_NAME").toString().trim();
						String typeIds = typeMap.get("TYPE_ID").toString().trim();
						if(sindexid==null||!"null".equals(focstr)){
							if(CateFrist==null&&i==prevCateindex){
									CateFrist = typeIds;
							}
						}else{
							if(CateFrist==null&&i==Integer.parseInt(sindexid)){
									CateFrist = typeIds;
							}
						}
							%>							
								cateids.push('<%=typeIds%>');
								catenames.push('<%=vodNames%>');
							<%	
						
					}
				}
				%>
				    if(cateids.length!=0){
						catePagecount = (cateids.length-1)/<%=catepagesize%>+1;
					}
					ids = getcurcates(cateids,area0.curpage,<%=catepagesize%>);
					names = getcurcates(catenames,area0.curpage,<%=catepagesize%>);
					getdatacate(names,ids);
				
				
        }
		function getbackdata() {
			var ids = new Array();
            var pics = new Array();
			<%		
				int PageSize = 10;
			    int countTotalPage = 0;
				int countTotal = 0;
			   //获取栏目下面的剧集
				
				String focObj1 = String.valueOf(getState(analyticFocStr(focstr),"1","curpage"));
				int contentcurpage = (focObj1==null||focObj1.equals("null"))?1:Integer.parseInt(focObj1);
				int contentstartindex = ((contentcurpage-1)*PageSize);
				ArrayList resultList1 =  metaData.getVodListByTypeId(CateFrist,PageSize,contentstartindex);
				if(resultList1 == null || resultList1.size() < 2 || ((ArrayList)resultList1.get(1)).size() == 0)
				{
					 str ="空";
					 countTotal = 100;
				}
				else
				{
					ArrayList contentList = (ArrayList)resultList1.get(1);
					int typeSize = contentList.isEmpty()? 0: contentList.size();
					countTotal = ((Integer)((HashMap)resultList1.get(0)).get("COUNTTOTAL")).intValue();
					countTotalPage = (countTotal-1)/PageSize+1;  
					for(int i=0;i<typeSize;i++)
					{
						 HashMap listCon = (HashMap)contentList.get(i);
						 String vodpath = listCon.get("PICPATH").toString().trim();
						 String vodId = listCon.get("VODID").toString().trim();
						 
						 HashMap temp2=(HashMap)listCon.get("POSTERPATHS"); 
						 vodpath = getPosterPath(temp2,request,vodpath,"1");
						 //String[] vodPaths = (String[])tempKey.get("type1");
						%>
						 pics.push("<%=vodpath%>");
						 ids.push("<%=vodId%>");
						<%
				}
			}
		%>
			//alert(pics[0]);
			//alert(ids);
			//document.write(pics);
        	getdatapic(ids, pics, <%=countTotalPage%>);
        }
<%
	String name = request.getParameter("name");
	if(name==null){
		HashMap typeInfoMap = metaData.getTypeInfoByTypeId(TypeID);
		name = typeInfoMap.get("TYPENAME").toString();
	}
%>
    </script>