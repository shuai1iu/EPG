<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page errorPage="ShowException.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray"%>
<%@ page import="net.sf.json.JSONObject"%>
<%@ include file="util_getPosterPaths.jsp"%>
<%
    
	String isFromTvod = request.getParameter("isFromTvod");
	
	String channelcode = request.getParameter("channelcode");
	String area0index = request.getParameter("area0index");
	String area1index = request.getParameter("area1index");
	String area2index = request.getParameter("area2index");
	String channelid = request.getParameter("channelid");
	
	MetaData metaData = new MetaData(request);
   
    ArrayList result=new ArrayList();
    ArrayList result1=new ArrayList();
    result = metaData.getChanListByTypeId("10000100000000090000000000039770",4,0);
    result1=(ArrayList)result.get(1);
    
	JSONArray recChannelBill=null;
	
	ArrayList recChanList=new ArrayList();
	
	for(int j=0;j<result1.size();j++)
	{
		HashMap chanInfomap = (HashMap)result1.get(j);
		String tempchannelcode =(String)chanInfomap.get("CHANNELID");
		int tempchannelid = ((Integer)chanInfomap.get("CHANNELINDEX")).intValue()-1000;
		String tempchannelname = (String)chanInfomap.get("CHANNELNAME");
		HashMap chanInfomap1 = new HashMap();
		chanInfomap1.put("channelname",tempchannelname);
		chanInfomap1.put("channelid",tempchannelid);
		chanInfomap1.put("channelcode",tempchannelcode);
		
		if(channelcode.equals("") && j==0){
			channelcode=tempchannelcode;
		}
		if(channelid.equals("") && j==0){
			channelid=tempchannelid;
		}
		recChanList.add(chanInfomap1);
	}  
	
	recChannelBill = JSONArray.fromObject(recChanList);
    
    ServiceHelp serviceHelpxx = new ServiceHelp(request);
	JSONArray tuijianjsonvodlist = null; //节目列表
	ArrayList tuijianvodlist = (ArrayList)metaData.getVasListByTypeId("10000100000000090000000000039725",2,0);
	ArrayList tuijiantempList = new ArrayList();
	ArrayList tuijianvod_list = new ArrayList();
	if(tuijianvodlist!=null && tuijianvodlist.size() > 1 && ((ArrayList)tuijianvodlist.get(1)).size() > 0)
	{
		tuijianvod_list = (ArrayList)tuijianvodlist.get(1);
	}
	
	for(int i = 0;i<tuijianvod_list.size();i++)
	{
		HashMap obj = (HashMap)tuijianvod_list.get(i);
		HashMap tempmap = new HashMap();
		int tmpvodid=(Integer)obj.get("VASID");
		String tmpvodname = obj.get("VASNAME").toString();
		tempmap.put("VASID",tmpvodid);
		tempmap.put("VASNAME",tmpvodname);
	    String vasurl=serviceHelpxx.getVasUrl(tmpvodid);
		Map mapindex = metaData.getVasDetailInfo(tmpvodid);
		HashMap postersMap = (HashMap)mapindex.get("POSTERPATHS");
		String picpath = (String)mapindex.get("POSTERPATH");
		String postpath =  getPosterPath(postersMap,request,picpath,"1").toString();
		tempmap.put("VARSURL",vasurl);
		tempmap.put("POSTERPATHS",postpath);
		tuijiantempList.add(tempmap);
	}
	tuijianjsonvodlist = JSONArray.fromObject(tuijiantempList);
    
	int len = 0;
	HashMap timeHash = metaData.getChannelInfo(channelcode);
	len = Integer.parseInt(timeHash.get("RECORDLENGTH").toString());
	int timeShiftLength = (int)len / 60;
	if(timeShiftLength < 1)
	timeShiftLength = 1;
	timeShiftLength = (int)timeShiftLength / 60 / 24;
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	SimpleDateFormat formatterChinese = new SimpleDateFormat("yyyy年M月d日");
	Date currDate = new java.util.Date();
	// currDate.setMinutes(timeShiftLength);
	Calendar  cal = Calendar.getInstance();
	cal.add(Calendar.DAY_OF_MONTH, -timeShiftLength);
	//cal.add(Calendar.DAY_OF_MONTH,1);
	Date beforeDate = cal.getTime();
	String time = formatter.format(beforeDate);
	ArrayList channelDateList=new ArrayList();
	while(beforeDate.compareTo(currDate) <= 0 )
	{
		//timeList += formatterChinese.format(beforeDate) + ",";
		HashMap mydate=new HashMap();
		mydate.put("date24",formatter.format(beforeDate));
		mydate.put("dateChinese",formatterChinese.format(beforeDate));
		channelDateList.add(mydate);
		cal.add(Calendar.DAY_OF_MONTH,1);
		beforeDate = cal.getTime();	
	}
	JSONArray jsonDateList = JSONArray.fromObject(channelDateList);
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>央视精品专区-标清-2 - 深圳央视标清EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<script  type="text/javascript">

		window.onload=function(){
			  if(pageobj.curareaindex==0){
				   $("divchannel"+area0.curindex).className="item item_focus";
				   $("divchannelbtn"+area0.curindex).style.display="block";
				  
			  }
			  bindChannelData();
			  bindDateData();
			  bindTvodData();
		 };

      //初始化绑定频道
	  function bindChannelData(){
		   area0.datanum=channellist.length;
		   for(var i=0;i<area0.datanum;i++){
				if(i<channellist.length){
				  $("divchanneltxt"+i).innerHTML=channellist[i].channelname;
				}else{
				  $("divchanneltxt"+i).innerHTML="";
				}
			   
		   }
	  }


	   //初始化绑定日期
	  function bindDateData(){
		   area1.datanum=datelist.length;
		   for(var i=0;i<area1.datanum;i++){
				if(i<datelist.length){
					$("divdatetxt"+i).innerHTML=datelist[i].dateChinese;
				}else{
					 $("divdatetxt"+i).innerHTML="";
					
				}
			}
	  }


      var _in_ajax = window.ActiveXObject ? new ActiveXObject("Microsoft.XMLHTTP") : new XMLHttpRequest();

      var zte_browser = navigator.userAgent.indexOf('ztebw');
     
	 //传入的successMethed有一个字符串参数，处理成功后将服务器返回的信息做参数传入
      function getAJAXData(url, successMethed,param) {
		if (url != undefined && url != null && url != "") {
			var temp = url.split("?"); url = temp[0];
			if (temp.length > 1) { url += "?" + encodeURI(temp[1]); }
		}
		if(zte_browser >=0){
			var _in_ajax_1 = window.ActiveXObject ? new ActiveXObject("Microsoft.XMLHTTP") : new XMLHttpRequest();
			_in_ajax_1.open("POST",  url,  true); 
			_in_ajax_1.onreadystatechange= function() {
			    if (_in_ajax_1.readyState == 4) { if (_in_ajax_1.status == 200) { successMethed(_in_ajax_1.responseText,param);} } 
		    }
		    _in_ajax_1.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		    _in_ajax_1.setRequestHeader("X-Requested-With", "XMLHttpRequest");
		    _in_ajax_1.send(null);
        }else{
			_in_ajax.open("POST", url, false);
			_in_ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
			_in_ajax.setRequestHeader("X-Requested-With", "XMLHttpRequest");
			_in_ajax.send(null);
			 //_in_ajax.onreadystatechange=successMethed;
			 if (_in_ajax.readyState == 4) { if (_in_ajax.status == 200) { successMethed(_in_ajax.responseText,param); } } 
          }
       }

       var channellist=eval('('+'<%=recChannelBill%>'+')');
       
	   var datelist=eval('('+'<%=jsonDateList%>'+')');
      
       var tvodlist=[{tvoddate:'03:40',tvodname:'开门大吉(3)',tvodid:'101'},
                {tvoddate:'03:40',tvodname:'生活就是舞台(精编版)',tvodid:'101'},
				{tvoddate:'03:40',tvodname:'生活就是舞台(精编版)',tvodid:'101'},
                {tvoddate:'03:40',tvodname:'生活就是舞台(精编版)',tvodid:'101'},
				{tvoddate:'03:40',tvodname:'开门大吉(3)',tvodid:'101'},
                {tvoddate:'03:40',tvodname:'生活就是舞台(精编版)',tvodid:'101'},
				{tvoddate:'03:40',tvodname:'生活就是舞台(精编版)',tvodid:'101'},
                {tvoddate:'03:40',tvodname:'生活就是舞台(精编版)',tvodid:'101'},
				{tvoddate:'03:40',tvodname:'开门大吉(3)',tvodid:'101'},
                {tvoddate:'03:40',tvodname:'生活就是舞台(精编版)',tvodid:'101'},
				{tvoddate:'03:40',tvodname:'生活就是舞台(精编版)',tvodid:'101'},
                {tvoddate:'03:40',tvodname:'生活就是舞台(精编版)',tvodid:'101'},
				{tvoddate:'03:40',tvodname:'开门大吉(3)',tvodid:'101'},
                {tvoddate:'03:40',tvodname:'生活就是舞台(精编版)',tvodid:'101'},
				{tvoddate:'03:40',tvodname:'生活就是舞台(精编版)',tvodid:'101'},
                {tvoddate:'03:40',tvodname:'生活就是舞台(精编版)',tvodid:'101'},
				{tvoddate:'03:40',tvodname:'开门大吉(3)',tvodid:'101'},
                {tvoddate:'03:40',tvodname:'生活就是舞台(精编版)',tvodid:'101'}];
   
  
    var  vaslist=[{vasid:'001',vasname:'高粱红',vasurl:''}];
   
   
	var curareaindex=0;
	var curindex=0;
  
    var area0={selectindex:0,curindex:0,stadyindex:0,datanum:4,curpage:1};
    var area1={selectindex:0,curindex:0,stadyindex:0,datanum:8,curpage:1};
    var area2={selectindex:0,curindex:0,stadyindex:0,datanum:18,curpage:1};
    var area3={selectindex:0,curindex:0,stadyindex:0,datanum:1,curpage:1};
    var pageobj=new Object();
    pageobj.curareaindex=curareaindex;
    pageobj.curindex=curindex;
    pageobj.areas=new Array();
    pageobj.areas.push(area0);
    pageobj.areas.push(area1);
    pageobj.areas.push(area2);
    pageobj.areas.push(area3);
  
  pageobj.backurl="";
  pageobj.goback=function(){
	   window.location.href=pageobj.backurl;
  };
  
  pageobj.ok=function(){
	   pageobj.areas[curareaindex].ok();
  };
  
  pageobj.move=function(direction){
	  switch(direction){
		   case 0:{
			   if(pageobj.curareaindex==0){
				  if((pageobj.areas[pageobj.curareaindex].curindex-1)>=0){
					   pageobj.curareaindex=0;
					   pageobj.areas[pageobj.curareaindex].areafocus(-1);
					  
				  }else{
					  pageobj.areas[pageobj.curareaindex].clearfocus();
					  pageobj.curareaindex=3;
					  pageobj.areas[pageobj.curareaindex].curindex=-1;
					  pageobj.areas[pageobj.curareaindex].areafocus(1);
					  
				  }
				   
			   }else  if(pageobj.curareaindex==1){
				   
				    if((pageobj.areas[pageobj.curareaindex].curindex-1)>=0){
					     pageobj.areas[pageobj.curareaindex].areafocus(-1);
				    }else{
						 pageobj.areas[pageobj.curareaindex].clearfocus();
						 pageobj.areas[pageobj.curareaindex].curindex=pageobj.areas[pageobj.curareaindex].datanum-2;
					     pageobj.areas[pageobj.curareaindex].areafocus(1);
					}
				   
			   }else  if(pageobj.curareaindex==2){
				    if((pageobj.areas[pageobj.curareaindex].curindex-1)>=0){
					     pageobj.areas[pageobj.curareaindex].areafocus(-1);
				    }else{
						 pageobj.areas[pageobj.curareaindex].clearfocus();
						 pageobj.areas[pageobj.curareaindex].curindex=pageobj.areas[pageobj.curareaindex].datanum-2;
					     pageobj.areas[pageobj.curareaindex].areafocus(1);
					}
				   
			   }else  if(pageobj.curareaindex==3){
				      pageobj.areas[pageobj.curareaindex].clearfocus();
					  pageobj.curareaindex=0;
					  pageobj.areas[pageobj.curareaindex].curindex=pageobj.areas[pageobj.curareaindex].datanum-2;
					  pageobj.areas[pageobj.curareaindex].areafocus(1);
				   
			   }
			   break;   
		   }
		   case 1:{
			    if(pageobj.curareaindex==1){
					  area0.areain();
					  pageobj.curareaindex=0;
			    }else if(pageobj.curareaindex==2){
				      area2.clearfocus();
					  pageobj.curareaindex=1;
				      area1.curindex=area1.stadyindex;
	                  $("divdate"+area1.curindex).className="item item_focus";
			    }
			    break; 
		   }
		   case 2:{
			    if(pageobj.curareaindex==0){
				  if((pageobj.areas[pageobj.curareaindex].curindex+1)<pageobj.areas[pageobj.curareaindex].datanum){
					   pageobj.curareaindex=0;
					   pageobj.areas[pageobj.curareaindex].areafocus(1);
					  
				  }else{
					  pageobj.areas[pageobj.curareaindex].clearfocus();
					  pageobj.curareaindex=3;
					  pageobj.areas[pageobj.curareaindex].curindex=-1;
					  pageobj.areas[pageobj.curareaindex].areafocus(1);
					  
					  
				  }
				   
			   }else  if(pageobj.curareaindex==1){
				    if((pageobj.areas[pageobj.curareaindex].curindex+1)<pageobj.areas[pageobj.curareaindex].datanum){
					     pageobj.areas[pageobj.curareaindex].areafocus(1);
				    }else{
						 pageobj.areas[pageobj.curareaindex].clearfocus();
						 pageobj.areas[pageobj.curareaindex].curindex=-1;
					     pageobj.areas[pageobj.curareaindex].areafocus(1);
					}
				   
			   }else  if(pageobj.curareaindex==2){
				    if((pageobj.areas[pageobj.curareaindex].curindex+1)<pageobj.areas[pageobj.curareaindex].datanum){
					     pageobj.areas[pageobj.curareaindex].areafocus(1);
				    }else{
						 pageobj.areas[pageobj.curareaindex].clearfocus();
						 pageobj.areas[pageobj.curareaindex].curindex=-1;
					     pageobj.areas[pageobj.curareaindex].areafocus(1);
					}
				   
			   }else  if(pageobj.curareaindex==3){
				      pageobj.areas[pageobj.curareaindex].clearfocus();
					  pageobj.curareaindex=0;
					  pageobj.areas[pageobj.curareaindex].curindex=-1;
					  pageobj.areas[pageobj.curareaindex].areafocus(1);
				}
			   break;   
		   }
		   case 3:{
			    if(pageobj.curareaindex==0){
					 area0.areaout();
					 pageobj.curareaindex=1;
					 area1.areain();
			    }else if(pageobj.curareaindex==1){
				     area1.areaout();
					 pageobj.curareaindex=2;
					 area2.areain();
			    }
			    break; 
			 
		   }
		  
	  }
	  
  };
  
  
  
  area3.ok=function(){
	  //加载视频
	  
	  
  };
  
  area3.areain=function(){
	
  };
  
  area3.areaout=function(){
	
  };
  
  area3.areafocus=function(stepvalue){
	  if(area3.curindex>=0 && area3.curindex<area3.datanum){
	    $("divvas"+area3.curindex).className="item";
	  }
	  area3.curindex=area3.curindex+stepvalue;
	  if(area3.curindex<0){
		  area3.curindex=0;
	  }
	  if(area3.curindex>=area3.datanum){
		  area3.curindex=area3.datanum-1;
	  }
	  pageobj.curindex=area3.curindex;
	  $("divvas"+area3.curindex).className="item item_focus";
  };
  area3.clearfocus=function(){
	 $("divvas"+area3.curindex).className="item";
  };
  
  
  area0.ok=function(){
	  //加载视频
	  
	  
  };
  
  area0.areain=function(){
	  $("divchannellist").style.display="none";
	  $("divtvodlist").style.display="none";
	  $("divchannel"+area0.stadyindex).className="item item_focus";
	  $("divchannelbtn"+area0.stadyindex).style.display="block";
	  pageobj.curareaindex=0;
  };
  
  area0.areaout=function(){
	  $("divchannellist").style.display="block";
	  $("divtvodlist").style.display="block";
	  area0.stadyindex=area0.curindex;
	  $("divchannel"+area0.curindex).className="item item_select";
	  $("divchannelbtn"+area0.curindex).style.display="none";
  };
  
  area0.areafocus=function(stepvalue){
	  if(area0.curindex>=0 && area0.curindex<area0.datanum){
	    $("divchannel"+area0.curindex).className="item";
		$("divchannelbtn"+area0.curindex).style.display="none";
	  }
	  area0.curindex=area0.curindex+stepvalue;
	  if(area0.curindex<0){
		  area0.curindex=0;
	  }
	  if(area0.curindex>=area0.datanum){
		  area0.curindex=area0.datanum-1;
	  }
	  pageobj.curindex=area0.curindex;
	  $("divchannel"+area0.curindex).className="item item_focus";
	  $("divchannelbtn"+area0.curindex).style.display="block";
  };
  area0.clearfocus=function(){
	 $("divchannel"+area0.curindex).className="item";
	 $("divchannelbtn"+area0.curindex).style.display="none";
  };
  
  
  
  area1.ok=function(){
	  
	  
	  
  };
  
  area1.areain=function(){
	   area1.clearfocus();
	   area1.curindex=-1;
	   area1.areafocus(1)
	   pageobj.curareaindex=1;
  };
  
  area1.areaout=function(){
	  area1.stadyindex=area1.curindex;
	  $("divdate"+area1.curindex).className="item item_select";
  };
  
  area1.areafocus=function(stepvalue){
	  if(area1.curindex>=0 && area1.curindex<area1.datanum){
	    $("divdate"+area1.curindex).className="item";
	  }
	  area1.curindex=area1.curindex+stepvalue;
	  if(area1.curindex<0){
		  area1.curindex=0;
	  }
	  if(area1.curindex>=area1.datanum){
		  area1.curindex=area1.datanum-1;
	  }
	  pageobj.curindex=area1.curindex;
	  $("divdate"+area1.curindex).className="item item_focus";
   };
  
  
  
   area1.clearfocus=function(){
	 $("divdate"+area1.curindex).className="item";
   };
  
  
  area2.ok=function(){
	  
	  
	  
  };
  
  area2.areain=function(){
	   area2.clearfocus();
	   area2.curindex=-1;
	   area2.areafocus(1)
	   pageobj.curareaindex=2;
  };
  
  area2.areaout=function(){
	  
	  
	  
  };
  
  area2.areafocus=function(stepvalue){
	  
	  if(area2.curindex>=0 && area2.curindex<area2.datanum){
	    $("divtvod"+area2.curindex).style.background="url()";
	  }
	  area2.curindex=area2.curindex+stepvalue;
	  if(area2.curindex<0){
		  area2.curindex=0;
	  }
	  if(area2.curindex>=area2.datanum){
		  area2.curindex=area2.datanum-1;
	  }
	  pageobj.curindex=area2.curindex;
	  $("divtvod"+area2.curindex).style.background="url(../images/list-b_focus.png) no-repeat";
	  
  };
  
   area2.clearfocus=function(){
	 $("divtvod"+area2.curindex).style.background="url()";
   };
  
 
  
  
  
  //返回dom对象
  function $(elementid){
	  return document.getElementById(elementid);  
  }
  
  
 
  //初始化绑定回看列表
  function bindTvodData(){
	   for(var i=0;i<area2.datanum;i++){
		    if(i<tvodlist.length){
		         $("divtvoddate"+i).innerHTML=tvodlist[i].tvoddate;
			     $("divtvodtxt"+i).innerHTML=tvodlist[i].tvodname;
			}else{
				  $("divtvoddate"+i).innerHTML="";
			      $("divtvodtxt"+i).innerHTML="";
			}
	  }
  }

 



	  // JScript 文件
	var	KEY_TV_IPTV=1290;
	var	KEY_POWEROFF=1291;
	var	KEY_SUBTITLE=1292;
	var	KEY_BOOKMARK =1293;
	var	KEY_PIP=1294;
	var KEY_LOCAL=1295;
	var KEY_REFRESH=1296;
	var KEY_SETUP=282;
	var KEY_HOME=292;
	var KEY_BACK = 8;
	var KEY_DELETE  = 280;
	var KEY_ENTER=13;
	var KEY_OK =13;
	var KEY_HELP = 284;
	var KEY_LEFT=37;
	var KEY_UP=38;
	var KEY_RIGHT=39;
	var KEY_DOWN=40;
	var KEY_PAGEUP = 33;
	var KEY_PAGEDOWN = 34;
	var KEY_0 = 48;
	var KEY_1 = 49;
	var KEY_2 = 50;
	var KEY_3 = 51;
	var KEY_4 = 52;
	var KEY_5 = 53;
	var KEY_6 = 54;
	var KEY_7 = 55;
	var KEY_8 = 56;
	var KEY_9 = 57;
	var KEY_CHANNELUP = 257;
	var KEY_CHANNELDOWN = 258;
	var KEY_VOLUP = 259;
	var KEY_VOLDOWN =260;
	var KEY_MUTE =261;
	var KEY_PLAY=263;
	var KEY_PAUSE=263;
	var KEY_SEEK=271;
	var KEY_SWITCH = 280;
	var KEY_FAVORITE = 281;
	var KEY_AUDIOCHANNEL=286;
	var KEY_IME= 283;
	var KEY_FASTFORWARD=264;
	var KEY_FASTREWIND=265;
	var KEY_SEEKEND=266;
	var KEY_SEEKBEGIN=267;
	var KEY_STOP=270;
	var KEY_MENU=290;
	//var KEY_RED = 275;
	//var KEY_GREEN = 276;
	//var KEY_YELLOW = 277;
	var KEY_RED = 1108;
	var KEY_GREEN = 1110;
	var KEY_YELLOW = 1109;
	var KEY_BLUE =278 ;
	var KEY_STAR=106;
	var KEY_SHARP=105;
	var KEY_F1 = 291;
	var KEY_F2 = 292;
	var KEY_F3 = 293;
	var KEY_F4 = 294;
	var KEY_F5 = 295;
	var KEY_F6 = 296;
	
	//事件 规范是0x300
	var KEY_EVENT= 768;
	
	//document.onirkeypress = keyEvent;
	//document.onkeypress = keyEvent;
	document.onkeydown = keyEvent;
	function keyEvent()
	{
		var val = event.which ? event.which : event.keyCode;
		return keypress(val);
	}
	function keypress(keyval)
	{
		switch(keyval)
		{
		
			case 87: //up
			case KEY_UP:			
				pageobj.move(0);
				break;
			case 65: //left
			case KEY_LEFT: 
				pageobj.move(1);
				break;
			case 83: //down
			case KEY_DOWN:
				pageobj.move(2);
				break;
			case 68: //right
			case KEY_RIGHT: //right
				pageobj.move(3);
				break;
			case 13:
			case KEY_OK: //enter
				pageobj.ok();
				break;
			case 32:    // 空格
			case KEY_BACK:
				pageobj.goBack();
				break;
		    default:return 0;
		}
		return 0;
	}


</script>


</head>

<body bgcolor="transparent">

<!--pagebg-->
<div class="pagebg">
	<div class="pic"><img src="../images/demopic/bg.jpg" width="640" height="530" /></div>
</div>
<!--pagebg the end-->



<div class="wrapper">
	<!--left-->	
	<div class="hd-left">
		<div class="logo"><img src="../images/logo-3.png" /></div>
		<div class="nav">
			<!--焦点 
					class="item item_focus"
				选中 
					class="item item_select"
			-->
			<div id="divchannel0" class="item item_select" style="top:3px;">
				<div class="txt" id="divchanneltxt0"></div>
			</div>
            <div class="btn" id="divchannelbtn0" style="top:3px;display:none">回看</div>

			<div  id="divchannel1" class="item" style="top:33px;">
				<div class="txt" id="divchanneltxt1"></div>
			</div>
            <div class="btn" id="divchannelbtn1" style="top:33px;display:none">回看</div>
			<div id="divchannel2" class="item" style="top:63px;">
				<div class="txt" id="divchanneltxt2"></div>
			</div>
            <div class="btn" id="divchannelbtn2" style="top:63px;display:none">回看</div>
			<div id="divchannel3" class="item" style="top:93px;">
				<div class="txt" id="divchanneltxt3"></div>
			</div>
            <div class="btn" id="divchannelbtn3" style="top:93px;display:none">回看</div>
		</div>
		
		<div class="poster">
			<!--焦点 
					class="item item_focus"
				-->
			<div class="item" id="divvas0">
				<div class="pic"><img id="divvasimg0" src="../images/demopic/pic-153X100.jpg" /></div>
			</div>
		</div>
	</div>	
	<!--left the end-->		
	
	
	
	<!--mid the end-->	
	<div class="hd-mid" id="divchannellist" style="display:none">
		<div class="nav-b">
			<!--焦点 
					class="item item_focus"
				选中 
					class="item item_select"
			-->
			<div id="divdate0" class="item" style="top:3px;">
				<div id="divdatetxt0" class="txt"></div>
			</div>
			<div id="divdate1" class="item" style="top:33px;">
				<div id="divdatetxt1" class="txt"></div>
			</div>
			<div id="divdate2" class="item" style="top:63px;">
				<div id="divdatetxt2" class="txt"></div>
			</div>
			<div id="divdate3" class="item" style="top:93px;">
				<div id="divdatetxt3" class="txt"></div>
			</div>
			<div id="divdate4" class="item" style="top:123px;">
				<div id="divdatetxt4" class="txt"></div>
			</div>
			<div id="divdate5" class="item" style="top:153px;">
				<div id="divdatetxt5" class="txt"></div>
			</div>
			<div id="divdate6" class="item" style="top:183px;">
				<div id="divdatetxt6" class="txt"></div>
			</div>
			<div id="divdate7" class="item" style="top:213px;">
				<div id="divdatetxt7" class="txt"></div>
			</div>
		</div>
	</div>
	<!--mid the end-->
	
	
	
	<!--list-->
	<div class="list-warp" id="divtvodlist" style="display:none">
		<div class="btn btn-up">
			<!--焦点 
					class="item item_focus"
			-->
			<div class="item"></div>
		</div>
		
		<div class="list-b">
			<!--焦点 
					class="item item_focus"
				已看 
					class="item item_see"
			-->
			<div class="item item_see" id="divtvod0">
				<div class="txt txt-time" id="divtvoddate0"></div>
				<div class="txt" id="divtvodtxt0"></div>
			</div>
			<div class="item item_see" style="top:25px;"  id="divtvod1">
				<div class="txt txt-time" id="divtvoddate1"></div>
				<div class="txt" id="divtvodtxt1"></div>
			</div>
			<div class="item item_see" style="top:50px;" id="divtvod2">
				<div class="txt txt-time" id="divtvoddate2"></div>
				<div class="txt" id="divtvodtxt2"></div>
			</div>
			<div class="item item_see" style="top:75px;" id="divtvod3">
				<div class="txt txt-time" id="divtvoddate3"></div>
				<div class="txt" id="divtvodtxt3"></div>
			</div>
			<div class="item item_see" style="top:100px;" id="divtvod4">
				<div class="txt txt-time" id="divtvoddate4"></div>
				<div class="txt" id="divtvodtxt4"></div>
			</div>
			<div class="item item_see" style="top:125px;" id="divtvod5">
				<div class="txt txt-time" id="divtvoddate5"></div>
				<div class="txt" id="divtvodtxt5"></div>
			</div>
			<div class="item" style="top:150px;" id="divtvod6">
				<div class="txt txt-time" id="divtvoddate6"></div>
				<div class="txt" id="divtvodtxt6"></div>
			</div>
			<div class="item" style="top:175px;" id="divtvod7">
				<div class="txt txt-time" id="divtvoddate7"></div>
				<div class="txt" id="divtvodtxt7"></div>
			</div>
			<div class="item" style="top:200px;" id="divtvod8">
				<div class="txt txt-time" id="divtvoddate8"></div>
				<div class="txt" id="divtvodtxt8"></div>
			</div>
			<div class="item" style="top:225px;" id="divtvod9">
				<div class="txt txt-time" id="divtvoddate9"></div>
				<div class="txt" id="divtvodtxt9"></div>
			</div>
			<div class="item" style="top:250px;" id="divtvod10">
				<div class="txt txt-time" id="divtvoddate10"></div>
				<div class="txt" id="divtvodtxt10"></div>
			</div>
			<div class="item" style="top:275px;" id="divtvod11">
				<div class="txt txt-time" id="divtvoddate11"></div>
				<div class="txt" id="divtvodtxt11"></div>
			</div>
			<div class="item" style="top:300px;" id="divtvod12">
				<div class="txt txt-time" id="divtvoddate12"></div>
				<div class="txt" id="divtvodtxt12"> </div>
			</div>
			<div class="item" style="top:325px;" id="divtvod13">
				<div class="txt txt-time" id="divtvoddate13"></div>
				<div class="txt" id="divtvodtxt13"> </div>
			</div>
			<div class="item" style="top:350px;" id="divtvod14">
				<div class="txt txt-time" id="divtvoddate14"></div>
				<div class="txt" id="divtvodtxt14"></div>
			</div>
			<div class="item" style="top:375px;" id="divtvod15">
				<div class="txt txt-time" id="divtvoddate15"></div>
				<div class="txt" id="divtvodtxt15"></div>
			</div>
			<div class="item" style="top:400px;" id="divtvod16">
				<div class="txt txt-time" id="divtvoddate16"></div>
				<div class="txt" id="divtvodtxt16"></div>
			</div>
			<div class="item" style="top:425px;" id="divtvod17">
				<div class="txt txt-time" id="divtvoddate17"></div>
				<div class="txt" id="divtvodtxt17"></div>
			</div>
		</div>
		
		<div class="btn btn-down">
			<!--焦点 
					class="item item_focus"
			-->
			<div class="item item_focus"></div>
		</div>
		
	</div>	
	<!--list the end-->	
	
</div>

</body>
</html>
