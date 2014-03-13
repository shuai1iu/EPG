if(typeof(iPanel) != 'undefined')
{
	iPanel.focusWidth = "2";
	iPanel.defaultFocusColor = "#FCFF05";
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

function showCurrentDate(id,format){
  var date=new Date();
  var day=date.getDay();
  var showStr="";
  var test=date.getFullYear();
  test=""+test;
  showStr= (new DateFormat(date).format(format)) ;
   
  document.getElementById(id).innerHTML=showStr;
}

var DateFormat=function(date){ 
 var format=function(str){
  str=str.replace('yyyy',''+(date.getFullYear()));
  str=str.replace('yy',''+(date.getFullYear().toString().slice(2)));
  str=str.replace('MM',''+((""+(date.getMonth()+1)).length>1?(date.getMonth()+1):("0"+(date.getMonth()+1))) );
  str=str.replace('dd',''+((""+(date.getDate() )).length>1?(date.getDate() ):("0"+(date.getDate() )))  );
  str=str.replace('wk',''+(date.getDay()));
  str=str.replace('hh', ''+((""+date.getHours()).length>1?(date.getHours()):("0"+date.getHours())));
  str=str.replace('mi', ''+((""+date.getMinutes()).length>1?(date.getMinutes()):("0"+date.getMinutes())));
  str=str.replace('ss',''+((""+date.getSeconds()).length>1?(date.getSeconds()):("0"+date.getSeconds())) );
  str=str.replace('ms',''+(date.getMilliseconds()));
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
    //key direct方向 0,1,2,3   上右下左 顺时针
    this.deleteData=function(key,direct ){
       var value=this.get(key); if( value!=undefined&&value!=null ){ value[direct]=""; this.put(key,value); } }
     
    //key direct方向 0,1,2,3 startOrEnd 0加在头 非0加在尾 
    this.insertData=function(key,direct,startOrEnd,date){
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
var linkMap=new Map(); 
var currentSelectObjectId=""; 