<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%!
/**
 * TblCmsChannel  
 */
public class TblCmsProgram
{
	private String did;//节目信息
	private java.lang.String dcode;//平台全局唯一标识	
	private String dcspid;//内容提供商
	private java.lang.String dcmsid;//CSP唯一ID 
	private java.lang.String dcmscode;//CSP全局唯一标识	
	private java.lang.String dname;//节目名称 	
	private java.lang.String dordernumber;//节目订单编号
	private java.lang.String doriginalname;//原名
	private java.lang.String dsortname;//索引名称 
	private java.lang.String dsearchname;//搜索名称供界面搜索
	private java.lang.String dgenre;// 默认类别
	private java.lang.String dactordisplay;
	private java.lang.String dwriterdisplay;	
	private java.lang.String doriginalcountry;// 国家地区
	private java.lang.String dlanguage;// 语言	
	private java.lang.String dreleaseyear;//上映年份	
	private java.lang.String dorgairdate;// 首播日期
	private java.lang.String dlicensingwindowstart;//有效开始时间（YYYYMMDDHH24MiSS）	
	private java.lang.String dlicensingwindowend;//有效结束时间（YYYYMMDDHH24MiSS）
	private java.lang.String ddisplayasnew;	
	private java.lang.String ddisplayaslastchance;	
	private String dmacrovision;	
	private java.lang.String ddescription;//节目描述,节目介绍	
	private java.lang.String dpricetaxin;// 列表定价 	
	private String dstatus; // 状态标志	
	private String dsourcetype; //源类型
	private String dseriesflag; // 点播类型 
	private String dmovieno;  // 电视剧时第几集
	private String dissitcom;//连续剧类型(0:非连续剧父集、1:连续剧父集) 	
	private java.lang.String dtype;// 节目内容类型  
	private java.lang.String dkeywords;// 关键字（多个关键字用分号分隔）  	
	private java.lang.String dtags;//关联标签 	
	private java.lang.String dviewpoint;// 看点
	private String dstarlevel;//星级
	private java.lang.String drating;//限制类别 	
	private java.lang.String dawards;// 所含奖项 	
	private String dduration;//影片时长（分钟）仅展示用  
	private java.lang.String dcontentprovider;//内容提供商代码    
	private String dflowStatus;//流程状态 	
	private java.lang.String ddirector;//导演名字
	private java.lang.String dactor;//主演名字
	private int ddefinition;//1:高清、2:标清
	private String dprogramtype;
	private String dparentid;
	private String dprice;
	private String dvolumncount;
	private String dthumbimg;
	private String dposter;
	private String dstill;
	private String disneedpic;
	private String dcategoryid;
	private String dcategoryname;
	private String dpicpath;
	private String dpostpath;
	private List dsubvodidlist;//子集id的列表
	private List dsubvodnumlist;//子集集数的列表
	private String isFavorited;
	///////////////////////////////////////////
	public String getDid() {
		return did;
	}
	public void setDid(String did) {
		this.did = did;
	}
	public java.lang.String getDcode() {
		return dcode;
	}
	public void setDcode(java.lang.String dcode) {
		this.dcode = dcode;
	}
	public String getDcspid() {
		return dcspid;
	}
	public void setDcspid(String dcspid) {
		this.dcspid = dcspid;
	}
	public java.lang.String getDcmsid() {
		return dcmsid;
	}
	public void setDcmsid(java.lang.String dcmsid) {
		this.dcmsid = dcmsid;
	}
	public java.lang.String getDcmscode() {
		return dcmscode;
	}
	public void setDcmscode(java.lang.String dcmscode) {
		this.dcmscode = dcmscode;
	}
	public java.lang.String getDname() {
		return dname;
	}
	public void setDname(java.lang.String dname) {
		this.dname = dname;
	}
	public java.lang.String getDordernumber() {
		return dordernumber;
	}
	public void setDordernumber(java.lang.String dordernumber) {
		this.dordernumber = dordernumber;
	}
	public java.lang.String getDoriginalname() {
		return doriginalname;
	}
	public void setDoriginalname(java.lang.String doriginalname) {
		this.doriginalname = doriginalname;
	}
	public java.lang.String getDsortname() {
		return dsortname;
	}
	public void setDsortname(java.lang.String dsortname) {
		this.dsortname = dsortname;
	}
	public java.lang.String getDsearchname() {
		return dsearchname;
	}
	public void setDsearchname(java.lang.String dsearchname) {
		this.dsearchname = dsearchname;
	}
	public java.lang.String getDgenre() {
		return dgenre;
	}
	public void setDgenre(java.lang.String dgenre) {
		this.dgenre = dgenre;
	}
	public java.lang.String getDactordisplay() {
		return dactordisplay;
	}
	public void setDactordisplay(java.lang.String dactordisplay) {
		this.dactordisplay = dactordisplay;
	}
	public java.lang.String getDwriterdisplay() {
		return dwriterdisplay;
	}
	public void setDwriterdisplay(java.lang.String dwriterdisplay) {
		this.dwriterdisplay = dwriterdisplay;
	}
	public java.lang.String getDoriginalcountry() {
		return doriginalcountry;
	}
	public void setDoriginalcountry(java.lang.String doriginalcountry) {
		this.doriginalcountry = doriginalcountry;
	}
	public java.lang.String getDlanguage() {
		return dlanguage;
	}
	public void setDlanguage(java.lang.String dlanguage) {
		this.dlanguage = dlanguage;
	}
	public java.lang.String getDreleaseyear() {
		return dreleaseyear;
	}
	public void setDreleaseyear(java.lang.String dreleaseyear) {
		this.dreleaseyear = dreleaseyear;
	}
	public java.lang.String getDorgairdate() {
		return dorgairdate;
	}
	public void setDorgairdate(java.lang.String dorgairdate) {
		this.dorgairdate = dorgairdate;
	}
	public java.lang.String getDlicensingwindowstart() {
		return dlicensingwindowstart;
	}
	public void setDlicensingwindowstart(java.lang.String dlicensingwindowstart) {
		this.dlicensingwindowstart = dlicensingwindowstart;
	}
	public java.lang.String getDlicensingwindowend() {
		return dlicensingwindowend;
	}
	public void setDlicensingwindowend(java.lang.String dlicensingwindowend) {
		this.dlicensingwindowend = dlicensingwindowend;
	}
	public java.lang.String getDdisplayasnew() {
		return ddisplayasnew;
	}
	public void setDdisplayasnew(java.lang.String ddisplayasnew) {
		this.ddisplayasnew = ddisplayasnew;
	}
	public java.lang.String getDdisplayaslastchance() {
		return ddisplayaslastchance;
	}
	public void setDdisplayaslastchance(java.lang.String ddisplayaslastchance) {
		this.ddisplayaslastchance = ddisplayaslastchance;
	}
	public String getDmacrovision() {
		return dmacrovision;
	}
	public void setDmacrovision(String dmacrovision) {
		this.dmacrovision = dmacrovision;
	}
	public java.lang.String getDdescription() {
		return ddescription;
	}
	public void setDdescription(java.lang.String ddescription) {
		this.ddescription = ddescription;
	}
	public java.lang.String getDpricetaxin() {
		return dpricetaxin;
	}
	public void setDpricetaxin(java.lang.String dpricetaxin) {
		this.dpricetaxin = dpricetaxin;
	}
	public String getDstatus() {
		return dstatus;
	}
	public void setDstatus(String dstatus) {
		this.dstatus = dstatus;
	}
	public String getDsourcetype() {
		return dsourcetype;
	}
	public void setDsourcetype(String dsourcetype) {
		this.dsourcetype = dsourcetype;
	}
	public String getDseriesflag() {
		return dseriesflag;
	}
	public void setDseriesflag(String dseriesflag) {
		this.dseriesflag = dseriesflag;
	}
	public String getDmovieno() {
		return dmovieno;
	}
	public void setDmovieno(String dmovieno) {
		this.dmovieno = dmovieno;
	}
	public String getDissitcom() {
		return dissitcom;
	}
	public void setDissitcom(String dissitcom) {
		this.dissitcom = dissitcom;
	}
	public java.lang.String getDtype() {
		return dtype;
	}
	public void setDtype(java.lang.String dtype) {
		this.dtype = dtype;
	}
	public java.lang.String getDkeywords() {
		return dkeywords;
	}
	public void setDkeywords(java.lang.String dkeywords) {
		this.dkeywords = dkeywords;
	}
	public java.lang.String getDtags() {
		return dtags;
	}
	public void setDtags(java.lang.String dtags) {
		this.dtags = dtags;
	}
	public java.lang.String getDviewpoint() {
		return dviewpoint;
	}
	public void setDviewpoint(java.lang.String dviewpoint) {
		this.dviewpoint = dviewpoint;
	}
	public String getDstarlevel() {
		return dstarlevel;
	}
	public void setDstarlevel(String dstarlevel) {
		this.dstarlevel = dstarlevel;
	}
	public java.lang.String getDrating() {
		return drating;
	}
	public void setDrating(java.lang.String drating) {
		this.drating = drating;
	}
	public java.lang.String getDawards() {
		return dawards;
	}
	public void setDawards(java.lang.String dawards) {
		this.dawards = dawards;
	}
	public String getDduration() {
		return dduration;
	}
	public void setDduration(String dduration) {
		this.dduration = dduration;
	}
	public java.lang.String getDcontentprovider() {
		return dcontentprovider;
	}
	public void setDcontentprovider(java.lang.String dcontentprovider) {
		this.dcontentprovider = dcontentprovider;
	}
	public String getDflowStatus() {
		return dflowStatus;
	}
	public void setDflowStatus(String dflowStatus) {
		this.dflowStatus = dflowStatus;
	}
	public java.lang.String getDdirector() {
		return ddirector;
	}
	public void setDdirector(java.lang.String ddirector) {
		this.ddirector = ddirector;
	}
	public java.lang.String getDactor() {
		return dactor;
	}
	public void setDactor(java.lang.String dactor) {
		this.dactor = dactor;
	}
	public int getDdefinition() {
		return ddefinition;
	}
	public void setDdefinition(int ddefinition) {
		this.ddefinition = ddefinition;
	}
	public String getDprogramtype() {
		return dprogramtype;
	}
	public void setDprogramtype(String dprogramtype) {
		this.dprogramtype = dprogramtype;
	}
	public String getDparentid() {
		return dparentid;
	}
	public void setDparentid(String dparentid) {
		this.dparentid = dparentid;
	}
	public String getDprice() {
		return dprice;
	}
	public void setDprice(String dprice) {
		this.dprice = dprice;
	}
	public String getDvolumncount() {
		return dvolumncount;
	}
	public void setDvolumncount(String dvolumncount) {
		this.dvolumncount = dvolumncount;
	}
	public String getDthumbimg() {
		return dthumbimg;
	}
	public void setDthumbimg(String dthumbimg) {
		this.dthumbimg = dthumbimg;
	}
	public String getDposter() {
		return dposter;
	}
	public void setDposter(String dposter) {
		this.dposter = dposter;
	}
	public String getDstill() {
		return dstill;
	}
	public void setDstill(String dstill) {
		this.dstill = dstill;
	}
	public String getDisneedpic() {
		return disneedpic;
	}
	public void setDisneedpic(String disneedpic) {
		this.disneedpic = disneedpic;
	}
	public String getDcategoryid() {
		return dcategoryid;
	}
	public void setDcategoryid(String dcategoryid) {
		this.dcategoryid = dcategoryid;
	}
	public String getDcategoryname() {
		return dcategoryname;
	}
	public void setDcategoryname(String dcategoryname) {
		this.dcategoryname = dcategoryname;
	}
	public String getDpicpath() {
		return dpicpath;
	}
	public void setDpicpath(String dpicpath) {
		this.dpicpath = dpicpath;
	}
	public String getDpostpath() {
		return dpostpath;
	}
	public void setDpostpath(String dpostpath) {
		this.dpostpath = dpostpath;
	}
	public List getDsubvodidlist() {
		return dsubvodidlist;
	}
	public void setDsubvodidlist(List dsubvodidlist) {
		this.dsubvodidlist = dsubvodidlist;
	}
	public List getDsubvodnumlist() {
		return dsubvodnumlist;
	}
	public void setDsubvodnumlist(List dsubvodnumlist) {
		this.dsubvodnumlist = dsubvodnumlist;
	}
	public String getIsFavorited() {
		return isFavorited;
	}
	public void setIsFavorited(String isFavorited) {
		this.isFavorited = isFavorited;
	}
}

%>