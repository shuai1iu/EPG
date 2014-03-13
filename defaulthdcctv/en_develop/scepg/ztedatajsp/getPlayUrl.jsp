<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex"%>
<%
	String type=request.getParameter("type")==null?"VOD":request.getParameter("type");
	String mediacode=request.getParameter("mediacode")==null?"1":request.getParameter("mediacode");
	String categoryCode=request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
	String varName = request.getParameter("varName")==null?"playUrl":request.getParameter("varName");
	String value=request.getParameter("value")==null?"-1":request.getParameter("value");
	String definition=request.getParameter("definition")==null?"0":request.getParameter("definition");
	String isBug=request.getParameter("isBug")==null?"-1":request.getParameter("isBug");
	String breakpoint=request.getParameter("breakpoint")==null?"0":request.getParameter("breakpoint");
	HashMap ht = new HashMap();//根据内容类型获得对应的内容类型值
	ht.put("VOD","1");
	ht.put("CHAN","2");
	ht.put("TVOD","4");
    String typeid = (String)ht.get(type);
%>
	 <ex:params var="inputhash">
					<ex:param name="terminalflag" value="1"/>
				    <ex:param name="contenttype" value="<%=typeid%>"/>
				    <ex:param name="columncode" value="<%=categoryCode%>"/>
				    <ex:param name="programcode" value="<%=value%>"/>
					<ex:param name="definition" value="<%=definition%>"/>
				</ex:params>
				<ex:action name="auth" inputparams="${inputhash}" var="authInfo">
					<ex:params var="inputhash2">
						<ex:param name="authidsession" value="${authInfo.productInfo.AuthorizationID}"/>
						<ex:param name="breakpoint" value="<%=breakpoint%>"/>
						<ex:param name="definition" value="<%=definition%>"/>
						<ex:param name="programcode" value="<%=value%>"/>
						<ex:param name="mediaservice" value="1"/>
					</ex:params>
					<ex:action name="vod_play" inputparams="${inputhash2}" var="playInfo">
					</ex:action>
				</ex:action>	
		<%
			if(isBug.equals("1")){
				Map playInfo = (Map) pageContext.getAttribute("playInfo");
				System.out.println(playInfo.get("playurl").toString());
			}
		%>
    	var <%=varName%>="${playInfo.playurl}";