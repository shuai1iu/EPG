<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="newsdata.jsp"%>
<%@ include file="codepage.jsp"%>
<%@ include file="OneKeyPlay.jsp"%>
<%@ include file="OneKeySwitch.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>成都台EPG页面2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<style>
<!--
body { background: #000 url("images/bg/news_bg.jpg") no-repeat}
.returnon{ position:absolute; top:501px; left:552px; z-index:10}
-->
</style>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript" src="js/cookie.js"></script>
    <script type="text/javascript">
	var tuijian1;
	var tuijian2;
	var tuijian3;
	<%
       String returnurl=request.getParameter("returnurl");
	   TurnPage turnPage = new TurnPage(request);
	   turnPage.addUrl();
    %>
	  document.onkeydown = keyDown;
      document.onkeypress = keyDown;
//按键执行
function keyDown() {
    var key_code = event.keyCode;
    switch (key_code) {
		case <%=KEY_0%>://0x0030;
		case <%=KEY_1%>://0x0031;
		case <%=KEY_2%>://0x0032;
		case <%=KEY_3%>://0x0033;
		case <%=KEY_4%>://0x0034;
		case <%=KEY_5%>://0x0035;
		case <%=KEY_6%>://0x0036;
		case <%=KEY_7%>://0x0037;
		case <%=KEY_8%>://0x0038;
		case <%=KEY_9%>://0x0039;
			funcInputNum(key_code-48);
			break;
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
            window.location.href='<%=returnurl%>';
            break;
		default:
			videoControl(key_code);
			break;
    }
    return 0;
}

    var pageobj;
	var area2;
	var area4;
	var news1;
	var news2;
    function initPage()
	{
		var mycookie=getCookie("news");
		
		var doms0=new Array();
		var doms1=new Array();
		var doms2=new Array();
		var doms3=new Array();
		var doms4=new Array();
		var doms5=new Array();
		var doms6=new Array();
		for(i=0;i<5;i++)
            doms0[i]=new DomData("area0_list_"+i,"className:bgon","className:bg");
        doms1[0]=new DomData("area1","className:pic_pop npic1","className:pic_pop");
		for(i=0;i<4;i++)
            doms2[i]=new DomData("area2_list_"+i,"className:on","className:off");
		for(i=0;i<5;i++)
            doms3[i]=new DomData("area3_list_"+i,"className:bgon","className:bg");
		for(i=0;i<5;i++)
            doms4[i]=new DomData("area4_list_"+i,"className:on","className:off");
		for(i=0;i<2;i++)
            doms5[i]=new DomData("area5_list_"+i,"className:pic_pop npic2","className:pic_pop");
		doms6[0]=new DomData("area6_img","src:images/returnon.png","src:images/return.png");
		doms6[0].mylink="indexpkit.jsp";
		var area0=new Area(1,5,doms0,new Array(-1,-1,2,-1));
		area0.stayindexdir='2';
		var area1=new Area(1,1,doms1,new Array(0,-1,3,2));
		area2=new Area(4,1,doms2,new Array(0,1,3,-1));
		area2.stayindexdir='1';
		var area3=new Area(1,5,doms3,new Array(2,-1,4,-1));
		area3.stayindexdir='2';
		area3.stablemoveindex=new Array("0-3,1-3,2-3,3-3,4-3",-1,-1,-1);
		area4=new Area(5,1,doms4,new Array(3,-1,6,5));
		area4.stayindexdir='3';
		var area5=new Area(1,2,doms5,new Array(3,4,6,-1));
		area5.stayindexdir='2';
		var area6=new Area(1,1,doms6,new Array(5,-1,-1,-1));
		
		var shizheng=eval('('+'<%=jsonshizhengxinwen%>'+')');
		var shehui=eval('('+'<%=jsonshehuixinwen%>'+')');
		doms1[0].mylink="newslist.jsp?code="+ (!!shizheng[5]?shizheng[5].TYPE_ID:"")+"&returnurl="+escape(window.location.href);
		doms5[0].mylink="newslist.jsp?code="+(!!shehui[5]?shehui[5].TYPE_ID:"")+"&returnurl="+escape(window.location.href);
		doms5[1].mylink="newslist.jsp?code="+ (!!shehui[6]?shehui[6].TYPE_ID:"")+"&returnurl="+escape(window.location.href);
		//填充数据
		//2011-07-06 12:43:45
		$("area1_img").src = "../"+eval('('+'<%=jsonshizhengxinwen%>'+')')[5].TYPE_PICPATH;
		$("area5_img_0").src = "../"+eval('('+'<%=jsonshehuixinwen%>'+')')[5].TYPE_PICPATH;
		$("area5_img_1").src = "../"+eval('('+'<%=jsonshehuixinwen%>'+')')[6].TYPE_PICPATH;
		
		area0.dataarea=area2;
		area3.dataarea=area4;
		for(i=0;i<5;i++)
		{
		    doms0[i].dataurlorparam="newsasyndata1.jsp?code="+eval('('+'<%=jsonshizhengxinwen%>'+')')[i].TYPE_ID;
			doms0[i].mylink="newslist.jsp?code="+eval('('+'<%=jsonshizhengxinwen%>'+')')[i].TYPE_ID+"&returnurl="+escape(window.location.href);
			doms3[i].dataurlorparam="newsasyndata2.jsp?code="+eval('('+'<%=jsonshehuixinwen%>'+')')[i].TYPE_ID;
			doms3[i].mylink="newslist.jsp?code="+eval('('+'<%=jsonshehuixinwen%>'+')')[i].TYPE_ID+"&returnurl="+escape(window.location.href);
		}
		area2.asyngetdata=function(dataurl)
		{
			area2.lockin=true;
			$('hidden_frame').src=dataurl;
		}
		area4.asyngetdata=function(dataurl)
		{
			area4.lockin=true;
			$('hidden_frame').src=dataurl;
		}
		
		if(!!mycookie[0]&&parseInt(mycookie[0])!=0)
		   getdata1(news1);
		if(parseInt(mycookie[0])!=3)
		   getdata2(news2);
		pageobj=new PageObj(!!mycookie[0]?parseInt(mycookie[0]):0,!!mycookie[1]?parseInt(mycookie[1]):0,new Array(area0,area1,area2,area3,area4,area5,area6));
		 pageobj.pageOkEvent=function()
	    {
			if(this.getfocusdom().mylink!=undefined)
		     saveCookie("news",this.curareaid,this.getfocusindex());
	    }
	}
	function getdata1(data)
	{
		area2.datanum=data.length;
		for(i=0;i<area2.doms.length;i++)
			{
				if(i<data.length)
			   {
				  
				   area2.doms[i].setcontent("·",data[i].VODNAME,34);
			       area2.doms[i].mylink="au_PlayFilm.jsp?PROGID="+data[i].VODID+"&pk_playtype=0&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&returnurl="+escape(location.href);
			   }
			   else
				area2.doms[i].updatecontent("");
			    
			}
		area2.lockin=false;
	}
	function getdata2(data)
	{
		area4.datanum=data.length;
		for(i=0;i<area4.doms.length;i++)
			{
				if(i<data.length)
			   {
				   
				   area4.doms[i].setcontent("·",data[i].VODNAME,25);
				   area4.doms[i].mylink="au_PlayFilm.jsp?PROGID="+data[i].VODID+"&pk_playtype=0&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&returnurl="+escape(location.href);
			   }
			   else
				area4.doms[i].updatecontent("");
			    
			}
		area4.lockin=false;
	}
	</script>
</head>

<body onLoad="initPage();">
<!--menu1-->
<div class="news_menu">
	<div class="on">时政新闻</div>
<div style="left:106px" class="bg" id="area0_list_0">今日头条</div>
<div style="left:202px" class="bg" id="area0_list_1">国际</div>
	<div style="left:268px" class="bg" id="area0_list_2">国内</div>
	<div style="left:333px" class="bg" id="area0_list_3">四川</div>
	<div style="left:399px" class="bg" id="area0_list_4">成都</div> 	      
</div>


<!--content-->
<div class="news_pic1">
	<img src="images/temp/5-1.jpg" id="area1_img" width="205px" height="138px" />
	<div class="pic_pop" id="area1"></div> <!--npic1-->
</div>
<div class="news_list">
	<div id="area2_list_0"></div>
	<div id="area2_list_1"></div>
	<div id="area2_list_2"></div>
	<div id="area2_list_3"></div>
</div>


<!--menu2-->
<div class="news_menu" style="top:288px">
	<div class="on">社会新闻</div>
  <div id="area3_list_0" style="left:98px" class="bg">社会热点</div>
<div id="area3_list_1" style="left:202px" class="bg">民生</div>
	<div id="area3_list_2" style="left:268px" class="bg">法治</div>
	<div id="area3_list_3" style="left:333px" class="bg">趣闻</div>
	<div id="area3_list_4" style="left:399px" class="bg">社会</div> 	      
</div>



<!--content-->
<div class="news_list2">
	<div id="area4_list_0"></div>
	<div id="area4_list_1"></div>
	<div id="area4_list_2"></div>
	<div id="area4_list_3"></div>
	<div id="area4_list_4"></div>
</div>
<div class="news_pic2">
	<img id="area5_img_0" src="images/temp/5-2.jpg" width="134" height="177" />
	<div class="pic_pop" id="area5_list_0"></div> <!--npic2-->
</div>
<div class="news_pic2" style="left:483px">
	<img id="area5_img_1" src="images/temp/5-3.jpg" width="134" height="177" />
	<div class="pic_pop" id="area5_list_1"></div> <!--npic2-->
</div>
<div class="returnon" id="xx" style="top:505px"><img id="area6_img" src="images/return.png" /></div><!--显示或隐藏-->
<iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>
</body>
</html>
