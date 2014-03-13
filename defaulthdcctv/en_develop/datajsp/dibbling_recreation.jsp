<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="database.jsp"%>

<%@ include file="../util/util_getPosterPaths.jsp" %>
<script type="text/javascript">
<%
	String subtypeStr = "10000100000000090000000000023718;00000100000000090000000000016919;00000100000000090000000000016920;10000100000000090000000000024252;10000100000000090000000000024253";
	String typeName = "推荐";
	String TypeID = request.getParameter("typeid")==null?"00000100000000090000000000001236":request.getParameter("typeid");
	HashMap typeInfo = (HashMap)(new MetaData(request).getTypeInfoByTypeId(TypeID));
	if(typeInfo!=null){
		typeName = typeInfo.get("TYPENAME").toString();
	}
%>
var cateids = new Array();
	var catenames = new Array();
	var catePagecount = 0;
//绑定大栏目的数
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
          		//String TypeID = request.getParameter("id");
				String CateFrist= null;
				MetaData metaData = new MetaData(request);
    			int[] intSubjectType = {9999};
				int catepagesize = 9;
				int catePagecount = 1;
				ArrayList resultList = metaData.getTypeListByTypeId(TypeID,-1,0,intSubjectType);
				if(resultList == null || resultList.size() < 2 || ((ArrayList)resultList.get(1)).size() == 0)
				{
					
				}
				else
				{
					ArrayList typeList = (ArrayList)resultList.get(1);
					int typeSize = typeList.isEmpty()? 0: typeList.size();
					String focObj = String.valueOf(getState(analyticFocStr(focstr),"0","curpage"));
					int catecurpage = (focObj==null||focObj.equals("null"))?1:Integer.parseInt(focObj);
					focObj = String.valueOf(getState(analyticFocStr(focstr),"0","curindex"));
					int catecurindex = (focObj==null||focObj.equals("null"))?0:Integer.parseInt(focObj);
					int prevCateindex = catepagesize*(catecurpage-1)+catecurindex;
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

		//绑定初始化第一个栏目下面的数据
        function getbackdata() {
          	var ids = new Array();
            var pics = new Array();
			var names = new Array();
			<%		
				int PageSize = 6;
			    int countTotalPage = 0;
				int countTotal = 0;
			   //获取栏目下面的剧集
			    int subtype = metaData.getSubTypeOrContent(CateFrist); //判断下级是栏目还是内容 1.栏目 0.内容 0x07010000.空
				
				if(subtype==1){
					PageSize = 6;
					String focObj = String.valueOf(getState(analyticFocStr(focstr),"1","curpage"));
					int catecurpage = (focObj==null||focObj.equals("null"))?1:Integer.parseInt(focObj);
					int startindex = ((catecurpage-1)*PageSize);
					ArrayList resultList1 = metaData.getTypeListByTypeId(CateFrist,PageSize,startindex,intSubjectType);
					if(resultList1 == null || resultList1.size() < 2 || ((ArrayList)resultList1.get(1)).size() == 0){
						countTotal=100;
					}else{
						ArrayList contentList = (ArrayList)resultList1.get(1);
						int typeSize = contentList.isEmpty()? 0: contentList.size();
						countTotal = ((Integer)((HashMap)resultList1.get(0)).get("COUNTTOTAL")).intValue();
						countTotalPage = (countTotal-1)/PageSize+1;  
						for(int i=0;i<typeSize;i++)
						{
							 HashMap listCon = (HashMap)contentList.get(i);
							 String vodpath = listCon.get("TYPE_PICPATH").toString().trim();
							 String vodId = listCon.get("TYPE_ID").toString().trim();
							 String vodNames = listCon.get("TYPE_NAME").toString().trim();
							 
							 
							 HashMap temp2=(HashMap)listCon.get("POSTERPATHS");  //获取当前对象的POSTERPATHS
							 vodpath = getPosterPath(temp2,request,vodpath,"2");
							 
							%>
							 pics.push("<%=vodpath%>");
							 ids.push("<%=vodId%>");
							 names.push("<%=vodNames%>");
							<%
						}
					}
				}else if(subtype==0){
					if(subtypeStr.indexOf(CateFrist)!=-1){
						PageSize = 10;
					}else{
						PageSize = 6;
					}
					String focObj = String.valueOf(getState(analyticFocStr(focstr),"2","curpage"));
					int catecurpage = (focObj==null||focObj.equals("null"))?1:Integer.parseInt(focObj);
					int startindex = ((catecurpage-1)*PageSize);
					ArrayList resultList2 = metaData.getVodListByTypeId(CateFrist,PageSize,startindex);
					if(resultList2 == null || resultList2.size() < 2 || ((ArrayList)resultList2.get(1)).size() == 0){
						countTotal = 100;
					}else{
						ArrayList contentList = (ArrayList)resultList2.get(1);
						int typeSize = contentList.isEmpty()? 0: contentList.size();
						countTotal = ((Integer)((HashMap)resultList2.get(0)).get("COUNTTOTAL")).intValue();
						countTotalPage = (countTotal-1)/PageSize+1;
						for(int i=0;i<typeSize;i++)
						{
								 HashMap listCon = (HashMap)contentList.get(i);
								 String vodpath = listCon.get("PICPATH").toString().trim();
								 String vodId = listCon.get("VODID").toString().trim();
								 String vodNames = listCon.get("VODNAME").toString().trim();

								 HashMap temp2=(HashMap)listCon.get("POSTERPATHS");  //获取当前对象的POSTERPATHS
								 vodpath = getPosterPath(temp2,request,vodpath,"1","2");
								%>
								 pics.push("<%=vodpath%>");
								 ids.push("<%=vodId%>");
								 names.push("<%=vodNames%>");
								<%
						}
					}
				}else if(subtype==0x07010000){
					//空
				}
			%>
            getdatapic(names, ids, pics, <%=countTotalPage%>,<%=subtype%>,<%=PageSize%>);
        }

      
    </script>
