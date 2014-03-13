<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">
		//Update By ty Date:2012-01-30 14:57:58
		var areaid = 0;
		var indexid = 0;
        var pageindex = 0;
        var area1;
        var area0;
		var catalogid = '<%=CateFrist %>';
		var area0realstate = {"curpage":1,"curindex":0};
		var returnurl = '<%=request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"index.jsp"%>';
		
        //页面加载时候执行
        window.onload = function() {
            //导航默认选中 行，列，可移动的方向（-1为不可移动或者区域号 上左下右）
            area0 = AreaCreator(9, 1, new Array(-1, -1, -1, 1), "cate_", "className:menuli on", "className:menuli");
            //导航链接地址
            area0.setstaystyle("className:menuli current", 3);
            //栏目列表页面数据
            area1 = AreaCreator(2, 5, new Array(-1, 0, -1, -1), "content_", "className:on", "className:");
            //是否默认选中需要传递参数进行判断
			if(focusObj!=undefined&&focusObj!="null"){
			   areaid = parseInt(focusObj[0].areaid);
			   indexid = parseInt(focusObj[0].curindex);
			   area0.curpage = parseInt(focusObj[1].curpage);
			   area0realstate.curpage = parseInt(focusObj[1].curpage);
			   area0realstate.curindex = parseInt(focusObj[1].curindex);
			   area1.curpage = parseInt(focusObj[0].curpage);
	  		}else{
				area0.curpage = <%=curpage %>;
				area0realstate.curpage = <%=curpage %>;
			   	area0realstate.curindex = <%=curindex %>;
				area0.curindex = <%=curindex %>;
				indexid = <%=curindex %>;
			}
            pageobj = new PageObj(areaid,indexid, new Array(area0, area1)); //参数（区域，选中第几个，区域列表）
area1.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png","images/down_gray.png");
			setDarkFocus();
//editing by ty 2011-11-22 17:09:54
			//菜单翻页
/////////////////////////////////////////////////////////////////////////////////////////////////////			
			area0.setcrossturnpage();
			area0.asyngetdata = function(dataurl) {
              ids = getcurcates(cateids,area0.curpage,<%=catepagesize%>);
			  names = getcurcates(catenames,area0.curpage,<%=catepagesize%>);
			   getdatacate(names,ids);
            }
            //区域1的确认事件
            area0.areaOkEvent = function() {
				//alert(1);
                area1.curpage = 1;
				area0realstate.curpage = area0.curpage;
			   	area0realstate.curindex = area0.curindex;
				catalogid=area0.doms[area0.curindex].dataurlorparam;
                getAJAXData("datajsp/dibbling_film_Ifrom.jsp?pageindex=1" + "&typeid=" + catalogid,GetJson);
				//$('hidden_frame').src = "datajsp/dibbling_film_Ifrom.jsp?pageindex=" + area1.curpage + "&typeid=" + area0.doms[area0.curindex].dataurlorparam;
            }
			
            area1.setcrossturnpage();
			
			area1.areaOkEvent = function(){
				area0.curpage = area0realstate.curpage;
			   	area0.curindex = area0realstate.curindex;		
	   		 	saveFocstr(pageobj);
	   		}
			
            //下一页事件
            area1.asyngetdata = function(dataurl) {
				getAJAXData("datajsp/dibbling_film_Ifrom.jsp?pageindex=" + this.curpage + "&typeid=" + catalogid,GetJson);
                //$('hidden_frame').src = "datajsp/dibbling_film_Ifrom.jsp?pageindex=" + this.curpage + "&typeid=" + area0.doms[area0.curindex].dataurlorparam;
            }
            //区域1右移事件
           // area0.areaOutingEvent = function() {
           //     area1.curpage = 1;
			//	getAJAXData("datajsp/dibbling_film_Ifrom.jsp?pageindex=" + area1.curpage + "&typeid=" + area0.doms[area0.curindex].dataurlorparam,GetJson);
                //$('hidden_frame').src = "datajsp/dibbling_film_Ifrom.jsp?pageindex=" + area1.curpage + "&typeid=" + area0.doms[area0.curindex].dataurlorparam;

            //}
			
            BindCateLeft();
            getbackdata();
			pageobj.backurl = returnurl;
        }
		//editing by ty 2011-11-22 17:47:21		
			//菜单回调的参数
/////////////////////////////////////////////////////////////////////////////////////////////////////
		function getcurcates(itms,curpage,pagesize){
			var newitms = new Array();
			for(var i = (curpage-1)*pagesize,j=0;j<pagesize&&i<itms.length;i++,j++){
				newitms.push(itms[i]);		
			}
			return newitms;
		}
			
		function getdatacate(names,ids){
			area0.setpageturndata(ids.length,catePagecount);
			$('catepage').innerHTML = area0.curpage + "/" + parseInt(catePagecount);
			for(var i=0;i<<%=catepagesize%>;i++){
					if(i<ids.length){
						 area0.doms[i].dataurlorparam = ids[i];
						 area0.doms[i].setcontent("",names[i],11,true);
						 //document.getElementById('menu'+i).style.visibility = "visible";
						 $('menu'+i).style.visibility = "visible";
					}
					else
					{
						area0.doms[i].updatecontent("");
						//document.getElementById('menu'+i).style.visiblity = "hidden";
						$('menu'+i).style.visibility = "hidden";
					}
				}
		}
		function GetJson(jsonTxt){
			//$('pao').innerHTML=jsonTxt;
			var thisjson = eval(jsonTxt);
			var ids = new Array();
			var pics = new Array();
			var pagecount = thisjson.countTotalPage[0].value;
			//var test="";
			for(var i = 0;i<thisjson.listJson.length;i++)
			{
				ids.push(thisjson.listJson[i].vodId);
				pics.push(thisjson.listJson[i].vodpath);
				//test+="ID->index("+i+"):"+ids[i];
			}
			//alert(test);
			getdatapic(ids,pics,pagecount);
		}

        //图片回掉的参数
        function getdatapic(ids, pics, pagecount) {
            area1.setpageturndata(ids.length, pagecount);
            for (i = 0; i < area1.doms.length; i++){
                if (i < pics.length) {
					//alert(ids[i]+"-->pic:"+pics[i]);
                    $('pic_' + i).src = pics[i];
					$('content_' + i).style.visibility="visible";
                    area1.doms[i].mylink =  "vod_turnpager.jsp?vodid="+ids[i]+"&typeid="+(area0.doms[area0.curindex]).dataurlorparam+"&returnurl="+escape(location.href);
                }else{
					$('content_' + i).style.visibility="hidden";
                    $('pic_' + i).src = "";				
                }
            }
            $('page').innerHTML = area1.curpage + "/" + pagecount;
        }
    </script>