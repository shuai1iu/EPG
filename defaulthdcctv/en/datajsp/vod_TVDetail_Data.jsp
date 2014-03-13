<!--文件名：vod_TVDetail_Data.jsp-->
<!--描述:电视详情数据层-->
<!--修改者：tanbaoqiang-->
<!--时间：2010-07-30-->
<%@ page contentType="text/html; charset=UTF-8" language="java" buffer="32kb"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.Integer"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>

<%@ include file = "SubStringFunction.jsp"%>
<%@ include file = "../util/util_IsHasBookMark.jsp"%>
<%@ include file = "../util/util_getPosterPaths.jsp"%>
<%@ include file = "../util/util_IsValidateAssess.jsp"%>

<script type="text/javascript">
var subDetail=[];

var preFocus = [];//返回的焦点数据
<%!  
    //一次取80条影片（MAX_NUM_ONCE/DISPLAY_ROWS可整除，为奇数）
    protected static int MAX_NUM_ONCE = 840;
%>
<%
    TurnPage turnPage = new TurnPage(request);
    String tempUrl = turnPage.go(-1);
	//删除上一个URL之后的所有URL
	String lastUrl=turnPage.getLast(); 
    if(lastUrl.indexOf("vod_FilmDetail.jsp")==0 ||lastUrl.indexOf("vod_TVDetail.jsp")==0 ||lastUrl.indexOf("vod_TVTypeDetail.jsp")==0)
	{
	    turnPage.removeUrl(tempUrl);
	}
	turnPage.addUrl();	
	
    String tmpFocus = (String)request.getParameter("PREFOUCS");
	if(tmpFocus == "" || tmpFocus == null)
	{
	    tmpFocus = "1,0,0,0,0,0,0,0";
	}
	String[] tempFocus = new String[8];
	tempFocus =tmpFocus.split(",");
	for(int i=0;i<tempFocus.length;i++)
	{
%>
	    preFocus.push(<%=tempFocus[i]%>);
<%
	}

  	// 从request中获取关键参数
    int supportHD = 0 ;
	try
	{
		supportHD = Integer.valueOf((String)session.getAttribute("SupportHD")).intValue();
	}
	catch(Exception ee)
	{
		supportHD = 0 ;
	}

	String strFilmId = request.getParameter("PROGID");
	

	String strTypeId = request.getParameter("TYPE_ID");
/*	String StrdetailNum = request.getParameter("detailNum");
	int detailNum=0;
	if(StrdetailNum!=null)
	{
	     detailNum = Integer.parseInt(StrdetailNum);
	}*/
	String supVodId = request.getParameter("SUPVODID");
	
	String type=request.getParameter("ECTYPE");
	//搜索方式
	String searchType = request.getParameter("TYPE");
	int itype = 0;
	try
	{
		itype=Integer.parseInt(type);
	}
	catch(Exception e)
	{
		
	}
	
    int filmId = 0;
    String pageName = "";

    try
    {
        filmId = Integer.parseInt(strFilmId);
    }
    catch(Exception ex)
    {
		turnPage.removeLast(); 
        pageName = "InfoDisplay.jsp?ERROR_ID=48";
%>
        <jsp:forward page="<%= pageName %>" />
<%
    }    
	MetaData metaData = new MetaData(request);
    // 调用MetaData获取影片详细信息
    Map filmInfoMap = metaData.getVodDetailInfo(filmId); // 注意增加对strFilmId的判断


	if (filmInfoMap == null || filmInfoMap.size() == 0)
    {
        turnPage.removeLast(); 
%>
        <jsp:forward page="InfoDisplay.jsp?ERROR_ID=25&ERROR_TYPE=2" />
<%
        
    }
	
	//判断获取的vod信息是否为空
    else if ( filmInfoMap != null && filmInfoMap.size() != 0 )
    {
         	int intContentType = ((Integer)filmInfoMap.get("CONTENTTYPE")).intValue();	
			// 影片名称、主导演、简介、片长、图片路径等信息
			String vodName = "";
			String vodFullName = "";
			if(filmInfoMap.get("VODNAME") != null)
			{
				vodName = subStringFunction(filmInfoMap.get("VODNAME").toString(),1,330);
				vodFullName = filmInfoMap.get("VODNAME").toString();
			}
			String definition=filmInfoMap.get("DEFINITION").toString().trim();

			String actorOne = "暂无信息";
			String fullActorOne="暂无信息";
			String actorTwo = "暂无信息";
			String fullActorTwo = "暂无信息";
			String  director = "暂无信息";
			String fullDirector = "暂无信息";
			HashMap allActor = (HashMap)filmInfoMap.get("CASTMAP");
			if(allActor!=null && allActor.size() != 0)
			{
			    String[] actors=(String[])allActor.get(0);
                if(actors!=null && actors.length!=0)
				{
				    int actorsLength=actors.length;
					if(actorsLength==1)
					{
					    fullActorOne= actors[0]; 
						String[] actorArray = fullActorOne.split(" ");
						
						fullActorOne="";
						for(int i=0;i<actorArray.length;i++)
						{
							if(i != (actorArray.length-1))
							{
							     fullActorOne +=actorArray[i]+ "、";
							}
							else
							{
								 fullActorOne +=actorArray[i];
							}
							
						}
						actorOne=subStringFunction(fullActorOne,1,135);
					}
					else if(actorsLength>=2)
					{
						for(int i=0;i<actorsLength;i++)
						{
						    fullActorOne += actors[i];
							if(i != (actorsLength-1))
							{
							     fullActorOne += "、";
							}
						}
					    //fullActorOne= actors[0]; 
						actorOne=subStringFunction(fullActorOne,1,135);
						//fullActorTwo= actors[1];
						//actorTwo=subStringFunction(fullActorTwo,1,135);
					}
				}
				String[] directors=(String[])allActor.get(1);
				if(directors!=null && directors.length!=0)
				{
				    int directorsLength = directors.length;
					String[] directorArray = directors[0].split(" ");
					fullDirector="";
				    for(int i=0;i<directorArray.length;i++)
					{
					    if(i != (directorArray.length-1))
						{
							 fullDirector +=directorArray[i]+ "、";
						}
						else
						{
							 fullDirector +=directorArray[i];
						}
					}
				    //fullDirector=directors[0];
					director=subStringFunction(fullDirector,1,135);
				}
			}
			//添加片源提供商
			String spname = "暂无信息";
			if(filmInfoMap.get("SPNAME") != null)
			{
				spname = subStringFunction((String)filmInfoMap.get("SPNAME"),1,75);
			}
			
			
			//影片介绍信息
			String introduce = "该影片暂无简介";
			if(filmInfoMap.get("INTRODUCE") != null)
			{
			    introduce = subStringFunction((String)filmInfoMap.get("INTRODUCE"),3,330);
			}
			String vodofflineDate = " ";
			//影片上下线标志
			if(Integer.parseInt(filmInfoMap.get("RELFLAG").toString()) == 3)
			{
				String year = filmInfoMap.get("ENDTIME").toString().substring(0,4);
				String month = filmInfoMap.get("ENDTIME").toString().substring(4,6);
				String day = filmInfoMap.get("ENDTIME").toString().substring(6,8);
				vodofflineDate = year+","+month+","+ day;
					
			}
		
			//此处从后台取来的数据单位为“分钟” 节目片长
			String elapsetime = String.valueOf(filmInfoMap.get("ELAPSETIME"));	
			
			
			
			//海报信息
			HashMap picpathTemp = (HashMap)filmInfoMap.get("POSTERPATHS"); 
			String picPath = getPosterPath(picpathTemp,request);
			if(picPath=="false")
			{
			     picPath="images/display/vod/no_pic.jpg";
			}
			String sitcomNum = String.valueOf(filmInfoMap.get("SITCOMNUM"));
			
			//影片价格
			String vodPrice = "0";
			if(filmInfoMap.get("VODPRICE")!=null)
			{
			   vodPrice = (String)filmInfoMap.get("VODPRICE");
			}			
			
		
			// 片花ID
			int assessId = ((Integer)filmInfoMap.get("ASSESSID")).intValue(); 
			
			//是否包含片花：1：包含	0：不包含
			int hasAssess= ((Integer)filmInfoMap.get("ISASSESS")).intValue();
			
			boolean validAssess = isValidAssess(String.valueOf(assessId),request);
			if(validAssess)
			{
				hasAssess = 1;
			}
			else
			{
				hasAssess = 0 ;
			}
			
			
			//连续剧类型：0：非连续剧父集1：连续剧父集
			int isSitCom = ((Integer)filmInfoMap.get("ISSITCOM")).intValue();
			
			// 是连续剧父集
			String fathervodid = String.valueOf(filmInfoMap.get("FATHERVODID"));
		
			int countTotal = 0 ;			
%>
 
			var sitcomList_js = [];
<%
            int fetchNum = 0; 
			//连续剧 
			if ( isSitCom == 1 )
			{
				//	0：非连续剧父集	1：连续剧父集
				ArrayList resultList = metaData.getSitcomList(String.valueOf(filmId), MAX_NUM_ONCE, 0);
				Map sitcomInfoMap = metaData.getVodDetailInfo(filmId);
				HashMap countMap = (HashMap)resultList.get(0);
				
				//影片总集数
				countTotal = ((Integer)countMap.get(EPGConstants.KEY_COUNT)).intValue();
				if(countTotal > 0)
				{
					ArrayList sitcomList = (ArrayList)resultList.get(1);
					
					//获取记录数
					fetchNum = sitcomList.size();
					//StringBuffer temp = null;
					String temp=null;
					HashMap sitcomMap = null;  
					int leng = 0;
					
					for(int i = 0; i < fetchNum; i++ )
					{
						    sitcomMap = (HashMap)sitcomList.get(i);
						    //子集Id
						    int ivodId=((Integer)sitcomMap.get("VODID")).intValue();
						    String vodId = String.valueOf(ivodId);
						    int sitcom = ((Integer)sitcomMap.get("SITCOMNUM")).intValue();
							//temp = new StringBuffer(String.valueOf((Integer)sitcomMap.get("SITCOMNUM")));
							temp = String.valueOf((Integer)sitcomMap.get("SITCOMNUM"));
							leng = temp.length();
							/*if(leng > 7)
							{
								temp.replace(3,leng-3,"...");
							}*/
							if(leng > 3)
							{
							    temp=temp.substring(0,3);
							}
							//temp.insert(0,"");
							//子集号
							//String realsitcomNum = temp.toString();
							String realsitcomNum = temp;
							String sicomdefinition = sitcomMap.get("DEFINITION").toString().trim();
							//影片价格
							String sicomvodPrice = "0";
							int subContentType=-1;
							Map subFilmInfoMap = metaData.getVodDetailInfo(ivodId);
							if ( subFilmInfoMap != null && subFilmInfoMap.size() != 0 )
							{
								  if(sitcomInfoMap.get("VODPRICE")!=null)
								  {
									    sicomvodPrice = (String)sitcomInfoMap.get("VODPRICE");
								  }
							      double realvodPrice = 0.0; ////影片价格
								  if(null!=sicomvodPrice&&!"".equals(sicomvodPrice))
								  {
										try
										{
											realvodPrice = Double.parseDouble(sicomvodPrice);
										}
										catch(NumberFormatException e)
										{
											realvodPrice = 0.0;
										}
								  }	
								  realvodPrice = realvodPrice/100;
								  sicomvodPrice = realvodPrice+"";
								  if(sicomvodPrice.length() > 10)
								  {
									   sicomvodPrice = sicomvodPrice.substring(0,10)+"...";
								  }					
							      subContentType = ((Integer)subFilmInfoMap.get("CONTENTTYPE")).intValue();
							}
							// 判断用户是否收藏，显示对应链接
							ServiceHelp serviceHelp = new ServiceHelp(request);
							String   favoriteHref = ""; 
							
							boolean  isFavorited  = serviceHelp.isFavorited(ivodId,intContentType);
						//	boolean  isFavorited  = serviceHelp.isFavorited(fathervodid,intContentType);
						
							//isFavorited为true时表示该VOD已经收藏,否则表示没有收藏
							
							//判断当前VOD是否含有书签
							HashMap bookMap = isHasBookMark(vodId,request);
							Boolean  tempIsBookMark = (Boolean)bookMap.get("ISBOOKMARK"); 
							boolean  hasBookMark = tempIsBookMark.booleanValue();
							String bookMarkBeginTime = "0";
							if(hasBookMark)
							{  
								 bookMarkBeginTime =(String)bookMap.get("BEGINTIME");		
							}
							
%>
							var tempObj = {};
							tempObj.vodId = "<%=vodId%>";
							tempObj.sitcomNum = "<%=realsitcomNum%>" ;
							tempObj.contentType = "<%=subContentType%>";
							tempObj.vodPrice = "<%=sicomvodPrice%>";
							tempObj.definition = "<%=sicomdefinition%>";
							tempObj.isFavorited="<%=isFavorited%>";
							tempObj.hasBookMark="<%=hasBookMark%>";
							tempObj.bookMarkBeginTime="<%=bookMarkBeginTime%>";
							subDetail.push(tempObj);											   
<%
					}
				}
				//elapsetime = String.valueOf(countTotal);
				else if(countTotal <= 0)
				{
				      turnPage.removeLast(); 
%>
                      <jsp:forward page="InfoDisplay.jsp?ERROR_ID=123" />
<%
				}
			}   
			else
			{
				
				double realvodPrice = 0.0; ////影片价格
				
				if(null!=vodPrice&&!"".equals(vodPrice))
				{
					try
					{
						realvodPrice = Double.parseDouble(vodPrice);
					}catch(NumberFormatException e)
					{
						realvodPrice = 0.0;
					}
				}
				
				realvodPrice = realvodPrice/100;
				vodPrice = realvodPrice+"";
			}
			
			if(vodPrice.length() > 10)
			{
				vodPrice = vodPrice.substring(0,10)+"...";
			}
	

			// 判断用户是否收藏，显示对应链接
			ServiceHelp serviceHelp = new ServiceHelp(request);
			String   favoriteHref = ""; 
			boolean  isFavorited  = serviceHelp.isFavorited(filmId,intContentType);
			//isFavorited为true时表示该VOD已经收藏,否则表示没有收藏
			
			//判断当前VOD是否含有书签
			HashMap bookMap = isHasBookMark(strFilmId,request);
			Boolean  tempIsBookMark = (Boolean)bookMap.get("ISBOOKMARK"); 
			boolean  hasBookMark = tempIsBookMark.booleanValue();
			String bookMarkBeginTime = "0";
			if(hasBookMark)
			{  
				 bookMarkBeginTime =(String)bookMap.get("BEGINTIME");		
			}
			

%>
	
		    var vodObject = new Object();
		    //VOD类型
		    vodObject.contentType = "<%=intContentType%>";
			//VOD的栏目编号
			vodObject.typeId = "<%=strTypeId%>";
			//
			vodObject.fetchNum = "<%=fetchNum%>";
			//是否有片花
			vodObject.hasAssess = "<%=hasAssess%>"; 
			//是否被收藏
			vodObject.isFavorited = "<%=isFavorited%>";
			//是否有书签
			vodObject.hasBookMark = "<%=hasBookMark%>";
			//书签的开始时间
			vodObject.bookMarkBeginTime = "<%=bookMarkBeginTime%>";
			//影片ID
			vodObject.filmId   = "<%=filmId%>";
			//影片名称
			vodObject.vodName   = "<%=vodName%>";
			vodObject.vodFullName   = "<%=vodFullName%>";
			//片花的ID
			vodObject.assessId   = "<%=assessId%>";
			//导演名称
			vodObject.director  = "<%=director%>";
			//完整导演名称
			vodObject.fullDirector ="<%=fullDirector%>";
			//供应商名称
			vodObject.spname = "<%=spname%>";
			//演员
			vodObject.actorOne ="<%=actorOne%>";
			vodObject.actorTwo ="<%=actorTwo%>";
			//完整演员名称
			vodObject.fullActorOne ="<%=fullActorOne%>";
			vodObject.fullActorTwo ="<%=fullActorTwo%>";
			//时长或者集数
			vodObject.elapsetime = "<%=elapsetime%>";
			//vod的海报
			vodObject.picPath= "<%=picPath%>";
			//vod的价格
			vodObject.vodPrice = "<%=vodPrice%>";
			//vod的介绍
			vodObject.introduce = "<%=introduce%>";
			//是否是连续剧
			vodObject.isSitCom = "<%=isSitCom%>" ;
			//连续剧的集数
			vodObject.countTotal = "<%=countTotal%>" ;
			//是否支持高清
			vodObject.supportHD = "<%=supportHD%>"; 
			//vod是否是高清
			vodObject.definition = "<%=definition%>";
			//VOD的下线时间
			vodObject.vodofflineDate = "<%=vodofflineDate%>";
			//父集ID
			vodObject.superVodId = "<%=supVodId%>" ;

<%
     }
%>
</script>