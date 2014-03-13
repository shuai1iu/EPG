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
var KEY_BACKSPACE=8;
function init()
{

//givechannelid();
buttonchange(getbuttonrowid(row));
//getlistinfo();
}
function keyEvent()
{
	var val = event.which ;
	return keyPress(val);
}
document.onirkeypress = keyEvent ;
document.onkeypress = keyEvent ;


function  getallchannel(id)
{
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.open("POST", "jsp/vodlist.jsp?typeid="+id,false);
	//xmlHttp.setRequestHeader("X-Requested-With", "XMLHttpRequest");
	xmlHttp.send(null);
	if(xmlHttp.readyState == 4){
	    var  info=xmlHttp.responseText;
           var list =eval('(' + info  + ')');
            if(list){
        	getchannelInfo(list);
	    }
	}
	
}
function  getallqi(id)
{
	var xmlHttp = new XMLHttpRequest();
        xmlHttp.open("POST", "jsp/contentlist.jsp?typeid="+id,false);
        xmlHttp.send(null);
	if(xmlHttp.readyState == 4){
            var  info=xmlHttp.responseText;
	var list=[];
	//document.getElementById("allpage").innerHTML="$"+info+"$";
	if (info!="")
	{
	  list =eval('(' + info  + ')');
	}
	//if(list){
        getchannelInfo(list);
		
          //  	}
        }


}

function muchorone(id,lu_id,positions,reback)
{
	var conttype=list[id].CONTENTTYPE;
	if(list[id].SUBVODNUMLIST && list[id].SUBVODNUMLIST!=0)
	{
		var vodid=list[id].VODID;
		var  numlist=list[id].SUBVODNUMLIST;
		 var vodlist=list[id].SUBVODIDLIST;
		var after=window.location.href.toString().lastIndexOf("/")+1;
		var url=window.location.href.substring(after);
		window.location.href="muchpage.html?numlist="+numlist+"&poster="+list[id].POSTPATH1+"&name="+list[id].VODNAME+"&desc="+list[id].INTRODUCE+"&vodlist="+vodlist+"&luid="+lu_id+"&vodid="+vodid+"&contenttype="+conttype+"&url="+url;	
	}else
	{
		var num;
		if(typeid)
		{
		num=list[id].PROGRAMID;
		}else
		{
		 num=list[id].VODID;
		}
		//window.location.href="../vod_turnpager.jsp?vodid="+num+"&typeid=typeid&returnurl="+escape("young/hryy.html?nowpage="+now_page);
		if(typeid)
		{
		window.location.href="../au_PlayFilm.jsp?PROGID="+num+"&FATHERSERIESID="+num+"&CONTENTTYPE=0&BUSINESSTYPE=1&PLAYTYPE=1&returnurl="+escape("young/qzkt_info.html?nowpage="+now_page+"&positons="+positions+"&typeid="+typeid+"&imgurl="+document.getElementById("l_img").src);
		}else
		{
			if(reback=="ttys")
			{
			 window.location.href="../au_PlayFilm.jsp?PROGID="+num+"&FATHERSERIESID="+num+"&CONTENTTYPE=0&BUSINESSTYPE=1&PLAYTYPE=1&returnurl="+escape("young/ttys.html?nowpage="+now_page+"&positons="+positions);
			}
			else
			{
			window.location.href="../au_PlayFilm.jsp?PROGID="+num+"&FATHERSERIESID="+num+"&CONTENTTYPE=0&BUSINESSTYPE=1&PLAYTYPE=1&returnurl="+escape("young/hryy.html?nowpage="+now_page+"&positons="+positions);
			}
		}
	}
}
function gotoplay(ob)
{
	var page=parseInt(ob.innerHTML)-1;
	window.location.href="/EPG/jsp/defaultsdcctv/en/page/au_PlayFilm.jsp?PROGID="+vod[page]+"&FATHERSERIESID="+vodid+"&CONTENTTYPE=0&BUSINESSTYPE=1&PLAYTYPE=1&returnurl="+escape("young/muchpage.html?numlist="+nums+"&poster="+path+"&name="+name+"&desc="+desc+"&vodlist="+vod+"&nowpage="+nowpage+"&vodid="+vodid+"&contenttype="+conttype+"&url="+href);
	//window.location.href="../../../defaultsdcctv/en/page/vod_turnpager.jsp?vodid="+vod[page]+"&typeid=lu_id&returnurl="+escape("young/muchpage.html?numlist="+nums+"&poster="+path+"&name="+name+"&desc="+desc+"&vodlist="+vod+"&nowpage="+nowpage);
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

function trim(str){
return str.replace(/(^\s*)|(\s*$)/g, "");
}
function ltrim(str){
return str.replace(/(^\s*)/g,"");
}
function rtrim(str){
return str.replace(/(\s*$)/g,"");
}

