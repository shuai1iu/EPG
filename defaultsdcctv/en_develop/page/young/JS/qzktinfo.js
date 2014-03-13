var list;
var now_page=0;
var allpage;
var typeid;
var urls;
var now_play=1;
var row=1;
var col=2;
var listcount=0;//date count 
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
	}else 
	{
		infoshow(nums-8,nums);
	}
	document.getElementById("l_img").src=urls;
	document.getElementById("info").style.display="block";
}
var number=0;
var allvalue=[];	
function infoshow(num,endnum)
{	var j=1;
	document.getElementById("allpage").innerHTML=now_page+"/"+allpage;
	for(var i=num;i<endnum;i++)
	{	
		if(((now_page-1)*8+j)<=listcount)
		{	
			document.getElementById("song_"+j).style.display="block";
			 document.getElementById("text_"+j).style.display="block";
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
			document.getElementById("song_"+j).style.display="none";
			document.getElementById("text_"+j).style.display="none";
		}
		j++;
		
	}
	/*var p=parseInt(getrequest("positons"));
	if(p!=0||p)
	{
	col=2;
	row=p;
	}*/
	buttonchange(getbuttonrowid());
}
function pageup()
{

	if(now_page<=allpage&&now_page>1)
	{
		now_page--;
		var num=now_page*8;
		 if(row!=9)
                {
                row=1;
                col=2;
                }
		infoshow(num-8,num);
	}
}
function pagedown()
{
	if(now_page<allpage)
	{
		now_page++;
		var num=now_page*8;
		if(row!=9)
		{
		row=1;
		col=2;
		}
		infoshow(num-8,num);
	}
}
function keyPress(keyval)
{
	
    //alert(keyval);
	switch(keyval)
	{
		case KEY_DOWN:
		case DOWN:
		if(col==2&&row<9)
		{
			 if(text.length>12)
                                {
                                        document.getElementById("text_"+row).innerHTML=text.substring(0,12)+"...";
                                }else
                                {
                                        document.getElementById("text_"+row).innerHTML=text;
                                }
			row++;
			if(((now_page-1)*8+row)>listcount)
			{
				row=9;
			}
			
		}
		 buttonchange(getbuttonrowid());
		break;
		case KEY_UP:
		case UP:
		if(row>1)
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
				}
				if((now_page*8>listcount)&&row==9)
				{
					col=2;
					row=listcount-((now_page-1)*8);
				}
				else
				{
					col=2;
					row--;
				}
				
		        buttonchange(getbuttonrowid());
                }
		break;
		case KEY_RIGHT:
		case RIGHT:
                if(col<3)
        	{
			if(col==2&&row!=9)
			{}
			else
			{	
				col++;
			}
		
		buttonchange(getbuttonrowid());
		}	
		break;
		case KEY_LEFT:
		case LEFT:
		if(col>1)
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
				row=9;
			}
                	col--;
                 buttonchange(getbuttonrowid());
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
                window.location.href="qzkt.html";
		break;
	}
}
function getbuttonrowid()
{
	var id;
	switch(col)
	{
	case 1:
		switch(row)
		{
			case 9:
			id="index";
			break;
		}
	break; 
	case 2:
	switch(row)
	{
	case 1:
	id="song_1";
	break;
	case 2:
	id="song_2";
        break;
	case 3:
	id="song_3";
        break;
	case 4:
	id="song_4";
        break;
	case 5:
	id="song_5";
        break;
	case 6:
	id="song_6";
        break;
	case 7:
	id="song_7";
        break;
	case 8:
	id="song_8";
        break;
	case 9:
	id="page_u";
        break;
	}
	break;
	case 3:
	 switch(row)
        {
        case 9:
        id="page_d";
        break;
        }
	break;
	}
	return id;
}
function buttonback()
{
	/*document.getElementById("up").style.display="none";
        document.getElementById("down").style.display="none";
        document.getElementById("left").style.display="none";
        document.getElementById("right").style.display="none";*/
	document.getElementById("index").style.background="url('images/ha_index.png')";
	//document.getElementById("big_image").style.background="";
	document.getElementById("song_1").style.background="url('image/list_se')";
	document.getElementById("song_2").style.background="url('image/list_se')";
	document.getElementById("song_3").style.background="url('image/list_se')";
	document.getElementById("song_4").style.background="url('image/list_se')";
	document.getElementById("song_5").style.background="url('image/list_se')";
	document.getElementById("song_6").style.background="url('image/list_se')";
	document.getElementById("song_7").style.background="url('image/list_se')";
	document.getElementById("song_8").style.background="url('image/list_se')";
	document.getElementById("page_u").style.background="url('images/pagebtn.png')";
	document.getElementById("page_d").style.background="url('images/pagebtn.png')";

}
function buttonchange(id)
{
	buttonback();
	switch(id)
	{
		case "song_1":
		textmove("1");
		break;
		case "song_2":
		textmove("2");
		break;
		case "song_3":
		textmove("3");
		break;
		case "song_4":
		textmove("4");
		break;
		case "song_5":
		textmove("5");
		break;
		case "song_6":
		textmove("6");
		break;
		case "song_7":
		textmove("7");
		break;
		case "song_8":
		textmove("8");
		break;
		case "index":
		document.getElementById("index").style.background="url('images/ha_index_sel.png')";
		break;
		case "page_u":
		document.getElementById("page_u").style.background="url('images/pagebtn_sel.png')";
		break;
		case "page_d":
		document.getElementById("page_d").style.background="url('images/pagebtn_sel.png')";
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
