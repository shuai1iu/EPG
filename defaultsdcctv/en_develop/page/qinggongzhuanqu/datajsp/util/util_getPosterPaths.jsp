<!-- 文件名：util_getPosterPaths.jsp -->
<!-- 版  权：Copyright 2005-2007 Huawei Tech. Co. Ltd. All Rights Reserved. -->
<!-- 描  述：公共取图片路径方法 -->
<!-- 作  者：高磊&程勇 -->
<!-- 创建时间：2009-2-1 -->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%!
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
	
	//重载的方法：当图片不存在时则返回“false”字符串，否则返回图片路径
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
	
	
	/**
	 * 重载posterpath, 根据图片的类型获得HashMap中的图片
	 * imageType:
	 *   0: 缩略图
	 *   1： 海报
	 */
	public String getPosterPath(HashMap postPathMap,String defaultPath,HttpServletRequest request, String imageType) 
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
			if(postPathMap.containsKey(imageType))
			{
				 mapLength = ((String[]) postPathMap.get(imageType)).length;
				 picPathTemp = new String[mapLength];
				 picPathTemp = (String[]) postPathMap.get(imageType);
			}  
		}
		//二次校验,用于判断路径下的图片是否存在
		String pagePath = request.getRealPath("./");
		if (null != picPathTemp && picPathTemp.length > 0)
		{
			for (int i = 0; i < picPath.length(); i++)
			{
				if(null == picPathTemp[i])
				{
					picPath = defaultPath;
					return picPath;
				}
				int numTemp = picPathTemp[i].lastIndexOf("images/universal/film");
				if(numTemp > 0)
				{
					String strTemp = picPathTemp[i].substring(numTemp);
					strTemp = "/jsp/" + strTemp;
					File imagesFile = new File(pagePath + strTemp);
					if(!imagesFile.exists())
					{
						if(i == mapLength - 1)
						{
							picPath = defaultPath;
							break;
						}
					}
					else
					{
						picPath = picPathTemp[i];
						break;
					}
				}
			}
		}
		return  picPath;
    }
%>


