var list;
var now_page;
var allpage;
var benginum=0;
var up_row;
var up_col;
var listcount;
var row=2;
var col=1;
var listcount;
function givechannelid()
{
	up_row=getrequest("row");
	up_col=getrequest("col");
	getallchannel(lu_id);
}
function getchannelInfo(info)
{
	list=info;
	listcount=list.length;
	now_page=1;
	allpage=Math.ceil(info.length/8);
	infoshow(0,8);
}
function imgblock()
{
	document.getElementById("info").style.display="block";
}
function infoshow(num,endnum)
{	var j=1;
	document.getElementById("allpage").innerHTML=now_page+"/"+allpage;
	benginum=num;
	for(var i=num;i<endnum;i++)
	{
		if((num+j)<=listcount)
		{
			 document.getElementById("kxbg_"+j).style.visibility="visible";
			document.getElementById("img_"+j).style.visibility="visible";
			document.getElementById("kx_"+j).style.visibility="visible";
			document.getElementById("img_"+j).src="../../"+list[i].POSTPATH1;
		}
		else
		{
			  document.getElementById("kxbg_"+j).style.visibility="hidden";
			 document.getElementById("img_"+j).style.visibility="hidden";
                        document.getElementById("kx_"+j).style.visibility="hidden";

		}
		j++;
	}
	buttonchange(getbuttonrowid(row));
	imgblock();
}
function pageup()
{

	if(now_page<=allpage&&now_page>1)
	{
		now_page--;
		var num=now_page*8;
		infoshow(num-8,num);
	}
}
function pagedown()
{
	if(now_page<allpage)
	{
		var num=now_page*8;
		now_page++;
		if(row!=1&&row!=4)
		{
			row=2;
			col=1;
		}
		infoshow(num,num+8);
		
	}
}
function keyPress(keyval)
{
	switch(keyval)
	{
		case KEY_DOWN:
		case DOWN:
		if(row<4)
		{
			if(now_page!=allpage)
			{
				row++;
			}
			else
			{
				if(row==2)
				{
					if((listcount-((now_page-1)*8))>4)
					{
						row=3;
						col=1;
					}
					else
					{
						row=4;
						col=2;
					}
				}
				 else
                                {
                                          row++;
                                          col=2;
                                }
			}
			if(row==2||row==4)
			{
				col=3;
			}
			buttonchange(getbuttonrowid(row));
		}
		break;
		case KEY_UP:
		case UP:
		if(row>1)
		{
			if(now_page!=allpage)
			{
				row--;
			}
			else
			{
				if(row==4)
				{
					 if((listcount-((now_page-1)*8))>4)
					{
						row=3;
						col=1;
					}
					else
					{
						row=2;
						col=1;	
					}
				}
				else
				{
					row--;
				}
			}
			if(row==1)
			{
				col=2;			
			}
			buttonchange(getbuttonrowid(row));
		}
		break;
		case KEY_RIGHT:
		case RIGHT:
		if(row==1&&col<2)
		{
			col++;
		}else if(row==4&&col<3)
		{
			col++;
		}else if(row!=1&&row!=4&&col<4)
		{
			if(now_page!=allpage)
			{
				col++;
			}
			else
			{
				var curnum=(row-2)*4+col;
				var compnum=listcount-((now_page-1)*8);
				if(curnum<compnum)
				{
					col++;
				}
			}
			
		}
		buttonchange(getbuttonrowid(row));
		break;
		case KEY_LEFT:
		case LEFT:
		if(col>1)
		{
			col--;
		}
		 buttonchange(getbuttonrowid(row));

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
		window.location.href="index.html?row="+up_row+"&col="+up_col;
		break;
	}
}

function getbuttonrowid(r)
{
    var id;
	
	switch(col)
	{
	case 1:
	switch(row)
	{
		case 1:
		id="page_u";
		break;
		case 2:
		id="kx_1";
		break;
		case 3:
		id="kx_5";
		break;
		case 4:
		id="back";
		break;
		
	}
	break;
	case 2:
	switch(row)
	{
		case 1:
		id="page_d";
		break;
		case 2:
		id="kx_2";
		break;
		case 3:
		id="kx_6";
		break;
		case 4:
		id="page_up";
		break;
		
	}
	break;
	case 3:
	switch(row)
	{
		
		case 2:
		id="kx_3";
		break;
		case 3:
		id="kx_7";
		break;
		case 4:
		id="page_down";
		break;
	}
	break;
	case 4:
	switch(row)
	{
		
		case 2:
		id="kx_4";
		break;
		case 3:
		id="kx_8";
		break;
	}
	break;
	}
	return id;
}

function buttonback()
{
	document.getElementById("kx_1").style.background="url('images/paper.png')";
	document.getElementById("kx_2").style.background="url('images/paper.png')";
	document.getElementById("kx_3").style.background="url('images/paper.png')";
	document.getElementById("kx_4").style.background="url('images/paper.png')";
	document.getElementById("kx_5").style.background="url('images/paper.png')";
	document.getElementById("kx_6").style.background="url('images/paper.png')";
	document.getElementById("kx_7").style.background="url('images/paper.png')";
	document.getElementById("kx_8").style.background="url('images/paper.png')";
	document.getElementById("page_u").style.background="url('images/pagebtn.png')";
	document.getElementById("page_up").style.background="url('images/pagebtn.png')";
	document.getElementById("page_d").style.background="url('images/pagebtn.png')";
	document.getElementById("page_down").style.background="url('images/pagebtn.png')";
	document.getElementById("index").style.background="url('images/ha_index.png')";
}	
function buttonchange(id)
{
	buttonback();
	switch(id)
	{
		
		case "kx_1":
		document.getElementById("kx_1").style.background="url('images/posters_sel.png')";
		break;
		case "kx_2":
		document.getElementById("kx_2").style.background="url('images/posters_sel.png')";
		break;
		case "kx_3":
		document.getElementById("kx_3").style.background="url('images/posters_sel.png')";
		break;
		case "kx_4":
		document.getElementById("kx_4").style.background="url('images/posters_sel.png')";
		break;
		case "kx_5":
		document.getElementById("kx_5").style.background="url('images/posters_sel.png')";
		break;
		case "kx_6":
		document.getElementById("kx_6").style.background="url('images/posters_sel.png')";
		break;
		case "kx_7":
		document.getElementById("kx_7").style.background="url('images/posters_sel.png')";
		break;
		case "kx_8":
		document.getElementById("kx_8").style.background="url('images/posters_sel.png')";
		break;
		case "page_u":
		document.getElementById("page_u").style.background="url('images/pagebtn_sel.png')";
		break;
		case "page_d":
		document.getElementById("page_d").style.background="url('images/pagebtn_sel.png')";
		break;
		case "page_up":
		document.getElementById("page_up").style.background="url('images/pagebtn_sel.png')";
		break;
		case "page_down":
		document.getElementById("page_down").style.background="url('images/pagebtn_sel.png')";
		break;
		case "back":
		document.getElementById("index").style.background="url('images/ha_index_sel.png')";
		break;
		
	}
}
