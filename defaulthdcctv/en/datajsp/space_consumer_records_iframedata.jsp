<%@ page contentType="text/html; charset=UTF-8" language="java" buffer="32kb" %>
<%@page pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="java.lang.Double"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="SubStringFunction.jsp"%>
<%
	int curpage=1;
    int pagecount=1;
	if(request.getParameter("curpage")!=null)
	{
		curpage = Integer.parseInt(request.getParameter("curpage"));
	}
    int pos = curpage * 11 - 11;
    ServiceHelpHWCTC serviceHelp = new ServiceHelpHWCTC(request); 
	String month1 = StringDateUtil.getTodaytimeString("yyyymm");
	String month3 = StringDateUtil.adjustMonth(month1, -2);
	Map retMap = (HashMap)serviceHelp.queryOrderHWCTC(month3,month1);
	String[] prodCode = new String[1];
    String[] prodName = new String[1];
    String[] price = new String[1];
	String[] price_cut = new String[1];
    String[] ordertime = new String[1];
	String[] prodName_cut = new String[1];	
	String[] isOrder = new String[1];
	int[] orderType = new int[1];
	String[] startTime = new String[1];
    int countTotal= 0;
    int ret_code = ((Integer) retMap.get("RETCODE")).intValue();
    ArrayList billList=new ArrayList();
    if (retMap!=null && ret_code == EPGErrorCode.SEARCHBILL_SUCCESSED)
	{
		    countTotal = ((String[])retMap.get("PROD_CODE")).length;
		    //产品描述列表(名称)
		    if(countTotal != 0)
			{	
			    pagecount=(int)Math.ceil(countTotal/8.0);
				prodCode = new String[countTotal];
				prodName = new String[countTotal];
				prodName_cut = new String[countTotal];
				//产品价格列表
				price = new String[countTotal];
				price_cut = new String[countTotal];
				//产品失效时间
				ordertime = new String[countTotal];
				
				
				isOrder  = new String[countTotal];
				prodCode = (String[])retMap.get("PROD_CODE");
				prodName = (String[])retMap.get("PROD_DES");
				price = (String[])retMap.get("PROD_PRICE");
				ordertime = (String[])retMap.get("PROD_ENDTIME");
				orderType = (int[])retMap.get("PROD_ORDERTYPE");
				
				startTime = (String[])retMap.get("PROD_BEGINTIME");
				
				
				for(int i = pos; ((i < countTotal)&&(i<(pos+11))); i++)
				{
					prodName_cut[i] = subStringFunction(prodName[i],1,300); 
					
					if(price[i] == null||price[i].equals(""))
					{
						price[i] = "未知";
					}

					price_cut[i] = subStringFunction(price[i],1,60);
					if(ordertime[i] == null||ordertime[i].equals(""))
					{
						ordertime[i] = "未知";
					}
					else
					{	
						String year = ordertime[i].substring(0,4);
						String month = ordertime[i].substring(4,6);
						String day = ordertime[i].substring(6,8);
						String hou = ordertime[i].substring(8,10);
						String mins = ordertime[i].substring(10,12);
						String tempTime = month+"-"+day+" "+hou+":"+mins;
						ordertime[i] = tempTime;
					}
					HashMap billobj = new HashMap();
					billobj.put("prodCode",prodCode[i]);  
					billobj.put("prodName",prodName[i]); 
					billobj.put("price",price[i]); 
					billobj.put("prodName_cut",prodName_cut[i]);  
					billobj.put("price_cut",price_cut[i]); 
					billobj.put("ordertime",ordertime[i]); 
					billobj.put("isOrder",isOrder[i]); 
					billobj.put("orderType",orderType[i]); 
					billobj.put("startTime",startTime[i]); 
					billList.add(billobj);
			   }
          }	
	 }
     response.getWriter().print(JSONArray.fromObject(billList));	
%>
