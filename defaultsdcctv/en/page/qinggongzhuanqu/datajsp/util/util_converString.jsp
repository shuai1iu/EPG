<%@ page import="java.util.Date"%>
<%!
	//用于判断请求传过来的变量是否有值,如果没值则给它默认值
	public String checkVariable(String variable, String defValue)
	{
		if(null == variable|| "".equals(variable) || "null".equals(variable) || "undefined".equals(variable))
		{
			variable = defValue;
		}
		return variable;
	}
	
	//将string转换为int值,出现民常则给默认值
	public int stringParseInt(String variable, int defaultNum)
	{
		int varNum = 0;
		try
		{
			varNum = Integer.parseInt(variable);
		}
		catch(Exception ee)
		{
			varNum = defaultNum;
		}
		return varNum;
	}
	
	//将字符数组转换成字符串
	public String converString(String[] strs)
	{
		String str = "";
		for(int i=0; i<strs.length; i++)
		{
			if(strs.length == (i+1))
			{
				str = str + strs[i];
			}
			else
			{
				str = str + strs[i] + ",";
			}
		}
		return str;
	}
	public String getCustomDate(Date date,int delay) {
		return org.apache.commons.lang.time.DateFormatUtils.format(
				org.apache.commons.lang.time.DateUtils.addDays(date,delay), "yyyy-MM-dd");
	}

%>