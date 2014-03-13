<%
/**********************
* FileName:codepage.jsp
* Time:20130909 9:30
* Author:ZSZ
* description:标清各栏目code
**********************/
%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%!
	String shouyezhibo="11"; 
	
	
	final static String shouyetuijiancode="10000100000000090000000000035475"; 
	//final static String shouyerediancode="00000100000000090000000000018810";  
	//final static String shouyetuijiancoe="00000100000000090000000000018811"; 

	final static String shouyetuijiancoe="10000100000000090000000000032666";  
	final static String shouyerediancode="10000100000000090000000000032667"; 
	final static String shouyezhuanticode="10000100000000090000000000032970"; 
	final static String shouyezhuanticode1="10000100000000090000000000032971";
	final static String shouyetuijiancoe1="10000100000000090000000000032992";


        final static String dianbocode="10000100000000090000000000035476"; 
	final static String shuqiancode="00000100000000090000000000018864"; 
	final static String shoucangcode="00000100000000090000000000018863"; 
  	final static String topiccode="10000100000000090000000000030110";
	final static String indexiframecode="10000100000000090000000000026864";

		final static String filmtypeid="";//"00000100000000090000000000018150";
		final static String hottypeid="00000100000000090000000000018151";
		final static String animationtypeid="00000100000000090000000000018157";
		final static String filmrecommcode="10000100000000090000000000025331"; 
		final static String filmrankcode="10000100000000090000000000025332"; 
		final static String filmtopiccode="00000100000000090000000000018812";
		final static String hotrecommcode="10000100000000090000000000025333"; 
		final static String hotrankcode="10000100000000090000000000025334"; 
		final static String hottopiccode="00000100000000090000000000018812"; 
		final static String animationrecommcode="10000100000000090000000000025335"; 
		final static String animationrankcode="10000100000000090000000000025336"; 
		final static String animationtopiccode="";//"00000100000000090000000000018812"; 															
	final static String gaoqingzhibocode="00000100000000090000000000015840"; 
	final static String biaoqingzhibocode="00000100000000090000000000015842"; 
%>
<script>
var fourcolorkey=new Array("live.jsp","playback.jsp","vod.jsp","space_collect.jsp","search.jsp","space_collect.jsp");
var indexhref=new Array("live.jsp","vod.jsp","playback.jsp","../../../defaultgdsd/en/page/index.jsp","app.jsp","topiclist.jsp","ranking.jsp");

</script>
<%
	String tmpcurpageName = request.getRequestURI();
	tmpcurpageName = tmpcurpageName.substring(tmpcurpageName.lastIndexOf("/")+1);
	tmpcurpageName = tmpcurpageName.substring(0,tmpcurpageName.lastIndexOf("."));
	ArrayList tmpfocstrList = (ArrayList)request.getSession().getAttribute("focstrs");
	List tmpallindePageName = Arrays.asList("index","dibbling");
	if(tmpallindePageName.contains(tmpcurpageName)){
			tmpfocstrList = new ArrayList();
			request.getSession().setAttribute("focstrs",tmpfocstrList);
	}

        ServiceHelp serviceHelpChannel = new ServiceHelp(request);
	int imageorchannel = 0;
	if(serviceHelpChannel !=null)
        {
            String codeOfChannel = serviceHelpChannel.getVasUrl(20500); 
	    if(codeOfChannel != null && codeOfChannel != "")
	    {
	        if(Integer.parseInt(codeOfChannel) == -1)
		{
		    imageorchannel = 1;
		}
		else
		{
		    shouyezhibo = codeOfChannel;
                }
             }
         }
%>
