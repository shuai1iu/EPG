<!-- FileName:au_Authorization.jsp -->
<%-- 
本页面用授权
--%>
<%@ page language="java" errorPage="ShowException.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC"%>
<%@ page import="com.huawei.iptvmw.epg.bean.func.UserService" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="java.net.URLEncoder"%>
<%@ taglib uri="/WEB-INF/ca.tld" prefix="ca" %>
<%@ include file="config/config_PlayFilm.jsp"%>
<html>
<head>
<title>SubscribeSelect</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<%
TurnPage turnPage = new TurnPage(request);
turnPage.addUrl();
ServiceHelp serviceHelp = new ServiceHelp(request);
ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
//是否可以预览 1，支持，0不支持
String sPreviewAble = request.getParameter("PREVIEWFLAG");
int previewAble = 0 ;
try
{
	previewAble = Integer.parseInt(sPreviewAble);
}
catch(Exception e)
{
	previewAble = 0 ;
}
//是否为御览的标示位
String pigFlag = request.getParameter("PIGFLAG");

//垫片判断
String sIsVir = "";
sIsVir = request.getParameter("ISVIR");
int isVir = 0;
if( sIsVir != null)
{

	isVir = Integer.parseInt(sIsVir);
}

String sTypeId = "";
int vipTypeId = 0;
//用于在尊享包体验期期间识别从主页哪个尊享栏目传入
sTypeId =  request.getParameter("VIPTYPE");
if( sTypeId != null)
{

	vipTypeId = Integer.parseInt(sTypeId);
}

//回看节目单过来的时候的频道ID
String strProChanID = request.getParameter("CHANNELID");
//要跳转的页面
String playPageUrl = turnPage.go(0);
//栏目号
String typesId = request.getParameter("TYPE_ID")==null?"-1":"null".equals(request.getParameter("TYPE_ID"))?"-1":request.getParameter("TYPE_ID");
//要播放影片的id
String sProgId = request.getParameter("PROGID"); 
//电视剧父集ID
String sFatherSeriesId = request.getParameter("FATHERSERIESID")==null? sProgId:"null".equals(request.getParameter("FATHERSERIESID"))?sProgId:"-1".equals(request.getParameter("FATHERSERIESID"))?sProgId:request.getParameter("FATHERSERIESID");

// 播放类型  内容类型 业务类型  
String sPlayType = request.getParameter("PLAYTYPE");
String sContentType = request.getParameter("CONTENTTYPE");
String sBusinessType = request.getParameter("BUSINESSTYPE");
//是否续订标示
String programOrder = request.getParameter("PROGRAM_ORDER");
//电视剧标志
String isTVSeriesFlag = request.getParameter("ISTVSERIESFLAG");
int proChanID = -1;
if(strProChanID != null) //回看节目的频道
{
	proChanID = Integer.parseInt(strProChanID);
}
int progId = Integer.parseInt(sProgId);
int playType = Integer.parseInt(sPlayType);
int contentType = Integer.parseInt(sContentType);
int businessType = Integer.parseInt(sBusinessType);
int fatherSeriesId = -2;
if ("1".equals(isTVSeriesFlag) || !"-2".equals(sFatherSeriesId)) 
{
	if (null != sFatherSeriesId && !"".equals(sFatherSeriesId)) 
	{
		System.out.println("authorizationHWCTC:sFatherSeriesId:"+sFatherSeriesId);
		fatherSeriesId = Integer.parseInt(sFatherSeriesId);
	}
}
//以上部分都是在获取参数值
String serviceType = (String)session.getAttribute("SERVICETYPE");

if ( serviceType == null || serviceType.trim().length() == 0 )
{
	serviceType = "-1";
	session.setAttribute("SERVICETYPE","-1");
}
serviceType = "-1";

%>
<!--更新数字证书授权-->
<ca:updateCAEntitlement playType="<%=playType%>" progId="<%=progId%>"/>
<%
//再把progId还原成录播频道的节目单ID
progId = Integer.parseInt(sProgId);
if(contentType == EPGConstants.CONTENTTYPE_PROGRAM &&(businessType == EPGConstants.BUSINESSTYPE_LIVETV|| businessType ==  EPGConstants.BUSINESSTYPE_NVOD))     
{
	System.out.println("EPGConstants.CONTENTTYPE_PROGRAM: BUSINESSTYPE_LIVETV || BUSINESSTYPE_NVOD");
	//增加页面超时的异常保护
	if(null != programOrder && programOrder.equalsIgnoreCase("false")&& serviceHelp.isSubscribeProgram(progId,contentType,businessType))	
	{
		programOrder = "true";
		%> 
			<jsp:forward page="<%=turnPage.go(0)%>"/>
			<%
	}
}
UserService userService = new UserService(request);
UserProfile userProfile = new UserProfile(request);
String userId = userProfile.getUserId();
String userToken = userProfile.getUserToken();
String stbMac = userProfile.getSTBMAC();
int lang = userProfile.getLang();
String stbIp = userProfile.getStbIp();
Map retMap = null;
//下面开授权

if ("1".equals(isTVSeriesFlag) || !"-2".equals(sFatherSeriesId)) 
{
	System.out.println("authorizationHWCTC:isTVSeriesFlag:1  sFatherSeriesId:!-2");
	retMap = serviceHelpHWCTC.authorizationHWCTC(fatherSeriesId,playType, contentType, businessType, typesId,fatherSeriesId);
}
else if (EPGConstants.PLAYTYPE_VAS == playType) 
{
	System.out.println("authorizationHWCTC:PLAYTYPE_VAS");
	retMap = serviceHelpHWCTC.authorizationHWCTC(progId, playType, contentType,businessType, typesId, fatherSeriesId);
} 
else if (EPGConstants.PLAYTYPE_TVOD == playType) 
{
	System.out.println("authorizationHWCTC:PLAYTYPE_TVOD");
	retMap = serviceHelpHWCTC.authorizationHWCTC(progId, playType, contentType,businessType, typesId, fatherSeriesId);
}
else 
{	
	// String typeid="00000100000000090000000000001261";
	System.out.println("authorizationHWCTC:Normal");

	retMap = serviceHelpHWCTC.authorizationHWCTC(progId, playType,contentType, businessType, typesId, fatherSeriesId);
}


int retCode = EPGErrorCode.AUTHORIZATION_DATABASEERROR;   //初始化为数据库异常，防止出现空值

if(null != retMap && null != retMap.get(EPGConstants.KEY_RETCODE))
{
	retCode = ((Integer)retMap.get(EPGConstants.KEY_RETCODE)).intValue();
}

String sProdId = (String) retMap.get("PROD_CODE");
String sServiceId = (String) retMap.get("SERVICE_CODE");
String sPrice = (String) retMap.get("PROD_PRICE");

int pProdCode = 0;
if(sProdId != null)
{
	pProdCode = Integer.parseInt(sProdId);
}


//查询已购的包
ArrayList prodList = (ArrayList) retMap.get("PREORDERED_PRODLIST");

Integer pProdIdInt = 0;  //用以保护标清节目
if(null != prodList &&  prodList.size() >0 )
{

	Object pProdIdObject = prodList.get(0); 
	Map preOrderedMap = null;
	preOrderedMap = (Map)pProdIdObject;

	String pProdId = (String) preOrderedMap.get("PROD_CODE");
	//未订购包的code
	pProdIdInt = Integer.parseInt(pProdId);

}



//查询未订购的包
ArrayList monthList = (ArrayList) retMap.get("MONTH_LIST");

Integer mProdIdInt = 0;  //用以保护标清节目
String mProdPrice = "";
String mProdName = "";
if(null != monthList && monthList.size()>0)
{
	Object mProdIdObject = monthList.get(0); 
	Map monthMap = null;
	monthMap = (Map)mProdIdObject;

	String mProdId = (String) monthMap.get("PROD_CODE");
	//	未订购包的code
	mProdIdInt = Integer.parseInt(mProdId);
	mProdPrice = (String) monthMap.get("PROD_PRICE");
	mProdName = (String) monthMap.get("PROD_NAME");	
}

//查询按次订购列表
ArrayList ppvList = (ArrayList) retMap.get("TIMES_LIST");
 System.out.println("=================PPVLIST====================="+ppvList);
Integer mPPVIdInt = 0;  //用以保护标清节目
if(null != ppvList && ppvList.size()>0)
{
        Object mPPVIdObject = ppvList.get(0);
	 System.out.println("===================mPPVIdObject===================="+mPPVIdObject);
        Map ppvMap = null;
        ppvMap = (Map)mPPVIdObject;
	 System.out.println("===================PPVMAP===================="+ppvMap);
        String mPPVId = (String) ppvMap.get("PROD_CODE");
        //      未订购包的code
        mPPVIdInt = Integer.parseInt(mPPVId);
	 System.out.println("===================mPPVIdInt===================="+mPPVIdInt);


}




String pageName ="errorinfo.jsp";

System.out.println("AUTHORIZATION_userid="+userId+",retCode="+retCode);


if( 1 != isVir)
{
	if( 0 == retCode)	//EPGErrorCode.SUCCESS
	{
		 System.out.println("===================SUCCECESS=============");
		//sPrice = URLEncoder.encode(sPrice,"UTF-8");
		StringBuffer queryStr = new StringBuffer();
		queryStr.append(request.getQueryString());
		//queryStr.append("&PRODUCTID=" ).append(sProdId).append("&SERVICEID=").append(sServiceId).append("&ONECEPRICE=").append(sPrice);*/
		pageName = "play_pageControl.jsp?" + queryStr.toString();
		%>
			<jsp:forward page="<%= pageName %>" />
			<%
	}
	else if (retCode == 0x04010004)//0x04010004：用户不存在或非法用户
	{
		//turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=157";
		%>
			<jsp:forward page="<%=pageName%>"/>
			<%
	}
	else if(isChanSubscribe == -1 && (EPGConstants.PLAYTYPE_LIVE == playType || EPGConstants.PLAYTYPE_VAS == playType))
	{		
		System.out.println("authorization_retCode:au_ReviewOrSubscribe");
		//turnPage.removeLast();				
		request.setAttribute("RETMAP",retMap);

		String jumpPage = "au_ReviewOrSubscribe.jsp?" + request.getQueryString();
		%>
			<jsp:forward page="<%=jumpPage%>"/>
			<%
	}
	else if (retCode == 0x07020001)//没有可以订购的产品
	{
		//turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=154";
		%>
			<jsp:forward page="<%=pageName%>"/>
			<%
	}
	else if (retCode == 0x07020100)//0x07020100：数据库异常
	{	
		//turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=155";
		%>
			<jsp:forward page="<%=pageName%>"/>
			<%
	}
	else if (retCode == 0x07020200)//0x07020200：操作超时
	{
		//turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=171";
		%>
			<jsp:forward page="<%=pageName%>"/>
			<%
	}
	else if (retCode == 0x04010899)//0x04010899：用户令牌非法
	{
		//turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=158";
		%>
			<jsp:forward page="<%=pageName%>"/>
			<%
	}
	else if (retCode == 0x07000005) //0x07000005 传入的参数错误
	{	
		//turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=159";
		%>
			<jsp:forward page="<%=pageName%>"/>
			<%
	}
	else if (retCode == 0x07000006) //0x07000006 解码出现异常
	{
		//turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=153";
		//这句打印信息不要删掉，需求就是这样，没有为什么。
		System.out.println("userid="+userId+",stbMac="+stbMac);
		%>
			<script>
			tempKey = Authentication.CTCGetConfig('identityEncode');
		var pageName =  "<%=pageName%>";
		pageName = pageName + "&tempKey="+ tempKey;
		window.location.href = pageName;
		</script>
			<%
	}	
	else if (retCode == 400) //BSS限呼的一个问题
	{
		//turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=171";
		%>
			<jsp:forward page="<%=pageName%>"/>
			<%
	}
	//如果是TVOD时跳转到提示页面，不支持在线订购,不能订购该产品，请到营业厅办理或者拨打10000号咨询
	/*else if(EPGConstants.PLAYTYPE_TVOD == playType)
	  {
	  turnPage.removeLast();
	  pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=163";
	  %>
	  <script>
	  <jsp:forward page="<%=pageName%>"/>
	  </script>
	  <%

	  }	*/
	else if (retCode == 0x07020002||retCode ==500||retCode ==501||retCode ==502||retCode ==503||retCode ==504)
	{
		if( retCode == 500)
		{
			//turnPage.removeLast();
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=135";
		}
		else if(retCode == 501)//产品不存在或状态不可用
		{
			//turnPage.removeLast();
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=125";
		} 
		else if(retCode == 502)//服务不存在或状态不可用
		{
			//turnPage.removeLast();
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=126";
		}
		else if( retCode == 503)//订购的产品不在使用期内
		{
			//turnPage.removeLast();
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=127";
		}
		else if(retCode == 504 )//用户没有订购相应产品或订购关系已失效或未生效
		{
			  if(4201 == mProdIdInt || 420101 == mProdIdInt)
			{
				turnPage.removeLast();
				String goback = turnPage.go(0);
				String play_url="../../../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+sProgId+
	                "&FATHERSERIESID=" + sFatherSeriesId;
					
				 pageName = "SZ_EPG/page/check/page/buy.jsp?SUBJECTID="+typesId+"&VODID="+sProgId+"&FATHERID="+sFatherSeriesId+"&PLAYTYPE=1&CONTENTTYPE="+sContentType+"&BUSINESSTYPE=1";
				 %>
				<script>
                var pageName =  "<%=pageName%>";
                window.location.href = pageName+"&playurl="+escape('<%=play_url%>&returnurl='+escape('<%=goback%>'))+"&returnurl="+escape("<%=goback%>");
                </script>
                <%	
			}
			else if(4353 == mProdIdInt)
			{
				turnPage.removeLast();
				String goback = turnPage.go(0);
				String play_url = "../../au_PlayFilm.jsp?PROGID="+sProgId;
					  play_url+="&FATHERSERIESID="+sProgId;
					  play_url+="&CONTENTTYPE="+sContentType;
					  play_url+="&BUSINESSTYPE=1";
					  play_url+="&PLAYTYPE=1";
					  
				      pageName = "SYGQ/page/order.jsp?SUBJECTID="+typesId+"&VODID="+sProgId+"&FATHERID="+sFatherSeriesId+"&PLAYTYPE=1&CONTENTTYPE="+sContentType+"&BUSINESSTYPE=1";
					   %>
						  <script>
                          var pageName =  "<%=pageName%>";
                          window.location.href = pageName+"&playurl="+escape('<%=play_url%>&returnurl='+escape('<%=goback%>'))+"&returnurl="+escape("<%=goback%>");
                          </script>
                      <%	
					  	
			}
			else if(4200==mProdIdInt||420001==mProdIdInt)
			{		
				turnPage.removeLast();
				String goback = turnPage.go(0);
				String play_url="../../../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+sProgId+
	                "&FATHERSERIESID=" + sFatherSeriesId;
					
				 pageName = "SZ_EPG/page/check/page/upgrade.jsp?SUBJECTID="+typesId+"&VODID="+sProgId+"&FATHERID="+sFatherSeriesId+"&PLAYTYPE=1&CONTENTTYPE="+sContentType+"&BUSINESSTYPE=1";
				 %>
				<script>
                var pageName =  "<%=pageName%>";
                window.location.href = pageName+"&playurl="+escape('<%=play_url%>&returnurl='+escape('<%=goback%>'))+"&returnurl="+escape("<%=goback%>");
                </script>
                <%	
			}

			
		} 
		else
		{
			    /*turnPage.removeLast();
				String goback = turnPage.go(0);
				String play_url="../../../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+sProgId+
	                "&FATHERSERIESID=" + sProgId ;
					
				 pageName = "SZ_EPG/page/check/page/upgrade.jsp?SUBJECTID="+typesId+"&VODID="+sProgId+"&FATHERID="+sProgId+"&PLAYTYPE=1&CONTENTTYPE="+sContentType+"&BUSINESSTYPE=1";
				 %>
				<script>
                var pageName =  "<%=pageName%>";
                window.location.href = pageName+"&playurl="+escape('<%=play_url%>&returnurl='+escape('<%=goback%>'))+"&returnurl="+escape("<%=goback%>");
                </script>
                <%*/
		}
	}		
	else
	{
		//turnPage.removeLast();		
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=26";
	}
}
else if(1 == isVir)
{
	
	if( 0 == retCode)
	{
	  
			if(4201 == pProdCode || 420101 == pProdCode)
				{
				  if(vipTypeId == 1)
                                        {

                                        StringBuffer queryStr = new StringBuffer();
                                        queryStr.append(request.getQueryString());
                                        pageName = "SZ_EPG/page/hdlist.jsp?typeid=10000100000000090000000000031171&returnurl=../../index.jsp";
                                        }else if(vipTypeId == 2)
                                        {

                                        StringBuffer queryStr = new StringBuffer();
                                        queryStr.append(request.getQueryString());
                                        pageName = "SZ_EPG/page/hdlist.jsp?typeid=10000100000000090000000000031172&returnurl=../../index.jsp";
                                        }
                                        else if(vipTypeId == 3)
                                        {

                                        StringBuffer queryStr = new StringBuffer();
                                        queryStr.append(request.getQueryString());
                                        pageName = "SZ_EPG/page/hdlist.jsp?typeid=10000100000000090000000000031173&returnurl=../../index.jsp";
                                        }
                                        else if(vipTypeId == 4)
                                        {


                                        StringBuffer queryStr = new StringBuffer();
                                        queryStr.append(request.getQueryString());
                                        pageName = "SZ_EPG/page/hdlist.jsp?typeid=10000100000000090000000000031174&returnurl=../../index.jsp";
                                        }else
                                        {
                                        StringBuffer queryStr = new StringBuffer();
                                        queryStr.append(request.getQueryString());
                                        pageName = "SZ_EPG/page/index.jsp";
                                        }				
}
			else
			{

				pageName = "index.jsp" ;
				System.out.println("!!!!!!!!!!!!!BBBBBBBBBBBBBBB!!!!!!!!!!!!"+pageName);
			}
			%>
                        <script>   //jsp:forward page="<%= pageName %>" /
				location.href = "<%=pageName%>";
			</script>
                        <%
				
	}	
	else if(0 != retCode)
		{
			if(mProdIdInt == 420101)
			{
			
				turnPage.removeLast();
				//pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=136";
				session.setAttribute("RETMAPSH",retMap);
				StringBuffer queryStrx = new StringBuffer();
				queryStrx.append(request.getQueryString());
				
				if(vipTypeId == 1)
				{
					pageName ="VipExperienceYO.jsp?typeid=10000100000000090000000000031171&returnurl=index.jsp";
					
				}else if (vipTypeId == 2)
				{	
					pageName = "VipExperienceYO.jsp?typeid=10000100000000090000000000031172&returnurl=index.jsp";

				}
				else if (vipTypeId == 3)
				{
					pageName = "VipExperienceYO.jsp?typeid=10000100000000090000000000031173&returnurl=index.jsp";

				}else if (vipTypeId == 4)
				{
					pageName ="VipExperienceYO.jsp?typeid=10000100000000090000000000031174&returnurl=index.jsp";
				}else
				{
					pageName ="VipExperience.jsp?returnurl=index.jsp";
					
				}


			}	
			else
			{
				turnPage.removeLast();
				//pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=136";
				session.setAttribute("RETMAPSH",retMap);
				StringBuffer queryStrx = new StringBuffer();
				queryStrx.append(request.getQueryString());
				pageName ="index.jsp";
			}
			%>
			<jsp:forward page="<%= pageName %>" />
			<%
		}	


}

%>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="transparent">
<table width="1280" height="720" border="0">
<tr>
<td width="640" height="530"></td>
</tr>
<tr>
<td align="center" style="font-size:36px;color:#FFFFFF; font-family:黑体">页面授权处理中. 请稍候...<%=pageName %></td>
</tr>
</table>
</body>	
</html>
