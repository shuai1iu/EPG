<!-- 文件名：spaceAllFavorited.jsp -->
<!-- 描  述：获取所有已经收藏影片 -->
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>

<%@ include file="../../../config/properties.jsp"%>

<%
   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
   System.out.println(basePath+"******************");
   int curpage = Integer.parseInt(request.getParameter("curpage"));
   int pos=curpage*6-6;
   MetaData metaData = new MetaData(request);
   ServiceHelp serviceHelp = new ServiceHelp(request);
   int favLimit = serviceHelp.getFavouriteLimit();//得到收藏列表的数目
   ArrayList result=null;
   ArrayList collentList=new ArrayList();
   int countTotal = 0;
   int pagecount=1;
   ArrayList favList = serviceHelp.getFavList();
   HashMap tempMap=new HashMap();
   if(favList == null)
   {
	   countTotal = 0;
   }
   else
   { 
	   //收藏总数
	   countTotal = ((Integer)((HashMap)favList.get(0)).get("COUNTTOTAL")).intValue();
	   result = (ArrayList)favList.get(1); 
	   pagecount=(int)Math.ceil(countTotal/6.0);
	   System.out.println(pagecount+"============pagecount=============");
   }
   if(countTotal>0)
   {
	   tempMap.put("countTotal",countTotal);
	   for(int i=pos;i<countTotal&&i<(pos+6);i++)
	   {
		   	HashMap collentobj=new HashMap();
		    int tempProgId = ((Integer)((HashMap)result.get(i)).get("PROG_ID")).intValue();
			String tempProgName = (String)((HashMap)result.get(i)).get("PROG_NAME");
			System.out.println(tempProgId+"============tempProgId==============tempProgName========="+tempProgName);
			
			collentobj.put("programCode",tempProgId);
			collentobj.put("progName",tempProgName);
			Map filmInfoMap = metaData.getVodDetailInfo(tempProgId); 
			if(filmInfoMap!=null)
			{
			    String targetPath =(filmInfoMap.get("PICPATH").toString()).replace("../../",basePath+"/EPG/jsp"+"/");
                int issitcom = Integer.parseInt(filmInfoMap.get("ISSITCOM").toString());
				collentobj.put("picUrl",targetPath);
				if(issitcom==0)
				{
					collentobj.put("programType","1");
				}
				else if(issitcom==1)
				{
					collentobj.put("programType","14");
				}
				else
				{
					collentobj.put("programType","-1");
				}
				
			//ISSITCOM
			
			}
			
			collentList.add(collentobj);   
	   }
	   
	   tempMap.put("collentList",collentList);    
   }
   
  JSONObject jsonObj= JSONObject.fromObject(tempMap);
  System.out.println(tempMap+"===========tempMap===============");
    
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<script type="text/javascript">
  var data=<%=jsonObj%>;
         function init()
		 {
               parent.callProgrameList(data);
         }

</script>
</head>
<body onload="init()">
</body>
</html>

    
    
    

