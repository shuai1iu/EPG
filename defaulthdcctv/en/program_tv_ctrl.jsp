<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">

        var pageindex = 0;
        var area1;
        var area0;
		var isfavsucc = -1; //用于判断收藏是否添加成功 0.添加失败(添加接口失败) 1.添加成功 2.收藏夹已满
		var isbuysucc = -1; //用于判断购买是否成功
		var cateid=<%=request.getParameter("id")%>;
		var returnurl = '<%=request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"index.jsp"%>';
        //页面加载时候执行
        window.onload = function() {
			
            //导航默认选中 行，列，可移动的方向（-1为不可移动或者区域号 上左下右）
            area0 = AreaCreator(2, 1, new Array(-1, -1, 1, 1), "menu", "className:menuli on", "className:menuli");
            //editing 2011年8月21日 14:24:03
			  //是否显示购买按钮
			  if(true){
				  area0.datanum = 2;
				  $("tmpicon1").style.display = "none";
				  $("menu3").style.display = "none";
				  $("tmpicon0").style.display = "none";
				  $("menu2").style.display = "none";
			 }
			area0.setfocuscircle(0);
            area0.setstaystyle("className:menuli current", 3);
            //栏目列表页面数据
            area1 = AreaCreator(1, 4, new Array(0, 0, -1, -1), "cate_", "className:on", "className:");
			for(var i=0;i<4;i++){
	   			area1.doms[i].imgdom = $("img_"+i);
	   		}
			//购买
			var area2 = AreaCreator(1, 2, new Array(-1, -1, 1, -1), "sele_", "className:on", "className:");
			var area3 = AreaCreator(1, 1, new Array(0, -1, -1, -1), "sele1_", "className:on", "className:");
			var popup1=new Popup("divshowsale",new Array(area2,area3),0,1);
			var popup2=new Popup("divshow");
			popup2.closetime=1;
			popup1.goBackEvent=function()
			{
				   this.closeme();
			}
			popup2.closemedEvent = function(){
				var shouchangtext = $("daohang_2").innerHTML;
				if(shouchangtext.indexOf("移除")<0){
				$("daohang_2").innerHTML = "移除收藏";
				}
				else{
					$("daohang_2").innerHTML = "收  &nbsp;&nbsp;  藏";
				}
			}
            //是否默认选中需要传递参数进行判断
            pageobj = new PageObj(0, 0, new Array(area0, area1),new Array(popup1,popup2)); //参数（区域，选中第几个，区域列表）
            //区域1的确认事件
            area0.areaOkEvent = function() {
                switch (area0.curindex) {
					case 0: return true; break;
                    case 1: window.location.href = "program_tvpart_choose.jsp?typeid=<%=typeId%>&ptypeid=<%=parent_typeId%>&returnurl="+escape(returnurl); return true; break;  
                    case 2: if(!isfaved){
							$("ctrframe").src = "datajsp/space_collectAdd_iframedata.jsp?PROGID="+jsonmediaInfo.VODID+"&PROGTYPE="+jsonmediaInfo.CONTENTTYPE;				
							isdofav();						
							}else{
							$("ctrframe").src = "datajsp/space_collectDel_iframedata.jsp?PROGID="+jsonmediaInfo.VODID+"&PROGTYPE="+jsonmediaInfo.CONTENTTYPE;
							dodelfav();
						}
						break;
                    case 3: pageobj.popups[0].showme(); return true; break;		
                }
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
			if(area0.doms[2]!=undefined)
			area0.doms[2].updatecontent(isfaved?"移除收藏":"收  &nbsp;&nbsp;  藏");
    		pageobj.backurl = returnurl;
			
			 //内容绑定			 
			Bindcontent();
			setListData(jAbouttypes);
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
    </script>