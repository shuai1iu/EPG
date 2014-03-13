var list;
var now_page;
var allpage;
var benginum;
var up_row;
var up_col;
var listcount;
function givechannelid()
{
	up_row=getrequest("row");
	up_col=getrequest("col");
	getallchannel(lu_id);
}
function getchannelInfo(info)
{
	var j=1;
	list=info;
	listcount=list.length;
	 document.getElementById("allpage").innerHTML=listcount;
	if(listcount>8)
	{
	now_page=1;
	allpage=Math.ceil(info.length/8);
	infoshow(0,8);
	}else
	{
		benginum=0;
		for(var i=0;i<8;i++)
        	{		        
                  	if(i<listcount)
			{
				document.getElementById("img_"+j).src="../../"+list[i].POSTPATH1;
			}else
			{
			document.getElementById("bg_"+j).style.display="none";
			}	
               		 j++;
        	}
		allpage=1;
		nowpage=1;
		document.getElementById("allpage").innerHTML="1/1";
		imgblock();
	}
}
function imgblock()
{
	document.getElementById("info").style.display="block";
}
function infoshow(num,endnum)
{	
	var j=1;
	//document.getElementById("allpage").innerHTML=now_page+"/"+allpage;
	benginum=num;
	for(var i=num;i<endnum;i++)
	{
		document.getElementById("img_"+j).src="../../"+list[i].POSTPATH1;
		j++;
	}
	/*var nonecount=8-(listcount-1-num);
	if(nonecount>0)
	{
		for
	}*/
	buttonchange(getbuttonrowid(row));
	imgblock();
}
function pageup()
{

	if(now_page<=allpage&&now_page>1)
	{
		row=2;
		col=1;
		now_page--;
		var num=now_page*8;
		infoshow(num-8,num);
	}
}
function pagedown()
{
	
	if(now_page<allpage)
	{
		row=2;
		col=1;
		var num=now_page*8;
		//var endnum=listcount-1-num;
		now_page++;
		/*if(endnum>8)
		{
			infoshow(num,num+8);
		}
		else
		{
			infoshow(num,endnum);
		}*/
	}
}
var up=false;
var down=false;
var left=false;
var right=false;
function keyPress(keyval)
{
	up=false;
	down=false;	
	left=false;
	right=false;
    //alert(keyval);
	switch(keyval)
	{
		case KEY_DOWN:
		case DOWN:
		down=true;
		if(row==3)
		{
			col=1;
			row++;
			blockornone(getbuttonrowid(row));
		}
		else if(row>=0&&row<5)
		{
			row++;
			blockornone(getbuttonrowid(row));
		}	
		break;
		case KEY_UP:
		case UP:
		up=true;
		if(row>=2&&row<6)
		{
			row--;
			blockornone(getbuttonrowid(row));
		}
		break;
		case KEY_RIGHT:
		case RIGHT:
		right=true;
		if(row>1&&row<4&&col<row_length)
		{
			col++;
			blockornone(getbuttonrowid(row));
		}else if(row==1&&col<row_length||row==4&&col<row_length)
		{
			col=2;
			blockornone(getbuttonrowid(row));
		}
		break;
		case KEY_LEFT:
		case LEFT:
		left=true;
		// document.getElementById("allpage").innerHTML=row+"#"+col+"#"+row_length;
		if(row>0&&col<=row_length&&col>1)
		{
		 document.getElementById("allpage").innerHTML=row+"#"+col+"#"+row_length;

			col--;
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
		window.location.href="index.html?row="+up_row+"&col="+up_col;
		break;
	}
}
function blockornone(lbid)
{
        if(document.getElementById(lbid).style.display=="none"&&up==true)
        {
                col=2;
                row=1;
                buttonchange(getbuttonrowid(row));
        }else if(document.getElementById(lbid).style.display=="none"&&down==true)
        {
		col=1;
		row=4;
                 buttonchange(getbuttonrowid(row));
        }else if(document.getElementById(lbid).style.display=="none"&&left==true)
        {
		col=2;
                row=1;
                buttonchange(getbuttonrowid(row));
        }else if(document.getElementById(lbid).style.display=="none"&&right==true)
        {
                col=2;
                row=2;
                buttonchange(getbuttonrowid(row));
        }else
        {
                 buttonchange(getbuttonrowid(row));
        }

}	
var row_length=0;

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
		row_length=2;
		break;
		case 2:
		id="kx_1";
		row_length=4;
		break;
		case 3:
		id="kx_5";
		row_length=4;
		break;
		case 4:
		row_length=3;
		id="back";
		//id="page_up";
		break;
		//case 5:
		//row_length=1;
		//id="back";
		//break;
		
	}
	break;
	case 2:
	switch(row)
	{
		case 1:
		id="page_d";
		row_length=2;
		break;
		case 2:
		id="kx_2";
		row_length=4;
		break;
		case 3:
		id="kx_6";
		row_length=4;
		break;
		case 4:
		row_length=3;
		id="page_up";
		break;
		//case 5:
		//row_length=1;
		//id="back";
		//break;
		
	}
	break;
	case 3:
	switch(row)
	{
		
		case 2:
		id="kx_3";
		row_length=4;
		break;
		case 3:
		id="kx_7";
		row_length=4;
		break;
		case 5:
		row_length=3;
		id="page_down";
		//id="back";
		break;
	}
	break;
	case 4:
	switch(row)
	{
		
		case 2:
		id="kx_4";
		row_length=4;
		break;
		case 3:
		id="kx_8";
		row_length=4;
		break;
		case 5:
		row_length=1;
		id="page_down";
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
var row=2;
var col=1;
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
		if(allpage==1&&down==true)
		{
		row++;col=1;
		buttonchange(getbuttonrowid(col));
		}else if(allpage==1&&up==true)
		{
		row=2;col=1;
                buttonchange(getbuttonrowid(col));
		}
		else
		{
		if(now_page==1)
		{
		col=2;
		document.getElementById("page_d").style.background="url('images/pagebtn_sel.png')";
		}else
		{
		document.getElementById("page_u").style.background="url('images/pagebtn_sel.png')";
		}
		}
		break;
		case "page_d":
		if(allpage==1&&down==true)
                {
                row++;col=1;
                buttonchange(getbuttonrowid(col));
                }else if(allpage==1&&up==true)
                {
                row=2;col=1;
                buttonchange(getbuttonrowid(col));
                }
		else
		{
		if(now_page==allpage)
		{
		col=1;
		document.getElementById("page_u").style.background="url('images/pagebtn_sel.png')";
		}else
		{
		document.getElementById("page_d").style.background="url('images/pagebtn_sel.png')";
		}
		}
		break;
		case "page_up":
		if(allpage==1&&down==true)
                {
                row++;col=1;
                buttonchange(getbuttonrowid(col));
                }else if(allpage==1&&up==true)
                {
                row=2;col=1;
                buttonchange(getbuttonrowid(col));
                }

		else
		{
		if(now_page==1)
		{
		col=2;
		document.getElementById("page_down").style.background="url('images/pagebtn_sel.png')";
		}else
		{
		document.getElementById("page_up").style.background="url('images/pagebtn_sel.png')";
		}
		}
		break;
		case "page_down":
		if(allpage==1&&down==true)
                {
                row++;col=1;
                buttonchange(getbuttonrowid(col));
                }else if(allpage==1&&up==true)
                {
                row=2;col=1;
                buttonchange(getbuttonrowid(col));
                }

		else
		{
		if(now_page==allpage)
		{
		col=1;
		document.getElementById("page_up").style.background="url('images/pagebtn_sel.png')";
		}else
		{
		document.getElementById("page_down").style.background="url('images/pagebtn_sel.png')";
		}
		}
		break;
		case "back":
		document.getElementById("index").style.background="url('images/ha_index_sel.png')";
		break;
		
	}
}
