<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.net.URLDecoder"%>
<%!

	public ArrayList getFocus(String name,HttpServletRequest request )
	{
	    Cookie cookie[]=request.getCookies();   
        String cookieName=null;
        String cookieValue=null;
        for(int i=0;i<cookie.length;i++){

            cookieName=cookie[i].getName();
            if(cookieName.equals(name))
			{
			    cookieValue=URLDecoder.decode(cookie[i].getValue());
				break;
			}
		}
		if(cookieValue!=null)
		{
			return analyticFocStr(cookieValue);
		}
		return null;
	}
	public ArrayList analyticFocStr(String jsonString){
				ArrayList list = new ArrayList();
				JSONObject jsonO = JSONObject.fromObject(jsonString);  
				JSONArray  jsonArray =jsonO.getJSONArray("datas");
				for(Iterator iter1 = jsonArray.iterator(); iter1.hasNext();){       
					JSONObject tjobj = (JSONObject)iter1.next();
					HashMap map = new HashMap();
		            for(Iterator iter = tjobj.keys(); iter.hasNext();){     
			        String key = (String)iter.next();
					map.put(key, tjobj.get(key));				
					list.add(map);
		            }
				}
		if(list.size()>0)
		    return list;
	    return null;
	}
%>
<script>
function createFocstr(_pageobj){
		if(_pageobj==null){
			_pageobj = pageobj;
		}
		var curarea = _pageobj.areas[_pageobj.curareaid];
		var curFoc_str = '{datas:[';
		curFoc_str += '{\"areaid\":'+curarea.id+',\"curindex\":'+curarea.curindex+',\"curpage\":'+curarea.curpage+'},';
		for(var i = 0;i<_pageobj.areas.length;i++){
			if(_pageobj.areas[i].darkness&&i!=_pageobj.curareaid){
				curarea = _pageobj.areas[i];
				curFoc_str+='{\"areaid\":'+curarea.id+',\"curindex\":'+curarea.curindex+',\"curpage\":'+curarea.curpage+'},';
			}
		}
		curFoc_str=curFoc_str.substr(0,curFoc_str.length-1);
		curFoc_str+=']}';
		return curFoc_str;
	}

function createAllFocstr(_pageobj){
		if(_pageobj==null){
			_pageobj = pageobj;
		}
		var curarea = _pageobj.areas[_pageobj.curareaid];
		var curFoc_str = '{datas:[';
		curFoc_str += '{\"areaid\":'+curarea.id+',\"curindex\":'+curarea.curindex+',\"curpage\":'+curarea.curpage+'},';
		for(var i = 0;i<_pageobj.areas.length;i++){
			if(i!=_pageobj.curareaid){
				curarea = _pageobj.areas[i];
				curFoc_str+='{\"areaid\":'+curarea.id+',\"curindex\":'+curarea.curindex+',\"curpage\":'+curarea.curpage+'},';
			}
		}
		curFoc_str=curFoc_str.substr(0,curFoc_str.length-1);
		curFoc_str+=']}';
		return curFoc_str;
	}
function saveCookie(key,json)
{
	var mycookie=key+"="+escape(json);
	document.cookie=mycookie;
}
function getCookie(c_name)
{
	var mycookie=getCookieString(c_name);
	if(!!mycookie)
	{
		mycookie=mycookie.replace(c_name+"=","");
        return mycookie;
	}
} 
function getCookieString(c_name)
{
  //window.alert(document.cookie);
  if (document.cookie.length>0)
  {
  c_start=document.cookie.indexOf(c_name + "=")
  if (c_start!=-1)
    { 
    c_start=c_start + c_name.length+1 
    c_end=document.cookie.indexOf(";",c_start)
    if (c_end==-1) c_end=document.cookie.length
    return unescape(document.cookie.substring(c_start,c_end))
    } 
  }
  return undefined;
}
function setDarkFocus(name)
{
   	var data=getCookie(name);
	var focusobj=eval('('+unescape(data)+')');
	for(i=1;i<focusobj.datas.length;i++)
	{ 
	    var tmparea=pageobj.areas[focusobj.datas[i].areaid];
		tmparea.curpage=focusobj.datas[i].curpage;
	    tmparea.setdarknessfocus(focusobj.datas[i].curindex);
	}
}
function getCurFocus(name)
{
	var data=getCookie(name);
	var focusobj=eval('('+unescape(data)+')');
	if(focusobj!=undefined&&focusobj!=""&&focusobj!=null&&focusobj!="undefined")
	    return focusobj.datas;
	return null;
}
</script>