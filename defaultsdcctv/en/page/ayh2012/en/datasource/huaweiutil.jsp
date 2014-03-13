<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.File" %>
<%@ include file="safeutil.jsp"%>
<%!
	
public class HuaWeiUtil extends SafeUtil{
	 
	//postPathMap:POSTERPATHS字段对应的HashMap,defaultPath:图片不存在是给的默认图片路径,request：JSP默认对象
	public String getPosterPath(HashMap postPathMap,String defaultPath,HttpServletRequest request) 
	{
	    String picPath = defaultPath;
		String[] picPathTemp = null;
		int mapLength = 0;		   
		if(postPathMap==null)
		{
			return picPath;
		}
		if(postPathMap.size() != 0)
		{
			for(int i=0;i < 14;i++)
			{
				if(postPathMap.containsKey("1"))
				{
					 mapLength = ((String[]) postPathMap.get("1")).length;
					 picPathTemp = new String[mapLength];
					 picPathTemp = (String[]) postPathMap.get("1");
					 break;
				}
				else if(postPathMap.containsKey(i + "") && i != 1)
				{	
					 mapLength = ((String[]) postPathMap.get(i + "")).length;
					 picPathTemp = new String[mapLength];
					 picPathTemp = (String[]) postPathMap.get(i + "");
					 break;
				}
				else if(i == 13 && postPathMap.containsKey("99"))
				{
					 mapLength = ((String[]) postPathMap.get("99")).length;
					 picPathTemp = new String[mapLength];
					 picPathTemp = (String[]) postPathMap.get("99");
					 break;
				}						
			}	   
		}
		
		//二次校验,用于判断路径下的图片是否存在
		String pagePath = request.getRealPath("./");
		for(int j = 0;j < mapLength;j++)
		{
			if(null == picPathTemp[j])
			{
				picPath = defaultPath;
				return picPath;
			}
			int numTemp = picPathTemp[j].lastIndexOf("images/universal/film");
			if(numTemp > 0)
			{
				String strTemp = picPathTemp[j].substring(numTemp);
				strTemp = "/jsp/" + strTemp;
				File imagesFile = new File(pagePath + strTemp);
				if(!imagesFile.exists())
				{
					if(j == mapLength -1)
					{
						picPath = defaultPath;
						break;
					}
				}
				else
				{
					picPath = picPathTemp[j];
					break;
				}
			}
		}	
		return  picPath;
    }
	
	//重载方法2:postPathMap:POSTERPATHS字段对应的HashMap,defaultPath:图片不存在是给的默认图片路径,request：JSP默认对象,posttype:获取的海报位置
	public HashMap getPosterPath(HashMap postPathMap,String defaultPath,HttpServletRequest request,String posttype)
	{
	    String picPath = defaultPath;
		HashMap picPathTemp = new HashMap();
		
		int mapLength = 0;		   
		if(postPathMap==null)
		{
			picPathTemp.put("type"+posttype,picPath);//默认值
			return picPathTemp;
		}
		
		if(!postPathMap.isEmpty())
		{
			Iterator iter = postPathMap.entrySet().iterator();
            while (iter.hasNext()&&!picPath.equals(defaultPath)) { 
                Map.Entry entry = (Map.Entry) iter.next(); 
                String key = entry.getKey().toString();
				if(key.equals(posttype)){
					Object val = entry.getValue();
					picPathTemp.put("type"+key,val);
				}
             } 	
		}				
		return picPathTemp;
    }
	
	//重载的方法：当图片不存在时则返回"false"字符串，否则返回图片路径
	public String getPosterPath(HashMap postPathMap,HttpServletRequest request) 
	{
	    String picPath = "false";
		String[] picPathTemp = null;
		int mapLength = 0;		   
		if(postPathMap==null)
		{
			return "false";
		}
		if(postPathMap.size() != 0)
		{
			for(int i=0;i < 14;i++)
			{
				if(postPathMap.containsKey("1"))
				{
					 mapLength = ((String[]) postPathMap.get("1")).length;
					 picPathTemp = new String[mapLength];
					 picPathTemp = (String[]) postPathMap.get("1");
					 break;
				}
				else if(postPathMap.containsKey(i + "") && i != 1)
				{	
					 mapLength = ((String[]) postPathMap.get(i + "")).length;
					 picPathTemp = new String[mapLength];
					 picPathTemp = (String[]) postPathMap.get(i + "");
					 break;
				}
				else if(i == 13 && postPathMap.containsKey("99"))
				{
					 mapLength = ((String[]) postPathMap.get("99")).length;
					 picPathTemp = new String[mapLength];
					 picPathTemp = (String[]) postPathMap.get("99");
					 break;
				}						
			}	   
		}
		
		//二次校验,用于判断路径下的图片是否存在
		String pagePath = request.getRealPath("./");
		for(int j = 0;j < mapLength;j++)
		{
			int numTemp = picPathTemp[j].lastIndexOf("images/universal/film");
			if(numTemp > 0)

			{
				String strTemp = picPathTemp[j].substring(numTemp);
				strTemp = "/jsp/" + strTemp;
				File imagesFile = new File(pagePath + strTemp);
				if(!imagesFile.exists())
				{
					return "false";
				}
				else
				{
					picPath = picPathTemp[j];
					break;
				}
			}
		}	
		return  picPath;
    }
	
	//重载方法3:postPathMap:POSTERPATHS字段对应的Hash,request：JSP默认对象,MadefaultPath:图片不存在是给的默认图片路径posttype:获取的海报位置
	public String getPosterPath(HashMap postPathMap,HttpServletRequest request,String defaultPath,String posttype)
	{
		
	    String picPath = defaultPath;
		if(posttype.equals("1")){
			picPath = "images/no_picture_192x264.jpg";
		}else if(posttype.equals("2")){
			picPath = "images/no_picture_259x232.jpg";
		}else if(posttype.equals("5")){
			picPath = "images/no_picture_259x165.jpg";
		}else if(posttype.equals("0")){
			picPath = "images/no_picture_259x232.jpg";
		}
		
		if(postPathMap==null){
			return null;
		}
		
		if("absolute".equals(defaultPath)){
			String path = request.getContextPath();
			String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
			String[] picPathTemp = null;
			
			int mapLength = 0;
			if(!postPathMap.isEmpty())
			{
				if(postPathMap.containsKey(posttype))
				{
					mapLength = ((String[]) postPathMap.get(posttype)).length;
					picPathTemp = new String[mapLength];
					picPathTemp = (String[]) postPathMap.get(posttype);
				}
			}
			if(picPathTemp!=null && picPathTemp.length!=0 && !picPathTemp[0].equals("")){
				picPath = picPathTemp[0];
			}
			String targetPath = picPath.replace("../../",basePath+"/EPG/jsp"+"/");
			return  targetPath;
		}
		else{
			String[] picPathTemp = null;
			
			int mapLength = 0;		   
			
			
			if(!postPathMap.isEmpty())
			{
				if(postPathMap.containsKey(posttype))
				{
					mapLength = ((String[]) postPathMap.get(posttype)).length;
					picPathTemp = new String[mapLength];
					picPathTemp = (String[]) postPathMap.get(posttype);
				}
			}
			if(picPathTemp!=null && picPathTemp.length!=0 && !picPathTemp[0].equals("")){
				picPath = picPathTemp[0];
			}
			return  picPath;
		}
    }
	//重载方法4:postPathMap:POSTERPATHS字段对应的Hash,request：JSP默认对象,MadefaultPath:图片不存在是给的默认图片路径posttype:获取的海报位置defaultType:默认图片类型
	public String getPosterPath(HashMap postPathMap,HttpServletRequest request,String defaultPath,String posttype,String defaultType)
	{

	    String picPath = defaultPath;
		if(defaultType.equals("1")){
			picPath = "images/no_picture_192x264.jpg";
		}else if(defaultType.equals("2")){
			picPath = "images/no_picture_259x232.jpg";
		}else if(defaultType.equals("5")){
			picPath = "images/no_picture_259x165.jpg";
		}else if(defaultType.equals("0")){
			picPath = "images/no_picture_259x232.jpg";
		}
		
		String[] picPathTemp = null;
		
		int mapLength = 0;		   
		if(postPathMap==null)
		{
			return picPath;
		}
		
		if(!postPathMap.isEmpty())
		{
			if(postPathMap.containsKey(posttype))
			{
				mapLength = ((String[]) postPathMap.get(posttype)).length;
				picPathTemp = new String[mapLength];
				picPathTemp = (String[]) postPathMap.get(posttype);
			}
		}
		if(picPathTemp!=null && picPathTemp.length!=0 && !picPathTemp[0].equals("")){
			picPath = picPathTemp[0];
		}
		return  picPath;
    }
	
	//重载方法5：传入相对路径，获取绝对路径
	public String getPosterPath(String picPath,HttpServletRequest request)
	{
		 String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
		 if("".equals(picPath))
		 {
			 return "";
		 }
		 String targetPath = picPath.replace("../../",basePath+"/EPG/jsp"+"/");
		 return targetPath;
	}
}

%>