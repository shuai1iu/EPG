<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<script type="text/javascript" src="js/gstatj.js"></script>

<script src="js/pagesini.js"></script>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">
var userid = Authentication.CTCGetConfig("UserID");
     	var areaid=<%=request.getParameter("areaid")%>;
	   	var indexid=<%=request.getParameter("indexid")%>;
        var pageindex = 0;
        var area2;
        var area1;
		var area0;
        //页面加载时候执行
        window.onload = function() {
     gstaFun(userid,641);
            //导航默认选中
       area0=AreaCreator(10,1,new Array(-1,-1,-1,1),"area0_list_","className:menuli on","className:menuli");
	   area0.setstaystyle("className:menuli current",3);
	   area0.doms[0].mylink=indexhref[0];
	   area0.doms[1].mylink=indexhref[1];
	   area0.doms[2].mylink=indexhref[2];
	   //area0.doms[3].mylink="application.jsp?indexid=3";
	   area0.doms[3].mylink=indexhref[3];
	   area0.doms[4].mylink=indexhref[4];
	   area0.doms[5].mylink=indexhref[5];
	   area0.doms[6].mylink=indexhref[6];
	   area0.doms[7].mylink=indexhref[7];
	   area0.doms[8].mylink=indexhref[8];
	   area0.doms[9].mylink=indexhref[9];
	   area0.setfocuscircle(0);
            //栏目列表页面数据
            area1 = AreaCreator(12, 1, new Array(-1, 0, -1, 2), "area1_list_", "className:sub on", "className:sub");
            //area1.stayindexdir="1";
            //移出保持区域样式
            area1.setstaystyle("className:sub current", 3);
			area1.setfocuscircle(0);
            //推荐区域数据
            area2 = AreaCreator(3, 1, new Array(-1, 1, -1, -1), "area2_list_", "className:on", "className:");
            //是否默认选中需要传递参数进行判断
			if(focusObj!=undefined&&focusObj!="null"){
				areaid = parseInt(focusObj[0].areaid);
			    indexid = parseInt(focusObj[0].curindex);
				if(focusObj[0].areaid == 1){
			    	area1.curpage = parseInt(focusObj[0].curpage);
				}
			}
			area2.setfocuscircle(0);
            pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):2, new Array(area0, area1, area2)); //参数（区域，选中第几个，区域列表）
			 //灰色显示的
            //一区修改焦点时改变2区数据
            //area1.dataarea = area2;
			setDarkFocus();
            //下一页事件
            area1.asyngetdata = function(dataurl) {
				
		//getAJAXData("datajsp/dibbling_data_Ifrom.jsp?curpage="+area1.curpage+"&curindex="+area1.curindex+"&x="+Math.random(1),updatecontents);
		         //************************
			     //栏目读取改变为一次性读取
			     //by:xx
			     //date:2011-12-6
				 var reclist=new Array();
			     var start = (this.curpage-1)*pagesize;
			     var size = jTypelist.length-start-1;
			     for(i=0;i<pagesize&&(i+(this.curpage-1)*pagesize)<jTypelist.length;i++)
	             {
	               reclist[i]=jTypelist[start+i];
	             }
				 bindListData(reclist);
            }	
			
			//移动事件
            //area2.asyngetdata = function(dataurl) {
				//alert(jTypelist[area1.curindex].TYPE_ID);
				//getAJAXData("datajsp/dibbling_data_Ifrom.jsp?ctypeid=" + jTypelist[area1.curindex].TYPE_ID,updatecontents);
                //$('hidden_frame2').src = "datajsp/dibbling_data_Ifrom.jsp?ctypeid=" + jTypelist[area1.curindex].TYPE_ID;
           // }
			
			
			
			pageobj.goBackEvent=function()
		   {
			   location.href="index.jsp";
		   	   //this.changefocus(0,2);
		   }
		   
		   area1.areaOkEvent = function(){
				saveFocstr(pageobj);
		   }
		   
		   area2.areaOkEvent = function(){
				saveFocstr(pageobj);
		   }

		   
		   area0.setfocuscircle(0);
           area1.setcrossturnpage();
		   area1.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png","images/down_gray.png");
			//填充点播栏目列表
			//************************
			//栏目读取改变为一次性读取
			//by:xx
			//date:2011-12-6
			var reclist=new Array();
			var start = (area1.curpage-1)*pagesize;
		  	for(i=0;i<pagesize&&(i+(area1.curpage-1)*pagesize)<jTypelist.length;i++){
	           reclist[i]=jTypelist[start+i];
	        }
			bindListData(reclist);
			
			//填充推荐栏目
			bindRmdData(JRmdlist,3);
		}
		
		//editing by ty
		//2011年10月18日 11:12:43
			function updatecontents(jsonstrs){
				var allcontents = eval('('+jsonstrs+')');
				var typeListstr = allcontents.jsontypelist;
				var typeList = typeListstr;
				bindListData(typeList);;
			}		
		
//获取0-length以内的随机整数
function creatRandoms(length){
		return Math.round(Math.random()*length);
	}

//获取itms数组中，随机size个数的新数组
function getRanItems(itms,size){
		
		var newarr = new Array();
		if(itms==undefined||itms[0]=="null"){
			size = 0;
		}else if(size>itms.length){
			size = itms.length;
		}
		
		for(var i = 0;i<size;i++){
			var idx = creatRandoms(itms.length-1);
			newarr[i] = itms[idx];
			itms.splice(idx,1);
		}
		return newarr;
	}
    </script>
