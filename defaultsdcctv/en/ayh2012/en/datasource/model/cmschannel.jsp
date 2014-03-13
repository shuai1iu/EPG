<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%!
/**
 * TblCmsChannel  
 */
public class TblCmsChannel
{
	/**
     * 频道       db_column: D_ID 
     */ 	
	
	private String did;
    /**
     * 平台全局唯一标识       db_column: D_CODE 
     */ 	
	private java.lang.String dcode;
    /**
     * CSP 唯一ID       db_column: D_CMSID 
     */ 	
	private java.lang.String dcmsid;
    /**
     * 内容提供商       db_column: D_CSPID 
     */ 	
	
	private String dcspid;
    /**
     * CSP全局唯一标识       db_column: D_CMSCODE 
     */ 	
	private java.lang.String dcmscode;
    /**
     * 频道号       db_column: D_CHANNELNUMBER 
     */ 	
	private java.lang.String dchannelnumber;
    /**
     * 频道名称       db_column: D_NAME 
     */ 	
	private java.lang.String dname;
    /**
     * 台标名称       db_column: D_CALLSIGN 
     */ 	
	private java.lang.String dcallsign;
    /**
     * 时移标识       db_column: D_TIMESHIFT 
     */ 	
	
	private String dtimeshift;
	private String distvod;
    /**
     * 存储时长(小时)       db_column: D_STORAGEDURATION 
     */ 	
	
	private String dstorageduration;
    /**
     * 默认时移时长(分钟)       db_column: D_TIMESHIFTDURATION 
     */ 	
	
	private String dtimeshiftduration;
    /**
     * 描述       db_column: D_DESCRIPTION 
     */ 	
	private java.lang.String ddescription;
    /**
     * 国家       db_column: D_COUNTRY 
     */ 	
	private java.lang.String dcountry;
    /**
     * 州/省       db_column: D_STATE 
     */ 	
	private java.lang.String dstate;
    /**
     * 城市       db_column: D_CITY 
     */ 	
	private java.lang.String dcity;
    /**
     * 邮编       db_column: D_ZIPCODE 
     */ 	
	private java.lang.String dzipcode;
    /**
     * 类型       db_column: D_TYPE 
     */ 	
	
	private String dtype;
    /**
     * 信号来源       db_column: D_SUBTYPE 
     */ 	
	
	private String dsubtype;
    /**
     * 语言       db_column: D_LANGUAGE 
     */ 	
	private java.lang.String dlanguage;
    /**
     * 状态标志       db_column: D_STATUS 
     */ 	
	
	private String dstatus;
    /**
     * 播放开始时间(HH24MI)       db_column: D_STARTTIME 
     */ 	
	private java.lang.String dstarttime;
    /**
     * 播放结束时间(HH24MI)       db_column: D_ENDTIME 
     */ 	
	private java.lang.String dendtime;
    /**
     * dmacrovision       db_column: D_MACROVISION 
     */ 	
	
	private String dmacrovision;
    /**
     * 视频参数       db_column: D_VIDEOTYPE 
     */ 	
	private java.lang.String dvideotype;
    /**
     * 音频类型       db_column: D_AUDIOTYPE 
     */ 	
	private java.lang.String daudiotype;
    /**
     * 码流标识       db_column: D_STREAMTYPE 
     */ 	
	
	private String dstreamtype;
    /**
     * 双语标识       db_column: D_BILINGUAL 
     */ 	
	
	private String dbilingual;
    /**
     * 内容提供商代码       db_column: D_CONTENTPROVIDER 
     */ 	
	private java.lang.String dcontentprovider;
    /**
     * 流程状态       db_column: D_FLOW_STATUS 
     */ 	
	
	private String dflowStatus;
	//
	private String dchannelid;
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
	public java.lang.String getDcmsid() {
		return dcmsid;
	}
	public void setDcmsid(java.lang.String dcmsid) {
		this.dcmsid = dcmsid;
	}
	public String getDcspid() {
		return dcspid;
	}
	public void setDcspid(String dcspid) {
		this.dcspid = dcspid;
	}
	public java.lang.String getDcmscode() {
		return dcmscode;
	}
	public void setDcmscode(java.lang.String dcmscode) {
		this.dcmscode = dcmscode;
	}
	public java.lang.String getDchannelnumber() {
		return dchannelnumber;
	}
	public void setDchannelnumber(java.lang.String dchannelnumber) {
		this.dchannelnumber = dchannelnumber;
	}
	public java.lang.String getDname() {
		return dname;
	}
	public void setDname(java.lang.String dname) {
		this.dname = dname;
	}
	public java.lang.String getDcallsign() {
		return dcallsign;
	}
	public void setDcallsign(java.lang.String dcallsign) {
		this.dcallsign = dcallsign;
	}
	public String getDtimeshift() {
		return dtimeshift;
	}
	public void setDtimeshift(String dtimeshift) {
		this.dtimeshift = dtimeshift;
	}
	public String getDistvod() {
		return distvod;
	}
	public void setDistvod(String distvod) {
		this.distvod = distvod;
	}
	public String getDstorageduration() {
		return dstorageduration;
	}
	public void setDstorageduration(String dstorageduration) {
		this.dstorageduration = dstorageduration;
	}
	public String getDtimeshiftduration() {
		return dtimeshiftduration;
	}
	public void setDtimeshiftduration(String dtimeshiftduration) {
		this.dtimeshiftduration = dtimeshiftduration;
	}
	public java.lang.String getDdescription() {
		return ddescription;
	}
	public void setDdescription(java.lang.String ddescription) {
		this.ddescription = ddescription;
	}
	public java.lang.String getDcountry() {
		return dcountry;
	}
	public void setDcountry(java.lang.String dcountry) {
		this.dcountry = dcountry;
	}
	public java.lang.String getDstate() {
		return dstate;
	}
	public void setDstate(java.lang.String dstate) {
		this.dstate = dstate;
	}
	public java.lang.String getDcity() {
		return dcity;
	}
	public void setDcity(java.lang.String dcity) {
		this.dcity = dcity;
	}
	public java.lang.String getDzipcode() {
		return dzipcode;
	}
	public void setDzipcode(java.lang.String dzipcode) {
		this.dzipcode = dzipcode;
	}
	public String getDtype() {
		return dtype;
	}
	public void setDtype(String dtype) {
		this.dtype = dtype;
	}
	public String getDsubtype() {
		return dsubtype;
	}
	public void setDsubtype(String dsubtype) {
		this.dsubtype = dsubtype;
	}
	public java.lang.String getDlanguage() {
		return dlanguage;
	}
	public void setDlanguage(java.lang.String dlanguage) {
		this.dlanguage = dlanguage;
	}
	public String getDstatus() {
		return dstatus;
	}
	public void setDstatus(String dstatus) {
		this.dstatus = dstatus;
	}
	public java.lang.String getDstarttime() {
		return dstarttime;
	}
	public void setDstarttime(java.lang.String dstarttime) {
		this.dstarttime = dstarttime;
	}
	public java.lang.String getDendtime() {
		return dendtime;
	}
	public void setDendtime(java.lang.String dendtime) {
		this.dendtime = dendtime;
	}
	public String getDmacrovision() {
		return dmacrovision;
	}
	public void setDmacrovision(String dmacrovision) {
		this.dmacrovision = dmacrovision;
	}
	public java.lang.String getDvideotype() {
		return dvideotype;
	}
	public void setDvideotype(java.lang.String dvideotype) {
		this.dvideotype = dvideotype;
	}
	public java.lang.String getDaudiotype() {
		return daudiotype;
	}
	public void setDaudiotype(java.lang.String daudiotype) {
		this.daudiotype = daudiotype;
	}
	public String getDstreamtype() {
		return dstreamtype;
	}
	public void setDstreamtype(String dstreamtype) {
		this.dstreamtype = dstreamtype;
	}
	public String getDbilingual() {
		return dbilingual;
	}
	public void setDbilingual(String dbilingual) {
		this.dbilingual = dbilingual;
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
	public String getDchannelid() {
		return dchannelid;
	}
	public void setDchannelid(String dchannelid) {
		this.dchannelid = dchannelid;
	}

}

%>