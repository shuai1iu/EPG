<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视奥运 标清EPG 2.0</title>
<meta name="page-view-size" content="640*530" />
<link rel="stylesheet" type="text/css" href="<%=static_url%>/css/style.css" />
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/mediaPlayerEx.js"></script>
<script language="javascript">
 

var media = new MediaPlayerExClass();
function onpageload() {
    
    var _left = "";
    var _top = "";
    var _width = "";
    var _height = "";
    var userchannelid = "";
    
    var para = window.location.search;
    para = para.replace('?','');
    var strs = para.split("&"); 
    var temp=""; 
    for(var i = 0;i<strs.length;i++){
      temp=strs[i].split("=");
      if( temp[0]=="_left" ){ _left=parseInt(temp[1]);continue; }
      if( temp[0]=="_top" ){ _top=parseInt(temp[1]);continue; }
      if( temp[0]=="_width" ){ _width=parseInt(temp[1]);continue; }
      if( temp[0]=="_height" ){ _height=parseInt(temp[1]);continue; }
      if( temp[0]=="userchannelid" ){  userchannelid=parseInt(temp[1]);continue; }
    } 
    
    if(  userchannelid!=''&&!isNaN(userchannelid) ){
       media.playLittleLive(userchannelid,_height,_width,_left,_top);
    }
	parent.media = media;    
}
function destoryMP()
{
	//media.releaseMediaPlayer();
	//media.stop();
	 mp.leaveChannel();
	 media.stop();
}
</script>
 </head>
 <body style="background:transparent;" onunload="destoryMP();" onload="onpageload();">

 </body>
</html>
