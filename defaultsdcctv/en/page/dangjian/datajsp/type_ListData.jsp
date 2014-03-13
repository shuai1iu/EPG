<%!
	public JSONArray getTypeList(MetaData metaData,String recTypeId)
	{
		JSONArray typeList = new JSONArray();
		ArrayList resultList = metaData.getTypeListByTypeId(recTypeId, 999, 0);
//		System.out.println("resultList:"+resultList);
		if(null != resultList && resultList.size() > 0)
		{
			HashMap map = (HashMap)resultList.get(0);
			if(null != map)
			{
				int totalNum = ((Integer)map.get("COUNTTOTAL")).intValue();
				if(totalNum > 0)
				{
					ArrayList list = (ArrayList)resultList.get(1);
					for(int i = 0; i < list.size(); i++)
					{
						HashMap tempMap = (HashMap)list.get(i);
						JSONObject tempObj = new JSONObject();
	
						String typeId = (String)tempMap.get("TYPE_ID");
						String typeName = (String)tempMap.get("TYPE_NAME");
						String typeImg = (String)tempMap.get("TYPE_PICPATH");
						tempObj.put("typeId", typeId);
						tempObj.put("typeImg", typeImg);
				//		System.out.println("--------------typeImg:"+typeImg);
						tempObj.put("typeName", typeName);
						typeList.add(tempObj);
					}
				}
			}
		}
		return typeList;
		
	}
%>
<%
	MetaData metaData = new MetaData(request);
%>