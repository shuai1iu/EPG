var list;
var now_page=0;
var allpage;
var typeid;
var urls;
var now_play=1;
var row=1;
var col=2;
var listcount=0;//date count
var timercode;//setInterval 
var network=0;//1:net is work 0:net is stop
function givechannelid()
{
	typeid=getrequest("typeid");
	urls=getrequest("imgurl");
	if(typeid!=0)
	{
	getallqi(typeid);
	}else
	{
	getallchannel(lu_id);
	}
}
function getchannelInfo(info)
{
	list=info;
	listcount=list.length;
	allpage=Math.ceil(listcount/8);
	if(getrequest("nowpage")!=undefined)
	{
	now_page=getrequest("nowpage");
	}
	var nums=now_page*8;
	
	if(nums==0)
	{
	now_page=1;
	 infoshow(0,8)
	number=0;
	}else 
	{
		infoshow(nums-8,nums);
		number=nums-8;
	}
	 if(!typeid)
	{
	document.getElementById("song_"+now_play).style.background="url('images/list_sel.png')";
	setTimeout(function(){
	playPage.location.href="../PlayTrailerInVas.jsp?left=34&top=80&width=216&height=182&type=VOD&value="+list[number].VODID+"&mediacode="+list[number].VODID+"&contenttype=1";
	changevideo(number);
        },3000);
	}else
	{
	document.getElementById("l_img").src=urls;
	}
	document.getElementById("info").style.visibility="visible";
}
var number=0;
function changevideo(num)
{
	number=parseInt(num);
	timercode=setInterval(function(){
	var curtm=playPage.mp.getCurrentPlayTime();
	var finishtm=playPage.mp.getMediaDuration()-2;
	if(curtm<10)
	{
	network=1;
	}
	//document.getElementById("allpage").innerHTML=curtm+"$"+finishtm;
	if(curtm>finishtm&&finishtm>0&&network==1)
	{
		network=0;
		document.getElementById("song_"+now_play).style.background="url('image/list_se')";
		if(now_play==8)
		{
		number=number-7;
		now_play=1;
		}else
		{
		number++;
		now_play++;
		}
		if(row!=9)
		{
		document.getElementById("song_"+row).style.background="url('images/listsel.png')";
		}
		document.getElementById("song_"+now_play).style.background="url('images/list_sel.png')";
	 	playPage.location.href="../PlayTrailerInVas.jsp?left=34&top=80&width=216&height=182&type=VOD&value="+list[number].VODID+"&mediacode="+list[number].VODID+"&contenttype=1";
	window.clearInterval(timercode);
	changevideo(number);
	}
	},1000);
}
var allvalue=[];	
function infoshow(num,endnum)
{	var j=1;
	document.getElementById("allpage").innerHTML=now_page+"/"+allpage;
	for(var i=num;i<endnum;i++)
	{	
		if(((now_page-1)*8+j)<=listcount)
		{	
			document.getElementById("song_"+j).style.visibility="visible";
			 document.getElementById("text_"+j).style.visibility="visible";
			if(typeid!=0&&typeid)
			{
				allvalue[j-1]=list[i].PROGRAMNAME;
				if(list[i].PROGRAMNAME.length>12)
				{	
				document.getElementById("text_"+j).innerHTML=list[i].PROGRAMNAME.substring(0,12)+"..." ;
				}else
				{
			 	document.getElementById("text_"+j).innerHTML=list[i].PROGRAMNAME ;
				}
			}else
			{
				allvalue[j-1]=list[i].VODNAME;
			 	if(list[i].VODNAME.length>12)
                        	{
                        	document.getElementById("text_"+j).innerHTML=list[i].VODNAME.substring(0,12)+"..." ;
                        	}else
                        	{
                         	document.getElementById("text_"+j).innerHTML=list[i].VODNAME ;
                        	}
		
			}
		}
		else
		{
			document.getElementById("song_"+j).style.visibility="hidden";
			document.getElementById("text_"+j).style.visibility="hidden";
		}
		j++;
		
	}
	/*var p=parseInt(getrequest("positons"));
	if(p!=0||p)
	{
	col=2;
	row=p;
	}*/
	if(row!=9)
	{
	textmove(row);
	}
}
function pageup()
{

	if(now_page<=allpage&&now_page>1)
	{
		if(row!=9)
		{
		 document.getElementById("song_"+row).style.background="url('')";
		}
		now_page--;
		var num=now_page*8;
		document.getElementById("song_"+now_play).style.background="url('')";
		now_play=1;
		if(row!=9)
                {col=2;
                row=1;
                }
                document.getElementById("song_"+now_play).style.background="url('images/list_sel.png')";
                changevideo(num-8);
		infoshow(num-8,num);
		playPage.location.href="../PlayTrailerInVas.jsp?left=34&top=80&width=216&height=182&type=VOD&value="+list[num-8].VODID+"&mediacode="+list[num-8].VODID+"&contenttype=1";
	}
}
function pagedown()
{
	if(now_page<allpage)
	{
		if(row!=9)
		{
		 document.getElementById("song_"+row).style.background="url('')";
		}
		now_page++;
		var num=now_page*8;
		document.getElementById("song_"+now_play).style.background="url('')";
		now_play=1;
                document.getElementById("song_"+now_play).style.background="url('images/list_sel.png')";
		if(row!=9)
		{col=2;
		row=1;
		}
                changevideo(num-8);
		infoshow(num-8,num);
		playPage.location.href="../PlayTrailerInVas.jsp?left=34&top=80&width=216&height=182&type=VOD&value="+list[num-8].VODID+"&mediacode="+list[num-8].VODID+"&contenttype=1";
	}
}
function keyPress(keyval)
{
	
    //alert(keyval);
	switch(keyval)
	{
		case KEY_DOWN:
		case DOWN:
		if(col==1&&row!=9)
		{
			document.getElementById("up").style.visibility="hidden";
       		 	document.getElementById("down").style.visibility="hidden";
        		document.getElementById("left").style.visibility="hidden";
        		document.getElementById("right").style.visibility="hidden";
			row=9;
			document.getElementById("index").style.background="url('images/ha_index_sel.png')";
		}
		else if(col==2&&row<9)
		{
			 if(text.length>12)
                                {
                                        document.getElementById("text_"+row).innerHTML=text.substring(0,12)+"...";
                                }else
                                {
                                        document.getElementById("text_"+row).innerHTML=text;
                                }
			
			document.getElementById("song_"+row).style.background="url('')";
			document.getElementById("song_"+now_play).style.background="url('images/list_sel.png')";
			row++;
			if(((now_page-1)*8+row)>listcount)
			{
				row=9;
			}
			if(row!=9)
			{
				 textmove(row);
			}
			else
			{
			document.getElementById("page_u").style.background="url('images/pagebtn_sel.png')";
			}
		}
		break;
		case KEY_UP:
		case UP:
		if(row>1)
                {
			if(col==2||col==3)
			{
				if(col==2&&row!=9)
				{
					 if(text.length>12)
	                                {
                                        document.getElementById("text_"+row).innerHTML=text.substring(0,12)+"...";
        	                        }else
                	                {
                                        document.getElementById("text_"+row).innerHTML=text;
                        	        }
					 document.getElementById("song_"+row).style.background="url('')";
				}
				else
				{
				col=2;
				document.getElementById("page_u").style.background="url('images/pagebtn.png')";
        			document.getElementById("page_d").style.background="url('images/pagebtn.png')";
				}
				if((now_page*8>listcount)&&row==9)
				{
					row=listcount-((now_page-1)*8);
				}
				else
				{
					row--;
				}
				textmove(row);
			}
			else
			{
				document.getElementById("index").style.background="url('images/ha_index.png')";
                		row=1;
				document.getElementById("up").style.visibility="visible";
				document.getElementById("down").style.visibility="visible";		
				document.getElementById("left").style.visibility="visible";
				document.getElementById("right").style.visibility="visible";
			}
                }
		break;
		case KEY_RIGHT:
		case RIGHT:
		switch(col)
		{
			case 1:
			col++;
			if(row==1)
			{
				 document.getElementById("up").style.visibility="hidden";
                        document.getElementById("down").style.visibility="hidden";
                        document.getElementById("left").style.visibility="hidden";
                        document.getElementById("right").style.visibility="hidden";
				textmove(row);	
			}
			else
			{
				document.getElementById("index").style.background="url('images/ha_index.png')";
				document.getElementById("page_u").style.background="url('images/pagebtn_sel.png')";	
			}
			break;
			case 2:
			if(row==9)
			{
				col++;
				document.getElementById("page_u").style.background="url('images/pagebtn.png')";
        			document.getElementById("page_d").style.background="url('images/pagebtn_sel.png')";
			}
			break;
		}
		//buttonchange(getbuttonrowid());
			
		break;
		case KEY_LEFT:
		case LEFT:
		switch(col)
		{
			case 2:
			if(row==9)
			{
				document.getElementById("page_u").style.background="url('images/pagebtn.png')";
				document.getElementById("index").style.background="url('images/ha_index_sel.png')";
			}
			else
			{
				if(text.length>12)
                                {
                                        document.getElementById("text_"+row).innerHTML=text.substring(0,12)+"...";
                                }else
                                {
                                        document.getElementById("text_"+row).innerHTML=text;
                                }
				 document.getElementById("song_"+row).style.background="url('')";
				document.getElementById("song_"+now_play).style.background="url('images/list_sel.png')";
				 document.getElementById("up").style.visibility="visible";
                                document.getElementById("down").style.visibility="visible";
                                document.getElementById("left").style.visibility="visible";
                                document.getElementById("right").style.visibility="visible";

				row=1;
			}
			col--;
			break;
			case 3:
			if(row==9)
			{
			col--;
			document.getElementById("page_u").style.background="url('images/pagebtn_sel.png')";
                        document.getElementById("page_d").style.background="url('images/pagebtn.png')";
			}
			break;
		}

                 //buttonchange(getbuttonrowid());
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
                window.location.href="index.html?row=3&col=1";
		break;
	}
}
var text="";
function textmove(num)
{
        var value=document.getElementById("text_"+num);
	if(value.innerHTML.length>12)
	{
		text=allvalue[num-1];
		value.innerHTML="<marquee behavior=scroll>"+text+"</marquee>";
		
	}
	else
	{
		text=allvalue[num-1];
	}
	if(!typeid)
	{
	document.getElementById("song_"+now_play).style.background="url('images/list_sel.png')";
	}
	document.getElementById("song_"+num).style.background="url('images/listsel.png')";
	
}
