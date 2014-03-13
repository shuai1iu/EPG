<!-- Copyright (C), pukka Tech. Co., Ltd. -->
<!-- Author:mxr -->
<!-- CreateAt:20110728 -->
<!-- FileName:play_ControleVodData.jsp -->

<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ include file = "datajsp/SubStringFunction.jsp"%>
<%!
	static int MAX_NUM_ONCE = 999;
%>
<%
	//从session中获取关键参数
    int supportHD = 0 ;
	int currIndex=-1;
	try
	{
		supportHD = Integer.valueOf((String)session.getAttribute("SupportHD")).intValue();
	}
	catch(Exception ee)
	{
		supportHD = 0 ;
	}
	String progId = request.getParameter("progId");
	int iProgId = Integer.parseInt(progId);
	String fatherId = request.getParameter("fatherId");
	String isChildren = request.getParameter("isChildren");
	int iFatherId = Integer.parseInt(fatherId);
	MetaData metaData = new MetaData(request);
	Map vodInfoMap = null;
	String preProgId = "-1";//上一个节目id
	String preProgNum = "";
	String nextProgId = "-1";//下一个节目id
	String nextProgNum = "";
	String vodName = "暂无信息";//本vod的名字
	String director = "暂无信息";//导演
	String actor = "暂无信息";//演员
	String introduce = "暂无信息";//介绍信息
	String sitNum = ""; //当前vod的集数
	
	String fatherVodName = "";
	String vodMediaCode ="";
	String preCanPlay = "2" ;
	String nextCanPlay = "2";

	//isChildren=1表示当前progid为子集,需要用父集ID来获取信息
	if(!("-1".equals(fatherId)) && fatherId !="" && fatherId != null && fatherId != "null" && isChildren =="1")
	{	
		vodInfoMap = metaData.getVodDetailInfo(iFatherId);
	}
	else
	{	
		vodInfoMap = metaData.getVodDetailInfo(iProgId);
	}
        System.out.println("INFOMAP===" + vodInfoMap);
	if(vodInfoMap != null)
	{	
		vodName = (String)vodInfoMap.get("VODNAME");
		String actorOne = "暂无信息";
		String fullActorOne="暂无信息";
		String actorTwo = "暂无信息";
		String fullActorTwo = "暂无信息";
		int actorsLength=0;
		HashMap allActor = (HashMap)vodInfoMap.get("CASTMAP");
		if(allActor!=null && allActor.size() != 0)
		{
			String[] actors=(String[])allActor.get(0);
			String[] directors = (String[])allActor.get(1);
			if(actors!=null && actors.length!=0)
			{
			    actorsLength=actors.length;
				if(actorsLength==1)
				{
					fullActorOne= actors[0]; 
					actorOne=subStringFunction(fullActorOne,1,130);
				}
				else if(actorsLength>=2)
				{
					fullActorOne= actors[0]; 
					actorOne=subStringFunction(fullActorOne,1,130);
					fullActorTwo= actors[1];
					actorTwo=subStringFunction(fullActorTwo,1,130);
				}
			}
			
			if(directors!=null && directors.length!=0)
			{
				director = subStringFunction(directors[0],1,130);
			}
		}
				
		actor = actorOne;
		introduce = (String)vodInfoMap.get("INTRODUCE");
		vodMediaCode  = (String)vodInfoMap.get("CODE");
	}
	
	//是连续剧的时候
	if(!("-1".equals(fatherId)))
	{
		
		currIndex = -1; //用来记录当前vod在数组中的位置
		
		ArrayList resultList = metaData.getSitcomList(String.valueOf(iFatherId), MAX_NUM_ONCE, 0);
		
		Map filmInfoMap = metaData.getVodDetailInfo(iFatherId);
		
		if(filmInfoMap!=null)
		{
			fatherVodName = (String)filmInfoMap.get("VODNAME");
		}
		
        ArrayList subVodList = null;
		
		if(resultList != null && resultList.size() > 1)
		{
			subVodList = (ArrayList)resultList.get(1);
		}

        if(subVodList != null && subVodList.size() > 0)
        {
			int totalSitNum = subVodList.size();
            for(int i = 0; i < subVodList.size(); i++)
            {
				Map sitVodMap = (HashMap)subVodList.get(i);
				Integer sitVodId = (Integer)sitVodMap.get("VODID");
				//如果传递进来的progId和当前的子集的ID相等
                if(sitVodId.toString().equals(progId))
                {
                    currIndex = i;
					
                    sitNum = ((Integer)sitVodMap.get("SITCOMNUM")).toString();//当前的子集集号
                }
            }

            if(currIndex - 1 < 0)
            {
                preProgId = "-1";
            }
            else
            {
				Map sitVodMap = (HashMap)subVodList.get(currIndex - 1);
				
				Integer sitVodId = (Integer)sitVodMap.get("VODID");
				String definition = sitVodMap.get("DEFINITION").toString().trim();
				if("1".equals(definition) && supportHD == 0)
				{
					//高清电影，标清机顶盒
					preCanPlay = "1" ;
				}
				preProgNum = ((Integer)sitVodMap.get("SITCOMNUM")).toString();
                preProgId = sitVodId.toString();
            }

            if(currIndex + 1 >=  totalSitNum)
            {
                nextProgId = "-1";
            }
            else
            {
				Map sitVodMap = (HashMap)subVodList.get(currIndex + 1);
				Integer sitVodId = (Integer)sitVodMap.get("VODID");
				String definition = sitVodMap.get("DEFINITION").toString().trim();
				if("1".equals(definition) && supportHD == 0)
				{
					//高清电影，标清机顶盒
					nextCanPlay = "1" ;
				}
                nextProgNum = ((Integer)sitVodMap.get("SITCOMNUM")).toString();
                nextProgId = sitVodId.toString();
            }
		}
	}
	
	/**************************对节目信息进行截取 start***********************************/
	if(!"-1".equals(fatherId))
	{
		vodName = (fatherVodName == null) ? "" : subStringFunction(fatherVodName,1,350);
		vodName = vodName + "&nbsp;(" + sitNum + ")";
	}
	else
	{
		vodName = (vodName == null) ? "" : subStringFunction(vodName,1,350);
	}
	actor = (actor == null) ? " " : subStringFunction(actor,1,130);
	director = (director == null) ? " " : subStringFunction(director,1,130);
	introduce = (introduce == null) ? "暂无简介" : subStringFunction(introduce,2,600);
	/**************************对节目信息进行截取 end***********************************/
	
	%>
        <script>
        	//alert("我是来到了play_controlVodData");
        </script>
	<%
	
%>
<script>
	 if (typeof(iPanel) != 'undefined')
	  {
		iPanel.focusWidth = "4";
		iPanel.defaultFocusColor = "#FCFF05";
	  }
	var preProgId = "<%=preProgId%>";//上一个节目id
	var preProgNum = "<%=preProgNum%>";
	var nextProgId = "<%=nextProgId%>";//下一个节目id
	var nextProgNum = "<%=nextProgNum%>";
	var vodName = "<%=vodName%>";//本vod的名字
	var director = "<%=director%>";//导演
	var actor = "<%=actor%>";//演员
	var introduce = "<%=introduce%>";//介绍信息
	var sitNum = "<%=sitNum%>"; //当前vod的集数
	var preCanPlay = "<%=preCanPlay%>";
	var nextCanPlay = "<%=nextCanPlay%>";
	/**
	*将数据赋值到父页面
	*/
	function copyDataToFather()
	{	
		Authentication.CTCSetConfig("mediacode","<%=vodMediaCode%>");
		parent.preProgId = preProgId;//上一个节目id
		parent.preProgNum = preProgNum;
		parent.nextProgId = nextProgId;//下一个节目id
		parent.nextProgNum = nextProgNum;
		parent.vodName = vodName;
		parent.director = director;
		parent.actor = actor;
		parent.introduce = introduce;
		parent.sitNum = sitNum; //当前vod的集数
		parent.preCanPlay = preCanPlay; 
		parent.nextCanPlay = nextCanPlay; 
	}
	
	copyDataToFather();
	parent.dataIsOk = true;
	parent.createMinEpg();
	parent.createQuitDiv();
	
</script>
