<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ include file="datajsp/dibbling_recreation.jsp"%> 
 <script type="text/javascript" src="js/pagecontrol.js"></script>
    <script type="text/javascript">
       
	    //Update BY Evans Date:2011/10/18
        var pageindex = 0;
        var area1;
        var area0;
		var catalogid;
		var area0realstate = {"curpage":1,"curindex":0};
		var areaid = 0;
		var indexid = 0;
		var returnurl = '<%=request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"index.jsp"%>';
		
        //页面加载时候执行
        window.onload = function() {
            //导航默认选中 行，列，可移动的方向（-1为不可移动或者区域号 上左下右）
            area0 = AreaCreator(9, 1, new Array(-1, -1, -1, 1), "cate_", "className:menuli on", "className:menuli");
            //导航链接地址
            area0.setstaystyle("className:menuli current", 3);
            //栏目列表页面数据
            area1 = AreaCreator(2, 3, new Array(-1, 0, -1, -1), "content_", "className:bgon", "className:bg");
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
			setDarkFocus();
//editing by ty 2011-11-22 17:09:54
			//菜单翻页
/////////////////////////////////////////////////////////////////////////////////////////////////////			
			area0.setcrossturnpage();
			area0.asyngetdata = function(dataurl) {
              var ids = getcurcates(cateids,area0.curpage,<%=catepagesize%>);
			  var names = getcurcates(catenames,area0.curpage,<%=catepagesize%>);
			   getdatacate(names,ids);
            }
/////////////////////////////////////////////////////////////////////////////////////////////////////			
            //区域1的确认事件
            area0.areaOkEvent = function() {
                area1.curpage = 1;
				area0realstate.curpage = area0.curpage;
			   	area0realstate.curindex = area0.curindex;
				catalogid=area0.doms[area0.curindex].dataurlorparam;
				getAJAXData("datajsp/dibbling_recreation_Ifrom.jsp?pageindex=1&cateid=" + catalogid,GetJson);
                //$('hidden_frame').src = "datajsp/dibbling_recreation_Ifrom.jsp?pageindex=" + area1.curpage + "&cateid=" + area0.doms[area0.curindex].dataurlorparam;
            }
			
			area1.areaOkEvent = function(){
				area0.curpage = area0realstate.curpage;
			   	area0.curindex = area0realstate.curindex;		
	   		 	saveFocstr(pageobj);
	   		}
			
            area1.setcrossturnpage();
			for(var i =0;i<6;i++){
				area1.doms[i].contentdom = $("contentname_"+i);
				area1.doms[i].imgdom = $("img_"+i);
			}
            //下一页事件
            area1.asyngetdata = function(dataurl) {
				//直接用JsON 获取数据
				getAJAXData("datajsp/dibbling_recreation_Ifrom.jsp?pageindex=" + this.curpage + "&cateid=" + catalogid,GetJson);
            }
			
			area1.doms[5].focusEvent = function(){
				alert($('content_5').style.visibility);
			}
			
            //区域1右移事件(取消)
            //area0.areaOutingEvent = function() {
               // area1.curpage = 1;
                //$('hidden_frame').src = "datajsp/dibbling_recreation_Ifrom.jsp?pageindex=" + area1.curpage + "&cateid=" + area0.doms[area0.curindex].dataurlorparam;
                
            //}
			area1.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png","images/down_gray.png");
			//加载的时候绑定的数据
			
			
            BindCateLeft();
            getbackdata();
			pageobj.backurl = returnurl;
			if(catalogid==undefined){
				catalogid=area0.doms[area0.curindex].dataurlorparam;
			}
        }
	
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
					$('menu'+i).style.visibility = "visible";
				}
				else{
					area0.doms[i].updatecontent("");
					$('menu'+i).style.visibility = "hidden";
				}
			}
		}
		function GetJson(txtJson){//转化Json对象成数据
			//alert(txtJson.length);
			
			//$('marq').innerHTML = txtJson;
			//解析Json数据
			var thisjson = eval(txtJson);
			//alert(thisjson.listJson.length);
			var names = new Array();
			var ids = new Array();
			var pics = new Array();
			var pagecount =  thisjson.countTotalPage[0].value;
			var subtype =parseInt(thisjson.subtype[0].value);
			for(var i=0;i<thisjson.listJson.length;i++)
			{
				//alert(thisjson.listJson[i].vodName);
				names.push(thisjson.listJson[i].vodName);
				ids.push(thisjson.listJson[i].vodId);
				pics.push(thisjson.listJson[i].vodpath);
			}
			//alert(subtype);
			getdatapic(names, ids, pics, pagecount,subtype);
		}
        //图片回掉的参数$('page').innerHTML
        function getdatapic(names, ids, pics, pagecount,subtype) {
            area1.setpageturndata(names.length, pagecount);
            for (i = 0; i < area1.doms.length; i++) {
                if (i < ids.length) {
					//$('content_'+i).style.visibility = "visible";
                    area1.doms[i].updateimg(((pics[i]==undefined||pics[i]=="")?"#":pics[i]));
                    area1.doms[i].setcontent("",names[i],13,true);
					
					switch(subtype){
						case 0: //内容
							//alert('content');
							//area1.doms[i].mylink = "vod_turnpager.jsp?typeid="+area0.doms[area0.curindex].dataurlorparam+"&vodid=" + ids[i]+"&returnurl="+escape(location.href);
							area1.doms[i].mylink = "program_tvpart_choose.jsp?ptypeid="+area0.doms[area0.curindex].dataurlorparam+"&type=cate&typeid="+ids[i]+"&returnurl="+escape(location.href);
							break;
						case 1:  //栏目
							//alert('cate');
							area1.doms[i].mylink = "program_tvpart_choose.jsp?ptypeid="+area0.doms[area0.curindex].dataurlorparam+"&type=cate&typeid="+ids[i]+"&returnurl="+escape(location.href);
							break;
						default:
							//alert(subtype);
							break;
					}
                }
                else {
                    $('img_' + i).src = "";
                    $('contentname_' + i).innerHTML = "";
					$('content_'+i).style.visibility = "hidden";
                }
            }
            $('page').innerHTML = area1.curpage + "/" + pagecount;	
        }
    </script>