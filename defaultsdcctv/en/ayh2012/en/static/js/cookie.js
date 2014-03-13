var cookieSplit="|&|";
var cookieNameandValue="|||";
var cookieFlag="cookieurl";
function addURLtoCookie(flag,url){
  var str=readCookie(cookieFlag);
  var strs=str.split(cookieSplit);
  var value="";
  var newvalue="";
  var isExist=false;
  for(var i=0;i<strs.length;i++){
    if(strs[i]==undefined||strs[i]==null||strs[i]=="undefined") continue;
    var strtemp=strs[i].split(cookieNameandValue);
    if(strtemp.length>1&&strtemp[0]==flag){
       newvalue+=flag+cookieNameandValue+url+cookieSplit;
       isExist=true;
    }else if(strtemp.length>1){
      newvalue+=strtemp[0]+cookieNameandValue+strtemp[1]+cookieSplit;
    }
  }
  if(!isExist){
   newvalue+=flag+cookieNameandValue+url+cookieSplit;
  }
  createCookie(cookieFlag,newvalue,1);
}

function getURLtoCookie(flag){
  var str=readCookie(cookieFlag);
  var strs=str.split(cookieSplit);
  var value="";
  var newvalue="";
  for(var i=0;i<strs.length;i++){
    if(strs[i]==undefined||strs[i]==null||strs[i]=="undefined") continue;
    var strtemp=strs[i].split(cookieNameandValue);
    if(strtemp.length>1&&strtemp[0]==flag){
      value=strtemp[1];
    }else if(strtemp.length>1){
      newvalue+=strtemp[0]+cookieNameandValue+strtemp[1]+cookieSplit;
    }
  }
  createCookie(cookieFlag,newvalue,1);
  return value;
}

function createCookie(name, value, days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime()+(days*24*60*60*1000));
        var expires = "; expires="+date.toGMTString();
    }
    else var expires = "";
    document.cookie = name+"="+value+expires+"; path=/";
}
function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) {
            //alert("cookie: " + c.substring(nameEQ.length,c.length) + ", c:" + c);
            return c.substring(nameEQ.length,c.length);
        }
    }
    return "";
}
function eraseCookie(name) {
    createCookie(name,"",-1);
}

function getValueFromUrl(para,name) {
    var value = "";
   if(!query) return value;
   if(query=="") return value;
   query=query.replace('?','');
 var strs=query.split("&");
     for(var i=0;i<strs.length;i++){ 
	       var arr=strs[i].split("="); 
	        if(name == arr[0]){
	        
	            value=arr[1]; 
	          break; 
	     } 
	   }
   
   return value;
}
