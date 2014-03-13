<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
            left: 31px;
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

//search progranname
var area0;
//search personname
var area1;
//A-Y
var area1; 
//1-9
var area2;
//0,Z
var area3;
//delete
var area4;

//programlist
var area5;

var programList = new Array();
window.onload = function()
{
	//refreshServerTime();
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
	 //搜索结果<span id="searchResult"></span>
	 if(totalRecord == null || totalRecord == undefined)
	 	totalrRecord = 0;
	$("searchResult").innerHTML = "搜索结果"+"<span>("+totalRecord+")</span>";
	if(pageCount != null && pageCount  != undefined && pageCount != 0)
	{
		//<span class="current">1</span>/3
		$("pager").innerHTML = "<span class='current'>"+area6.curpage +"</span>/"+pageCount;
	}
	pager(pageCount);
}

function pager(pageCount)
{
	if(programList == null)
		return ;
	var list=new Array();
	var start = (area6.curpage-1)*10;
	var size = totalRecord-start;
	for(var i = 0; i <size; i++)
	{
		list[i]=programList[start+i];
	}
	if(list.length != 0)
		setValue(list,pageCount);
	
}

function setValue(data,pageCount)
{
	alert("setvalue:datalength:"+data.length);
	area6.setpageturndata(data.length, pageCount);
	area6.datanum = data.length;
	for(var i = 0 ; i < area6.doms.length; i ++)
	{
		if( i < data.length)
		{
			area6.doms[i].setcontent("",data[i].vodName,18,true,false);
			area6.doms[i].mylink="vod_turnpager.jsp?vodid="+data[i].vodId;
		}
		else
		{
			area6.doms[i].updatecontent("");
		}
	}
}

function initPage()
{
	//search button progranname
	area0=AreaCreator(1,1,new Array(-1,-1,2,1),"btnsearch_programname","className:btn-searchOri onboder","className:btn-searchOri offboder");
	
	area0.areaOkEvent = function()
	{
		var url = "datajsp/search-result-data.jsp?words=" +$("words").innerHTML;
		url +="&searchType=programname";
		alert(url);
		getAJAXData(url, loadProgram);
	}
	
	//search button personname
	area1=AreaCreator(1,1,new Array(-1,0,2,6),"btnsearch_personname","className:btn-searchG onboder","className:btn-searchG offboder");
	
	area1.areaOkEvent = function()
	{
		var url = "datajsp/search-result-data.jsp?words=" +$("words").innerHTML;
		url +="&searchType=personname";
		alert(url);
		getAJAXData(url, loadProgram);
	}
	
	//A-Z
	area2=AreaCreator(5,5,new Array(0,-1,-1,3),"area1_a","className:item onboder","className:item offboder");
	area2.areaOkEvent=function()
	{
        
         if($("words").innerHTML.length <22)
		{
		   	$("words").innerHTML += $("area1_letter"+this.curindex).innerHTML;
		}
    }
    //1-9
    area3=AreaCreator(3,3,new Array(1,2,4,6),"area2_a","className:item onboder","className:item offboder");
	area3.areaOkEvent = function()
	{
		if($("words").innerHTML.length <22)
		{
		   	$("words").innerHTML+= this.doms[this.curindex].dom[0].innerHTML;
		}
	}
	//0,Z
	area4=AreaCreator(2,1,new Array(3,2,-1,5),"area3_a","className:item onboder","className:item offboder");
	area4.areaOkEvent = function()
	{
		if($("words").innerHTML.length <22)
		{
		   	$("words").innerHTML+= this.doms[this.curindex].dom[0].innerHTML;
		}
	}
	//delete
	area5=AreaCreator(1,1,new Array(3,4,-1,6),"btndelete_a","className:item item-del onboder","className:item item-del offboder");
	area5.areaOkEvent = function()
	{
		  $("words").innerHTML= $("words").innerHTML.substr(0,$("words").innerHTML.length-1);
	}
	//programlist
	area6=AreaCreator(10,1,new Array(-1,3,-1,-1),"p_a","className:item onboder","className:item offboder");
	for(var i = 0 ; i < area6.doms.length ; i ++)
	{
		area6.doms[i].contentdom = $("p_name"+i);
	}
	area6.asyngetdata=function()
	{
		pager();
	}
	
   pageobj = new PageObj(2, 0, new Array(area0, area1, area2,area3,area4,area5,area6));
   pageobj.backurl = "index.jsp";
  // pageobj.changefocus(1, 0);
   
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
        <div class="btn-searchG" id="btnsearch_personname0">
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
            <div class="item" style="top: 122px;">
                <div class="link" id="p_a0"><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name0"></div>
            </div>
            <div class="item" style="top: 154px;">
                <div class="link" id="p_a1"><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name1"></div>
            </div>
            <div class="item" style="top: 186px;">
                <div class="link" id="p_a2"><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name2"></div>
            </div>
            <div class="item" style="top: 218px;">
                <div class="link" id="p_a3"><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name3"></div>
            </div>
            <div class="item" style="top: 250px;">
                <div class="link" id="p_a4"><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name4"></div>
            </div>
            <div class="item" style="top: 282px;">
                <div class="link" id="p_a5"><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name5"></div>
            </div>
            <div class="item" style="top: 314px;">
                <div class="link" id="p_a6"><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name6"></div>
            </div>
            <div class="item" style="top: 346px;">
                <div class="link" id="p_a7"><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name7"></div>
            </div>
            <div class="item" style="top: 378px;">
                <div class="link" id="p_a8"><img src="../images/t.gif" /></div>
                <div class="txt" id="p_name8"></div>
            </div>
            <div class="item" style="top: 410px;">
                <div class="link" id="p_a9"><img src="../images/t.gif" /></div>
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