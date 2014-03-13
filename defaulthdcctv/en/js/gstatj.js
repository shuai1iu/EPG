function gstaFun(gstaUserId,gstaId)//userId,pid
{

	var cUrl = window.location.href;
	var refer = document.referrer;
	cUrl = cUrl.replace(/\&/g,"$");
	refer = refer.replace(/\&/g,"$");
	var gstaurl = "http://14.29.1.68:8081/writeLogs/writeLogServlet?cUrl="+cUrl+"&cRefer="+refer+"&cUserId="+gstaUserId+"&cPid="+gstaId;
	var xmlHttp="xmlHttp2013";
	if(window.XMLHttpRequest)
	{
		xmlHttp=new XMLHttpRequest();
	}
	else if(window.ActiveXObject)
	{
		xmlHttp=new ActiveXObject("Microsoft.XMLHttp");
	}
	if(xmlHttp)
	{
		xmlHttp.open("GET",gstaurl,true);
		xmlHttp.send(null);
		xmlHttp=null;
	}
}
