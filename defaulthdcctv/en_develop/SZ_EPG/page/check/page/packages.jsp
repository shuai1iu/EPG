<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ include file="codepage.jsp"%>
<%
    String returnurl=request.getParameter("returnurl")==null?"../../index.jsp":request.getParameter("returnurl");
	String playurl=request.getParameter("playurl")==null?"packages.jsp":request.getParameter("playurl");
    MetaData metadata = new MetaData(request);
    ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	
	//尊享整包
	String zxprodid="";
	String zxproname="";
	String zxservercode="";
	String zxprice="0";
	int iszxorder=0;
	HashMap zxresultMap = new HashMap();
	HashMap zxmediadetailInfo = (HashMap)metadata.getVodDetailInfo(zxvod);
	int zxcontenttype= Integer.parseInt(zxmediadetailInfo.get("CONTENTTYPE").toString());
	zxresultMap = serviceHelpHWCTC.authorizationHWCTC(zxvod,1, zxcontenttype,1,"",zxvod);
	int zxretCode = EPGErrorCode.AUTHORIZATION_DATABASEERROR;   //初始化为数据库异常，防止出现空值
	ArrayList zxmouseList = new ArrayList();
	if(null != zxresultMap && null != zxresultMap.get(EPGConstants.KEY_RETCODE))
	{
	   zxretCode = ((Integer)zxresultMap.get(EPGConstants.KEY_RETCODE)).intValue();
	}
	if(zxretCode == 504){
			   zxmouseList = (ArrayList) zxresultMap.get("MONTH_LIST");
			   if(zxmouseList!=null && zxmouseList.size()>0){
				   zxprodid = (String) ((HashMap)zxmouseList.get(0)).get("PROD_CODE");
				   zxproname = (String) ((HashMap)zxmouseList.get(0)).get("PROD_NAME");
				   zxservercode = (String) ((HashMap)zxmouseList.get(0)).get("SERVICE_CODE");
				   zxprice = (String) ((HashMap)zxmouseList.get(0)).get("PROD_PRICE");
				   if(zxprice == null || "".equals(zxprice))
				   {
							zxprice = "0";
				   }
				   zxprice=(Integer.parseInt(zxprice)/100)+"";
			   }
			  iszxorder=1;
	}else{
		 iszxorder=0;
	}
 
    
	//尊享大片
    String zxdapianprodid="";
	String zxdapianproname="";
	String zxdapianservercode="";
	String zxdapianprice="30";
	int iszxdapianorder=0;
	
	HashMap zxdapianresultMap = new HashMap();
	HashMap zxdapianmediadetailInfo = (HashMap)metadata.getVodDetailInfo(dapianvod);
	int zxdapiancontenttype= Integer.parseInt(zxdapianmediadetailInfo.get("CONTENTTYPE").toString());
	zxdapianresultMap = serviceHelpHWCTC.authorizationHWCTC(dapianvod,1, zxdapiancontenttype,1,"",dapianvod);
	int zxdapianretCode = EPGErrorCode.AUTHORIZATION_DATABASEERROR;   //初始化为数据库异常，防止出现空值
	ArrayList zxdapianmouseList = new ArrayList();
	if(null != zxdapianresultMap && null != zxdapianresultMap.get(EPGConstants.KEY_RETCODE))
	{
	   zxdapianretCode = ((Integer)zxdapianresultMap.get(EPGConstants.KEY_RETCODE)).intValue();
	}
	if(zxdapianretCode == 504){
			   zxdapianmouseList = (ArrayList) zxdapianresultMap.get("MONTH_LIST");
			   if(zxdapianmouseList!=null && zxdapianmouseList.size()>0){
				   zxdapianprodid = (String) ((HashMap)zxdapianmouseList.get(0)).get("PROD_CODE");
				   zxdapianproname = (String) ((HashMap)zxdapianmouseList.get(0)).get("PROD_NAME");
				   zxdapianservercode = (String) ((HashMap)zxdapianmouseList.get(0)).get("SERVICE_CODE");
				   zxdapianprice = (String) ((HashMap)zxdapianmouseList.get(0)).get("PROD_PRICE");
				   if(zxdapianprice == null || "".equals(zxdapianprice))
				   {
							zxdapianprice = "0";
				   }
				   zxdapianprice=(Integer.parseInt(zxdapianprice)/100)+"";
			   }
			  iszxdapianorder=1;
	}else{
		      iszxdapianorder=0;	
	}
 
    //高清热剧
    String zxrejuprodid="";
	String zxrejuproname="";
	String zxrejuservercode="";
	String zxrejuprice="20";
	int iszxrejuorder=0;
	
	HashMap zxrejuresultMap = new HashMap();
	HashMap zxrejumediadetailInfo = (HashMap)metadata.getVodDetailInfo(rejuvod);
	int zxrejucontenttype= Integer.parseInt(zxrejumediadetailInfo.get("CONTENTTYPE").toString());
	zxrejuresultMap = serviceHelpHWCTC.authorizationHWCTC(rejuvod,1, zxrejucontenttype,1,"",rejuvod);
	int zxrejuretCode = EPGErrorCode.AUTHORIZATION_DATABASEERROR;   //初始化为数据库异常，防止出现空值
	ArrayList zxrejumouseList = new ArrayList();
	if(null != zxrejuresultMap && null != zxrejuresultMap.get(EPGConstants.KEY_RETCODE))
	{
	   zxrejuretCode = ((Integer)zxrejuresultMap.get(EPGConstants.KEY_RETCODE)).intValue();
	}
	if(zxrejuretCode == 504){
			   zxrejumouseList = (ArrayList) zxrejuresultMap.get("MONTH_LIST");
			   if(zxrejumouseList!=null && zxrejumouseList.size()>0){
				   zxrejuprodid = (String) ((HashMap)zxrejumouseList.get(0)).get("PROD_CODE");
				   zxrejuproname = (String) ((HashMap)zxrejumouseList.get(0)).get("PROD_NAME");
				   zxrejuservercode = (String) ((HashMap)zxrejumouseList.get(0)).get("SERVICE_CODE");
				   zxrejuprice = (String) ((HashMap)zxrejumouseList.get(0)).get("PROD_PRICE");
				   if(zxrejuprice == null || "".equals(zxrejuprice))
				   {
							zxrejuprice = "0";
				   }
				   zxrejuprice=(Integer.parseInt(zxrejuprice)/100)+"";
			   }
			  iszxrejuorder=1;
	}
    else{
		
	         iszxrejuorder=0;	
	}
 
	
	//高清纪实
    String zxjishiprodid="";
	String zxjishiproname="";
	String zxjishiservercode="";
	String zxjishiprice="30";
	int iszxjishiorder=0;
	
	HashMap zxjishiresultMap = new HashMap();
	HashMap zxjishimediadetailInfo = (HashMap)metadata.getVodDetailInfo(jishivod);
	int zxjishicontenttype= Integer.parseInt(zxjishimediadetailInfo.get("CONTENTTYPE").toString());
	zxjishiresultMap = serviceHelpHWCTC.authorizationHWCTC(jishivod,1, zxjishicontenttype,1,"",jishivod);
	int zxjishiretCode = EPGErrorCode.AUTHORIZATION_DATABASEERROR;   //初始化为数据库异常，防止出现空值
	ArrayList zxjishimouseList = new ArrayList();
	if(null != zxjishiresultMap && null != zxjishiresultMap.get(EPGConstants.KEY_RETCODE))
	{
	   zxjishiretCode = ((Integer)zxjishiresultMap.get(EPGConstants.KEY_RETCODE)).intValue();
	}
	if(zxjishiretCode == 504){
			   zxjishimouseList = (ArrayList) zxjishiresultMap.get("MONTH_LIST");
			   if(zxjishimouseList!=null && zxjishimouseList.size()>0){
				   zxjishiprodid = (String) ((HashMap)zxjishimouseList.get(0)).get("PROD_CODE");
				   zxjishiproname = (String) ((HashMap)zxjishimouseList.get(0)).get("PROD_NAME");
				   zxjishiservercode = (String) ((HashMap)zxjishimouseList.get(0)).get("SERVICE_CODE");
				   zxjishiprice = (String) ((HashMap)zxjishimouseList.get(0)).get("PROD_PRICE");
				   if(zxjishiprice == null || "".equals(zxjishiprice))
				   {
							zxjishiprice = "0";
				   }
				   zxjishiprice=(Integer.parseInt(zxjishiprice)/100)+"";
			   }
			  iszxjishiorder=1;
	}else{
		
		      iszxjishiorder=0;
	}
	
	
	//高清娱乐
    String zxyuleprodid="";
	String zxyuleproname="";
	String zxyuleservercode="";
	String zxyuleprice="20";
	int iszxyuleorder=0;
	
	
	HashMap zxyuleresultMap = new HashMap();
	HashMap zxyulemediadetailInfo = (HashMap)metadata.getVodDetailInfo(yulevod);
	int zxyulecontenttype= Integer.parseInt(zxyulemediadetailInfo.get("CONTENTTYPE").toString());
	zxyuleresultMap = serviceHelpHWCTC.authorizationHWCTC(yulevod,1, zxyulecontenttype,1,"",yulevod);
	int zxyuleretCode = EPGErrorCode.AUTHORIZATION_DATABASEERROR;   //初始化为数据库异常，防止出现空值
	ArrayList zxyulemouseList = new ArrayList();
	if(null != zxyuleresultMap && null != zxyuleresultMap.get(EPGConstants.KEY_RETCODE))
	{
	   zxyuleretCode = ((Integer)zxyuleresultMap.get(EPGConstants.KEY_RETCODE)).intValue();
	}
	if(zxyuleretCode == 504){
			   zxyulemouseList = (ArrayList) zxyuleresultMap.get("MONTH_LIST");
			   if(zxyulemouseList!=null && zxyulemouseList.size()>0){
				   zxyuleprodid = (String) ((HashMap)zxyulemouseList.get(0)).get("PROD_CODE");
				   zxyuleproname = (String) ((HashMap)zxyulemouseList.get(0)).get("PROD_NAME");
				   zxyuleservercode = (String) ((HashMap)zxyulemouseList.get(0)).get("SERVICE_CODE");
				   zxyuleprice = (String) ((HashMap)zxyulemouseList.get(0)).get("PROD_PRICE");
				   if(zxyuleprice == null || "".equals(zxyuleprice))
				   {
							zxyuleprice = "0";
				   }
				   zxyuleprice=(Integer.parseInt(zxyuleprice)/100)+"";
			   }
			   iszxyuleorder=1;
	}else{
		
	           iszxyuleorder=0;
	}
	int isTotalOrder=0;
	if(iszxorder==0 || (iszxyuleorder==0 && iszxjishiorder==0 && iszxrejuorder==0  && iszxdapianorder==0)){
		 isTotalOrder=1;
	}
	
	HashMap mediacheckdetailInfo = (HashMap)metadata.getVodDetailInfo(1893157);
	int checkcontenttype = Integer.parseInt(mediacheckdetailInfo.get("CONTENTTYPE").toString());
	Map retCheckMap = null;
	int checkresult=0;
	retCheckMap = serviceHelpHWCTC.authorizationHWCTC(1893157,1, checkcontenttype,1,"",1893157);
	int checkretCode = EPGErrorCode.AUTHORIZATION_DATABASEERROR;   //初始化为数据库异常，防止出现空值
	if(null != retCheckMap && null != retCheckMap.get(EPGConstants.KEY_RETCODE))
	{
		checkretCode = ((Integer)retCheckMap.get(EPGConstants.KEY_RETCODE)).intValue();
	}
	
	//授权通过
	if(checkretCode == EPGErrorCode.SUCCESS)
	{
		checkresult=1;
		
	}else{
		
		checkresult=0;
		
	}
     int zxDiscount=110-Integer.parseInt(zxprice);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
     <meta charset="UTF-8">
     <meta name="page-view-size" content="1280*720"/>
     <title>高清视界-已订购 EPG</title>
     <link rel="stylesheet" href="../css/style.css">
     <style>
        body {
            background: #b8b9bd url("../images/j-bg-orderWhite.jpg") no-repeat;
        }
     </style>

    <script type="text/javascript" src="../../../js/pagecontrol.js"></script>
	<script type="text/javascript">
	    if(<%=isTotalOrder%>==1){
			 window.location.href="buy-tipslast.jsp";
		}
		var area0,area1;
		var areaid = 0,indexid = 0;
		window.onload = function(){
			var tempdoms=new Array();
			
                        //半价特惠包子包订购页置灰尊享包整包订购按钮
			$("area0_list0").style.background = "url(../images/z-icon-003-2-discount.png) center top no-repeat";
			
			if(<%=iszxdapianorder%>==1){
			  var tempdom1=new DomData("area0_list1");
			  tempdom1.domOkEvent=function(){
				
				if(<%=checkresult%>==1)
				{
				  window.location.href="order-sure.jsp?price=<%=zxdapianprice%>&prodname=<%=zxdapianproname%>&prodid=<%=zxdapianprodid%>&serverid=<%=zxdapianservercode%>&vodid=<%=dapianvod%>&parentvodid=<%=dapianvod%>&url1="+escape(window.location.href)+"&playurl="+escape("<%=playurl%>");
				}else{
			window.location.href="upgradeorder.jsp?returnurl="+escape(window.location.href)+"&playurl="+escape(window.location.href);
				}
			  };
			  tempdoms.push(tempdom1);
			}else{
				$("area0_list1").style.background = "url(../images/z-icon-003-2.png) center top no-repeat";
			}
			
			
			
			if(<%=iszxrejuorder%>==1){
			  var tempdom2=new DomData("area0_list2");
			  tempdom2.domOkEvent=function(){
				  if(<%=checkresult%>==1){
					  window.location.href="order-sure.jsp?price=<%=zxrejuprice%>&prodname=<%=zxrejuproname%>&prodid=<%=zxrejuprodid%>&serverid=<%=zxrejuservercode%>&vodid=<%=rejuvod%>&parentvodid=<%=rejuvod%>&url1="+escape(window.location.href)+"&playurl="+escape("<%=playurl%>");
				  }else{
					  window.location.href="upgradeorder.jsp?returnurl="+escape(window.location.href)+"&playurl="+escape(window.location.href);
				  }
			  };
			  tempdoms.push(tempdom2);
			}else{
				$("area0_list2").style.background = "url(../images/z-icon-003-2.png) center top no-repeat";
			}
			
			
		   if(<%=iszxjishiorder%>==1){
			  var tempdom3=new DomData("area0_list3");
			  tempdom3.domOkEvent=function(){
				  if(<%=checkresult%>==1){
				     window.location.href="order-sure.jsp?price=<%=zxjishiprice%>&prodname=<%=zxjishiproname%>&prodid=<%=zxjishiprodid%>&serverid=<%=zxjishiservercode%>&vodid=<%=jishivod%>&parentvodid=<%=jishivod%>&url1="+escape(window.location.href)+"&playurl="+escape("<%=playurl%>");	
				  }else{
					  window.location.href="upgradeorder.jsp?returnurl="+escape(window.location.href)+"&playurl="+escape(window.location.href);
					  
				  }
			  };
			  tempdoms.push(tempdom3);
			}else{
				$("area0_list3").style.background = "url(../images/z-icon-003-2.png) center top no-repeat";
			}
		
			
			if(<%=iszxyuleorder%>==1){
			  var tempdom4=new DomData("area0_list4");
			  tempdom4.domOkEvent=function(){
				  if(<%=checkresult%>==1){
				     window.location.href="order-sure.jsp?price=<%=zxyuleprice%>&prodname=<%=zxyuleproname%>&prodid=<%=zxyuleprodid%>&serverid=<%=zxyuleservercode%>&vodid=<%=yulevod%>&parentvodid=<%=yulevod%>&url1="+escape(window.location.href)+"&playurl="+escape("<%=playurl%>");	
				  }else{
					 window.location.href="upgradeorder.jsp?returnurl="+escape(window.location.href)+"&playurl="+escape(window.location.href);
				  }
			  };
			  tempdoms.push(tempdom4);
			}else{
				$("area0_list4").style.background = "url(../images/z-icon-003-2.png) center top no-repeat";
			}
			
			if(tempdoms.length>0){
			    area0=new Area(1,tempdoms.length,tempdoms,new Array(-1,-1,1,-1));
				var domsfocusstyle=new Array("className:icon-btn item_focus");
		        area0.commonfocusstyle=domsfocusstyle;
		        var domsunfocusstyle=new Array("className:icon-btn");
		        area0.commonunfocusstyle=domsunfocusstyle;
				area1=AreaCreator(1,1,new Array(0,-1,-1,-1),"area1_list","className:item item_focus","className:item");
				pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0, area1));
			}
			else{
				area1=AreaCreator(1,1,new Array(-1,-1,-1,-1),"area1_list","className:item item_focus","className:item");
				pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area1));
		    }
			area1.doms[0].domOkEvent=function(){
	             window.location.href="<%=returnurl%>";
            };
			pageobj.backurl ="<%=returnurl%>";
		}
    </script>
</head>
<body>
<div class="wrapper">
    
    <!-- S 页面头部 -->
    <div class="j-logoPageTitle">高清尊享包 <span class="f">订购</span></div>
    <!-- E 页面头部 -->

    <!-- S 页面内容 -->
    <div class="packages">
			<div class="z-top"></div>
			<div class="seniorVip">
				<div class="zMiddle">
					<div class="item">
						<div class="zTop">高清尊享包</div>
						<div class="icon-img icon1">
							<div>高清尊享包</div>
						</div>
						<div class="price"><span><%=zxprice%></span>元/月</div>
						<div class="price del"></div>
						<div class="desVip">
							<span class="z-title">包含：</span>
							<div class="des">
								高清大片、高清热剧
								高清纪实、高清娱乐
								高清时尚
							</div>
						</div>
						<div class="icon-btn" id="area0_list0" style="left: 90px;"></div>
					</div>
				</div>
				<div class="zBottom"></div>
			</div>
			<div class="ordinary">
				<div class="zMiddle">
					<div class="item">
						<div class="zTop">高清大片</div>
						<div class="icon-img icon1">
							<div>高清大片</div>
						</div>
						<div class="price"><%=zxdapianprice%>元/月</div>
						<div class="des">
							欧美高票房大片，
							惊险、刺激、华
							丽的好莱坞大片
							抢先放送。
						</div>
						<div class="icon-btn" id="area0_list1"></div>
					</div>
					<div class="item" style="left: 173px;">
						<div class="zTop">高清热剧</div>
						<div class="icon-img icon2">
							<div id="alertstr">高清热剧</div>
						</div>
						<div class="price"><%=zxrejuprice%>元/月</div>
						<div class="des">
							同步热播卫视剧，
							独家首播港台剧、
							海外剧等上千集
							高清剧集。
						</div>
						<div class="icon-btn" id="area0_list2"></div>
					</div>
					<div class="item" style="left: 346px;">
						<div class="zTop">高清纪实</div>
						<div class="icon-img icon3">
							<div>高清纪实</div>
						</div>
						<div class="price"><%=zxjishiprice%>元/月</div>
						<div class="des">
							BBC 、国家地理
							等品牌纪录片，
							科技、军事、人
							文等全方位放送。
						</div>
						<div class="icon-btn" id="area0_list3"></div>
					</div>
					<div class="item" style="left: 519px;">
						<div class="zTop">高清娱乐</div>
						<div class="icon-img icon4">
							<div>高清娱乐</div>
						</div>
						<div class="price"><%=zxyuleprice%>元/月</div>
						<div class="des">
							众星云集，演唱
							会、音乐会、晚
							会、各大娱乐节
							目想看就看。
						</div>
						<div class="icon-btn" id="area0_list4"></div>
					</div>
				</div>
				<div class="zBottom">
					<div class="j-btn-back" style="left: 538px;top: 405px;">
			            <div class="item" id="area1_list0"></div>
			        </div>
				</div>
			</div>
		</div>
		
    <!-- E 页面内容 -->
</div>
</body>
