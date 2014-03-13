<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%
if(request.getParameter("typeid")!=null){
    MetaData metadata=new MetaData(request);
    int t=metadata.getSubTypeOrContent(request.getParameter("typeid"));
    if(t==0){
  	ArrayList vl=(ArrayList)metadata.getVodListByTypeId(request.getParameter("typeid"),-1,0);
        if(vl!=null && vl.size()>1 &&((ArrayList)vl.get(1)).size()>0 ){
             ArrayList pl=(ArrayList)vl.get(1);
             for(int i=0;i<pl.size();i++){
	         HashMap mp=(HashMap)pl.get(i);
		 if(mp!=null && mp.get("POSTERPATHS")!=null){
		 	HashMap postersMap = (HashMap)mp.get("POSTERPATHS");
			if(postersMap!=null && postersMap.get("0")!=null){
                            String[] ars= (String[])postersMap.get("0");
                            if(ars.length>0){
                                mp.put("POSTPATH0",ars[0]);
      			    }
                        }
                        if(postersMap!=null && postersMap.get("1")!=null){
                            String[] ars= (String[])postersMap.get("1");
  			    if(ars.length>0){
			        mp.put("POSTPATH1",ars[0]);
			    }
			}
			if(postersMap!=null && postersMap.get("2")!=null){
                            String[] ars= (String[])postersMap.get("2");
                            if(ars.length>0){
			        mp.put("POSTPATH2",ars[0]);
			    }
			}
			if(postersMap!=null && postersMap.get("3")!=null){
			    String[] ars= (String[])postersMap.get("3");
			    if(ars.length>0){
			        mp.put("POSTPATH3",ars[0]);
			    }
			}
		 }
	     }	     
             out.print(JSONArray.fromObject((ArrayList)vl.get(1)).toString());
	}
    }
    else if(t==1){
        ArrayList tl=(ArrayList)metadata.getTypeListByTypeId(request.getParameter("typeid"),-1,0);
	if(tl!=null && tl.size()>1 &&((ArrayList)tl.get(1)).size()>0){
	     out.print(JSONArray.fromObject((ArrayList)tl.get(1)).toString());  
	}
    }
    else{
    	out.print("[]");
	//HashMap mi = (HashMap)metaData.getVodDetailInfo();
	
    }
}
/*
else if(request.getParameter("vodid")!=null){
    ServiceHelp sh = new ServiceHelp(request);
    out.print(sh.getTriggerPlayUrl(1,Integer.parseInt(request.getParameter("vodid")),"0"));
}
*/
%>


