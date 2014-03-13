<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.util.logging.FileHandler" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="java.util.logging.SimpleFormatter" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.facade.service.BookmarkImpl"%>
<%@ include file="huaweiutil.jsp"%>
<%@ include file="model/epgresult.jsp"%>
<%@ include file="model/userinfo.jsp"%>
<%!
    final static Logger logger = Logger.getLogger("DataSource"); 
    static int counts = 0; 
%>
<%!
//通用数据接口
public class DataSource {
	
	public HuaWeiUtil huaWeiUtil=new HuaWeiUtil();
	//获取频道信息接口
	public PkitEpgResult getChannelInfo(String channelid,String categoryid){
		PkitEpgResult epgResult=new PkitEpgResult();
		MetaData metaData = new MetaData(request);
    	
		return epgResult;
	}
	
	//频道列表查询接口：不建议使用该方法
    public PkitEpgResult getChannels(int pageIndex,int pageSize,String categoryid){
    	PkitEpgResult epgResult=new PkitEpgResult();
		MetaData metaData = new MetaData(request);
    	ArrayList result = metaData.getChanListByTypeId(categoryid,-1,0);
    	//logger.log(Level.INFO, " "+result);
    	
    	if(result!=null){
    		if(result.size()>0&&result.get(0)!=null){
    			Map map=(Map)result.get(0);
        		epgResult.setItemCount(huaWeiUtil.getInt( map.get("COUNTTOTAL") ));
        		epgResult.setResultcode(huaWeiUtil.getInt( map.get("RETCODE") ));
        		epgResult.setPageSize(pageSize);
        		epgResult.setPageIndex(pageIndex);
        		epgResult.setPageCount( huaWeiUtil.getInt(Double.valueOf(Math.ceil(epgResult.getItemCount()/Double.valueOf(pageSize) )).intValue()) );
    		}
    		if(result.size()>1&&result.get(1)!=null){
    			List newchannels=new ArrayList();
    			List allchannels=(ArrayList)result.get(1);
    			List channels=null;
    			if(allchannels.size()>=(pageIndex)*pageSize){
    				channels=allchannels.subList( (pageIndex-1)*pageSize,(pageIndex)*pageSize);
    			}else{
    				channels=allchannels.subList( (pageIndex-1)*pageSize,allchannels.size());
    			}
    			Map map=null;
    			for(int i=0;i<channels.size();i++){
    				map=(Map)channels.get(i);
    				TblCmsChannel cha=new TblCmsChannel();
    				cha.setDname( huaWeiUtil.getString(map.get("CHANNELNAME")) );
    				cha.setDcmsid( huaWeiUtil.getString(map.get("CHANNELID")) );
    				cha.setDid( huaWeiUtil.getString(map.get("CHANNELID")) );
    				cha.setDchannelnumber( huaWeiUtil.getString(huaWeiUtil.getInt(map.get("CHANNELINDEX"))) );//mxr 四川
    				//cha.setDchannelnumber( huaWeiUtil.getString(huaWeiUtil.getInt(map.get("CHANNELINDEX"))-1000) );//mxr 因为深圳的特殊处理
					cha.setDistvod( huaWeiUtil.getString(map.get("ISTVOD")) );
    				newchannels.add(cha);
    			}
    			epgResult.setDatas(newchannels);	 
    		}
    	}
		return epgResult;
	}
    
	
	//频道列表查询接口:按照直播的栏目的ID，每次获取指定的数量的直播频道信息,获取直播的信息，建议使用该接口
     /*
	 pageIndex:获取的第几页数据
	 pageSize:每页显示的记录数
	 categoryid：栏目编号
	 */
    public PkitEpgResult getChannelListByTypeId(int pageIndex,int pageSize,String categoryid){
    	PkitEpgResult epgResult=new PkitEpgResult();
		MetaData metaData = new MetaData(request);

    	ArrayList result = metaData.getChanListByTypeId(categoryid,pageSize,(pageIndex-1)*pageSize);
    	//logger.log(Level.INFO, " getChannelListByTypeId::::::::"+result);
    	
    	if(result!=null){
    		if(result.size()>0&&result.get(0)!=null){
    			Map map=(Map)result.get(0);
        		epgResult.setItemCount(huaWeiUtil.getInt( map.get("COUNTTOTAL") ));//此处返回为pagesize的大小
        		epgResult.setResultcode(huaWeiUtil.getInt( map.get("RETCODE") ));
        		epgResult.setPageSize(pageSize);
        		epgResult.setPageIndex(pageIndex);
        		epgResult.setPageCount( huaWeiUtil.getInt(Double.valueOf(Math.ceil(epgResult.getItemCount()/Double.valueOf(pageSize) )).intValue()) );
    		}
    		if(result.size()>1&&result.get(1)!=null){
    			List newchannels=new ArrayList();
    			List allchannels=(ArrayList)result.get(1);
    			Map map=null;
    			for(int i=0,l=allchannels.size();i<l;i++){
    				map=(Map)allchannels.get(i);
    				TblCmsChannel cha=new TblCmsChannel();
    				cha.setDname( huaWeiUtil.getString(map.get("CHANNELNAME")) );
    				cha.setDcmsid( huaWeiUtil.getString(map.get("CHANNELID")) );
    				cha.setDid( huaWeiUtil.getString(map.get("CHANNELID")) );
    				cha.setDchannelnumber( huaWeiUtil.getString(huaWeiUtil.getInt(map.get("CHANNELINDEX"))) );//mxr 因为深圳的特殊处理
					//cha.setDchannelnumber( huaWeiUtil.getString(huaWeiUtil.getInt(map.get("CHANNELINDEX"))-1000) );//mxr 因为深圳的特殊处理
    				cha.setDistvod( huaWeiUtil.getString(map.get("ISTVOD")) );
    				newchannels.add(cha);
    			}
    			epgResult.setDatas(newchannels);	 
    		}
    	}
		return epgResult;
	}
	
	
    //频道节目单查询接口
    public PkitEpgResult getRecordContentInfos(int pageIndex,int pageSize,String channelid){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	MetaData metaData = new MetaData(request);
    	
		return epgResult;
	}
    
	//单个栏目的信息的查询
	/*
	 categoryid：所要查询的栏目的ID
	 postertype：获取的增值业务的图片属性，其中如果是获取的是栏目的单个的海报POSTERPATH的属性时，此值就可以默认为"0"
	 postertype：0.缩略图1.海报2.剧照3.图标4.标题图5.广告图6.草图7.背景9.频道图99.其他
	 */
	public PkitEpgResult getCategory(String categoryid,String postertype){
		PkitEpgResult epgResult=new PkitEpgResult();
    	MetaData metaData = new MetaData(request);
				
		HashMap categorydetailInfo = (HashMap)metaData.getTypeInfoByTypeId(categoryid);
		
		TblCmsCategory cate=new TblCmsCategory();
		//logger.log(Level.INFO, " getCategory--------------------------------------------"+categorydetailInfo);
		if(categorydetailInfo!=null){
			epgResult.setItemCount(0);
    		epgResult.setResultcode(0);
    		epgResult.setPageSize(0);
    		epgResult.setPageIndex(0);
    		epgResult.setPageCount(0);
			
			HashMap posterPathMap = (HashMap)categorydetailInfo.get("POSTERPATHS");
			String picPath = huaWeiUtil.getString(huaWeiUtil.getPosterPath(posterPathMap,request,"absolute",postertype));
			cate.setPicpath(picPath);
			cate.setPosterpath(huaWeiUtil.getPosterPath(huaWeiUtil.getString(categorydetailInfo.get("PICPATH")),request));
			String introduce = huaWeiUtil.getString(categorydetailInfo.get("TYPE_INTRODUCE"));
			cate.setDdescription(introduce);
		}
		
		epgResult.setOneObject(cate);
		
		return epgResult;
	}
	
    //类别（栏目）集查询接口
    /*
	 pageIndex:获取的第几页数据
	 pageSize:每页显示的记录数
	 categoryid：父栏目编号
	 postertype：获取的增值业务的图片属性，其中如果是获取的是栏目的单个的海报POSTERPATH的属性时，此值就可以默认为"0"
	 postertype：0.缩略图1.海报2.剧照3.图标4.标题图5.广告图6.草图7.背景9.频道图99.其他
	 */
    public PkitEpgResult getCategorys(int pageIndex,int pageSize,String categoryid,String postertype){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	MetaData metaData = new MetaData(request);
    	int [] intSubjectType = {9999,10};//子栏目类型
    	int typeFlag = 0; //0:非定制栏目、1:定制栏目、2:所有栏目,包括定制和非定制栏目
    	ArrayList result = metaData.getTypeListByTypeId(categoryid,pageSize,((pageIndex-1)*pageSize),intSubjectType,typeFlag); //获取根目录全部
    	//logger.log(Level.INFO, " getCategorys::::::::"+result);
    	
    	if(result!=null){
    		if(result.size()>0&&result.get(0)!=null){
    			Map map=(Map)result.get(0);
        		epgResult.setItemCount(huaWeiUtil.getInt( map.get("COUNTTOTAL") ));
        		epgResult.setResultcode(huaWeiUtil.getInt( map.get("RETCODE") ));
        		epgResult.setPageSize(pageSize);
        		epgResult.setPageIndex(pageIndex);
        		epgResult.setPageCount( Double.valueOf(Math.ceil(epgResult.getItemCount()/Double.valueOf(pageSize) )).intValue() );
    		}
    		if(result.size()>1&&result.get(1)!=null){
    			List newcategorys=new ArrayList();
    			List categorys=(ArrayList)result.get(1);
    			Map map=null;
    			for(int i=0,l=categorys.size();i<l;i++){
    				map=(Map)categorys.get(i);
    				TblCmsCategory cate=new TblCmsCategory();
    				cate.setDname( huaWeiUtil.getString(map.get("TYPE_NAME")) );
    				cate.setDcmsid( huaWeiUtil.getString(map.get("TYPE_ID")) );
    				cate.setDid( huaWeiUtil.getString(map.get("TYPE_ID")) );
					
					HashMap posterPathMap = (HashMap)map.get("POSTERPATHS");
					String picPath = huaWeiUtil.getString(huaWeiUtil.getPosterPath(posterPathMap,request,"absolute",postertype));
					cate.setPicpath(picPath);
					String introduce = huaWeiUtil.getString(map.get("TYPE_INTRODUCE"));
			        cate.setDdescription(introduce);
    				newcategorys.add(cate);
    			}
    			epgResult.setDatas(newcategorys);	 
    		}
    	}

    	return epgResult;
	}
    
	 //获取推荐栏目vas列表:pageIndex:
	 /*
	 pageIndex:获取的第几页数据
	 pageSize:每页显示的记录数
	 categoryid：栏目编号
	 postertype：获取的增值业务的图片属性，其中如果是获取的是栏目的单个的海报POSTERPATH的属性时，此值就可以默认为"0"
	 postertype：0.缩略图1.海报2.剧照3.图标4.标题图5.广告图6.草图7.背景9.频道图99.其他
	 */
	 public PkitEpgResult getVasCategorys(int pageIndex,int pageSize,String categoryid,String postertype){
		 PkitEpgResult epgResult=new PkitEpgResult();
		 MetaData metaData = new MetaData(request);
		 
		 ArrayList result = null;
		 try{
		 	result = (ArrayList)metaData.getVasListByTypeId(categoryid,pageSize,(pageIndex-1)*pageSize);
		 }catch(Exception e)
		 {e.printStackTrace();}
		 //logger.log(Level.INFO, " getVasCategorys-result::::::::"+result);
		 if(result!=null){
			if(result.size()>0&&result.get(0)!=null){
    			Map map=(Map)result.get(0);
        		epgResult.setItemCount(huaWeiUtil.getInt(map.get("COUNTTOTAL")));
        		epgResult.setResultcode(0);
        		epgResult.setPageSize(pageSize);
        		epgResult.setPageIndex(pageIndex);
        		epgResult.setPageCount( Double.valueOf(Math.ceil(epgResult.getItemCount()/Double.valueOf(pageSize) )).intValue() );
    		}
			if(result.size()>1&&result.get(1)!=null){
				List newvascategorys=new ArrayList();
    			List vascategorys=(ArrayList)result.get(1);
    			Map map=null;
				if(vascategorys!=null)
				{
					ServiceHelp serviceHelp = new ServiceHelp(request);
					for(int i=0,l=vascategorys.size();i<l;i++)
					{
						map = ((HashMap)vascategorys.get(i));
						TblCmsVasCategory vascate=new TblCmsVasCategory();
						Integer vasId = (Integer)map.get("VASID");
						logger.log(Level.INFO, " VASID::::::::"+vasId);
						HashMap tempMap = (HashMap)metaData.getVasDetailInfo(vasId);
						if(tempMap!=null)
						{
							/*需要用到时，直接启用
							vascate.setDvasId(huaWeiUtil.getInt(tempMap.getInt("VASID")));
							vascate.setDvasname(huaWeiUtil.getString(tempMap.get("VASNAME")));
							vascate.setDsupplylang(huaWeiUtil.getString(tempMap.get("SUPPLYLANG")));
							vascate.setDproducedate(huaWeiUtil.getString(tempMap.get("PRODUCEDATE")));
							vascate.setDvasprice(huaWeiUtil.getString(tempMap.get("VASPRICE")));
							vascate.setDstyle(huaWeiUtil.getString(tempMap.get("STYLE")));
							vascate.setDtheme(huaWeiUtil.getString(tempMap.get("THEME")));
							vascate.setDintroduce(huaWeiUtil.getString(tempMap.get("INTRODUCE")));
							vascate.setDnation(huaWeiUtil.getString(tempMap.get("NATION")));
							vascate.setDspname(huaWeiUtil.getString(tempMap.get("SPNAME")));
							*/
							vascate.setDposterpath0(huaWeiUtil.getPosterPath(huaWeiUtil.getString(tempMap.get("POSTERPATH")),request));
							HashMap posterPathMap = (HashMap)map.get("POSTERPATHS");
							String picPath = huaWeiUtil.getString(huaWeiUtil.getPosterPath(posterPathMap,request,"absolute",postertype));
							vascate.setDposterpath(picPath);
							String vasUrl = huaWeiUtil.getString(serviceHelp.getVasUrl(vasId));
							vascate.setDvasurl(vasUrl);
							//logger.log(Level.INFO, " getVasCategorys-vasUrl::::::::"+vasUrl);
					    }
						
						newvascategorys.add(vascate);
				    }	
					epgResult.setDatas(newvascategorys);				
			    }
			}
		 }
		 
		 return epgResult;
	 }
	 
	
	//获得滚动走字：categoryid  -1：获取系统的 ; 有具体的栏目值：获取栏目的简介
	public PkitEpgResult getAdText(String categoryid)
	{
		PkitEpgResult epgResult=new PkitEpgResult();
		
		TblRollInfo rollinfo=new TblRollInfo();
		
		if("-1".equals(categoryid))
		{
			HashMap rollAd = null;
			ServiceHelp serviceHelp_Ad = new ServiceHelp(request);
			rollAd = serviceHelp_Ad.getAdText();//随机获取一条滚动信息
			if(null != rollAd){
				rollinfo.setDrollname((String)rollAd.get("ADTEXT_NAME"));
				rollinfo.setDrollspeed((Integer)rollAd.get("RECYCLE_SPEED"));//速度
				rollinfo.setDrolltime((Integer)rollAd.get("RECYCLE_TIME"));//次数
			}
		}else {
			MetaData metaData = new MetaData(request);
			
			HashMap map = null ;
			try{
				map = (HashMap)metaData.getTypeInfoByTypeId(categoryid);
				rollinfo.setDrollname((String)map.get("INTRODUCE"));
			}catch(Exception e){
				rollinfo.setDrollname("请检查公告CODE");
			}
			rollinfo.setDrollspeed(3);//速度
			rollinfo.setDrolltime(3);//次数
		}
		epgResult.setOneObject(rollinfo);
		
		return epgResult;
	}
	
    //点播查询接口：根据栏目ID来获取栏目下面的影片的列表
	 /*
	 pageIndex:获取的第几页数据
	 pageSize:每页显示的记录数
	 categoryid：栏目编号
	 postertype：获取的增值业务的图片属性，其中如果是获取的是栏目的单个的海报POSTERPATH的属性时，此值就可以默认为"0"
	 */
    public PkitEpgResult getVodListByTypeId(int pageIndex,int pageSize,String categoryid,String postertype){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	MetaData metaData = new MetaData(request);
    	ArrayList result = metaData.getVodListByTypeId(categoryid,pageSize,((pageIndex-1)*pageSize) ); //获取根目录全部
    	//logger.log(Level.INFO, " "+result);
    	
    	if(result!=null){
    		if(result.size()>0&&result.get(0)!=null){
    			Map map=(Map)result.get(0);
        		epgResult.setItemCount(huaWeiUtil.getInt( map.get("COUNTTOTAL") ));
        		epgResult.setResultcode(huaWeiUtil.getInt( map.get("RETCODE") ));
        		epgResult.setPageSize(pageSize);
        		epgResult.setPageIndex(pageIndex);
        		epgResult.setPageCount( Double.valueOf(Math.ceil(epgResult.getItemCount()/Double.valueOf(pageSize))).intValue() );
    		}
    		if(result.size()>1&&result.get(1)!=null){
    			List newvods=new ArrayList();
    			List vods=(ArrayList)result.get(1);
    			Map map=null;
    			for(int i=0,l=vods.size();i<l;i++){
    				map=(Map)vods.get(i);
    				TblCmsProgram vod=new TblCmsProgram();
    				vod.setDname( huaWeiUtil.getString(map.get("VODNAME")) );
    				vod.setDcmsid( huaWeiUtil.getString(map.get("VODID")) );
    				vod.setDid( huaWeiUtil.getString(map.get("VODID")) );
    				String picpath = huaWeiUtil.getString(map.get("PICPATH"));
					vod.setDpicpath(huaWeiUtil.getPosterPath(picpath,request));
					HashMap posterPathMap = (HashMap)map.get("POSTERPATHS");
    				vod.setDpostpath(huaWeiUtil.getString(huaWeiUtil.getPosterPath(posterPathMap,request,"absolute",postertype)));

    				newvods.add(vod);
    			}
    			epgResult.setDatas(newvods);	 
    		}
    	}
    	
		return epgResult;
	}
    
    
    //查询接口
	 /*
	 pageIndex:获取的第几页数据
	 pageSize:每页显示的记录数
	 keywords：搜索码
	 searchtype：搜索的方式 1：按影片代码查询影片 0：演员姓名查询影片
	 */ 
    public PkitEpgResult searchVodInfos(int pageIndex,int pageSize,String keywords,String searchtype){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	ServiceHelp serviceHelp = new ServiceHelp(request);
    	List result = new ArrayList();
    	int isSubVod = 1;
    	if("1".equals(searchtype)){
    		result = serviceHelp.searchFilmsByCode(keywords,(pageIndex-1)*pageSize,pageSize,isSubVod);//片名
    	}else{
    		result = serviceHelp.searchFilmsByActor(keywords,(pageIndex-1)*pageSize,pageSize,isSubVod);//导演
    	}
    	//logger.log(Level.INFO, " searchVodInfos:::::::"+result);
    	if(result!=null){
    		if(result.size()>0&&result.get(0)!=null){
    			Map map=(Map)result.get(0);
        		epgResult.setItemCount(huaWeiUtil.getInt( map.get("COUNTTOTAL") ));
        		epgResult.setResultcode(huaWeiUtil.getInt( map.get("RETCODE") ));
        		epgResult.setPageSize(pageSize);
        		epgResult.setPageIndex(pageIndex);
        		epgResult.setPageCount( Double.valueOf(Math.ceil(epgResult.getItemCount()/Double.valueOf(pageSize))).intValue() );
    		}
    		if(result.size()>1&&result.get(1)!=null){
    			List newvods=new ArrayList();
    			List vods=(ArrayList)result.get(1);
    			Map map=null;
    			for(int i=0,l=vods.size();i<l;i++){
    				map=(Map)vods.get(i);
    				TblCmsProgram vod=new TblCmsProgram();
    				vod.setDname(huaWeiUtil.getString(map.get("vodName")));
    				vod.setDcmsid(huaWeiUtil.getString(map.get("vodId")));
    				vod.setDid(huaWeiUtil.getString(map.get("vodId")));
    				String picpath = huaWeiUtil.getString(map.get("PICPATH"));
    				vod.setDpicpath(huaWeiUtil.getPosterPath(picpath,request));
    				//vod.setDpostpath( "../"+huaWeiUtil.getString( huaWeiUtil.getPosterPath((HashMap)map.get("POSTERPATHS"),request,picpath,postertype) ) );
    				newvods.add(vod);
    			}
    			epgResult.setDatas(newvods);	 
    		}
    	}
    	
		return epgResult;
	}
    
    
    //点播详情(会自行判断多集和单集的情况)
	/*
	 categoryid:所属的栏目的ID
	 catename:所属栏目的名称
	 programid：要查询的该影片的ID
	 type：所以的类型：如-1表示为搜索进来的影片
	 postertype：0.缩略图1.海报2.剧照3.图标4.标题图5.广告图6.草图7.背景9.频道图99.其他
	 */ 
    public PkitEpgResult getVodInfo(String categoryid,String catename,String programid,String type,String postertype){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	MetaData metaData = new MetaData(request);
		
    	HashMap mediadetailInfo = (HashMap)metaData.getVodDetailInfo(huaWeiUtil.getInt(programid));
    	
    	//logger.log(Level.INFO, " getVodInfo::::::::"+mediadetailInfo);
    	if(mediadetailInfo!=null)
		{
    		epgResult.setItemCount(0);
    		epgResult.setResultcode(0);
    		epgResult.setPageSize(0);
    		epgResult.setPageIndex(0);
    		epgResult.setPageCount(0);
    		
    		TblCmsProgram vod=new TblCmsProgram();
			vod.setDname(huaWeiUtil.getString(mediadetailInfo.get("VODNAME")));
			vod.setDcmsid( huaWeiUtil.getString(mediadetailInfo.get("VODID")));
			vod.setDid( huaWeiUtil.getString(mediadetailInfo.get("VODID")));
			vod.setDdescription( huaWeiUtil.getString(mediadetailInfo.get("INTRODUCE"))); //简介
			vod.setDdirector( huaWeiUtil.getString(mediadetailInfo.get("DIRECTOR"))); //导演
			vod.setDactor( huaWeiUtil.getString(mediadetailInfo.get("ACTOR")));  //主演
 			String picpath = huaWeiUtil.getString(mediadetailInfo.get("PICPATH"));
			vod.setDpicpath(huaWeiUtil.getPosterPath(picpath,request));
    		
			HashMap posterPathMap = (HashMap)mediadetailInfo.get("POSTERPATHS");
    		vod.setDpostpath(huaWeiUtil.getString( huaWeiUtil.getPosterPath(posterPathMap,request,"absolute",postertype)));
			
			if(("".equals(catename))){
				if(!("".equals(categoryid))){
				    HashMap first_ptypemap = (HashMap)metaData.getTypeInfoByTypeId(categoryid);
    				if(first_ptypemap!=null){
    					String first_ptypeid = (String)first_ptypemap.get("PARENTID");  //第一级父栏目
    					if(!("-1".equals(first_ptypeid))){
    						HashMap second_ptypemap = (HashMap)metaData.getTypeInfoByTypeId(first_ptypeid); //第二级父栏目
    						if(second_ptypemap!=null){
    							String second_ptypeid = (String)second_ptypemap.get("PARENTID");
    							catename = (String)second_ptypemap.get("TYPENAME")+"-"+(String)first_ptypemap.get("TYPENAME");
    							catename = catename.replace("s-","-");
    						}else{
    							catename = (String)first_ptypemap.get("TYPENAME");
    						}
    					}
    				}
				}else if("-1".equals(categoryid)){   //搜索类的时候，采用上级为-1
    				String[] allTypeids = (String[])mediadetailInfo.get("allTypeId");// VOD所属的栏目ID列表
    				categoryid = allTypeids[0];//默认采用第一个栏目
    				HashMap first_ptypemap = (HashMap)metaData.getTypeInfoByTypeId(categoryid);
    				if(first_ptypemap!=null){
    					String first_ptypeid = (String)first_ptypemap.get("PARENTID");  //第一级父栏目
    					if(!("-1".equals(first_ptypeid))){
    						HashMap second_ptypemap = (HashMap)metaData.getTypeInfoByTypeId(first_ptypeid); //第二级父栏目
    						if(second_ptypemap!=null){
    							String second_ptypeid = (String)second_ptypemap.get("PARENTID");
    							catename = (String)second_ptypemap.get("TYPENAME")+"-"+(String)first_ptypemap.get("TYPENAME");
    							catename = catename.replace("s-","-");
    						}else{
    							catename = (String)first_ptypemap.get("TYPENAME");
    						}
    					}
    				}
    			}else{
    				catename = "推荐栏目";
    			}
    		}
			vod.setDcategoryname(catename);

			String issitcom = huaWeiUtil.getString(mediadetailInfo.get("ISSITCOM"));
			vod.setDissitcom(issitcom); 
    		ArrayList newArr = new ArrayList();
    		//0：非连续剧  1：连续剧
			if("0".equals(issitcom)){   
    			HashMap tempMap = new HashMap();
    			tempMap.put("VODID",vod.getDid());
    			tempMap.put("VODNAME","全集");
    			newArr.add(tempMap);
				vod.setDsubvodidlist(newArr);
    		}else{
				ArrayList resultList = metaData.getSitcomList(programid, 999, 0);//获得所有的连续剧
				ArrayList subVodList = null;	
				ArrayList subVodIdList = new ArrayList();	
				ArrayList subVodNumList = new ArrayList();
				if(resultList != null && resultList.size() > 1)
				{
					subVodList = (ArrayList)resultList.get(1);
				}
				if(subVodList != null && subVodList.size() > 0)
				{
					int totalSitNum = subVodList.size();
					for(int i = 0; i < totalSitNum; i++)
					{
						Map sitVodMap = (HashMap)subVodList.get(i);
						//Integer definition=(Integer)sitVodMap.get("DEFINITION");//(1:高清、2:标清)
						subVodIdList.add((Integer)sitVodMap.get("VODID"));//子集的ID
						subVodNumList.add((Integer)sitVodMap.get("SITCOMNUM"));//子集号					
					}
					vod.setDsubvodidlist(subVodIdList);
					vod.setDsubvodnumlist(subVodNumList);
			    }
    		}
    		
    		int contentid = huaWeiUtil.getInt(mediadetailInfo.get("VODID"));
    		int contenttype = huaWeiUtil.getInt(mediadetailInfo.get("CONTENTTYPE"));//影片类型(0:视频点播、4:音频点播)
    		ServiceHelp shelper = new ServiceHelp(request);
    		if(shelper.isFavorited(contentid,contenttype)){
    			vod.setIsFavorited("1");//是否已收藏
    		}else{
    			vod.setIsFavorited("0");//是否已收藏
    		}
			
			epgResult.setOneObject(vod);
    	}
		return epgResult;
	}
    
	//点播查询接口
	 /*
	 pageIndex:获取第几页
	 pageSize:每页显示的记录数
	 categoryid：栏目的ID片
	 postertype：0.缩略图1.海报2.剧照3.图标4.标题图5.广告图6.草图7.背景9.频道图99.其他
	 */ 
    public PkitEpgResult getVodInfos(int pageIndex,int pageSize,String categoryid,String postertype){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	MetaData metaData = new MetaData(request);
    	ArrayList result = metaData.getVodListByTypeId(categoryid,pageSize,((pageIndex-1)*pageSize) ); //获取根目录全部
    	//logger.log(Level.INFO, " getVodInfos:::::::"+result);
    	
    	if(result!=null){
    		if(result.size()>0&&result.get(0)!=null){
    			Map map=(Map)result.get(0);
        		epgResult.setItemCount(huaWeiUtil.getInt( map.get("COUNTTOTAL") ));
        		epgResult.setResultcode(huaWeiUtil.getInt( map.get("RETCODE") ));
        		epgResult.setPageSize(pageSize);
        		epgResult.setPageIndex(pageIndex);
        		epgResult.setPageCount( Double.valueOf(Math.ceil(epgResult.getItemCount()/Double.valueOf(pageSize))).intValue() );
    		}
    		if(result.size()>1&&result.get(1)!=null){
    			List newvods=new ArrayList();
    			List vods=(ArrayList)result.get(1);
    			Map map=null;
    			for(int i=0,l=vods.size();i<l;i++){
    				map=(Map)vods.get(i);
    				TblCmsProgram vod=new TblCmsProgram();
    				vod.setDname( huaWeiUtil.getString(map.get("VODNAME")) );
    				vod.setDcmsid( huaWeiUtil.getString(map.get("VODID")) );
    				vod.setDid( huaWeiUtil.getString(map.get("VODID")) );
					vod.setDdescription( huaWeiUtil.getString(map.get("INTRODUCE"))); 
    				String picpath = huaWeiUtil.getString(map.get("PICPATH"));
					
    				vod.setDpicpath(huaWeiUtil.getPosterPath(picpath,request));
    				
					HashMap posterPathMap = (HashMap)map.get("POSTERPATHS");
					vod.setDpostpath(huaWeiUtil.getString(huaWeiUtil.getPosterPath(posterPathMap,request,"absolute",postertype)));
					
    				newvods.add(vod);
    			}
    			epgResult.setDatas(newvods);	 
    		}
    	}
    	
		return epgResult;
	}
	
	
	//获得点播的播放地址
	/*
	playType - int 播放类型
	progId - int 内容ID（VOD或频道）
	playBillId - int 节目编号（对TVOD有效）
	beginTime - String 节目开始时间
	endTime - String 节目结束时间（对TVOD有效）
	productId - String 产品ID(用于统计,兼容广东)
	serviceId - String 服务ID(用于统计,兼容广东)
	contentType - String 内容类型(用于统计,兼容广东)
	测试可采用参数为：1,iProgId,1,"0","200000","0","0","0" 
	*/
	public String getVodUrl(int playType,int progId,int playBillId,String beginTime,String endTime,String productId,String serviceId,String contentType){
    	
		ServiceHelpHWCTC  serviceHelp = new ServiceHelpHWCTC(request);
	
	    String vodUrl = "";
		vodUrl = serviceHelp.getTriggerPlayUrlHWCTC(playType,progId,playBillId,beginTime,endTime,productId,serviceId,contentType);
    	
		return vodUrl;
	} 
	
	
	//订购接口
    public PkitEpgResult userSubscribe(String ContentID,String ServiceID,String ProductID,String Action ){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	MetaData metaData = new MetaData(request);
    	
		return epgResult;
	} 
	
    //用户鉴权
    public PkitEpgResult userAAA(String ContentID,String ServiceID,String ProductID,PkitUserInfo userInfo ){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	MetaData metaData = new MetaData(request);
    	
		return epgResult;
	} 
	
    //产品列表
    public PkitEpgResult getProductInfos(PkitUserInfo userInfo,int pageIndex,int pageSize ){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	MetaData metaData = new MetaData(request);
    	
		return epgResult;
	} 
	
    //获取首页视频接口
    public PkitEpgResult getFirstVideo( String pageCode,String type ){
    	PkitEpgResult epgResult=new PkitEpgResult();
		return epgResult;
	}
    
    //获取首页广播接口
    public PkitEpgResult getBoardInfo( String pageCode,String boardType,int pageIndex,int pageSize){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	MetaData metaData = new MetaData(request);
    	
		return epgResult;
	}
	
    //获取首页栏目接口
    public PkitEpgResult getFirstCategorys( String pageCode,String type,int pageIndex,int pageSize ){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	MetaData metaData = new MetaData(request);
    	
		return epgResult;
	}
    
    //获取首页图片接口
    public PkitEpgResult getFirstPics( String pageCode,String type,int pageIndex,int pageSize ){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	MetaData metaData = new MetaData(request);
    	
		return epgResult;
	}
    
    //用户消费记录
    public PkitEpgResult getCosumeInfos(PkitUserInfo userInfo,int pageIndex,int pageSize,String cosumetype,String cdrtype,String cosumedate){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	MetaData metaData = new MetaData(request);
    	
		return epgResult;
	}
    
    //用户收藏记录
    public PkitEpgResult getFavoriteInfos(PkitUserInfo userInfo,int pageIndex,int pageSize,String sorttype){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	MetaData metaData = new MetaData(request);
    	
		return epgResult;
	}
    
    //查询内容是否已经收藏
    public PkitEpgResult hasFavorite(PkitUserInfo userInfo,String categoryid,String programid){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	MetaData metaData = new MetaData(request);
    	
		return epgResult;
	}
    
    //删除收藏
    /*
	programid -内容的编号
	programType -0:视频VOD.1:视频频道.2:音频频道.4:音频AOD.100:增值业务
	*/
    public PkitEpgResult delFavorite(String programid,String programType){
    	PkitEpgResult epgResult =new PkitEpgResult();
    	
		ServiceHelp serviceHelp = new ServiceHelp(request);
		
		int resultcode = -1;
		String resultdesc = "未执行";
		if(programid == null ||programType== null ){
		   resultcode = 2;
		   resultdesc = "参数错误";
		}else{
			boolean ret = serviceHelp.delFavItem(programid,programType);
			if( ret == false ){
				resultcode = 1;
		   		resultdesc = "删除失败";
			}else{           
				resultcode = 0;
		   		resultdesc = "删除成功";
			}     
		}
    	epgResult.setResultcode(resultcode);
		epgResult.setResultdesc(resultdesc);
				
		return epgResult;
	}
    
    //增加收藏
	/*
	programid -内容的编号
	programType -0:视频VOD.1:视频频道.2:音频频道.4:音频AOD.100:增值业务
	返回结果 succ - 0：添加失败  1：添加成功 2:收藏夹已满
	*/
    public PkitEpgResult addFavorite(String programid,String programType){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	
		ServiceHelp serviceHelp = new ServiceHelp(request);
	    UserProfile userInfo = new UserProfile(request);
		int favoSize = serviceHelp.getFavouriteLimit();//获得收藏夹的容量(默认值8)
		ArrayList userFavo = (ArrayList)userInfo.getFavorite();
		
		int resultcode = -1;
		String resultdesc = "未执行";
		
		if(programid != null && programType != null && favoSize != 0){
			//增加插入操作时，判断收藏夹是否已满
			if(userFavo != null){
				if(userFavo.size() >= favoSize){
					 resultcode = 2;
		   			 resultdesc = "收藏夹已满";
				}else if(userFavo.size() < favoSize ){
					boolean ret = serviceHelp.insFavItem(programid,programType);
					if(ret == false){
						resultcode = 1;
		   			    resultdesc = "添加失败";
					}else{           
						resultcode = 0;
		   			    resultdesc = "添加成功";            
					} 
				}
			}
		}
		epgResult.setResultcode(resultcode);
		epgResult.setResultdesc(resultdesc);
		
		return epgResult;
	}
    
    //用户书签记录
    public PkitEpgResult getBookMarks(PkitUserInfo userInfo,int pageIndex,int pageSize,String sorttype){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	MetaData metaData = new MetaData(request);
    	
		return epgResult;
	}
    
    //增加书签
    public PkitEpgResult addBookMarks(PkitUserInfo userInfo,String categoryid,String programid,String programName,String programDesc,String programType,String bookmark){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	
		ServiceHelp serviceHelp = new ServiceHelp(request);
		//BookmarkImpl bookmark = new BookmarkImpl(request);
		
		int resultcode = -1;
		String resultdesc = "未执行";
		
		/*int bookmarkSize = serviceHelp.getBookmarkLimit(); //得到书签大小
				
		boolean isBookMark = false ;
		if(null != supVodId){
		   isBookMark = bookmark.isBookmark(progId,supVodId);
		}else{
		   isBookMark = bookmark.isBookmark(progId,null);
		}
		//当书签的最大容量为0或缺少参数时，增加出错提示信息
		if(progId == null || beginTime == null || endTime==null || bookmarkSize ==0){
			resultcode = 0;
		}             
		int tempcountTotal = 0; 		
		List<BookmarkItem> tempList = bookmark.getList();
		if(bookmarkList != null && null != tempList)
		{
			tempcountTotal = tempList.size();
		}
		//用户已有的书签大于书签的上限时报错
		if(tempList != null){
		   if(tempcountTotal >= bookmarkSize && !isBookMark){
				resultcode = 2;
		  	    resultdesc = "书签已满";
			}
		}
		boolean ret = bookmark.addItem(progId,beginTime,endTime,supVodId);
		if( ret == false ){
		   resultcode = 1;
		   resultdesc = "添加失败";
		}else{
		   resultcode = 0;
		   resultdesc = "添加成功";
		}
		*/
		
		epgResult.setResultcode(resultcode);
		epgResult.setResultdesc(resultdesc);
		
		return epgResult;
	}
    
    //删除书签
    public PkitEpgResult delBookMark( String id){
    	PkitEpgResult epgResult=new PkitEpgResult();
    	
	    int resultcode = -1;
		String resultdesc = "未执行";	
		
    	epgResult.setResultcode(resultcode);
		epgResult.setResultdesc(resultdesc);
		
		return epgResult;
	} 	
	
	
    public HttpServletRequest request;
	public DataSource(HttpServletRequest re) 
	{
		this.request = re;		
		try{			
			String path=request.getRealPath("");
			
			path=path+"/jsp/defaultsdzhuanti/ayh2012/en/datasource/log";
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
}
%>
<%
DataSource d=new DataSource(request);
%>
