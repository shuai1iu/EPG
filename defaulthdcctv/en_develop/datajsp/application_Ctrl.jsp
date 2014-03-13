<!-- 文件名：self_AppList_Ctrl.jsp -->
<!-- 描  述：应用页面控制层 -->
<!-- 修改人：wangss -->
<!-- 修改时间：2010-8-9-->
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="keyboard/keydefine.jsp"%>
<%@ include file = "OneKeySwitch.jsp"%>
<%@ include file="datajsp/application_Data.jsp"%>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">
var area0;
var area1;
document.onkeydown = keyDown;
document.onkeypress = keyDown;
 function keyDown() {
    var key_code = event.keyCode;
    switch (key_code) {
		case KEY_0:
		case KEY_1:
		case KEY_2:
		case KEY_3:
		case KEY_4:
		case KEY_5:
		case KEY_6:
		case KEY_7:
		case KEY_8:
		case KEY_9:
			break
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
        case KEY_BACK://
		    setDefaultCookie1("applist");	
            break;
		case KEY_PAGEUP:
		    area1.pageturn(-1);//焦点变为灰色
           break;
		case KEY_PAGEDOWN:
		    area1.pageturn(1);
		    break;
		default:
		  break;			
    }
    return 0;
}

   var pageobj;
   window.onload=function()
   {  
       var mycookie=getCookie("applist");
	    area0=AreaCreator(9,1,new Array(-1,-1,-1,1),"area0_list_","className:menuli on","className:menuli");
	   area0 = AreaCreator(9, 1, new Array(-1, -1, -1, 1), "area0_list_", "className:menuli on", "className:menuli");
       area0.setstaystyle("className:menuli current", 3);
	   area0.setdarknessfocus(5);
	   area0.areaOutingEvent=function()
	    {
		   switch(this.curindex)
		   {
			  case 0:   window.location.href="index.jsp";return true; break;
			  case 1:   window.location.href="channel.jsp";return true; break;
			  case 2:   window.location.href="dibbling.jsp";return true; break;
			  case 3:   window.location.href="playback.jsp";return true; break;
			  case 4:   window.location.href="local.jsp";return true; break;
			  //case 5:   window.location.href="application.jsp";return true; break;
			  case 6:   window.location.href="package.jsp";return true; break;
			  case 7:   window.location.href="space_collect.jsp";return true; break;
			  case 8:   window.location.href="search.jsp";return true; break;
		   }
	    }
	   area0.doms[0].mylink="index.jsp";
	   area0.doms[1].mylink="channel.jsp";
	   area0.doms[2].mylink="dibbling.jsp";
	   area0.doms[4].mylink="local.jsp";
	   area0.doms[5].mylink="application.jsp";
	   area0.doms[6].mylink="package.jsp";
	   area0.doms[7].mylink="space_collect.jsp";
	   area0.doms[8].mylink="search.jsp";
	   area0.setfocuscircle(0);
	   //定义应用区域
	   area1=AreaCreator(2,3,new Array(-1,0,-1,-1),"app","className:bgon","className:bg");
	   area1.setcrossturnpage();
	   area1.asyngetdata=function()
	   {
			 area1.lockin=true;
			 $('hidden_frame').src="datajsp/application_Dataiframe.jsp?curpage="+area1.curpage;
	   }
	   area1.curpage=!!mycookie[0]?parseInt(mycookie[0]):1;
	   area1.datanum = applist.length;
	   
       getdata(applist,2);
	   
	   pageobj=new PageObj(1,0,new Array(area0,area1),null);
     
	   ///写cookie获取
	   pageobj.pageOkEvent=function()
	   { 
		  if(this.getfocusdom().mylink!=undefined)
		  {
		     saveCookie1("applist",this.areas[this.curareaid].curpage,this.curareaid,this.getfocusindex());
		  }
	   }
  }
 
 


 //数据绑定 为图片和文字绑定内容 
  function getdata(data,count)
  {		
        area1.setpageturndata(data.length,parseInt(count));
		for(var i=0;i<area1.doms.length;i++)
		 {
			 if(i<data.length)
			 { 
			     area1.doms[i].contentdom=$("name"+i);
				 area1.doms[i].imgdom=$("pic"+i);
	  			 area1.doms[i].setcontent("·",data[i].packageObjtype,15);
				 area1.doms[i].mylink="";
				 area1.doms[i].updateimg(data[i].packageObjimg);
				 document.getElementById('app'+i).style.display = "";
			 }
			 else
			 { 
			     area1.doms[i].contentdom=$("name"+i);
				 area1.doms[i].imgdom=$("pic"+i);  
			     area1.doms[i].updatecontent("");
				 area1.doms[i].updateimg("images/temp/dot.gif");
				 area1.doms[i].mylink="";
				  document.getElementById('app'+i).style.display = "none";
			 }
		 }
		 $('pageNum').innerHTML=area1.curpage+"/"+count;
		 area1.lockin=false;
		 if(area1.curpage==1) {$("pageup").src="images/up_gray.png";} else {$("pageup").src="images/up.png";}
		 if(area1.curpage==count) {$("pagedown").src="images/down_gray.png";} else {$("pagedown").src="images/down.png";}
	 }


</script>