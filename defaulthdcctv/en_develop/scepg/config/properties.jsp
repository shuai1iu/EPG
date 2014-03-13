<%@ page import="javax.servlet.ServletContext" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%!
  public static Properties  getParams(HttpServletRequest req) throws Exception{		
		String pathInfo = req.getRequestURI();
		pathInfo = pathInfo.replaceFirst(req.getContextPath(), "");
		ServletContext context = req.getSession().getServletContext();
		String file = context.getRealPath(pathInfo);
		if(file.indexOf("epgPage/")!=-1){
			String[] strs = file.split("epgPage/");
	   		file = strs[0]+"portal.properties";
		}
		Properties props = new Properties();
		FileInputStream reader = new FileInputStream(file);
		props.load(reader);
		reader.close();
		return props;
	}
%>
<%
  	Properties pageParams =getParams(request);
  	String datajspname = (String)pageParams.get("datajspname");
%>