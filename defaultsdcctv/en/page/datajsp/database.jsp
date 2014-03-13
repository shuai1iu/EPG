<%@ page contentType="text/html; charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="net.sf.json.JSONArray"%>
<%@ page import="net.sf.json.JSONObject"%>
<%!public class MyUtil {
		HttpServletRequest re;

		public MyUtil(HttpServletRequest re) {
			this.re = re;
		}
        public MyUtil()
        {
        	
        }
		//栏目 200
		public ArrayList getTypeListData(String code, int size) {
			return getTypeListData(code, size, 1);
		}

		public ArrayList getTypeListData(String code, int size, int curpage) {
			return getListData(code, size, curpage, "type");
		}
        //视频和音频 0，4
		public ArrayList getVodListData(String code, int size) {
			return getVodListData(code, size, 1);
		}

		public ArrayList getVodListData(String code, int size, int curpage) {
			return getListData(code, size, curpage, "vod");
		}
		//视频频道和音频频道 1，2
		public ArrayList getLiveListData(String code, int size) {
			return getLiveListData(code, size, 1);
		}

		public ArrayList getLiveListData(String code, int size, int curpage) {
			return getListData(code, size, curpage, "live");
		}
		//获得混合栏目
		public ArrayList getContentListData(String code, int size) {
			return getContentListData(code, size, 1);
		}

		public ArrayList getContentListData(String code, int size, int curpage) {
			return getListData(code, size, curpage, "content");
		}
		//获得增值业务列表
		public ArrayList getVasListData(String code, int size) {
			return getVasListData(code, size, 1);
		}

		public ArrayList getVasListData(String code, int size, int curpage) {
			return getListData(code, size, curpage, "vas");
		}
		public ArrayList getListData(String code, int size, int curpage,
				String mytype) {
			int begin = (curpage - 1) * size;
			MetaData metaData = new MetaData(re);
			JSONArray jsonList = null;
			ArrayList list = null;
			if (mytype.equals("vod"))
			{
				list = metaData.getVodListByTypeId(code, size, begin);
				if(help(list))
					return nullListReturn();
			    ArrayList templist=(ArrayList)list.get(1);
				//转换PosterPaths格式
				System.out.println("vodnum=="+templist.size());
				for(int i=0;i<templist.size();i++)
				{
					HashMap temp1=(HashMap)templist.get(i);   //获取对象 hashmap
					HashMap temp2=(HashMap)temp1.get("POSTERPATHS");  //获取当前对象的POSTERPATHS
					//String[][] shuzu=new String[temp2.size()][];  //根据POSTER
					System.out.println("VODNAME=="+temp1.get("VODNAME"));
					HashMap tmptype=new HashMap();
					if(!temp2.isEmpty())
					{
					   Iterator iter = temp2.entrySet().iterator(); 
                       while (iter.hasNext()) { 
                            Map.Entry entry = (Map.Entry) iter.next(); 
                            Object key = entry.getKey(); 
                            Object val = entry.getValue();
							tmptype.put("type"+key,val);
                       } 	
					}
				    
				    temp1.put("POSTERPATHS",tmptype);
				}
				list.set(1,templist);
			}
			else if (mytype.equals("content"))
			{
				list = metaData.getContentBySubjectId(code, size, begin);
				if(help(list))
					return nullListReturn();
			}
			else if (mytype.equals("live"))
			{
				list = metaData.getLiveChanListByTypeId(code, size, begin);
				if(help(list))
				     return nullListReturn();
			}
			else if(mytype.equals("vas"))
			{
				list = metaData.getVasListByTypeId(code, size, begin);
				if(help(list)){
				     return nullListReturn();
				}else{
					ServiceHelp serviceHelp = new ServiceHelp(re);
					ArrayList vasList = (ArrayList)list.get(1);
					for(Object valObj : vasList){
						Integer vasid = (Integer)((HashMap)valObj).get("VASID");						
						String vasurl=serviceHelp.getVasUrl(vasid);
						((HashMap)valObj).put("VASURL",vasurl);
					}
				}
			}
			else if (mytype.equals("type"))
			{
				list = metaData.getTypeListByTypeId(code, size, begin);
				if(help(list))
					return nullListReturn();
				ArrayList templist=(ArrayList)list.get(1);
				//转换PosterPaths格式
				for(int i=0;i<templist.size();i++)
				{
					HashMap temp1=(HashMap)templist.get(i);   //获取对象 hashmap
					HashMap temp2=(HashMap)temp1.get("POSTERPATHS");  //获取当前对象的POSTERPATHS
					//String[][] shuzu=new String[temp2.size()][];  //根据POSTER
					HashMap tmptype=new HashMap();
					if(!temp2.isEmpty())
					{
					   Iterator iter = temp2.entrySet().iterator(); 
                       while (iter.hasNext()) { 
                            Map.Entry entry = (Map.Entry) iter.next(); 
                            Object key = entry.getKey(); 
                            Object val = entry.getValue();
							tmptype.put("type"+key,val);
                       } 	
					}
				    
				    temp1.put("POSTERPATHS",tmptype);
				}
				list.set(1,templist);
			}
			HashMap hash = (HashMap) list.get(0);;
			int pagecount = 0;
			int count = 0;
            jsonList = JSONArray.fromObject(list.get(1));
		    count = Integer.parseInt(hash.get("COUNTTOTAL").toString());
		    pagecount = (count - 1) / size + 1;
		    ArrayList returnArray = new ArrayList();
			returnArray.add(jsonList);
			returnArray.add(pagecount);
			return returnArray;
		}
		private Boolean help(ArrayList list)
		{
			
			if (list != null)
			{
				 HashMap hash = (HashMap) list.get(0);
			     if(Integer.parseInt(hash.get("COUNTTOTAL").toString())==0)
				     return true;
			     return false;
			}
			else
				return true;
		}
        private ArrayList nullListReturn()
        {
        	ArrayList returnarray=new ArrayList();
        	returnarray.add(null);
        	returnarray.add(null);
        	return returnarray;
        }
		public ArrayList getTypeListSimulateData(String[] texts,
				String[][] imgs, int size) {
			return getTypeListSimulateData(texts, imgs, size, 1);
		}

		public ArrayList getTypeListSimulateData(String[] texts,
				String[][] imgs, int size, int curpage) {
			return getListSimulateData(texts, imgs, size, curpage);
		}

		public ArrayList getVodListSimulateData(String[] texts,
				String[][] imgs, int size) {
			return getVodListSimulateData(texts, imgs, size, 1);
		}

		public ArrayList getVodListSimulateData(String[] texts,
				String[][] imgs, int size, int curpage) {
			return getListSimulateData(texts, imgs, size, curpage);
		}

		public ArrayList getListSimulateData(String[] texts, String[][] imgs,
				int size, int curpage) {
			int total = 25;
			int datanum = 0;
			ArrayList list = new ArrayList();
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("COUNTTOTAL", "" + total);
			list.add(map);
			ArrayList list1 = new ArrayList();
			if (25 - (curpage - 1) * size < size)
				datanum = 25 - (curpage - 1) * size;
			else
				datanum = size;
			for (int i = 0; i < datanum; i++) {
				HashMap<String, String> map1 = new HashMap<String, String>();
				for (int j = 0; j < texts.length; j++)
					map1.put(texts[j], "测试数据"
							+ (((curpage - 1) * size) + (i + 1)));
				for (int j = 0; j < imgs.length; j++)
					map1.put(imgs[j][0], imgs[j][1]);
				list1.add(map1);
			}
			list.add(list1);
			HashMap hash = null;
			JSONArray jsonList = null;
			int pagecount = 0;
			int count = 0;
			if (list != null) {
				jsonList = JSONArray.fromObject(list.get(1));
				hash = (HashMap) list.get(0);
			}
			if (hash != null) {
				count = Integer.parseInt(hash.get("COUNTTOTAL").toString());
				pagecount = (count - 1) / size + 1;
			}
			ArrayList returnArray = new ArrayList();
			returnArray.add(jsonList);
			returnArray.add(pagecount);
			return returnArray;
		}
	}%>