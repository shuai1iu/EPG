    function FocusData(){
	  this.areaid=0;
	  this.curindex=0;
	  this.curpage=0;
	  this.curyouwanaobj=undefined;
	}
	
    function OperatorFocus()
	{
		
	}
	
	function Myfocus(){
		this.pathurl=undefined;
		this.urlname=undefined;
		this.focusdatas=new Array();
	}
    
    function saveDarfocus(name,_pageobj){
	    if(_pageobj==undefined||_pageobj==null){
				_pageobj = pageobj;
		}
		var curarea = _pageobj.areas[_pageobj.curareaid];
		var curPage="";
		if(_pageobj.urlpath==""){
			curPage=escape(window.location.href);
		}else{
			curPage=escape(_pageobj.urlpath);
		}
		var tempurlname=window.location.href;
		if(tempurlname.indexOf("?")!=-1)
		{
		   tempurlname=tempurlname.substring(0,tempurlname.indexOf("?"));
		}
		tempurlname=escape(tempurlname);
		var myfocus=new Myfocus();
		myfocus.pathurl=curPage;
		myfocus.urlname=tempurlname;
		
		var focusdatalists=new Array();
		var tempfocusData=new  FocusData();
		tempfocusData.areaid=curarea.id;
		tempfocusData.curindex=curarea.curindex;
		tempfocusData.curpage=curarea.curpage;
		
		if(curarea.youwanasave==true&&curarea.doms[curarea.curindex].youwanaobj!=undefined){
			tempfocusData.curyouwanaobj=curarea.doms[curarea.curindex].youwanaobj;	
		}
		focusdatalists.push(tempfocusData);
		
		for(var i = 0;i<_pageobj.areas.length;i++){
			if(_pageobj.areas[i].darkness&&i!=_pageobj.curareaid){
				curarea = _pageobj.areas[i];
				var tempiFocusData=new  FocusData();
				tempiFocusData.areaid=curarea.id;
		        tempiFocusData.curindex=curarea.curindex;
		        tempiFocusData.curpage=curarea.curpage;
				if(curarea.youwanasave==true&&curarea.doms[curarea.curindex].youwanaobj!=undefined){
					tempiFocusData.curyouwanaobj=curarea.doms[curarea.curindex].youwanaobj;
				}
				focusdatalists.push(tempiFocusData);
			}
		}
		myfocus.focusdatas=focusdatalists;
     
	 	var strJSON="{pathurl:'"+myfocus.pathurl+"',urlname:'"+myfocus.urlname+"',focusdatas:";
		if(myfocus.focusdatas.length>0){
			
			strJSON=strJSON+"[";
			for(var i=0;i<myfocus.focusdatas.length;i++){
				strJSON=strJSON+"{areaid:"+myfocus.focusdatas[i].areaid+",curindex:"+myfocus.focusdatas[i].curindex+",curpage:"+myfocus.focusdatas[i].curpage+"},";
			}
			strJSON=strJSON.substring(0,strJSON.length-1);
			strJSON=strJSON+"]}";
		}
		else{
			strJSON=strJSON+"null}";
			
		}
		saveCookie(name,strJSON);
   }
    
   //取出暗焦点
   function getDarfocus(name){
	    var  focusArray=JSONdecode(getCookie(name));
	    return   focusArray;
   } 
   
   //保存焦点页面对象
   function saveFocstr(_pageobj)
   {
		if(_pageobj==undefined||_pageobj==null){
				_pageobj = pageobj;
		}
		var curarea = _pageobj.areas[_pageobj.curareaid];
		var curPage="";
		if(_pageobj.urlpath==""){
			curPage=escape(window.location.href);
		}else{
			curPage=escape(_pageobj.urlpath);
		}
		var tempurlname=window.location.href;
		if(tempurlname.indexOf("?")!=-1)
		{
		   tempurlname=tempurlname.substring(0,tempurlname.indexOf("?"));
		}
		tempurlname=escape(tempurlname);
		var myfocus=new Myfocus();
		myfocus.pathurl=curPage;
		myfocus.urlname=tempurlname;
		
		var focusdatalists=new Array();
		var tempfocusData=new  FocusData();
		tempfocusData.areaid=curarea.id;
		tempfocusData.curindex=curarea.curindex;
		tempfocusData.curpage=curarea.curpage;
		
		if(curarea.youwanasave==true&&curarea.doms[curarea.curindex].youwanaobj!=undefined){
			tempfocusData.curyouwanaobj=curarea.doms[curarea.curindex].youwanaobj;	
		}
		focusdatalists.push(tempfocusData);
		
		for(var i = 0;i<_pageobj.areas.length;i++){
			if(_pageobj.areas[i].darkness&&i!=_pageobj.curareaid){
				curarea = _pageobj.areas[i];
				var tempiFocusData=new  FocusData();
				tempiFocusData.areaid=curarea.id;
		        tempiFocusData.curindex=curarea.curindex;
		        tempiFocusData.curpage=curarea.curpage;
				if(curarea.youwanasave==true&&curarea.doms[curarea.curindex].youwanaobj!=undefined){
					tempiFocusData.curyouwanaobj=curarea.doms[curarea.curindex].youwanaobj;
				}
				focusdatalists.push(tempiFocusData);
			}
		}
		
		myfocus.focusdatas=focusdatalists;
		
	    var	focusArray=JSONdecode(getCookie("lastfoc"));
		if(focusArray==undefined || focusArray=="null" || focusArray==null)
		{
		    focusArray=new Array();
		}
		if(focusArray.length>0){
		   if(focusArray[focusArray.length-1].urlname==myfocus.urlname){
			   focusArray[focusArray.length-1]=myfocus;
		   }else{
			   focusArray.push(myfocus);
		   }
		}else{
			focusArray.push(myfocus);
		}
		var strjson=JSONencodeFocus(focusArray);
		saveCookie("lastfoc",strjson);
    }
	 
    function JSONencodeFocus(val){
    	var strjson="";
        if(val.length>0){
			strjson="[";
		    for(var i=0;i<val.length;i++)
			{
				 var strJSON="{pathurl:'"+val[i].pathurl+"',urlname:'"+val[i].urlname+"',focusdatas:";
		         if(val[i].focusdatas.length>0){
					 strJSON=strJSON+"[";
					 for(var j=0;j<val[i].focusdatas.length;j++){
							strJSON=strJSON+"{areaid:"+val[i].focusdatas[j].areaid+",curindex:"+val[i].focusdatas[j].curindex+",curpage:"+val[i].focusdatas[j].curpage+"},";
					  }
					  strJSON=strJSON.substring(0,strJSON.length-1);
					  strJSON=strJSON+"]}";
		         }
	          	else{
			       strJSON=strJSON+"null}";
			
		        }
				strjson=strjson+strJSON+",";
			}
			strjson=strjson.substring(0,strjson.length-1);
			strjson=strjson+"]";
		}
		return strjson;
    }
    
    function JSONdecode(val)
    {
    	if(val=='') return null;
        var result= eval('('+val+')');
    	return result;
    }
    
    
	function saveCookie(key,json)
	{
		var Days = 1;
		var exp = new Date(); 
		exp.setTime(exp.getTime() + Days*24*60*60*1000);
		

		 var mycookie=key+"="+json+";path=/;expires=" + exp.toGMTString()+";";
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
	  var cookieresult=undefined;
	  if (document.cookie.length>0)
	  {
	  c_start=document.cookie.indexOf(c_name + "=")
	  if (c_start!=-1)
		{ 
		c_start=c_start + c_name.length+1 
		c_end=document.cookie.indexOf(";",c_start)
		if (c_end==-1) c_end=document.cookie.length
		cookieresult=unescape(document.cookie.substring(c_start,c_end))
		} 
	  }
	  //alert(cookieresult);
	  return cookieresult;
	}
	
    //得到当前页面的焦点
	function getCurFocus()
	{
		var focusArray=JSONdecode(getCookie("lastfoc"));
		if(focusArray!=undefined&&focusArray!="null")
		{  
		   var curPage=escape(window.location.href);
		   if(focusArray.length>0){
		      var tempmyfocus=focusArray[focusArray.length-1];
		      if(tempmyfocus.pathurl==curPage){
		         return tempmyfocus;
			  }
		   }
		}
		return undefined;
	}
   
    //得到当前页面的返回地址
	function getLastReturn()
	{
		var returnresult="";
		var focusArray=JSONdecode(getCookie("lastfoc"));
		if(focusArray!=undefined&&focusArray!="null")
		{  
		   if(focusArray.length>0){
		      var tempmyfocus=focusArray[focusArray.length-1];
		      returnresult=unescape(tempmyfocus.pathurl);
		   }
		}
		return returnresult;
	}
   
   	//得到当前页面的焦点
	function getCurFocusAndDelete()
	{
		var focusArray=JSONdecode(getCookie("lastfoc"));
		if(focusArray!=undefined&&focusArray!="null")
		{
			var tempurlname=window.location.href;
			if(tempurlname.indexOf("?")!=-1)
			{
			   tempurlname=tempurlname.substring(0,tempurlname.indexOf("?"));
			}
		    var curPage=escape(tempurlname);
		    if(focusArray.length>0){
			     var tempmyfocus=focusArray[focusArray.length-1];
				 var strpathurl=tempmyfocus.urlname;
				 if(strpathurl==curPage){
					  var  tempfocuslist=focusArray.splice(focusArray.length-1,1);
					  var tempmyfocus=tempfocuslist[tempfocuslist.length-1];
		              var strjson=JSONencodeFocus(focusArray);
		              saveCookie("lastfoc",strjson);
					  return tempmyfocus;
				 }
		   }
		}
		return undefined;
   }
   //保存cookie
   function saveCookie(key,json)
   {   
        var Days = 1;
        var exp = new Date();
        exp.setTime(exp.getTime() + Days*24*60*60*1000);
		var mycookie=key+"="+escape(json)+";path=/;expires=" + exp.toGMTString()+";";
		//path=/
		document.cookie=mycookie;
		
   }
   
   //删除所有的焦点对象
   function deleteFocus(){
	    focusArray=new Array();
	    var strjson=JSONencodeFocus(focusArray);
		saveCookie("lastfoc",strjson);
   }
   window['OperatorFocus']={};
   //定义OperatorFocus命名空间
   window['OperatorFocus']['deleteFocus']=deleteFocus;
   window['OperatorFocus']['getCurFocusAndDelete']=getCurFocusAndDelete;
   window['OperatorFocus']['getLastReturn']=getLastReturn;
   window['OperatorFocus']['getDarfocus']=getDarfocus;
   window['OperatorFocus']['saveDarfocus']=saveDarfocus;
   window['OperatorFocus']['getCurFocus']=getCurFocus;
   window['OperatorFocus']['saveFocstr']=saveFocstr;