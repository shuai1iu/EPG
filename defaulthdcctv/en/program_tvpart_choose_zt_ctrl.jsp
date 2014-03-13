<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript" src="js/EPGConstants.js"></script>
<script type="text/javascript">
        var pageindex = 0;
        var area1;
        var area0;
		var area2;
		var area3;
		var area5;
		var areaid = 1;
		var indexid = 0;
		var isfavsucc = -1; //用于判断收藏是否添加成功 0.添加失败(添加接口失败) 1.添加成功 2.收藏夹已满
		var isbuysucc = -1; //用于判断购买是否成功
		var cateid=<%=request.getParameter("id")%>;
		var returnurl = '<%=request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"index.jsp"%>';
        var isbookmark = undefined;  //是否有书签返回码
		var begintime = '-1';
		var endtiem = '-1';
		var isSitcom = false;
		var newSits;
		var curcontentindex = <%=curcontentindex %>;
		//页面加载时候执行
        window.onload = function() {
            //导航默认选中 行，列，可移动的方向（-1为不可移动或者区域号 上左下右）
            area0 = AreaCreator(1, 1, new Array(-1, -1, -1, 1), "menu", "className:menuli on", "className:menuli");
            //editing 2011年8月21日 14:24:03
			  //是否显示购买按钮
			  if(true){
				  area0.datanum = 2;
				  $("tmpicon1").style.display = "none";
				  $("menu3").style.display = "none";
				  $("menu1").style.display = "none";
				  $("tmpicon0").style.display = "none";
				  $("menu2").style.display = "none";
			 }
			area0.setfocuscircle(0);
			
			//导航链接地址
            area0.setstaystyle("className:menuli current", 3);
            //栏目列表页面数据
            area1 = AreaCreator(pagesize, 1, new Array(-1, 0, -1, -1), "content_", "className:ch_li on", "className:ch_li");
			area1.setfocuscircle(0);
			area2 = AreaCreator(1, 2, new Array(-1, -1, 1, -1), "sele_", "className:on", "className:");
			area3 = AreaCreator(1, 1, new Array(0, -1, -1, -1), "sele1_", "className:on", "className:");
			var popup1=new Popup("divshowsale",new Array(area2,area3),0,1);
			var popup2=new Popup("divshow");
			
			//弹出层
	   		//书签
		   area5 = AreaCreator(1,2,new Array(-1,-1,-1,-1),"div_tip","className:on","className:");
		   area5.doms[0].domOkEvent = function(){ //书签播放
				location.href = "au_PlayFilm.jsp?PROGID="+newSits[area1.curindex].VODID+"&PLAYTYPE="+EPGConstants.PLAY_TYPE_BOOKMARK+"&CONTENTTYPE="+jsonContent.CONTENTTYPE+"&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD+"&BEGINTIME="+begintime+"&ENDTIME="+endtime+"&TYPE_ID=<%=typeId%>&returnurl="+escape(location.href);
		   }
	   
		   area5.doms[1].domOkEvent = function(){ //从头播放
				location.href = "play_turnpager.jsp?vodid="+newSits[area1.curindex].VODID+"&returnurl="+escape(location.href);
				popup3.closeme();
		   }
		   var popup3 = new Popup("div_tip",new Array(area5));
		   popup3.goBackEvent=function()
		   {
			   this.closeme();
		   }
            //是否默认选中需要传递参数进行判断
			
			if( curcontentindex != -1){
				area1.curpage = parseInt(curcontentindex/pagesize)+1;
				area1.curindex = curcontentindex%pagesize;
				areaid = 1;
				indexid = area1.curindex;
				
			}
			area0.curindex = 0;
			area0.setdarknessfocus(0);
			newSits = getcurcates(jsonSitcoms,area1.curpage,pagesize);
			if(focusObj!="null"&&focusObj!=undefined){
				areaid = focusObj[0].areaid;
				indexid = focusObj[0].curindex;
				area1.curpage = focusObj[0].curpage;
			}
			
            pageobj = new PageObj(areaid, indexid, new Array(area0,area1),new Array(popup1,popup2,popup3)); //参数（区域，选中第几个，区域列表）
			
			//area0.setdarknessfocus(1); //灰色显示的

			//书签判断
			area1.areaOkEvent = function(){
				saveFocstr(pageobj);
				 getAJAXData("datajsp/check_bookmark.jsp?vodid=" + newSits[area1.curindex].VODID,GetBookJson);
			}
			
			popup2.closetime=1;
			popup1.goBackEvent=function()
			{
				   this.closeme();
			}
			
            //区域0的确认事件
            area0.areaOkEvent = function() {
                switch (this.curindex) {
					//editing ty 2011年8月21日 21:26:16
					//case 0: break;
					case 1: window.location.href = "program_tv_zt.jsp?typeid=<%=typeId%>&ptypeid=<%=parent_typeId%>&returnurl="+escape(returnurl); return true; break;  
                    case 0:	pageobj.changefocus(1,0);area0.setdarknessfocus(0);return true; break;
                    case 2: if(!isfaved){
							$("hidden_frame").src = "datajsp/space_collectAdd_iframedata.jsp?PROGID="+jsonContent.VODID+"&PROGTYPE="+jsonContent.CONTENTTYPE;				
							isdofav();						
							}else{
							$("hidden_frame").src = "datajsp/space_collectDel_iframedata.jsp?PROGID="+jsonContent.VODID+"&PROGTYPE="+jsonContent.CONTENTTYPE;
							dodelfav();
						}
						break;
                    case 3: pageobj.popups[0].showme(); return true; break;
                }
            }
			
            area1.setcrossturnpage();
            //下一页事件
            area1.asyngetdata = function(dataurl) {
				newSits = getcurcates(jsonSitcoms,area1.curpage,pagesize);
				bindData(newSits);
                getAJAXData("datajsp/program_tvpart_choose_data_Ifrom.jsp?ccid="+newSits[area1.curindex].VODID,GetJson);
				//getAJAXData("datajsp/program_tvpart_choose_data_Ifrom.jsp?curpage=" + this.curpage + "&cateid=<%=tmp_typeId %>&curindex="+area1.curindex,GetJson);
            }
			area1.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png","images/down_gray.png");
			
			//切换焦点事件
			area1.changefocusedEvent = function(){
				getAJAXData("datajsp/program_tvpart_choose_data_Ifrom.jsp?ccid="+newSits[area1.curindex].VODID,GetJson);
				//alert("qiehuan");
				//$('hidden_frame').src = "datajsp/program_tvpart_choose_data_Ifrom.jsp?ccid="+jsonSitcoms[area1.curindex].VODID;
			}
			
			area2.areaOkEvent = function() {
                switch (area2.curindex) {
					case 0: return true; break;
                    case 1: area2.closeme(); return true; break;
                }
            }
			area3.areaOkEvent = function() {
                window.location.href = "package_intro.jsp"; return true; break;  
            }
			//ZTE
//			area0.doms[2].updatecontent( isfaved ?"移除收藏":"收  &nbsp;&nbsp;  藏");
			if (area0.doms[2] != undefined) area0.doms[2].updatecontent( isfaved ?"移除收藏":"收  &nbsp;&nbsp;  藏");
            //区域1右移事件
			 newSits = getcurcates(jsonSitcoms,area1.curpage,pagesize);
             bindData(newSits);
  			 bindContent(jsonContent);
			 pageobj.backurl = returnurl;
        }
		function GetBookJson(JsonTxT)
		{
			//$('pao').innerHTML= JsonTxT;
			var thisjosn = eval('('+JsonTxT+')');
			begintime = thisjosn.begintime;
	        endtiem = thisjosn.endtime;
	        isbookmark = thisjosn.isbookmark;
			isSitcom = thisjosn.isSitcom;
			//alert("begintime:"+begintime+",endtiem"+endtiem+",isbookmark"+isbookmark);
			getbookmark();
		}
		function GetJson(JsonTxT)
		{
			   //$('pao').innerHTML= JsonTxT;

			   var thisJson = eval("("+JsonTxT+")");
			   
			   //alert(thisJson.Films.length);
			   //绑定内容信息
			   var contentJson = thisJson.Content;
			   var DataJson = thisJson.Films;
			   bindContent(contentJson);
			   //alert(contentJson.DIRECTOR+"-"+contentJson.ACTOR+"-"+contentJson.INTRODUCE);			   
			   //绑定分页数据
			   if(DataJson!=null&&DataJson!=undefined&&DataJson!="null"){
					bindData(DataJson);
					jsonSitcoms=DataJson;
			   }
		}
        //图片回掉的参数
        function getdataName(ids, names, pagecount) {
            for (i = 0; i < area1.doms.length; i++) {
                if (i < names.length) {
                    $('content_' + i).innerHTML = names[i];
                    area1.doms[i].mylink = "index.jsp";
                }
                else {
                    $('content_' + i).innerHTML = "";
                }
            }
            //$('page').innerHTML = area1.curpage + "/" + pagecount;
        }
		
		function isdofav(){
		   switch(isfavsucc){
			   		case -1:
						setTimeout("isdofav()",500);
						break;
					case 0:
						$("divshowtext").innerHTML = "添加收藏失败，请稍候再试";
						pageobj.popups[1].showme();
						break;
					case 1:
						isfaved = true;						
						$("menu2").innerHTML = "移除收藏";
						$("divshowtext").innerHTML = "节目已成功加入收藏";
						isfavsucc = -1;
						pageobj.popups[1].showme();
						break;
					case 2:
						$("divshowtext").innerHTML = "收藏夹已满，请删除后重试";
						pageobj.popups[1].showme();
						break;
					default:
						break;
			} 	   
   }
  
   
   function dodelfav(){
	   isfavsucc = succ;
	   switch(isfavsucc){
		   case -1:
				setTimeout("dodelfav()",500);
				break;
			case 0:
				$("divshowtext").innerHTML = "移除收藏失败，请稍候再试";
				pageobj.popups[1].showme();
				break;
			case 1:
				isfaved = false;
				$("divshowtext").innerHTML = "节目已移除收藏";
				$("menu2").innerHTML = "收  &nbsp;&nbsp;  藏";
				pageobj.popups[1].showme();
				isfavsucc = -1;
				succ = -1;
				break;
			default:
				break;
	   }
   }
   
   //editing ty 2011年8月22日 10:40:37
   //获取书签并播放
   function getbookmark(){
	   if(isbookmark==undefined){
		   setTimeout("getbookmark()",500);
	   }else{
		   if(!isSitcom){
			   if(isbookmark==true){  //判断是否有书签
					pageobj.popups[2].showme();
				}else{
					location.href = "play_turnpager.jsp?vodid="+newSits[area1.curindex].VODID+"&returnurl="+escape(location.href);		
				}
		   }else{
			   location.href = "program_tv_choose.jsp?vodid="+newSits[area1.curindex].VODID+"&typeid=<%=tmp_typeId %>"+"&returnurl="+escape(location.href);
		   }
		   
	   }
   }
   
   //获取当前页面的内容集合
   function getcurcates(itms,curpage,pagesize){
	  if(itms!=null&&itms!=undefined&&itms!="null"){
			var newitms = new Array();
			for(var i = (curpage-1)*pagesize,j=0;j<pagesize&&i<itms.length;i++,j++){
				newitms.push(itms[i]);		
			}
			return newitms;
	  }else{
		  return itms;
	  }
	}
    </script>