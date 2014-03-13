<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%!
	//获取当前记忆焦点位置字符串，并从Session中删除
	public String getFocusStr(HttpServletRequest request){
		String focstr = "null";
		String curpageName = request.getRequestURI();
		curpageName = curpageName.substring(curpageName.lastIndexOf("/")+1);
		curpageName = curpageName.substring(0,curpageName.lastIndexOf("."));
		curpageName = curpageName.replaceAll("-","");
		ArrayList focstrList = (ArrayList)request.getSession().getAttribute("focstrs");
		//List allindePageName = Arrays.asList("index","channel","dibbling","playback","application","package","space_collect","space_bookmarks","space_consumer_records","space_instructions","search");
		List allindePageName = new ArrayList();
		if(focstrList!=null&&focstrList.size()>0&&((HashMap)focstrList.get(focstrList.size()-1)).get(curpageName)!=null){ //获取字符串并且清除
			focstr = ((HashMap)focstrList.get(focstrList.size()-1)).get(curpageName).toString();
			if(!allindePageName.contains(curpageName)){
				focstrList.remove(focstrList.size()-1);
			}else{
				focstrList = new ArrayList();
			}
			request.getSession().setAttribute("focstrs",focstrList);
		}else if(allindePageName.contains(curpageName)){
			focstrList = new ArrayList();
			request.getSession().setAttribute("focstrs",focstrList);
		}
		return URLDecoder.decode(focstr);
	}
	
	//从Cookie中获取前一焦点位置字符串，存入Session中
	public String getTempFocusStr(HttpServletRequest request,HttpServletResponse response){
		ArrayList focstrList = (ArrayList)request.getSession().getAttribute("focstrs");
		if(focstrList==null){
			focstrList = new ArrayList();
		}
		Cookie[] cookies = request.getCookies();
		String tmpfocstr = "null"; //前一页面保存在Cookie中的焦点字符串
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("lastfoc")){
				tmpfocstr = cookie.getValue();
				break;
			}
		}	
		if(!"null".equals(tmpfocstr)){  //是否为空来判断方向，为非"null"说明是需要存的
			HashMap tempMap = new HashMap();
			tempMap.put(tmpfocstr.split("-")[0],tmpfocstr.split("-")[1]);
			focstrList.add(tempMap);
			request.getSession().setAttribute("focstrs",focstrList);
			Cookie emptycookie=new Cookie("lastfoc", "null");
			response.addCookie(emptycookie);
		}
		return tmpfocstr;
	}

	public ArrayList analyticFocStr(String jsonString){
		if(jsonString==null||jsonString.equals("null")){
			return null;
		}
				ArrayList list = new ArrayList();
				JSONObject jsonO = JSONObject.fromObject(jsonString);  
				JSONArray jsonArray =jsonO.getJSONArray("datas");
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
	
	public HashMap getState(ArrayList focstrs,String areaid){
		HashMap tempMap = null;
		for(int i = 0;focstrs!=null&&i<focstrs.size();i++){
			tempMap = (HashMap)focstrs.get(i);
			if((tempMap.get("areaid").toString()).equals(areaid)){
				break;
			}
		}
		return tempMap;
	}
	
	public Object getState(ArrayList focstrs,String areaid,String argName){
		HashMap tempMap = getState(focstrs,areaid);
		return tempMap==null?null:tempMap.get(argName);
	}
%>
<%
//1.获取当前页面的焦点，并删除List中的记录
//2.获取上个页面存入的焦点，并删除Cookie中的记录
	String focstr = getFocusStr(request); //当前页面焦点字符串
	getTempFocusStr(request,response);	
%>
<script>
	var focusObj = getCurFocus('<%=focstr %>');
//保存焦点
	function saveFocstr(_pageobj){
		if(_pageobj==undefined||_pageobj==null){
				_pageobj = pageobj;
		}
		var curarea = _pageobj.areas[_pageobj.curareaid];
		var curFoc_str = '{datas:[';
		curFoc_str += '{\"areaid\":'+curarea.id+',\"curindex\":'+curarea.curindex+',\"curpage\":'+curarea.curpage;
		if(curarea.youwanasave==true&&curarea.doms[curarea.curindex].youwanaobj!=undefined){
			curFoc_str += ',\"curyouwanaobj\":' + curarea.doms[curarea.curindex].youwanaobj+'},';	
		}else{
			curFoc_str += '},';
		}
		for(var i = 0;i<_pageobj.areas.length;i++){
			if(_pageobj.areas[i].darkness&&i!=_pageobj.curareaid){
				curarea = _pageobj.areas[i];
				curFoc_str+='{\"areaid\":'+curarea.id+',\"curindex\":'+curarea.curindex+',\"curpage\":'+curarea.curpage;
				if(curarea.youwanasave==true&&curarea.doms[curarea.curindex].youwanaobj!=undefined){
					curFoc_str += ',\"curyouwanaobj\":' + curarea.doms[curarea.curindex].youwanaobj+'},';	
				}else{
					curFoc_str += '},';
				}
			}
		}
		curFoc_str=curFoc_str.substr(0,curFoc_str.length-1);
		curFoc_str+=']}';
		saveCookie("lastfoc",curFoc_str); 
	}
	
	//获取焦点
	function getFocstr(){
		var curPage = window.location.pathname;
		return getCookie("lastfoc");
	}
	 
	
	function saveCookie(key,json)
	{
		var curPage = window.location.pathname;
		curPage = curPage.substring(curPage.lastIndexOf("/")+1);
		curPage = curPage.substring(0,curPage.lastIndexOf("."));
		curPage = curPage.replace(new RegExp("-","gm"),"");
		var mycookie=key+"="+curPage+"-"+escape(json);
		document.cookie=mycookie;
	}
	
	function getCookie(c_name)
	{
		if(c_name.indexOf("datas")==-1){
			var mycookie=getCookieString(c_name);
			if(!!mycookie)
			{
				mycookie=mycookie.replace(c_name+"=","");
				return mycookie;
			}
		}else{
			return c_name;
		}
	}
	
	function getCookieString(c_name)
	{
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
		if(name!=undefined){
			var data=getCookie(name);
			focusObj=eval('('+unescape(data)+')');
			focusObj = focusObj.datas;
		}
		if(focusObj!=undefined&&focusObj!="null"){
			for(i=1;i<focusObj.length;i++){ 
				var tmparea=pageobj.areas[focusObj[i].areaid];
				tmparea.curpage=focusObj[i].curpage;
				tmparea.setdarknessfocus(focusObj[i].curindex);
			}
		}
	}
	
	function getCurFocus(name)
	{
		var data=getCookie(name);
		if(data=="null"||data==undefined){
			return undefined;
		}
		var focusobj=eval('('+unescape(data)+')');
		if(focusobj!=undefined&&focusobj!=""&&focusobj!=null&&focusobj!="null")
			return focusobj.datas;
		return undefined;
	}
</script>