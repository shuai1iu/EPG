// JavaScript Document

/*
_existProg 存在节目单  0否，1是
_lastProg  最后一个节目单 0否，1是
_flag  移时间段  0不能移 1能左移（上一时间段） 2右移（下一时间段） 3左右都可以
_status    状态 0直播，1已录制，2未录制
_url   	链接
_id    a标签ID
*/

function createProgDiv(_existProg,_lastProg,_left,_top,_width,_height,_flag,_status,_url,_id)
{
	var left = _left == "" ? "-1" : _left ;
	var top = _top == "" ? "-1" : _top;
	var width = _width == "" ? "-1": _width;
	var height = _height == "" ? "-1" : _height;
	var lastProg = _lastProg == "" ? "-1": _lastProg;
	var existProg = _existProg ;
	var flag = _flag == "" ? "-1" : _flag;
	var status = _status ;
	var url = _url;
	var id = _id;
	
	var progDiv = "";
	
	//无节目单的情况
	if(existProg == 0)
	{	
		
		progDiv += "<div style=\"position:absolute;border:1px solid white;left:175px;top:" + (top - 10) + "px;width:452px;height:32px;\"><a id=\""+id+"\" href=\"#\" onfocus=\"startMarquee(this,3,"+lastProg+")\" onblur=\"stopMarquee(this,3,"+lastProg+")\"><img src=\"images/dot.gif\" width=\"452\" height=\"32\" border=\"0\"></a></div>";		
		progDiv += "<div style=\"position:absolute;left:175px;top:" + top + "px;width:452px;height:32px;color:#FFFFFF;font-size:20px;text-align:center;\">暂无节目</div>";			
		return progDiv;
	}
	//有节目单情况
	else
	{	
		//直播
		if(status == 0)
		{
			progDiv += "<div style=\"position:absolute;border:1px solid white;left:" + left + "px;top:" + (top - 10) + "px;width:" + width + "px;height:32px;\"><a id=\"prog" + id + "\" href=\"" + url + "\" onfocus=\"startMarquee(this,"+flag+","+lastProg+")\" onblur=\"stopMarquee(this,"+flag+","+lastProg+")\"><img src=\"images/display/tvod/green.gif\" width=\"" + width + "\" height=\"32\" border=\"0\"></a></div>";	
		}
		//已录制
		else if(status == 1)
		{
			progDiv += "<div style=\"position:absolute;border:1px solid white;left:" + left + "px;top:" + (top - 10) + "px;width:" + width + "px;height:32px;\"><a id=\"prog" + id + "\" href=\"" + url + "\" onfocus=\"startMarquee(this,"+flag+","+lastProg+")\" onblur=\"stopMarquee(this,"+flag+","+lastProg+")\"><img src=\"images/display/tvod/gray.gif\" width=\"" + width + "\" height=\"32\" border=\"0\"></a></div>";	
		}
		//未录制
		else if(status == 2)
		{
			progDiv += "<div style=\"position:absolute;border:1px solid white;left:" + left + "px;top:" + (top - 10) + "px;width:" + width + "px;height:32px;\"><a id=\"prog" + id + "\" href=\"javascript:pressNoRec();\" onfocus=\"startMarquee(this,"+flag+","+lastProg+")\" onblur=\"stopMarquee(this,"+flag+","+lastProg+")\"><img src=\"images/display/tvod/blue.gif\" width=\"" + width + "\" height=\"32\" border=\"0\"></a></div>";	
		}
		//空
		else
		{
			progDiv += "<div style=\"position:absolute;border:1px solid white;left:" + tempLeft + "px;top:" + (top - 10) + "px;;width:" + tempDivWidth + "px;height:32px;\"><a id=\""+id+"\" href=\"#\" onfocus=\"startMarquee(this,"+flag+","+lastProg+")\" onblur=\"stopMarquee(this,"+flag+","+lastProg+")\"><img src=\"images/dot.gif\" width="+tempDivWidth+" height=\"32\" border=\"0\"></a></div>";	
			progDiv += "<div style=\"position:absolute;left:" + tempLeft + "px;top:" + top + "px;width:" + tempDivWidth + "px;height:32px;color:#FFFFFF;font-size:20px;text-align:center;\"></div>";		
		}
				
	
		
	}
	
	
	return progDiv;
	
}