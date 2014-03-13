function setCookie(name,value)//两个参数，一个是cookie的名字，一个是值
{
    var Days = 2; //此 cookie 将被保存 2 天
    var exp  = new Date();    //new Date("December 31, 9998");
    exp.setTime(exp.getTime() + Days*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}
function getCookie(name)//取cookies函数        
{
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
     if(arr != null) return unescape(arr[2]); return null;

}

function getTopStr(value,len,defaultval)
{  
    if(value!=null){
    	value =value.replace(/&nbsp;/g,"");
       if(value.length >len ){
         value = value.substring(0,len)+"...";
       }
       return value;
     }
      if(typeof(defaultval)!="undefined" && defaultval!=null){
        return defaultval;
      }else{
         return "";
      }  
}

function showCurrentDate(id){
  var date=new Date();
  var day=date.getDay();
  var showStr="";
  switch(day){
   case 0:showStr="星期天";break;
   case 1:showStr="星期一";break;
   case 2:showStr="星期二";break;
   case 3:showStr="星期三";break;
   case 4:showStr="星期四";break;
   case 5:showStr="星期五";break;
   case 6:showStr="星期六";break;
  }
  showStr= (new DateFormat(date).format("yyyy年MM月dd日"))+" "+showStr+" "+(new DateFormat(date).format("hh:mi"));
   
  document.getElementById(id).innerHTML=showStr;
}

var DateFormat=function(date){ 
 var format=function(str){
  str=str.replace(/yyyy/g,date.getFullYear());
  str=str.replace(/yy/g,date.getFullYear().toString().slice(2));
  str=str.replace(/MM/g,(""+(date.getMonth()+1)).length>1?(date.getMonth()+1):("0"+(date.getMonth()+1)));
  str=str.replace(/dd/g,(""+(date.getDate() )).length>1?(date.getDate() ):("0"+(date.getDate() ))  );
  str=str.replace(/wk/g,date.getDay());
  str=str.replace(/hh/g, (""+date.getHours()).length>1?(date.getHours()):("0"+date.getHours()));
  str=str.replace(/mi/g, (""+date.getMinutes()).length>1?(date.getMinutes()):("0"+date.getMinutes()));
  str=str.replace(/ss/g,(""+date.getSeconds()).length>1?(date.getSeconds()):("0"+date.getSeconds()) );
  str=str.replace(/ms/g,date.getMilliseconds());
  return str;}
 var valueOf=function(){}
 var toString=function(){
  return date.toLocaleString();} 
 date=new Date(date);
 if(!date||date=="NaN")
  date=new Date(); 
 this.format=format;
 this.valueOf=valueOf;
 this.toString=toString;}
 
 
function getHourMinuteSecond (second){
    var tmpret="";
    if(second<0)return "";
    second=parseInt(second);
   var tmphours =parseInt(second/3600);
   var tmpminutes =parseInt(second%3600); 
       tmpminutes = parseInt( tmpminutes/60);
   var tmpseconds = parseInt(second%60);
   
   tmpret += ("00"+tmphours).substring(("00"+tmphours).length-2,("00"+tmphours).length)+":";
   tmpret += ("00"+tmpminutes).substring(("00"+tmpminutes).length-2,("00"+tmpminutes).length)+":";
   tmpret += ("00"+tmpseconds).substring(("00"+tmpseconds).length-2,("00"+tmpseconds).length);
   return tmpret;
}
 
function getQueryString(){
       var result = location.search.match(new RegExp("[\?\&][^\?\&]+=[^\?\&]+","g")); 
       if(result == null){
           return "";
       }
       for(var i = 0; i < result.length; i++){
           result[i] = result[i].substring(1);
       }
       return result;
  }
  function getQueryStringByName(name){
       var result = location.search.match(new RegExp("[\?\&]" + name+ "=([^\&]+)","i"));
       if(result == null || result.length < 1){
           return "";
       }
       return result[1];
  }
 
function Map() {
    //key direct方向 0,1,2,3   
    this.deleteDate=function(key,direct ){
       var value=this.get(key); if( value!=undefined&&value!=null ){ value[direct]=""; this.put(key,value); } }
     
    //key direct方向 0,1,2,3 startOrEnd 0加在头 非0加在尾 
    this.insertDate=function(key,direct,startOrEnd,date){
       var value=this.get(key); if( value!=undefined&&value!=null ){ var temp=value[direct]; if(temp==""){ temp=date; }else{
        if(startOrEnd==0){  temp=date+","+temp; }else{ temp+=","+date; } } value[direct]=temp; this.put(key,value); }
    }
    
    this.elements = new Array();     
    this.size = function() {           return this.elements.length;       }   
  
    this.isEmpty = function() {           return (this.elements.length < 1);       }   
  
    this.clear = function() {           this.elements = new Array();       }   
  
    this.put = function(_key, _value) { if(this.get(_key)!=undefined&&this.get(_key)!=null) this.remove(_key);          this.elements.push({key:_key, value:_value});       }   
  
    this.remove = function(_key) {           var bln = false;     
        try {               for (i = 0; i < this.elements.length; i++) {                   if (this.elements[i].key == _key) {                       this.elements.splice(i, 1);                       return true;                   }   
            }   
        } catch(e) {               bln = false;           }   
        return bln;       }   
  
    this.get = function(_key) {           try{                for (i = 0; i < this.elements.length; i++) {                   if (this.elements[i].key == _key) {                       return this.elements[i].value;                   }   
            }   
        }catch(e) {               return null;           }   
    }   
  
    this.element = function(_index) {           if (_index < 0 || _index >= this.elements.length) {               return null;           }   
        return this.elements[_index];       }   
  
    this.containsKey = function(_key) {           var bln = false;           try {               for (i = 0; i < this.elements.length; i++) {                   if (this.elements[i].key == _key) {                       bln = true;                   }   
            }   
        }catch(e) {               bln = false;           }   
        return bln;       }   
  
    this.containsValue = function(_value) {           var bln = false;           try {               for (i = 0; i < this.elements.length; i++) {                   if (this.elements[i].value == _value){                       bln = true;                   }   
            }   
        } catch(e) {               bln = false;           }   
        return bln;       }   
  
    this.values = function() {           var arr = new Array();           for (i = 0; i < this.elements.length; i++) {               arr.push(this.elements[i].value);           }   
        return arr;       }   
  
    this.keys = function() {           var arr = new Array();           for (i = 0; i < this.elements.length; i++) {               arr.push(this.elements[i].key);           }   
        return arr;       }   
}


//获得元素对象
function ele(elementId){
  var obj = document.getElementById(elementId);
  if(typeof(obj)!="object")
	  obj = null; 
  return obj;
}

//显示元素
function showEle(elementId){
	var obj = ele(elementId);
	if(obj!=null){
		if(obj.style.display !="block")
	    obj.style.display="block";
	}
}

//隐藏元素
function hideEle(elementId){
	var obj = ele(elementId);
	if(obj!=null){
		if(obj.style.display !="none")
	     obj.style.display="none";
	}
}

//元素写入HTML
function eleSetHtml(elementId,text){
	 var obj = ele(elementId);
	 if(obj!=null)
	   obj.innerHTML = text;
}

//元素读取HTML
function eleGetHtml(elementId){
	 var text = "";
	 var obj = ele(elementId);
	 if(obj!=null)
	  text=obj.innerHTML;
	 return text;
}

//写样式
function eleSetClass(elementId,className){
	 var obj = ele(elementId);
	 if(obj!=null)
	   obj.className = className;
}

//读取样式
function eleGetClass(elementId){
	 var className = "";
	 var obj = ele(elementId);
	 if(obj!=null)
		 className=obj.className;
	 return className;
}

//写入图片
function eleSetImage(elementId,src){
	 var obj = ele(elementId);
	 if(obj!=null)
	   obj.src = src;
}

//元素写入宽度
function eleSetWidth(elementId,width){
	 var obj = ele(elementId);
	 if(obj!=null)
	   obj.style.width=width;
}

//元素读取宽度
function eleGetWidth(elementId){
	 var width = 0;
	 var obj = ele(elementId);
	 if(obj!=null)
	  width=obj.style.width;
	 return width;
}

//元素写入左
function eleSetLeft(elementId,left){
	 var obj = ele(elementId);
	 if(obj!=null)
	   obj.style.left = left;
}

//元素读取左
function eleGetLeft(elementId){
	 var left = "";
	 var obj = ele(elementId);
	 if(obj!=null)
	  left=obj.style.left;
	 return left;
}

//增加导航
function addNavigationUrl(){
	var nav = getCookie("nav");
	var navUrlStr = "";
	var navUrlArray = null;
	if(nav==null || nav.length<1)
		navUrlArray = new Array();
	else
		navUrlArray = nav.split(',');
	navUrlArray.push(window.location.href);
	navUrlStr= navUrlArray.join(","); 
	setCookie("nav",navUrlStr); 
}

//跳转上一导航
function gotoBackNavigationUrl(){
	var nav = getCookie("nav");
	var navUrlStr = "";
	var navUrlArray = null;
	var url = "";
	if(nav!=null){
		navUrlArray = nav.split(',');
        if(navUrlArray.length>0){
        	navUrlArray.pop();
            if(navUrlArray.length>0){
               url=navUrlArray.pop();
               navUrlStr=navUrlArray.join(","); 
               setCookie("nav",navUrlStr);
               if(url.length>0){
            	   alert(url);
                 window.location.href = url;
               }
            }
        }
	}
}

//时间格式化
function timeFormat(time) {
      var hour = parseInt(time / 3600);
      time = parseInt(time % 3600);
      var minute = parseInt(time / 60);
      time = parseInt(time % 60);
      var second = parseInt(time);

      var timeStr = "";
      if (hour < 10)
          timeStr += "0";
      timeStr += hour + ":";
      if (minute < 10)
          timeStr += "0";
      timeStr += minute+":";
      if (second < 10)
          timeStr += "0";
      timeStr += second;
      return timeStr;
  }

//跳转页面
function gotoPage(url){
	window.location.href = url;
}

//获取文件类型
function getFileType(filename){
	var index1=filename.lastIndexOf(".")+1;
	var index2=filename.length;
	var postf=filename.substring(index1,index2);//后缀名
	return 	postf;
}
 //获取数组下标
function getItemIndex(index,arraylen){
   var maxIndex = arraylen-1;
   if(index<0)
      index = arraylen+index;
   if(index>maxIndex)
       index = index-arraylen;
   return index;    
}