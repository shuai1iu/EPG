var _in_ajax = window.ActiveXObject ? new ActiveXObject("Microsoft.XMLHTTP") : new XMLHttpRequest();
//传入的successMethed有一个字符串参数，处理成功后将服务器返回的信息做参数传入
function getAJAXData(url,successMethed){
if(url!=undefined&&url!=null&&url!=""){
var temp=url.split("?"); url=temp[0];
if(temp.length>1){ url+="?"+encodeURI(temp[1]); }
} 
_in_ajax.open( "POST",url ,false);
_in_ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
_in_ajax.setRequestHeader("X-Requested-With", "XMLHttpRequest");
_in_ajax.send(null);
//_in_ajax.onreadystatechange=successMethed;
if( _in_ajax.readyState == 4 ) { if( _in_ajax.status == 200 ) { successMethed(_in_ajax.responseText); } } }
