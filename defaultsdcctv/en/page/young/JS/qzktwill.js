var list;
var now_page;
var allpage;
var col=1;
var row=2;
var listcount=0;
var beginum=0;
function givechannelid()
{
	var id="00000100000000090000000000022138";
	getallchannel(id);
}
function getchannelInfo(info)
{
	list=info;
	listcount=list.length;
	now_page=1;
	allpage=Math.ceil(info.length/6);
	infoshow(0,6);
	// document.getElementById("allpage").innerHTML=row+"$"+col;
}

function infoshow(num,endnum)
{       var j=1;
        document.getElementById("allpage").innerHTML=now_page+"/"+allpage;
        beginum=num;
	//document.getElementById("allpage").innerHTML=benginum;
        for(var i=num;i<endnum;i++)
        {
                if((num+j)<=listcount)
                {
                         document.getElementById("kxbg_"+j).style.visibility="visible";
                        document.getElementById("img_"+j).style.visibility="visible";
                        document.getElementById("text_"+j).style.visibility="visible";
                        document.getElementById("text_"+j).innerHTML=list[i].TYPE_NAME ; 
			document.getElementById("img_"+j).src="../../"+list[i].PICPATH ; 
                }
                else
                {
                          document.getElementById("kxbg_"+j).style.visibility="hidden";
                         document.getElementById("img_"+j).style.visibility="hidden";
                        document.getElementById("text_"+j).style.visibility="hidden";

                }
                j++;
        }
        buttonchange(getbuttonrowid(row));
}
function pageup()
{

        if(now_page<=allpage&&now_page>1)
        {
                now_page--;
                var num=now_page*6;
                infoshow(num-6,num);
        }
}
function pagedown()
{
        if(now_page<allpage)
        {
                var num=now_page*6;
                now_page++;
		if(row!=1&&row!=4)
		{	
		row=2;
		col=1;
		}
                infoshow(num,num+6);

        }
}
function imgblock()
{
	document.getElementById("info").style.display="block";
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
				switch(row)
				{
					case 1:
					row=2;
					col=1;
					break;
					case 2:
                                        if((listcount-((now_page-1)*6))>3)
                                        {
                                                row=3;
                                                col=1;
                                        }
                                        else
                                        {
                                                row=4;
                                                col=2;
                                        }
					break;
					case 3:
					row=4;
					col=2;
					break;
				}
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
                                         if((listcount-((now_page-1)*6))>3)
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
                }else if(row!=1&&row!=4&&col<3)
                {
                        if(now_page!=allpage)
                        {
                                col++;
                        }
                        else
                        {
                                var curnum=(row-2)*3+col;
                                var compnum=listcount-((now_page-1)*6);
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
                window.location.href="index.html?row=5&col=1";
                break;
        }
}

function getbuttonrowid(r)
{
    var id;
	switch(row)
	{
	case 1:
	switch(col)
	{
		case 1:
		id="page_u"; 
		break;
		case 2:
		id="page_d";
		break;
	}
	break;
	case 2:
	switch(col)
	{
		case 1:
		id="kx_1";
		break;
		case 2:
		id="kx_2";
		break;
		case 3:
		id="kx_3";
		break;
		
	}
	break;
	case 3:
	switch(col)
	{
		case 1:
		id="kx_4";
		break;
		case 2:
                id="kx_5";
                break;
		case 3:
		id="kx_6";
		break;
		
	}
	break;
	case 4:
	switch(col)
	{
		case 1:
		id="back";
		break;
		case 2:
		id="page_up";
		break;
		case 3:
		id="page_down";
		break;
		
	}
	break;
	}
	return id;
}

function buttonback()
{
	document.getElementById("kx_1").style.background="url('images/box_se.png')";
	document.getElementById("kx_2").style.background="url('images/box_se.png')";
	document.getElementById("kx_3").style.background="url('images/box_se.png')";
	document.getElementById("kx_4").style.background="url('images/box_se.png')";
	document.getElementById("kx_5").style.background="url('images/box_se.png')";
	document.getElementById("kx_6").style.background="url('images/box_se.png')";
	document.getElementById("page_u").style.background="url('images/pagebtn.png')";
	document.getElementById("page_up").style.background="url('images/pagebtn.png')";
	document.getElementById("page_d").style.background="url('images/pagebtn.png')";
	document.getElementById("page_down").style.background="url('images/pagebtn.png')";
	document.getElementById("back").style.background="url('images/ha_index.png')";
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
		document.getElementById("back").style.background="url('images/ha_index_sel.png')";
		break;
		
		
	}
}
