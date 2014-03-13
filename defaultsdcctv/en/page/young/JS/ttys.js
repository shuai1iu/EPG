var left=false;
var right=false;
var up=false;
var down=false;
var KEY_NUM0=48;
var KEY_NUM1=49;
var KEY_NUM2=50;
var KEY_NUM3=51;
var KEY_NUM4=52;
var KEY_NUM5=53;
var KEY_NUM6=54;
var KEY_NUM7=55;
var KEY_NUM8=56;
var KEY_NUM9=57; 
function keyPress(keyval)
{
   	//alert(keyval);
	left=false;
	right=false;
	up=false;
	down=false;
	switch(keyval)
	{
		case KEY_DOWN:
		case DOWN:
		down=true;
		if(col==1&&row>0&&row<=2)
		{
			row++;
			blockornone(getbuttonrowid(row));
		}else if(col<=7&&col>1&&row>=0&&row<=7)
		{
			row++;
			blockornone(getbuttonrowid(row));		
		}
		
		break;
		case KEY_UP:
		case UP:
		up=true;
		if(col==1&&row<=3&&row>=2)
		{
			row--;
			blockornone(getbuttonrowid(row));
		}else if(col<=7&&col>=2&&row>=2&&row<=8)
		{
			row--;
			blockornone(getbuttonrowid(row));
		}
		
		break;
		case KEY_LEFT:
		case LEFT:
		left=true;
		if(col>=5&&col<=7&&row==1)
		{
			col=4;
			blockornone(getbuttonrowid(row));
		}else  if(col>=3&&col<=7&&row>=2&&row<=7)		
		{
			col--;
			blockornone(getbuttonrowid(row));
		}
		else  if(col>=2&&col<=4&&row==1)		
		{
			col=1;
			 blockornone(getbuttonrowid(row));
		}
		else  if(col>3&&col<=7&&row==8)		
		{
			col=3;
			blockornone(getbuttonrowid(row));
		}
		else  if(col>1&&col<=3&&row==8)		
		{
			col=1;
			row=1;
			blockornone(getbuttonrowid(row));
		}else if(col==2&&row>=0&&row<=3)
		{
			col=1;row=1;
			blockornone(getbuttonrowid(row));		
		}
		else if(col==2&&row>=4&&row<=7)
		{
			row=2;
			col=1;
			blockornone(getbuttonrowid(row));
		}
		break;
		case KEY_RIGHT:
		case RIGHT:
		right=true;
		if(col==1&&row>=0&&row<=3)
		{
		col=2;
		row=2;
		blockornone(getbuttonrowid(row));
		}
		else if(col>1&&col<7&&row>1&&row<=8)
		{
		col++;
		blockornone(getbuttonrowid(row));
		}
		else if(row==8&&col>1&&col<=3)
		{
		col=4;
		blockornone(getbuttonrowid(row));
		}else if(row==1&&col>=2&&col<=4)
		{
		col=5;
		blockornone(getbuttonrowid(row));
		}
		break;
		case KEY_ENTER:
		case KEY_OK:
		case ENTER:
		gotowhat();
		break;
		case KEY_PAGEUP:
		pageup();
		break;
		case KEY_PAGEDOWN:
		pagedown();
		break;
		case KEY_RETURN:
		case KEY_BACKSPACE:
                window.location.href=href;
                break;
	}
}

function getbuttonrowid(r)
{
	var id;
	switch(col)
	{
		case 1:
		switch(r)
		{
			case 1:
			id="index";
			break;
			case 2:
			id="collect";
			break;
			case 3:
			id="return";
			break;
		}
		break;
		case 2:
		switch(r)
		{
			case 1:
			id="num_kuang";
			break;
			case 2:
			id="num";
			num="num1_1";
			break;
			case 3:
			id="num";
			num="num2_1";
			break;
			case 4:
			id="num";
			num="num3_1";
			break;
			case 5:
			id="num";
			num="num4_1";
			break;
			case 6:
			id="num";
			num="num5_1";
			break;
			case 7:
			id="num";
			num="num6_1";
			break;
			case 8:
			id="page_up";
			break;
		}
		break;
		case 3:
		switch(r)
		{
			case 1:
			id="num_kuang";
			break;
			case 2:
			id="num";
			num="num1_2";
			break;
			case 3:
			id="num";
			num="num2_2";
			break;
			case 4:
			id="num";
			num="num3_2";
			break;
			case 5:
			id="num";
			num="num4_2";
			break;
			case 6:
			id="num";
			num="num5_2";
			break;
			case 7:
			id="num";
			num="num6_2";
			break;
			case 8:
			id="page_up";
			break;
		}
		break;
		case 4:
		switch(r)
		{
			case 1:
			id="num_kuang";
			break;
			case 2:
			id="num";
			num="num1_3";
			break;
			case 3:
			id="num";
			num="num2_3";
			break;
			case 4:
			id="num";
			num="num3_3";
			break;
			case 5:
			id="num";
			num="num4_3";
			break;
			case 6:
			id="num";
			num="num5_3";
			break;
			case 7:
			id="num";
			num="num6_3";
			break;
			case 8:
			id="page_up";
			break;
		}
		break;
		case 5:
		switch(r)
		{
			case 1:
			id="enter";
			break;
			case 2:
			id="num";
			num="num1_4";
			break;
			case 3:
			id="num";
			num="num2_4";
			break;
			case 4:
			id="num";
			num="num3_4";
			break;
			case 5:
			id="num";
			num="num4_4";
			break;
			case 6:
			id="num";
			num="num5_4";
			break;
			case 7:
			id="num";
			num="num6_4";
			break;
			case 8:
			id="page_down";
			break;
		}
		break;
		case 6:
		switch(r)
		{
			case 1:
			id="enter";
			break;
			case 2:
			id="num";
			num="num1_5";
			break;
			case 3:
			id="num";
			num="num2_5";
			break;
			case 4:
			id="num";
			num="num3_5";
			break;
			case 5:
			id="num";
			num="num4_5";
			break;
			case 6:
			id="num";
			num="num5_5";
			break;
			case 7:
			id="num";
			num="num6_5";
			break;
			case 8:
			id="page_down";
			break;
		}
		break;
		case 7:
		switch(r)
		{
			case 1:
			id="enter";
			break;
			case 2:
			id="num";
			num="num1_6";
			break;
			case 3:
			id="num";
			num="num2_6";
			break;
			case 4:
			id="num";
			num="num3_6";
			break;
			case 5:
			id="num";
			num="num4_6";
			break;
			case 6:
			id="num";
			num="num5_6";
			break;
			case 7:
			id="num";
			num="num6_6";
			break;
			case 8:
			id="page_down";
			break;
		}
		break;
	}
	return id;
}
var num="";
var num1="";
function buttonback()
{
		document.getElementById("allinfo").style.background="url('images/content_intr_bg.png')";
		//document.getElementById("num_kuang").style.background="url('images/tftv_text_bg.png')";		
		document.getElementById("num_kuang").style.visibility="hidden";
		document.getElementById("num_kuang_hide").style.visibility="visible";
		 document.getElementById("num_value").innerHTML=document.getElementById("num_kuang").value;
		document.getElementById("enter").style.background="url('images/search_btnbg_sel.png')";		
		if(iscollect)
		{
		 document.getElementById("collect").style.background="url('images/cancel_collect_bg.png')";
		}
		else
		{
		document.getElementById("collect").style.background="url('images/collect_bg.png')";		
		}
		document.getElementById("return").style.background="url('images/return_bg_se.png')";	
		document.getElementById("page_up").style.background="url('images/pagebtn.png')";		
		document.getElementById("page_down").style.background="url('images/pagebtn.png')";
		//alert(num);
		if(num1!="")
		{		
		document.getElementById(num1).style.background="url('images/table_se.png')";
		}
		document.getElementById("big_image").style.background="";
		document.getElementById("index").style.background="url('images/ha_index.png')";
		document.getElementById("num_kuang").readOnly=true;
}
var nowpage=1;
var allpage;
var vod;
var nums;
var name; 
 var desc ;
var path;
var lu_id;
var conttype;
var vodid;
var href;
function getlistinfo()
{
	href=getrequest("url");
	vodid=getrequest("vodid");
	conttype=getrequest("contenttype");
	 nums=getrequest("numlist").toString().split(",");
	vod=getrequest("vodlist").toString().split(",");	
	nowpage=getrequest("nowpage");
	lu_id=getrequest("luid");
	buttonchange(getbuttonrowid(row));
	if(nowpage==0)
	{
		nowpage=1;
	}
         path=getrequest("poster");
         name=getrequest("name");
         desc=getrequest("desc");
        document.getElementById("poster").src="../../"+path;
        document.getElementById("name").innerHTML=decodeURI(name);
        document.getElementById("desc").innerHTML=decodeURI(desc).substr(0,50)+"...";
	allpage=Math.floor(nums.length/36)+1;
	if(nowpage==1)
	{
	show(nums);
	}else if(nowpage>1)
	{
		 var end={};
                for(var i=0;i<nums.length;i++)
                {
                        if(nums[i+36])
                        {
                        end[i]=nums[i+36];
                        }
                }

                show(end);
	}
	getCollect();				
}
var quit=false;
function show(much)
{
	quit=false;
	   var a=0;
	   for(var j=1;j<7;j++)
                        {
                                for(var k=1;k<7;k++)
                                {
					if(much[a]==null)
					{
						quit=true;
						break;
					}else
					{
                                         document.getElementById("num"+j+"_"+k).innerHTML=much[a];
                                         
					}
					a++;
                                }
				if(quit)
				{
				break;
				}
				
                        }
	if(much.length==36)
	{
	allpage=1;
	}
	document.getElementById("allpage").innerHTML=nowpage+"/"+allpage;
        // document.getElementById("allpage").innerHTML=much.length;        
	if(much.length<37)
                {

                         r=Math.floor(much.length/6);
                         c1=much.length-r*6;
			c1++;	
			r++;
			var c=c1;
                        for(var w=r;w<7;w++)
                        {
                                for(var e=c;e<7;e++)
                                {
			
                                         document.getElementById("num"+w+"_"+e).innerHTML="";//.style.visibility="hidden";
					// document.getElementById("allpage").innerHTML=document.getElementById("num"+w+"_"+e).style.visibility;

                                }
			c=1;
                        }

                }
		

        
}
var r;
var c1;
function pagedown()
{
	if(nowpage<allpage)
	{
		nowpage++;
		var end=[];
		for(var i=0;i<nums.length-36;i++)
		{
			if(nums[i+36])
			{
			end[i]=nums[i+36];
			}
		}
		row=2;
		col=2;	
		buttonchange(getbuttonrowid(row));
		show(end);		
	}	

}function pageup()
{
        if(nowpage<=allpage&&nowpage>1)
        {
                nowpage--;
		buttonchange(getbuttonrowid(row));
                show(nums);
        }

}

function blockornone(lbid)
{
	//buttonback();
	if(document.getElementById(num).innerHTML==""&&up==true)
	{
		col=2;
		row=2;
		buttonchange(getbuttonrowid(row));
	}else if(document.getElementById(num).innerHTML==""&&down==true)
	{
		if(nowpage==1)
		{
			row=8;
			col=5;
		}else
		{
			row=8;
			col=3;
		}
		 buttonchange(getbuttonrowid(row));
	}else if(document.getElementById(num).innerHTML==""&&left==true){
        }else if(document.getElementById(num).innerHTML==""&&right==true)
        {
		col=2;
                row=2;
                buttonchange(getbuttonrowid(row));
	}else
	{
		 buttonchange(getbuttonrowid(row));
	}
	
}
function changeplay()
{
	var value=document.getElementById("num_kuang").value;
	var page=parseInt(value);
	if(page>0&&page<=nums.length)
	{
	page=page-1;
	window.location.href="../au_PlayFilm.jsp?PROGID="+vod[page]+"&FATHERSERIESID="+vodid+"&CONTENTTYPE=0&BUSINESSTYPE=1&PLAYTYPE=1&returnurl="+escape("young/muchpage.html?numlist="+nums+"&poster="+path+"&name="+name+"&desc="+desc+"&vodlist="+vod+"&nowpage="+nowpage+"&vodid="+vodid+"&contenttype="+conttype+"&url="+href);
        //window.location.href="../vod_turnpager.jsp?vodid="+vod[page]+"&typeid=lu_id&returnurl="+escape("young/muchpage.html?numlist="+nums+"&poster="+path+"&name="+name+"&desc="+desc+"&vodlist="+vod+"&nowpage="+nowpage);
	}
}
var iscollect;
function getCollect()
{
  var req=new XMLHttpRequest();
  req.open("POST","jsp/iscollect.jsp?vodid="+vodid+"&contenttype="+conttype,false);
  req.send(null);
  var s=trim(req.responseText);
  if(s=="true")
  {
	iscollect=true;
	document.getElementById("collect").style.background="url('images/cancel_collect_bg.png')";		
  }else
 {
	iscollect=false;
        document.getElementById("collect").style.background="url('images/collect_bg.png')";
 }
  	buttonchange(getbuttonrowid(row));
}
function CollectPro()
{
	var xmlHttp = new XMLHttpRequest();
        xmlHttp.open("POST", "../datajsp/space_collectAdd_iframedata.jsp?PROGID="+vodid+"&PROGTYPE="+conttype,false);
        xmlHttp.send(null);
        var  info=xmlHttp.responseText;
	document.getElementById("box").style.display="block";
	document.getElementById("boxtext").innerHTML="添加收藏夹成功";
	setTimeout(function()
	{
	document.getElementById("box").style.display="none";
	},3000);
	getCollect();
}
function cancelCollect()
{
	var xmlHttp = new XMLHttpRequest();
        xmlHttp.open("POST", "../datajsp/space_collectDel_iframedata.jsp?PROGID="+vodid+"&PROGTYPE="+conttype,false);
        xmlHttp.send(null);
        var  info=xmlHttp.responseText;
         document.getElementById("box").style.display="block";
        document.getElementById("boxtext").innerHTML="移除收藏夹";
        setTimeout(function()
        {
        document.getElementById("box").style.display="none";
        },3000);
	getCollect();

}	
function trim(str){ 
return str.replace(/(^\s*)|(\s*$)/g, "");
}
function ltrim(str){ 
return str.replace(/(^\s*)/g,"");
}
function rtrim(str){ 
return str.replace(/(\s*$)/g,"");
}	
