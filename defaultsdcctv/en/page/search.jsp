<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="page-view-size" content="640*530" />
<title></title>
  <link rel="stylesheet" type="text/css" href="../css/style.css" />
 <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
    <meta name="page-view-size" content="640*530"/>
    <title>搜索页面 | CCTV-IP电视</title>
    <link rel="stylesheet" type="text/css" href="../../css/style.css" />
    <style type="text/css">
        body {
            background: #0d4764 url("../images/body-page-search.jpg") no-repeat;
        }
        .searchTitle {
            height: 24px;
            width: 310px;
            position: absolute;
            left: 30px;
            top: 93px;
        }
       .searchInput {
            background: url("../images/bg-search-input.jpg") no-repeat;
			color:#000;
            height: 41px;
			line-height:40px;
            width: 288px;
            position: absolute;
            left: 30px;
            top: 124px;
        }
        .searchBtnLine {}
        .searchBtnLine .btn-searchOri {
            background: url("../images/btn-search-ori.png") no-repeat;
            position: absolute;
            left: 182px;
            top: 175px;
        }
        .searchBtnLine .btn-searchOri,
        .searchBtnLine .btn-searchOri .link,
        .searchBtnLine .btn-searchOri .link img {
            height: 37px;
            width: 136px;
        }
        .searchBtnLine .btn-searchOri .txt {
            height: 24px;
            width: 100px;
            left: 30px;
            top: 7px;
        }

        .searchBtnLine .btn-searchG {
            background: url("../images/btn-search-g.png") no-repeat;
            position: absolute;
            left: 182px;
            top: 175px;
        }
        .searchBtnLine .btn-searchG,
        .searchBtnLine .btn-searchG .link,
        .searchBtnLine .btn-searchG .link img {
            height: 37px;
            width: 136px;
        }
        .searchBtnLine .btn-searchG .txt {
            height: 24px;
            width: 100px;
            left: 30px;
            top: 7px;
        }

        .searchKey {}
        .searchKey .item,
        .searchKey .item .link,
        .searchKey .item .link img,
        .searchKey .item .txt {
            height: 37px;
            width: 26px;
        }
        .searchKey .item {
            background: url("../images/btn-w-26x37-1.png") no-repeat;
        }
        .searchKey .item .txt {
            color: #04334f;
            height: 24px;
            text-align: center;
            top: 9px;
        }

        .searchKey .item-del,
        .searchKey .item-del .link,
        .searchKey .item-del .link img,
        .searchKey .item-del .txt {
            height: 82px;
            width: 61px;
        }
        .searchKey .item-del {
            background: url("../images/btn-w-61x82-1.png") no-repeat;
        }
        .searchKey .item-del .txt {
            color: #04334f;
            height: 34px;
            text-align: center;
            top: 30px;
        }

        .searchResult {}
        .searchResult .hd {
            color: #a0a1a4;
            position: absolute;
            left: 372px;
            top: 94px;
        }
        .searchResult .hd span {
            color: #7cc9e6;
        }
        .searchResult .bd {}

        .searchResult .bd .item,
        .searchResult .bd .item .link,
        .searchResult .bd .item .link img {
            height: 33px;
            width: 276px;
        }
        .searchResult .bd .item {
            left: 363px;
        }
        .searchResult .bd .item .txt {
            height: 24px;
            width: 256px;
            left: 10px;
            top: 8px;
        }
        .searchResult .ft .mod-paging-b {
            height: 24px;
            width: 160px;
            position: absolute;
            left: 372px;
            top: 452px;
        }

    </style>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">


var area0;
var area1;
var area2; 
var area3;
var area4;
var area5;

//programlist
var area6;

var _pageCount = 0;

var _totalRecord = 0;

var words = '<%=request.getParameter("words")%>';

var curIndex =  '<%=request.getParameter("curindex")%>';

var searchType ='<%=request.getParameter("searchType")%>';

var programList = new Array();
window.onload = function()
{
	initPage();
}

function loadProgram(result)
{
	
	 var re;
	 if (result.substring(0, 1) != '{')
	 return;
	 re = eval('(' + result + ')');
	 var data = re.data;
	 for(var i = 0 ; i < data.length ; i ++)
	 {
		 programList.push(data[i]);
	 }
	 var pageCount = re.pageCount;
	 var totalRecord = re.totalRecord;
	 if(totalRecord == null || totalRecord == undefined || totalRecord == "undefined" || totalRecord == "null")
	 {
	 	totalRecord = "0";
		
	 }
	$("searchResult").innerHTML = "搜索结果"+"<span>("+totalRecord+")</span>";
	
	_pageCount = pageCount;
	_totalRecord = totalRecord;
	pager(pageCount);
	
}

function pager(pageCount)
{

	if(programList == null)
		return ;
	var list=new Array();
	var start = (area6.curpage-1)*10;
	var size = _totalRecord-start;
	for(var i = 0; i <size; i++)
	{
		list[i]=programList[start+i];
	}
	setValue(list,pageCount);
	
}

function clearProgramList()
{
	for(var i = 0 ; i < area6.doms.length; i ++)
	{
		area6.doms[i].updatecontent("");
	}
	$("pager").innerHTML = "";
	$("searchResult").innerHTML = "";
}


function setValue(data,pageCount)
{
	area6.setpageturndata(data.length, pageCount);
	area6.datanum = data.length;
	for(var i = 0 ; i < area6.doms.length; i ++)
	{
		if( i < data.length)
		{
			area6.doms[i].setcontent("",data[i].vodName,25,true,false);
		
			area6.doms[i].url = "vod-tv-detail.jsp?vodid="+data[i].vodId ;
			
		}
		else
		{
			area6.doms[i].updatecontent("");
		}
	}
	if(pageCount != null && pageCount  != undefined && pageCount != 0)
	{
		$("pager").innerHTML = "<span class='current'>"+area6.curpage +"</span>/"+pageCount;
	}
	if(data.length != 0)
	{
		
	}
}

function initPage()
{
	area0=AreaCreator(1,1,new Array(-1,-1,2,6),"btnsearch_programname","className:btn-searchOri onboder","className:btn-searchOri offboder");
	
	area0.areaOkEvent = function()
	{

		searchType = "programname";
		clearProgramList();
                if($("words").innerHTML=="AFGHIJ1")
                {
                        window.location.href = "sim_index.jsp?returnurl="+returnurl;
                }
		var url = "datajsp/search-result-data.jsp?words=" +$("words").innerHTML;
		url +="&searchType=programname";
	
		getAJAXData(url, loadProgram);
	}
	
	area1=AreaCreator(1,1,new Array(-1,0,2,6),"btnsearch_personname","className:btn-searchG onboder","className:btn-searchG offboder");
	
	area1.areaOkEvent = function()
	{
		searchType = "personname";
		clearProgramList();
		var url = "datajsp/search-result-data.jsp?words=" +$("words").innerHTML;
		url +="&searchType=personname";
		
		getAJAXData(url, loadProgram);
	}
	
	area2=AreaCreator(5,5,new Array(0,-1,-1,3),"area1_a","className:item onboder","className:item offboder");
	area2.areaOkEvent=function()
	{
        
         if($("words").innerHTML.length <22)
		{
		   	$("words").innerHTML += $("area1_letter"+this.curindex).innerHTML;
		}
    }
    area3=AreaCreator(3,3,new Array(0,2,4,6),"area2_a","className:item onboder","className:item offboder");
	area3.areaOkEvent = function()
	{
		if($("words").innerHTML.length <22)
		{
		   	$("words").innerHTML+= $("area2_number"+this.curindex).innerHTML;
		}
	}
	area4=AreaCreator(2,1,new Array(3,2,-1,5),"area3_a","className:item onboder","className:item offboder");
	area4.areaOkEvent = function()
	{
		if($("words").innerHTML.length <22)
		{
		   $("words").innerHTML+= $("area3_number"+this.curindex).innerHTML;
		}
	}
	area5=AreaCreator(1,1,new Array(3,4,-1,6),"btndelete_a","className:item item-del onboder","className:item item-del offboder");
	area5.areaOkEvent = function()
	{
		if($("words").innerHTML!=""){
		  $("words").innerHTML= $("words").innerHTML.substr(0,$("words").innerHTML.length-1);
		}
	        else{
			//location.href = "../../../defaultsdzhuanti/ozb2012/ozb/url.html";
		}
	}
	area6=AreaCreator(10,1,new Array(-1,3,-1,-1),"p_a","className:item onboder","className:item offboder");
	area6.setfocuscircle(0);
	area6.datanum = 0;
	area6.setcrossturnpage();
	for(var i = 0 ; i < area6.doms.length ; i ++)
	{
		area6.doms[i].contentdom = $("p_name"+i);
	}
	area6.asyngetdata=function()
	{
		pager(_pageCount);
	}
	
	area6.areaOkEvent=function()
	{
		var returnurl = escape("search.jsp?words="+$("words").innerHTML+"&searchType="+searchType+"&curindex="+this.curindex);
		var url = area6.doms[this.curindex].url +"&returnurl="+returnurl;
		window.location.href = url;
		
	}
	
  
 

   if(words != null && words != "null")
   		$("words").innerHTML = words;
	
   if(searchType == "programname")
   {
	 
		area0.areaOkEvent();
   }
   if(searchType == "personname")
		area1.areaOkEvent();
	pageobj = new PageObj(2, 0, new Array(area0, area1, area2,area3,area4,area5,area6));
    pageobj.backurl = "index.jsp";
	if(curIndex != null && curIndex != "null" && curIndex != "")
	{
	
		if(_totalRecord != 0)
			pageobj.changefocus(6,parseInt(curIndex));
		
	}
   
}


</script>
</head>

<body>
<div class="wrapper">

    <!-- S 面包屑 -->
    <div class="mod-bread">搜索</div>
    <!-- E 面包屑 -->

    <div class="searchTitle">请输入关键字的首字母进行查找</div>
    <div class="searchInput" id="words"></div>

    <!-- S 按钮部分 -->
    <div class="searchBtnLine">
        <div class="btn-searchOri" id="btnsearch_programname0">
            <div class="link " ><img src="../images/t.gif" /></div>
            <div class="txt">按节目搜索</div>
        </div>
        <div class="btn-searchG" id="btnsearch_personname0" style="display:none;">
            <div class="link" id="btnsearch1"><img src="../images/t.gif" /></div>
            <div class="txt">按人名搜索</div>
        </div>
    </div>
    <!-- E 按钮部分 -->

    <!-- S 键盘 -->
    <div class="searchKey">

        <!-- S 字母区 -->
        <div class="item" style="left:31px; top:232px;" id="area1_a0">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter0">A</div>
        </div>
        <div class="item" style="left:67px; top:232px;" id="area1_a1">
            <div class="link"  ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter1">B</div>
        </div>
        <div class="item" style="left:103px; top:232px;" id="area1_a2">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter2">C</div>
        </div>
        <div class="item" style="left:139px; top:232px;" id="area1_a3">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter3">D</div>
        </div>
        <div class="item" style="left:175px; top:232px;" id="area1_a4">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter4">E</div>
        </div>
        <div class="item" style="left:31px; top:277px;" id="area1_a5">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter5">F</div>
        </div>
        <div class="item" style="left:67px; top:277px;" id="area1_a6">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter6">G</div>
        </div>
        <div class="item" style="left:103px; top:277px;" id="area1_a7">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter7">H</div>
        </div>
        <div class="item" style="left:139px; top:277px;" id="area1_a8">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter8">I</div>
        </div>
        <div class="item" style="left:175px; top:277px;" id="area1_a9">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter9">J</div>
        </div>
        <div class="item" style="left:31px; top:322px;" id="area1_a10">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter10">K</div>
        </div>
        <div class="item" style="left:67px; top:322px;" id="area1_a11">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter11">L</div>
        </div>
        <div class="item" style="left:103px; top:322px;" id="area1_a12">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter12">M</div>
        </div>
        <div class="item" style="left:139px; top:322px;" id="area1_a13">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter13">N</div>
        </div>
        <div class="item" style="left:175px; top:322px;" id="area1_a14">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter14">O</div>
        </div>
        <div class="item" style="left:31px; top:367px;" id="area1_a15">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter15">P</div>
        </div>
        <div class="item" style="left:67px; top:367px;" id="area1_a16">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter16">Q</div>
        </div>
        <div class="item" style="left:103px; top:367px;" id="area1_a17">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter17">R</div>
        </div>
        <div class="item" style="left:139px; top:367px;" id="area1_a18">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter18">S</div>
        </div>
        <div class="item" style="left:175px; top:367px;" id="area1_a19">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter19">T</div>
        </div>
        <div class="item" style="left:31px; top:412px;" id="area1_a20">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter20">U</div>
        </div>
        <div class="item" style="left:67px; top:412px;" id="area1_a21">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter21">V</div>
        </div>
        <div class="item" style="left:103px; top:412px;" id="area1_a22">
            <div class="link" ><img2 src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter22">W</div>
        </div>
        <div class="item" style="left:139px; top:412px;" id="area1_a23">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter23">X</div>
        </div>
        <div class="item" style="left:175px; top:412px;" id="area1_a24">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_letter24">Y</div>
        </div>

        <div class="item" style="left:221px; top:412px;" id="area3_a1">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area3_number1">Z</div>
        </div>
        <!-- E 字母区 -->

        <!-- S 数字区 -->
        <div class="item" style="left:221px; top:232px;" id="area2_a0">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area2_number0">1</div>
        </div>
        <div class="item" style="left:257px; top:232px;" id="area2_a1">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area2_number1">2</div>
        </div>
        <div class="item" style="left:293px; top:232px;" id="area2_a2">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area2_number2">3</div>
        </div>

        <div class="item" style="left:221px; top:277px;" id="area2_a3">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area2_number3">4</div>
        </div>
        <div class="item" style="left:257px; top:277px;" id="area2_a4">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area2_number4">5</div>
        </div>
        <div class="item" style="left:293px; top:277px;" id="area2_a5">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area2_number5">6</div>
        </div>
        <div class="item" style="left:221px; top:322px;" id="area2_a6">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area2_number6">7</div>
        </div>
        <div class="item" style="left:257px; top:322px;" id="area2_a7">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area2_number7">8</div>
        </div>
        <div class="item" style="left:293px; top:322px;" id="area2_a8">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area2_number8">9</div>
        </div>
        <div class="item" style="left:221px; top:367px;" id="area3_a0">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="area3_number0">0</div>
        </div>
        <!-- E 数字区 -->

        <div class="item item-del" style="left:257px; top:367px;" id="btndelete_a0">
            <div class="link" ><img src="../images/t.gif" /></div>
            <div class="txt" id="btndelete">删除</div>
        </div>
    </div>
    <!-- E 键盘 -->

    <!-- 搜索结果列表 -->
    <div class="searchResult">
        <div class="hd" id="searchResult"></div>
        <div class="bd">
            <div class="item" style="top: 122px;" id="p_a0">
                <div class="link" ><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name0"></div>
            </div>
            <div class="item" style="top: 154px;" id="p_a1">
                <div class="link" ><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name1"></div>
            </div>
            <div class="item" style="top: 186px;" id="p_a2">
                <div class="link" ><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name2"></div>
            </div>
            <div class="item" style="top: 218px;" id="p_a3">
                <div class="link" ><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name3"></div>
            </div>
            <div class="item" style="top: 250px;" id="p_a4">
                <div class="link" ><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name4"></div>
            </div>
            <div class="item" style="top: 282px;" id="p_a5">
                <div class="link" ><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name5"></div>
            </div>
            <div class="item" style="top: 314px;" id="p_a6">
                <div class="link" ><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name6"></div>
            </div>
            <div class="item" style="top: 346px;" id="p_a7">
                <div class="link" ><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name7"></div>
            </div>
            <div class="item" style="top: 378px;" id="p_a8">
                <div class="link" ><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name8"></div>
            </div>
            <div class="item" style="top: 410px;" id="p_a9">
                <div class="link" ><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name9"></div>
            </div>
        </div>
        <div class="ft">
            <div class="mod-paging-b" id="pager"></div>
        </div>
    </div>

</div>
</body>


</html>
