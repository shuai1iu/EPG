<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页_央视高清EPG</title>
<meta name="page-view-size" content="640*530" />
<script src="js/registerGlobalKey.js"  language="javascript"></script>
<script type="text/javascript">
<%

String directPlay = request.getParameter("directplay");
String lastChannelNo = request.getParameter("lastchannelNo");
%>

var directPlay = <%=directPlay%>;
var isFirst = 0;
var lastChannelNo = <%=lastChannelNo%>;
window.onload=function()
{

    if( null != directPlay)
    {
         isFirst = 1;
    }

	if ("1" == directPlay && "" != lastChannelNo && null != lastChannelNo)
	{       
		window.location.href="page/play_ControlChannel.jsp?CHANNELNUM="+lastChannelNo+"&COMEFROMFLAG=1&returnurl=index.jsp";
	}
	else
	{
		window.location.href="page/index.jsp?isFirst="+ isFirst;
	}



	if (typeof(iPanel) != 'undefined')
	{
		iPanel.focusWidth = "2";
		iPanel.defaultFocusColor = "#FCFF05";
	}


}


</script>
</head>

<body>
</body>
</html>
