<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="datajsp/package_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<html>
<head>
<script language="javascript" type="text/javascript" src="js/pagecontrol.js"></script>
<script language="javascript" type="text/javascript">
 var scrollText = "套餐";
 var pagecount=1;
 var isdetail=false;
 function loadData()
	{
	   loadChannel();
	   getdata(packageList,pagecount);
	 
   
    }
   	function getdata(data,count)
	{		 
	 
	   area1.setpageturndata(data.length,parseInt(count));
	   for(var i=0;i<area1.doms.length;i++)
	   { 
		   if(i<data.length)
		   {   
		      area1.doms[i].imgdom=$("area1_list_img"+i);
	          area1.doms[i].contentdom=$("area1_list_text"+i);
			  area1.doms[i].updateimg(data[i].packageObjimg);
			  area1.doms[i].updatecontent(data[i].packageObjtype);
			 // area1.doms[i].mylink="package_intro.jsp?packageBack="+escape(data[i].packageObjback) +"&packageid="+data[i].packageObjId+"&isorder=" +data[i].packageObjorder +"&returnurl="+escape("package.jsp?curpage="+area1.curpage+"&areaid=1"+"&indexid="+i);
			  area1.doms[i].domOkEvent=function(){
				   isdetail=true;
				   $("dibblist").style.display="none";
				   $("pagearea").style.display="none";
				   $("dibbdetail").style.display="block";
				 
				   $("imgdibbdetail").src=packageBackimgList[area1.curindex];
			 }
			  document.getElementById('area1_list_'+i).style.display = "";
		   }
		   else
			{    
			    area1.doms[i].imgdom=$("area1_list_img"+i);
	            area1.doms[i].contentdom=$("area1_list_text"+i);
			    area1.doms[i].updatecontent("");
				area1.doms[i].updateimg("images/temp/dot.gif");
				area1.doms[i].mylink="";
				document.getElementById('area1_list_'+i).style.display = "none";
			}
		 }
		 area1.lockin=false;
		 $("pagearea").innerHTML=area1.curpage+"/"+count;
		 if(area1.curpage==1) {$("pageup").src="images/up_gray.png";} else {$("pageup").src="images/up.png";}
		 if(area1.curpage==count) {$("pagedown").src="images/down_gray.png";} else {$("pagedown").src="images/down.png";}
     }
	
	 function loadChannel() {
	    area0 = AreaCreator(10, 1, new Array(-1, -1, -1, 1), "area0_list_", "className:menuli on", "className:menuli");
        area0.setstaystyle("className:menuli current", 3);
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
		
		area1 = AreaCreator(3, 1, new Array(-1,0, -1, -1), "area1_list_", "className:bgon", "className:bg");
	    area1.setcrossturnpage();
	   
	     
	    pageobj = new PageObj(areaid, indexid, new Array(area0, area1),null);
	    pageobj.goBackEvent=function()
	    {
			if(isdetail==true){
				 isdetail=false;
				 $("dibblist").style.display="block";
				 $("pagearea").style.display="block";
				 $("dibbdetail").style.display="none";
			}else{
			location.href="index.jsp";
			}
		    //this.changefocus(0,7);
	    }
}
</script>
</head>
</html>