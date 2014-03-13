<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>	
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="net.sf.json.JSONArray"%>
<%@ page import="net.sf.json.JSONObject"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.util.logging.FileHandler" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="java.util.logging.SimpleFormatter" %>
<%!
final static Logger logger = Logger.getLogger("DataSource"); 
static int counts = 0; 
public class MyUtil {
		HttpServletRequest re;

		public MyUtil(HttpServletRequest re) 
		{
			this.re = re;	
			try{			
				String path=re.getRealPath("");
				//path=path+"/page/log/log";
				path=path+"/jsp/defaulthdcctv/en_develop/log/log";
				path=path.replace('\\','/');
				path=path.replaceAll("//","/");
				
				if(logger.getHandlers()==null || logger.getHandlers().length==0){
					 
					FileHandler fh = new FileHandler(path,false);//方法返回日志文件存放的路径
					logger.addHandler(fh);
					logger.setLevel(Level.ALL);
			        fh.setFormatter(new SimpleFormatter());
				}else{
					  
					Object[] files= logger.getHandlers();
					FileHandler file=null;
					if(counts==0){
						File logfile=new File(path);
						 
						for(int i=1;i<files.length;i++){
							if(files[i] instanceof FileHandler){
								file=(FileHandler)files[i];
								file.close();
								logger.removeHandler(file); 
							}
						}
						file=(FileHandler)files[0];
						file= new FileHandler(path,false);//方法返回日志文件存放的路径
						logger.addHandler(file);
						logger.setLevel(Level.ALL);
						file.setFormatter(new SimpleFormatter());
						counts=counts+1;
					} 
				}
			}catch(Exception e){
				e.printStackTrace();
			}	
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
		public ArrayList getListData(String code, int size, int curpage,String mytype) 
		{
			int begin = (curpage - 1) * size;
			MetaData metaData = new MetaData(re);
			JSONArray jsonList = null;
			ArrayList list = null;
			ArrayList clonelist = null;//用来克隆获取出来的总集合
			if (mytype.equals("vod"))
			{
				list = metaData.getVodListByTypeId(code, size, begin);
				logger.log(Level.INFO, "getListData_vod--------------------------------------------"+list);
				if(help(list)){
					return nullListReturn();
				}
				clonelist = (ArrayList)list.clone();//克隆总集合
			    ArrayList templist=(ArrayList)clonelist.get(1);
			    ArrayList tmplist = new ArrayList();//增加一个本地
				//转换PosterPaths格式
				for(int i=0;i<templist.size();i++)
				{
					HashMap temp1=(HashMap) ((HashMap)templist.get(i)).clone(); //克隆出来修改
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
				    tmplist.add(temp1);
				}
				clonelist.set(1,tmplist);//是用克隆的返回
				
			}
			else if (mytype.equals("content"))
			{
				list = metaData.getContentBySubjectId(code, size, begin);
				if(help(list))
					return nullListReturn();
				clonelist = (ArrayList)list.clone();//克隆总集合
			}
			else if (mytype.equals("live"))
			{
				list = metaData.getLiveChanListByTypeId(code, size, begin);
				if(help(list))
				     return nullListReturn();
				clonelist = (ArrayList)list.clone();//克隆总集合
			}
			else if(mytype.equals("vas"))
			{
				list = metaData.getVasListByTypeId(code, size, begin);
				logger.log(Level.INFO, " getListData_vas--------------------------------------------"+list);
				if(help(list)){
				     return nullListReturn();
				}else{
					ServiceHelp serviceHelp = new ServiceHelp(re);
					clonelist = (ArrayList)list.clone();//克隆总集合
					ArrayList vasList = (ArrayList)clonelist.get(1);
					ArrayList tmpvasList = new ArrayList();//增加一个本地集合sir
					for(int i=0;i<vasList.size();i++){
						HashMap temp1=(HashMap) ((HashMap)vasList.get(i)).clone(); //克隆出来修改
						Integer vasid = (Integer)(temp1.get("VASID"));
						String vasurl=serviceHelp.getVasUrl(vasid);
						temp1.put("VASURL",vasurl);
						tmpvasList.add(temp1);
					}
					clonelist.set(1,tmpvasList);
				}
			}
			else if (mytype.equals("type"))
			{
				list = metaData.getTypeListByTypeId(code, size, begin);
				logger.log(Level.INFO, " getListData_type--------------------------------------------"+list);
				if(help(list)){
					return nullListReturn();
				}
				clonelist = (ArrayList)list.clone();//克隆总集合
				ArrayList templist=(ArrayList)clonelist.get(1);
				ArrayList tmplist = new ArrayList();//增加一个本地
				//转换PosterPaths格式
				for(int i=0;i<templist.size();i++)
				{
					HashMap temp1=(HashMap) ((HashMap)templist.get(i)).clone(); //克隆出来修改
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
				    tmplist.add(temp1);
				}
				clonelist.set(1,tmplist);//返回克隆后的
				
			}
			int pagecount = 0;
			int count = 0;
			HashMap hash = null;
			if(clonelist!=null)
			{
				hash = (HashMap) clonelist.get(0);
				jsonList = JSONArray.fromObject(clonelist.get(1));
				count = Integer.parseInt(hash.get("COUNTTOTAL").toString());
				pagecount = (count - 1) / size + 1;
			}   
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
				  {   return true;}
			     return false;
			}
			else
			{	return true;}
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