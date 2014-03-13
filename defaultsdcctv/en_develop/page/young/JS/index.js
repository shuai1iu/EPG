var DOWN=50;
var UP=56;
var LEFT=52;
var RIGHT=54;
var ENTER=13;
var KEY_UP = 38;//0x0026;
var KEY_DOWN = 40;//0x0028;
var KEY_LEFT = 37;//0x0025;
var KEY_RIGHT = 39;//0x0027;
var KEY_PAGEUP = 33;//0x0021;
var KEY_PAGEDOWN = 34;//0x0022;
var KEY_ENTER = 13;//0x000D;
var KEY_OK = 13;//0x000D;
var KEY_RETURN=8;

document.onirkeypress = keyEvent;
document.onkeypress = keyEvent;
document.onkeydown = keyEvent;
function keyEvent()
{
	if (navigator.userAgent.indexOf('Chrome') != -1) {
		var val = event.which || event.keyCode;
		return keyPress(val);
	}
	else if (navigator.userAgent.indexOf('iPanel') != -1) {
		var val = event.which ? event.which : event.keyCode;
        	keyPress(val);
		return 0;
	}
	else{
	//	var val = event.which;
	        var val = event.which ? event.which : event.keyCode;
         	return keyPress(val);
	}
}
function keyPress(keyval)
{
	switch(keyval)
	{
		case KEY_RETURN:
		window.location.href="../index.jsp";
		break; 	
		case KEY_DOWN:
		case DOWN:
		if(row==1&&col>0&&col<7)
		{
			row++;
			col=1;
			buttonchange(getbuttonrowid());
		}else if(col==1&&row>1&&row<7)
		{
			row++;
			buttonchange(getbuttonrowid());
		}
		break;
		case KEY_UP:
		case UP:
		if(row==7&&col>0&&col<4)
		{
			row--;
			col=1;
			buttonchange(getbuttonrowid());
		}else if(col==1&&row>1&&row<8)
		{
			row--;
			buttonchange(getbuttonrowid());
		}
		break;
		case KEY_RIGHT:
		case RIGHT:
		if(row==1&&col>0&&col<7)
		{
			col++;
			buttonchange(getbuttonrowid());
		}else if(col==1&&row>1&&row<8)
		{
			col++;
			row=7;
			buttonchange(getbuttonrowid());
		}else if(col>1&&col<4&&row==7)
		{
			col++;
			buttonchange(getbuttonrowid());
		}
		break;
		case KEY_LEFT:
		case LEFT:
		if(row==1&&col>1&&col<7)
		{
			col--;
			buttonchange(getbuttonrowid());
		}
		/*else if(col==1&&row>1&&row<9)
		{
			//col--;
			row=7;
			buttonchange(getbuttonrowid());
		}*/
		else if(col>1&&col<5&&row==7)
		{
			col--;
			buttonchange(getbuttonrowid());
		}
		break;
		case KEY_ENTER:
		case KEY_OK:
		case ENTER:
		switch(col)
	{
	case 1:
	switch(row)
	{
		case 1:
                if(mp!=undefined)//hxt
              // playPage.mp.stop();
		window.location.href="../play_ControlChannel.jsp?CHANNELNUM=7&COMEFROMFLAG=1&returnurl="+escape("young/index.html?row="+row+"&col="+col);
		//window.location.href="/EPG/jsp/defaultsdcctv/en/page/play_ControlChannel.jsp?CHANNELNUM=7&COMEFROMFLAG=1&returnurl="+escape("/EPG/jsp/defaultgdsd/en/page/young/index.html?row="+row+"&col="+col);
		break;
		case 2:
		window.location.href="kxdh.html?row="+row+"&col="+col;
		break;
		case 3:
		window.location.href="hryy.html?row="+row+"&col="+col;
		break;
		case 4:
		window.location.href="ttys.html?row="+row+"&col="+col;
		break;
		case 5:
		window.location.href="qzkt.html?row="+row+"&col="+col;
		break;
		case 6:
		window.location.href="sezt.html?row="+row+"&col="+col;
                //window.location.href="test.html";

		break;
		case 7:
		window.location.href="bbpp.html?row="+row+"&col="+col;
		break;
	}
	break;
	case 2:
	switch(row)
	{
		case 1:
//playPage.mp.stop();
		window.location.href="/EPG/jsp/defaultsdcctv/en/page/play_ControlChannel.jsp?CHANNELNUM=24&COMEFROMFLAG=1&returnurl="+escape("young/index.html?row="+row+"&col="+col);
		break;
		case 7:
		changepage(0);	
		break;
		
	}
	break;
	case 3:
	switch(row)
	{
		case 1:
//playPage.mp.stop();
		window.location.href="/EPG/jsp/defaultsdcctv/en/page/play_ControlChannel.jsp?CHANNELNUM=59&COMEFROMFLAG=1&returnurl="+escape("young/index.html?row="+row+"&col="+col);
		break;
		case 7:
		changepage(1);
		break;
		
	}
	break;
	case 4:
	switch(row)
	{
		case 1:
//playPage.mp.stop();
		window.location.href="/EPG/jsp/defaultsdcctv/en/page/play_ControlChannel.jsp?CHANNELNUM=60&COMEFROMFLAG=1&returnurl="+escape("young/index.html?row="+row+"&col="+col);
		break;
		case 7:
		changepage(2);
		break;
		
	}
	break;
	case 5:
	switch(row)
	{
		case 1:
//playPage.mp.stop();
		window.location.href="/EPG/jsp/defaultsdcctv/en/page/play_ControlChannel.jsp?CHANNELNUM=61&COMEFROMFLAG=1&returnurl="+escape("young/index.html?row="+row+"&col="+col);	
		break;
		case 2:		
		break;
		
	}
	break;
	case 6:
	switch(row)
	{
		case 1:
//playPage.mp.stop();
		//window.location.href="../play_ControlChannel.jsp?&CHANNELNUM=24&COMEFROMFLAG=1&returnurl=young/index.html?row="+row+"&col="+col;
              window.location.href="/EPG/jsp/defaultsdcctv/en/page/play_ControlChannel.jsp?CHANNELNUM=65&COMEFROMFLAG=1&returnurl="+escape("young/index.html?row="+row+"&col="+col);
		break;
		case 2:		
		break;
		
	}
	break;
	}
		break;
	}
	
return 0;
}
function changepage(id)
{
	var conttype=list[id].CONTENTTYPE;
        if(list[id].SUBVODNUMLIST && list[id].SUBVODNUMLIST!=0)
        {
                var vodid=list[id].VODID;
                var  numlist=list[id].SUBVODNUMLIST;
                var vodlist=list[id].SUBVODIDLIST;
                window.location.href="muchpage.html?numlist="+numlist+"&poster="+list[id].POSTPATH1+"&name="+list[id].VODNAME+"&desc="+list[id].INTRODUCE+"&vodlist="+vodlist+"&luid="+lu_id+"&vodid="+vodid+"&contenttype="+conttype+"&url=index.html";
        }else
        {
		 window.location.href="../au_PlayFilm.jsp?PROGID="+list[id].VODID+"&FATHERSERIESID="+list[id].VODID+"&CONTENTTYPE=0&BUSINESSTYPE=1&PLAYTYPE=1&returnurl="+escape("young/index.html");
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
		case 1:
		id="button_SC";
		break;
		case 2:
		id="button_ha";
		break;
		case 3:
		id="button_fm";
		break;
		case 4:
		id="button_tf";
		break;
		case 5:
		id="button_kc";
		break;
		case 6:
		id="button_cp";
		break;
		case 7:
		id="button_pa";
		break;
	}
	break;
	case 2:
	switch(row)
	{
		case 1:
		id="button_CC";
		break;
		case 7:
		id="film_f";
		
	}
	break;
	case 3:
	switch(row)
	{
		case 1:
		id="button_CCL";
		break;
		case 7:
		id="film_s";
		
	}
	break;
	case 4:
	switch(row)
	{
		case 1:
		id="button_FC";
		break;
		case 7:
		id="film_t";
		
	}
	break;
	case 5:
	switch(row)
	{
		case 1:
		id="button_JC";
		break;
		
		
	}
	break;
	case 6:
	switch(row)
	{
		case 1:
		id="button_OD";
		break;
		
		
	}
	break;
	}
//	alert(id);
	return id;
}
function buttonchange(id)
{
	buttonback();
	switch(id)
	{
		case "button_SC":
		document.getElementById("button_SC").style.background="url('images/shenzhen_childrensel.png')";
		//playPage.mp.joinChannel(7);
		playPage.location.href="/EPG/jsp/defaultsdcctv/en/page/PlayTrailerInVas.jsp?left=250&top=110&width=281&height=197&type=CHAN&value=7&contenttype=1&liveid=7";
		break;
		case "button_CC":
		document.getElementById("button_CC").style.background="url('images/cctv_childrensel.png')";
		//playPage.mp.joinChannel(24);
		playPage.location.href="/EPG/jsp/defaultsdcctv/en/page/PlayTrailerInVas.jsp?left=250&top=110&width=281&height=197&type=CHAN&value=24&contenttype=1&liveid=24";
		break;
		case "button_CCL":
		document.getElementById("button_CCL").style.background="url('images/card_coolsel.png')";
                //playPage.mp.joinChannel(59);
		playPage.location.href="/EPG/jsp/defaultsdcctv/en/page/PlayTrailerInVas.jsp?left=250&top=110&width=281&height=197&type=CHAN&value=59&contenttype=1&liveid=59";		
		break;
		case "button_FC":
		document.getElementById("button_FC").style.background="url('images/fine_cartoonsel.png')";
                //playPage.mp.joinChannel(60);	
		playPage.location.href="/EPG/jsp/defaultsdcctv/en/page/PlayTrailerInVas.jsp?left=250&top=110&width=281&height=197&type=CHAN&value=60&contenttype=1&liveid=60";
		break;
		case "button_JC":
		document.getElementById("button_JC").style.background="url('images/jinying_cartoonsel.png')";
                //playPage.mp.joinChannel(61);
		playPage.location.href="/EPG/jsp/defaultsdcctv/en/page/PlayTrailerInVas.jsp?left=250&top=110&width=281&height=197&type=CHAN&value=61&contenttype=1&liveid=61";		
		break;
		case "button_OD":
		document.getElementById("button_OD").style.background="url('images/optimal_diffusesel.png')";
                playPage.location.href="/EPG/jsp/defaultsdcctv/en/page/PlayTrailerInVas.jsp?left=250&top=110&width=281&height=197&type=CHAN&value=65&contenttype=1&liveid=65";
		break;
		case "button_index":
		document.querySelector("button#button_index").style.background="url('images/card_coolsel.png')";
		break;
		case "button_ha":
		document.getElementById("button_ha").style.background="url('images/Happy_animationsel.png')";
		break;
		case "button_fm":
		document.getElementById("button_fm").style.background="url('images/Flowers_musicsel.png')";
		break;
		case "button_tf":
		document.getElementById("button_tf").style.background="url('images/Tong_film_sel.png')";
		break;
		case "button_kc":
		document.getElementById("button_kc").style.background="url('images/Kiss_classroomsel.png')";
		break;
		case "button_cp":
		document.getElementById("button_cp").style.background="url('images/Children_projectsel.png')";
		break;
		case "button_pa":
		document.getElementById("button_pa").style.background="url('images/photo_album_sel.png')";
		break;
		case "film_f":
		document.getElementById("film_f").style.background="url('images/film_sel.png')";
		break;
		case "film_s":
		document.getElementById("film_s").style.background="url('images/film_sel.png')";
		break;
		case "film_t":
		document.getElementById("film_t").style.background="url('images/film_sel.png')";
		break;
		
	}
}
function buttonback()
{
	document.getElementById("button_OD").style.background="url('images/optimal_diffuse.png')";
	document.getElementById("button_JC").style.background="url('images/jinying_cartoon.png')";
	document.getElementById("button_FC").style.background="url('images/fine_cartoon.png')";
	document.getElementById("button_CCL").style.background="url('images/card_cool.png')";
 	document.getElementById("button_CC").style.background="url('images/cctv_children.png')";
	document.getElementById("button_SC").style.background="url('images/shenzhen_children.png')";
	document.getElementById("button_ha").style.background="url('images/Happy_animation.png')";
	document.getElementById("button_fm").style.background="url('images/Flowers_music.png')";
	document.getElementById("button_tf").style.background="url('images/Tong_film.png')";
	document.getElementById("button_pa").style.background="url('images/photo_album.png')";
	document.getElementById("button_kc").style.background="url('images/Kiss_classroom.png')";
	document.getElementById("button_cp").style.background="url('images/Children_project.png')";
	document.getElementById("film_f").style.background="url('images/film_box.png')";
	document.getElementById("film_s").style.background="url('images/film_box.png')";
	document.getElementById("film_t").style.background="url('images/film_box.png')";
//	document.getElementById("big_image").style.background="";
}
var list;
var _in_ajax = window.ActiveXObject ? new ActiveXObject("Microsoft.XMLHTTP") : new XMLHttpRequest();
function  getchannelplay(id)
{
	var xmlHttp = new XMLHttpRequest();
        xmlHttp.open("POST", "jsp/vodlist.jsp?typeid="+id,false);
//xmlHttp.open("GET", "http://125.88.104.16:8082/EPG/jsp/defaultgdsd/en/page/datajsp/channelasyndata.jsp?channelid=3200",false);	
xmlHttp.setRequestHeader("X-Requested-With", "XMLHttpRequest");
        xmlHttp.send(null);
        if(xmlHttp.readyState == 4){
            var  info=xmlHttp.responseText;
            list =eval('(' + info  + ')');
		if(list){
                channelInfo(list);
            }
        }
/*var url="jsp/vodlist.jsp?typeid="+id;
if (url != undefined && url != null && url != "") {
        var temp = url.split("?"); url = temp[0];
        if (temp.length > 1) { url += "?" + encodeURI(temp[1]); }
    }
    _in_ajax.open("POST", url, false);
    _in_ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
    _in_ajax.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    _in_ajax.send(null);
        if (_in_ajax.readyState == 4)
	{
            if (_in_ajax.status == 200)
		{
		 var  info=xmlHttp.responseText;
           	 list =eval('(' + info  + ')');
               	 if(list){
                	channelInfo(list);
                        
			}
			else
			{
                        getchannelplay(id);
                     	}
                }
	}*/
}
	
function channelInfo(list)
{
	//for(var i=0;i<list.length;i++)
        //{
		if(list.length>=3)
		{
                	document.getElementById("s_image_1").src="../../"+list[0].POSTPATH3;
			 document.getElementById("s_image_2").src="../../"+list[1].POSTPATH3;
			 document.getElementById("s_image_3").src="../../"+list[2].POSTPATH3;
		
		}
		//document.getElementById("s_text_"+(i+1)).innerHTML=list[i].VODNAME;
        //}
}
function getrequest(paras)
{
    var url = window.location+"";
    var paraString=[];
    //alert(url.substring(url.indexOf("?")+1,url.length));
    paraString = url.substring(url.indexOf("?")+1,url.length).split("&");
    var returnValue=0;
    for (var i=0; i<paraString.length; i++)
    {
        var tmp=paraString[i].indexOf("=");

        if(paraString[i].substring(0,tmp)==paras)
        {
            if((tmp+1)!=paraString[i].length)
            {
                //alert(paras);
                returnValue=paraString[i].substring(tmp+1,paraString[i].length);
            }
            //alert((tmp+1)+"!!!"+paraString[i].length);
        }
    }

    return returnValue;
}

