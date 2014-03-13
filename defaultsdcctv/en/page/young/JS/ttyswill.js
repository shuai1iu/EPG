var list;
var now_page;
var allpage;
var benginum;
var up_row;
var up_col;
var listcount;
var row=1;
var col=1;
function givechannelid()
{
	up_row=getrequest("row");
	up_col=getrequest("col");
	getallchannel(lu_id);
}
function getchannelInfo(info)
{
	list=info;
	benginum=0;
	for(var i=0;i<8;i++)
    {
		if(i<2)
		{
  		    document.getElementById("img_"+(i+1)).src="../../"+list[i].POSTPATH1;
		}
		else
		{
		    document.getElementById("bg_"+(i+1)).style.display="none";
		}	
    }
		document.getElementById("allpage").innerHTML="1/1";
		document.getElementById("info").style.display="block";
}

function keyPress(keyval)
{
	switch(keyval)
	{
		case KEY_DOWN:
		case DOWN:
		if(row==1)
		{
			row++;
			buttonchange(getbuttonrowid(row));
		}	
		break;
		case KEY_UP:
		case UP:
		if(row==2)
		{
			row--;
			buttonchange(getbuttonrowid(row));
		}
		break;
		case KEY_RIGHT:
		case RIGHT:
		if(row==1&&col==1)
		{
			col++;
			buttonchange(getbuttonrowid(row));
		}
		break;
		case KEY_LEFT:
		case LEFT:
		if(row==1&&col==2)
		{
			col--;
			buttonchange(getbuttonrowid(row));
		}
		break;
		case KEY_ENTER:
		case KEY_OK:
		case ENTER:
		gotowhat();
		break;
		case KEY_PAGEUP:
		break;
		case KEY_PAGEDOWN:
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
		    id="kx_1";
		    break;
		    case 2:
		    id="back";
		    break;
    		
	    }
	break;
	case 2:
	    switch(row)
	    {
		    case 1:
		    id="kx_2";
		    break;
		    case 2:
		    id="back";
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
		case "back":
		document.getElementById("index").style.background="url('images/ha_index_sel.png')";
		break;
		
	}
}
