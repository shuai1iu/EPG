<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ include file="datajsp/dibbling_data.jsp"%>
<%@ include file="datajsp/dibbling_data_image.jsp"%>
<script type="text/javascript" src="js/pagecontrol.js"></script>

    <script type="text/javascript">
       var areaid=<%=request.getParameter("areaid")%>;
	   var indexid=<%=request.getParameter("indexid")%>;
        var pageindex = 0;
        var area2;
        var area1;
        //页面加载时候执行
        window.onload = function() {
            //导航默认选中
            var area0 = AreaCreator(11, 1, new Array(-1, -1, -1, 1), "area0_list_", "className:menuli on", "className:menuli");
            //导航链接地址
            area0.setstaystyle("className:menuli current", 3);
		    area0.doms[0].mylink="index.jsp";
		    area0.doms[1].mylink="channel.jsp";
	   		area0.doms[2].mylink="dibbling.jsp";
	   		area0.doms[3].mylink="application.jsp?indexid=3";
	   		//area0.doms[3].mylink="special_topic.jsp";
	   		area0.doms[4].mylink="playback.jsp";
			if(indexid==5){  //四川
				area0.doms[6].mylink="local.jsp?type=local&indexid=6";
			}
			if(indexid==6){  //成都
				area0.doms[5].mylink="local.jsp?type=local&indexid=5";
			}  		
	   		area0.doms[7].mylink="application.jsp";
	   		area0.doms[8].mylink="package.jsp";
	   		area0.doms[9].mylink="space_collect.jsp";
	  		area0.doms[10].mylink="search.jsp";
            //栏目列表页面数据
            area1 = AreaCreator(12, 1, new Array(-1, 0, -1, 2), "area1_list_", "className:sub on", "className:sub");
            //area1.stayindexdir="1";
            //移出保持区域样式
            area1.setstaystyle("className:sub current", 3);
            //推荐区域数据
            area2 = AreaCreator(3, 1, new Array(-1, 1, -1, -1), "area2_list_", "className:on", "className:");
            //是否默认选中需要传递参数进行判断
            pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):5, new Array(area0, area1, area2)); //参数（区域，选中第几个，区域列表）
			if(areaid!=null&&areaid!=0)
            	area0.setdarknessfocus(indexid); //灰色显示的
            //一区修改焦点时改变2区数据
            area1.dataarea = area2;

            //下一页事件
            area1.asyngetdata = function(dataurl) {
            this.lockin = true;
                $('hidden_frame').src = "datajsp/dibbling_data_Ifrom.jsp?CategoryPageIndex=" + this.curpage;
            }
            area2.asyngetdata = function(dataurl) {
                area2.lockin = true;
                $('hidden_frame2').src = "datajsp/dibbling_data_image_Ifrom.jsp?cateid=" + dataurl;
            }
			area0.setfocuscircle(0);
			pageobj.goBackEvent=function()
		   {
			   location.href="index.jsp";
		   		//this.changefocus(0,indexid);
		   }
            area1.setcrossturnpage();
			area1.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png","images/down_gray.png");
            getbackdata();
            getbackpic();
			
        }

        //栏目回掉的参数
        function getdataCate(names, ids, catecount) {
            area1.setpageturndata(names.length, catecount);
            for (i = 0; i < area1.doms.length; i++) {
                if (i < names.length) {
                    area1.doms[i].updatecontent(names[i]);
                    if (names[i].indexOf("娱乐") >= 0) {
                        area1.doms[i].mylink = "dibbling_recreation.jsp?id=" + ids[i] +"&returnurl="+escape(location.href);
                    } 
					if(names[i].indexOf("新闻") >= 0){
						area1.doms[i].mylink = "news_focus.jsp?id=" + ids[i] +"&returnurl="+escape(location.href);
					}
					else {
                        area1.doms[i].mylink = "dibbling_film.jsp?id=" + ids[i] +"&returnurl="+escape(location.href);
                    }
                    area1.doms[i].dataurlorparam = ids[i];
                }
                else
                    area1.doms[i].updatecontent("");
            }
            $('page').innerHTML = area1.curpage + "/" + catecount;
            area1.lockin = false;
        }
        //图片回掉的参数
        function getdatapic(images, ids) {
            for (i = 0; i < area2.doms.length; i++) {
                if (i < images.length) {
                    $('img' + i).src = images[i];
                    area2.doms[i].mylink = "program_film.jsp?mediaid="+ids[i]+"&returnurl="+escape(location.href);
                }
                else
                    $('img' + i).src = "images/temp/" + 1 + ".jpg";
            }
            area2.lockin = false;
        }
       
    </script>