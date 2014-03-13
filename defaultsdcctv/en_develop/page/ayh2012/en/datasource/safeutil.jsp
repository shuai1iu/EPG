<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%!
	
public class SafeUtil {
	 
	public String getTopString(String value,int len,String defaultString){
		if (value==null || value.trim().equals("")) {
			return defaultString;
		}
		if (value.length()>len) {
			return value.substring(0, len-1)+"..";
		}
		return value;
	}
	
	
	
	public String getTopStringGBK(String value,int len,String defaultString){
		if (value==null || value.trim().equals("")) {
			return defaultString;
		}
		char[] cs=value.toCharArray();
		char[] resultcs=new char[cs.length];
		for (int i = 0,flag=0; i < cs.length; i++) {
			if (cs[i]>255) {
				flag+=3;
			}else{
				flag++;
			}
			if (flag<len) {
				resultcs[i]=cs[i];
			}
		}
		 
		return new String(resultcs);
	}
	
	
    public Long[] strToLong(String jobIds){
    	if (jobIds==null) {
			return null;
		}
    	String[] s=jobIds.split(",");
    	
    	List<Long> list=new ArrayList<Long>();
    	for (int i = 0; i < s.length; i++) {
    		if (s[i].equals("")) {
				continue;
			}
    		list.add(getLong(s[i]));
		}
    	Long[] l=new Long[list.size()];
    	for (int i = 0; i < l.length; i++) {
			l[i]=list.get(i);
		}
    	return l;
    }
    
    public String delNotChar(String ids){
    	ids=ids.replaceAll(",{1,10}", ",").replaceAll(" ", "");
    	if (ids.startsWith(",")) {
    		ids=ids.replaceFirst(",", "");
		}
    	if (ids.endsWith(",")) {
    		ids=ids.substring(0, ids.length()-1);
		}
    	return ids;
    }
    
     
    public Object[] vectorToObjectArray(Vector vec){
        Object[] tmpobjects = null;
        int i=0;
        if((vec!=null)&&(vec.size()>0)){
            tmpobjects = new Object[vec.size()];
            for(i=0;i<vec.size();i++){
                tmpobjects[i] = vec.get(i);                
            }
        }
        return tmpobjects;        
    }
    public int getYearOfDate(java.util.Date date){
        Calendar   cal   =   Calendar.getInstance();
        cal.setTime(date);        
        return cal.get(Calendar.YEAR);
    }
    public int getCurrentYear(){
        Calendar   cal   =   Calendar.getInstance();
        return cal.get(Calendar.YEAR);
    }
    public int getAgeOfBirthday(Object obj){
        int tmpage=0;
        java.util.Date tmpdate = getSqlDate(obj);
        if(tmpdate!=null){
                   tmpage = getCurrentYear()- getYearOfDate(tmpdate);
        }
        return tmpage;
    }
    
    public int getInt(Object obj){
    	if(obj==null) return 0;
   	 if ( isDia(obj) ) {
   		 Integer tmpret = Integer.valueOf(obj.toString().trim());
            return tmpret;
		}
        return 0;
    }

public Long getLong(Object obj,Long defvalue){
 Long tmpret = defvalue;
 if ( isDia(obj) ) {
	  tmpret = Long.valueOf(obj.toString().trim());
     return tmpret;
}
 return tmpret;
}
    public int getInt(Object obj,int defvalue){
        int tmpret =defvalue;
        if ( isDia(obj) ) {
   		  tmpret = Integer.valueOf(obj.toString().trim());
            return tmpret;
		}
       return tmpret;
    }
     public Integer getInteger(Object obj){
    	 if(obj==null) return null;
    	 if ( isDia(obj) ) {
    		 Integer tmpret = Integer.valueOf(obj.toString().trim());
             return tmpret;
		}
         return null;
    }
     
     public Short getShort(Object obj){
    	 if(obj==null) return null;
    	 if ( isDia(obj) ) {
    		 Short tmpret = Short.valueOf(obj.toString().trim());
             return tmpret;
		}
         return null;
     }
     
     public Long getLong(Object obj){
         if(obj==null) return null;
         if ( isDia(obj) ) {
        	 Long tmpret = Long.valueOf(obj.toString().trim());
             return tmpret;
		}
         return null;
     }
     
     public String getIntString(Object input,int type){
    	 if (input==null) {
			return null;
		}
    	 String[] s=input.toString().split("[.]");
    	 if (type==0) {
    		 return s[0];
		}
    	 return s[0];
     }
     
      public Integer getInteger(Object obj,int defvalue){
        Integer tmpret = defvalue;
        if ( isDia(obj) ) {
        	tmpret = Integer.valueOf(obj.toString().trim());
            return tmpret;
		}
       return tmpret;
    }
    public double getDouble(Object obj){
        double tmpvalue=0;
        try{
                tmpvalue = Double.parseDouble(obj.toString().trim());
        }catch(Exception ex){
            
        }
        return tmpvalue;
    }
    public double getDouble(Object obj,double defvalue){
            double tmpvalue=defvalue;
            try{
                    tmpvalue = Double.parseDouble(obj.toString().trim());
            }catch(Exception ex){
                
            }
            return tmpvalue;
        }
    

     
    
    
    public String getString(Object obj){
        String tmpret="";
        if(obj!=null){
        	tmpret = obj.toString().trim();
        }
        
        return tmpret;
    }


    public java.util.Date getSqlDate(Object obj){
        java.util.Date tmpdate = null;
        if(obj!=null){
        	 if (obj instanceof java.util.Date) {
        			return (java.util.Date)obj;
        		}
        	 if (obj instanceof String) {
     			return getSqlDate(obj,"yyyy-MM-dd");
     		}
                try{
                    tmpdate = new java.util.Date(((java.sql.Timestamp)obj).getTime());   
                }catch(Exception ex){
                    
                }
        }
        return tmpdate;
    }
    public java.util.Date getSqlDate(Object obj,String format){
        java.util.Date tmpdate = null;
        if((format==null)||(format.equals("")))format ="yyyy-MM-dd HH:mm:ss";
        java.text.SimpleDateFormat s= new java.text.SimpleDateFormat(format);
        if(obj!=null){
                try{
                	if (obj.toString().startsWith("1-")) {
                		return tmpdate;
					}
                    tmpdate = new java.util.Date(s.parse(obj.toString().trim()).getTime());
                }catch(Exception ex){
                   
                }
        }
        return tmpdate;
    }
    public java.sql.Timestamp getSqlTimestamp(Object obj,String format){
        java.sql.Timestamp tmpdate = null;
        if((format==null)||(format.equals("")))format ="yyyy-MM-dd HH:mm:ss";
        java.text.SimpleDateFormat s= new java.text.SimpleDateFormat(format);
        if(obj!=null){
                try{
                    tmpdate = new java.sql.Timestamp(s.parse(obj.toString().trim()).getTime());
                }catch(Exception ex){
                    
                }
        }
        return tmpdate;
    }
    public java.util.Date getDate(String date){
        return getSqlDate(date, "yyyy-MM-dd");
    }
    
    /**/
    public java.util.Date getSqlCurrentTime(){
        Calendar   ca           =   Calendar.getInstance();
        java.util.Date   tmpnow     =   new java.util.Date(ca.getTimeInMillis());
        return tmpnow;
    }
    public String getCurrentTimeStr(String format){
        String tmpret="";
        try {
                Calendar   ca           =   Calendar.getInstance();
                SimpleDateFormat   sdf   = new SimpleDateFormat(format);
                tmpret = sdf.format(ca.getTime());
        }catch(Exception ex){
            
        }
        return tmpret;
    }

    /**
     * 获取当前时间偏移的最终时间，
     * @param days
     * @return
     */
    public java.util.Date getSqlTimeByDayOffset(int days){
    	 Calendar   ca           =   Calendar.getInstance();
        ca.add(Calendar.DATE,days);
        java.util.Date   tmpnow     =   new java.util.Date(ca.getTimeInMillis());
        return tmpnow;
    }
    
    public java.util.Date getSqlTimeByDayOffset(Calendar   ca,int days){
        ca.add(Calendar.DATE,days);
        java.util.Date   tmpnow     =   new java.util.Date(ca.getTimeInMillis());
        return tmpnow;
    }
	  public java.util.Date getSqlTimeByDayOffset(java.util.Date date,int field,int offset){
	      Calendar   ca           =   Calendar.getInstance();
	      ca.setTime(date);
	      ca.add(field,offset);
	      java.util.Date   tmpnewdate     =   new java.util.Date(ca.getTimeInMillis());
	      return tmpnewdate;
	  }
	  public java.sql.Timestamp getSqlTimeByDayOffset(java.sql.Timestamp date,int field,int offset){
	      Calendar   ca           =   Calendar.getInstance();
	      ca.setTime(date);
	      ca.add(field,offset);
	      java.sql.Timestamp   tmpnewdate     =   new java.sql.Timestamp(ca.getTimeInMillis());
	      return tmpnewdate;
	  }
    public String formatDate(java.util.Date date,String format){
        String tmpdatestr="";
        if (date==null) {
        	return tmpdatestr;
		}
        try{
                SimpleDateFormat f=new SimpleDateFormat(format);
                tmpdatestr =  f.format(date);
        }catch(Exception ex){
           
        }
        return tmpdatestr;
    }
    public java.util.Date getUtilDate(java.util.Date date){
        java.util.Date tmpUtilDate=new java.util.Date(date.getTime());
        return tmpUtilDate;               
    }
    public java.sql.Time getSqlTime(java.util.Date date){
       java.sql.Time sTime=new java.sql.Time(date.getTime());
        return sTime;
    }
    public java.sql.Timestamp getSqlTimeStamp(java.util.Date date){
       java.sql.Timestamp stp=new java.sql.Timestamp(date.getTime());
        return stp;
    }
 
    
    
    
	/**
	 * 判断对象是否可安全转为为整数
	 * */
	public boolean isDia(Object obj){
		if (obj == null || (""+obj).trim().equals("")) {
			return false;
		}
		String s = (""+obj).trim();
		s=s.replaceAll("-", "");
		char[] c = s.toCharArray();
		for (int i = 0; i < c.length; i++) {
			if (c[i]>'9' || c[i]<'0') {
				return false;
			}
		}
		return true;
	}
	
	public long subdate(String str1,String str2)
	{
		//日期相减得到相差的日期
		long day=0;
		try {
			Date date1 = safeGetDate(str1);
			Date date2 = safeGetDate(str2);
			long l = date1.getTime()-date2.getTime()>0 ? date1.getTime()-date2.getTime():date2.getTime()-date1.getTime();
			day = (date1.getTime()-date2.getTime())/(24*60*60*1000);
		} catch ( Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return day;
	}
	
	public String subdate(String str1,String str2,int type)
	{
		//日期相减得到相差的日期
		long day=0;
		try {
			Date date1 = safeGetDate(str1);
			Date date2 = safeGetDate(str2);
			long l = date1.getTime()-date2.getTime()>0 ? date1.getTime()-date2.getTime():date2.getTime()-date1.getTime();
			if (type==Calendar.HOUR) {
				return Math.abs((date1.getTime()-date2.getTime())/(60*60*1000))+"";
			}
			if (type==Calendar.MINUTE) {
				return Math.abs((date1.getTime()-date2.getTime())/(60*1000))+"";
			}
			if (type==Calendar.DAY_OF_YEAR) {
				return Math.abs((date1.getTime()-date2.getTime())/(24*60*60*1000))+"";
			}
			day = (date1.getTime()-date2.getTime())/(24*60*60*1000);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return day+"";
	}
	
	public String subdate(Date date1,Date date2,int type)
	{
		//日期相减得到相差的日期
		long day=0;
		try {
			 
			long l = date1.getTime()-date2.getTime()>0 ? date1.getTime()-date2.getTime():date2.getTime()-date1.getTime();
			if (type==Calendar.HOUR) {
				return Math.abs((date1.getTime()-date2.getTime())/(60*60*1000))+"";
			}
			if (type==Calendar.MINUTE) {
				return Math.abs((date1.getTime()-date2.getTime())/(60*1000))+"";
			}
			if (type==Calendar.DAY_OF_YEAR) {
				return Math.abs((date1.getTime()-date2.getTime())/(24*60*60*1000))+"";
			}
			day = (date1.getTime()-date2.getTime())/(24*60*60*1000);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return day+"";
	}
	
	public Date safeGetDate(String dateformat){
		dateformat=dateformat.replaceAll("[^0-9]", "");
		if (dateformat.replaceAll("[0-9]*", "").length()==0) {
			if (dateformat.length()==8) {
				return getSqlDate(dateformat, "yyyyMMdd");
			}
			if (dateformat.length()==14) {
				return getSqlDate(dateformat, "yyyyMMddHHmmss");
			}
			if (dateformat.length()==6) {
				return getSqlDate(dateformat, "HHmmss");
			}
		}
		
		
		return null;
	}
	
	
}

%>