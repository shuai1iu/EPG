var _in_ajax = window.ActiveXObject ? new ActiveXObject("Microsoft.XMLHTTP") : new XMLHttpRequest();
//解决变量作用域问题，临时存储参数
var ajaxtempparms = {}; 
//传入的successMethed有一个字符串参数，处理成功后将服务器返回的信息做参数传入
function getAJAXData(url, successMethed,param,obj) {
	if(_in_ajax==undefined){
		if (url != undefined && url != null && url != "") {
			var temp = url.split("?"); 
			url = temp[0];
			url = url.replace(".jsp","woa.jsp");
			if (temp.length > 1) { url += "?" + encodeURI(temp[1]); }
			if($("hidden_frame")!=undefined){
				if(url.indexOf("http")!=0){
					var tempaburl = (location.href.indexOf('0')==-1)?location.href:location.href.split('?')[0];
					var tempurlstrs = tempaburl.split("/");
					url = tempaburl.replace(tempurlstrs[tempurlstrs.length-1],url);
				}
				$("hidden_frame").src = url;
			}else{
				$("currDate").innerHTML = "unsuccess";
			}
		}
	}else{		
		ajaxtempparms["url"] = url;
		ajaxtempparms["successMethed"] = successMethed;
		ajaxtempparms["param"] = param;
		ajaxtempparms["obj"] = obj;
		if (url != undefined && url != null && url != "") {
			var temp = url.split("?"); url = temp[0];
			if (temp.length > 1) { url += "?" + encodeURI(temp[1]); }
		}
		if(url.indexOf("http")!=0){
			var tempaburl = (location.href.indexOf('0')==-1)?location.href:location.href.split('?')[0];
			var tempurlstrs = tempaburl.split("/");
			url = tempaburl.replace(tempurlstrs[tempurlstrs.length-1],url);
		}
		_in_ajax.open("GET", ajaxtempparms["url"], true);	
		_in_ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");		
		_in_ajax.onreadystatechange=function() { 
			 if (_in_ajax.readyState == 4) {
				 if (_in_ajax.status == 200) {
			 		successMethed = ajaxtempparms["successMethed"];			 
			 		successMethed(_in_ajax.responseText,ajaxtempparms["param"],ajaxtempparms["obj"]); 
					}
			 }else if(_in_ajax.readyState == 1&&_in_ajax.status==0){
			 	 _in_ajax = undefined;
				 getAJAXData(ajaxtempparms["url"],ajaxtempparms["successMethed"],ajaxtempparms["param"],ajaxtempparms["obj"]); 
			 }
		};
		_in_ajax.send(null);
	}
}