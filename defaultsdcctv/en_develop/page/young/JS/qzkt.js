var list;
var now_page;
var allpage;
var col=2;
var row=1;
function givechannelid()
{
	var id="00000100000000090000000000022138";
	buttonchange(getbuttonrowid(row));
	getallchannel(id);
}
function getchannelInfo(info)
{
	list=info;
	now_page=1;
	allpage=Math.floor(info.length/6);
	infoshow(0,6);
}
function infoshow(num,endnum)
{
	document.getElementById("allpage").innerHTML=now_page+"/"+allpage;
	for(var i=num;i<endnum;i++)
	{
		//document.getElementById("text_"+(j)).innerHTML="";
		document.getElementById("text_"+(i+1)).innerHTML=list[i].TYPE_NAME ; 

		document.getElementById("img_"+(i+1)).src="../../"+list[i].PICPATH ; 
		
	}
	buttonchange(getbuttonrowid(row));
}
function imgbock()
{
	document.getElementById("info").style.display="block";
}	
function pageup()
{

	if(now_page<=allpage&&now_page>1)
	{
		row=1;
		col=2;
		now_page--;
		var num=now_page*6;
		infoshow(num-6,num);
	}
}
function pagedown()
{
	
	if(now_page<allpage)
	{
		row=1;
		col=2;
		var num=now_page*6;
		now_page++;
		infoshow(num,num+6);
		
	}
}
function keyPress(keyval)
{
    //alert(keyval);
	switch(keyval)
	{
		case KEY_DOWN:
		case DOWN:
		if(row==3)
		{
			col=1;
			row++;
			buttonchange(getbuttonrowid(row));
		}
		else if(row>=0&&row<5)
		{
			row++;
			buttonchange(getbuttonrowid(row));
		}	
		break;
		case KEY_UP:
		case UP:
		if(row>=2&&row<6)
		{
			row--;
			buttonchange(getbuttonrowid(row));
		}
		break;
		case KEY_RIGHT:
		case RIGHT:
		if(row>1&&row<4&&col<row_length)
		{
			col++;
			buttonchange(getbuttonrowid(col));
		}else if(row==1&&col<row_length||row==4&&col<row_length)
		{
			col=2;
			buttonchange(getbuttonrowid(col));
		}
		break;
		case KEY_LEFT:
		case LEFT:
		if(row>0&&col<=row_length&&col>1)
		{
			col--;
			buttonchange(getbuttonrowid(col));
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
                window.location.href="index.html";
		break;
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
		row_length=3;
		break;
		case 2:
		id="kx_1";
		row_length=3;
		break;
		case 3:
		id="kx_4";
		row_length=3;
		break;
		case 4:
		row_length=3;
		id="page_up";
		break;
		case 5:
		row_length=1;
		id="back";
		break;
		
	}
	break;
	case 2:
	switch(row)
	{
		case 1:
		id="page_d";
		row_length=3;
		break;
		case 2:
		id="kx_2";
		row_length=3;
		break;
		case 3:
		id="kx_5";
		row_length=3;
		break;
		case 4:
		row_length=3;
		id="page_down";
		break;
		case 5:
		row_length=1;
		id="back";
		break;
		
	}
	break;
	case 3:
	switch(row)
	{
		
		case 2:
		id="kx_3";
		row_length=3;
		break;
		case 3:
		id="kx_6";
		row_length=3;
		break;
		
	}
	break;
	}
	return id;
}

function buttonback()
{
	document.getElementById("kx_1").style.background="";
	document.getElementById("kx_2").style.background="";
	document.getElementById("kx_3").style.background="";
	document.getElementById("kx_4").style.background="";
	document.getElementById("kx_5").style.background="";
	document.getElementById("kx_6").style.background="";
	document.getElementById("page_u").style.background="url('images/pagebtn.png')";
	document.getElementById("page_up").style.background="url('images/pagebtn.png')";
	document.getElementById("page_d").style.background="url('images/pagebtn.png')";
	document.getElementById("page_down").style.background="url('images/pagebtn.png')";
}	
function buttonchange(id)
{
	buttonback();
	switch(id)
	{
		
		case "kx_1":
		document.getElementById("kx_1").style.background="url('images/box_sel.png')";
		break;
		case "kx_2":
		document.getElementById("kx_2").style.background="url('images/box_sel.png')";
		break;
		case "kx_3":
		document.getElementById("kx_3").style.background="url('images/box_sel.png')";
		break;
		case "kx_4":
		document.getElementById("kx_4").style.background="url('images/box_sel.png')";
		break;
		case "kx_5":
		document.getElementById("kx_5").style.background="url('images/box_sel.png')";
		break;
		case "kx_6":
		document.getElementById("kx_6").style.background="url('images/box_sel.png')";
		break;
		case "kx_7":
		document.getElementById("kx_7").style.background="url('images/box_sel.png')";
		break;
		case "kx_8":
		document.getElementById("kx_8").style.background="url('images/box_sel.png')";
		break;
		case "page_u":
		if(now_page==1)
		{
		col=2;
		document.getElementById("page_d").style.background="url('images/pagebtn_sel.png')";
		}else
		{
		document.getElementById("page_u").style.background="url('images/pagebtn_sel.png')";
		}
		break;
		case "page_d":
		if(now_page==allpage)
		{
		col=1;
		document.getElementById("page_u").style.background="url('images/pagebtn_sel.png')";
		}
		else
		{
		document.getElementById("page_d").style.background="url('images/pagebtn_sel.png')";
		}
		break;
		case "page_up":
		if(now_page==1)
		{
		col=2;
		document.getElementById("page_down").style.background="url('images/pagebtn_sel.png')";
		}else
		{
		document.getElementById("page_up").style.background="url('images/pagebtn_sel.png')";
		}
		break;
		break;
		case "page_down":
		if(now_page==allpage)
		{
		col=1;
		document.getElementById("page_up").style.background="url('images/pagebtn_sel.png')";
		}
		else
		{
		document.getElementById("page_down").style.background="url('images/pagebtn_sel.png')";
		}
		break;
		case "back":
		document.getElementById("back").style.background="url('images/ha_index_sel.png')";
		break;
		
	}
}
