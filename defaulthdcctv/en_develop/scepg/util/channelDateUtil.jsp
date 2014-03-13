<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<%
		
		java.text.SimpleDateFormat formatter1 = new java.text.SimpleDateFormat("yyyyMMdd");
		java.util.Date currDate1 = new java.util.Date();
		String strDate = formatter1.format(currDate1);
		
		
		java.util.Calendar cal = java.util.Calendar.getInstance();
		int datalength = 7;
        java.lang.StringBuffer buf=new java.lang.StringBuffer();
		java.lang.StringBuffer buf1=new java.lang.StringBuffer();
		for(int i=0;i<datalength;i++)
		{
			cal.set(java.util.Calendar.DATE, cal.get(java.util.Calendar.DATE) - 1);
			java.util.Date beforeDate = cal.getTime();
			String dataValue = formatter1.format(beforeDate);
			buf.append(dataValue+",");
		};
		String resultNum=buf.toString().substring(0, buf.length()-1);
		
		String[] array=resultNum.split(",");
		for(int i=0;i<array.length;i++)
		{
			array[i]=array[i].substring(4,6)+"月"+array[i].substring(6,8)+"日";
		    if(array[i].substring(0, 1).equals("0"))
		    {
		    	array[i]=array[i].substring(1);
		    	
		    }
		    buf1.append(array[i]+",");
		}
		
		String currentResult=buf1.toString().substring(0, buf1.length()-1);
		
	%>	

<script type="text/javascript">

</script>