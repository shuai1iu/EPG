<%@ include file = "util/util_getPosterPaths.jsp"%>
<%
	JSONArray vasArrayList = new JSONArray();
	ServiceHelp serviceHelp = new ServiceHelp(request);
	ArrayList categoryVasList = metaData.getVasListByTypeId(Vas_TYPE_ID,3,0);
//	System.out.println("-----------DatuVasList:"+DatuVasList);
	if(null != categoryVasList && categoryVasList.size() > 0)
	{
		List VasList = (ArrayList) categoryVasList.get(1);
		
		/*ArrayList XiaotuVasList = metaData.getVasListByTypeId(XIAOTU_TYPE_ID,2,0);
	//	System.out.println("-----------XiaotuVasList:"+XiaotuVasList);
		if(null != XiaotuVasList && XiaotuVasList.size() > 0)
		{
			List VasTempList = (ArrayList) XiaotuVasList.get(1);
			for(int j=0;j<XiaotuVasList.size();j++)
			{
				VasList.add(VasTempList.get(j));
			}*/
			
			if(null != VasList && VasList.size() > 0)
			{
				for(int i=0; i<VasList.size();i++)
				{
					Map map = (HashMap)VasList.get(i);
					int vasId = ((Integer) map.get("VASID")).intValue();
					//根据增值业务id获取增值业务详细信息
					HashMap vasInfo = (HashMap)metaData.getVasDetailInfo(vasId);
					if(null != vasInfo)
					{
						//将增值业务名称充当应用名称部分
						String vasName = (String)vasInfo.get("VASNAME");	
						vasName = vasName == null ? "" : vasName;					
						
					//	String vasImgUrl = (String)vasInfo.get("POSTERPATH");
						HashMap picMap = (HashMap)vasInfo.get("POSTERPATHS");
						String defaultPath = "images/dot.gif";
						String picPath = getPosterPath(picMap,defaultPath,request,"5");
					//	System.out.println("-----------------picPath:"+picPath);
						JSONObject vasObj = new JSONObject();
						vasObj.put("vasName", vasName);
						vasObj.put("imgUrl", picPath);
				//		System.out.println("=========imgUrl:"+vasImgUrl);
						
						//将增值业务名称充当应用url部分
						String url = (String)serviceHelp.getVasUrl(vasId);
						if("" != url && null != url)
						{
							vasObj.put("url", url);
						}
						else
						{
							vasObj.put("url", "http");
						}
						vasArrayList.add(vasObj);
					}
				}
			}
//		}
	}
%>
<script>
	var vasList = <%=vasArrayList%>;
</script>