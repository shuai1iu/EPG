<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%!
/**
 * TblCmsChannel  
 */
public class TblCmsCategory
{
	private String did;//栏目
	private java.lang.String dcode;//平台全局唯一标识
	private String dcspid;//内容提供商	
	private java.lang.String dcmsid;//CSP唯一ID 	
	private java.lang.String dcmscode;//CSP全局唯一标识  
	private java.lang.String dname;//分类名称	
	private java.lang.String dsequence;//显示序号	
	private java.lang.String dparentid;//父节点ID 
	private java.lang.String dparentcode;// 父节点Code
	private String dstatus;//状态
	private java.lang.String ddescription;//描述 	
	private java.lang.String dcontentprovider;//内容提供商代码
	private String picpath;//栏目的海报的路径，对于华为的平台的POSTERPATHS
	private String posterpath;//栏目对应的海报路径,为一个的海报的图片，对应华为平台的PICPATH
	private String dtype;
	//columns END
	public String ParentCode;

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
	public java.lang.String getDsequence() {
		return dsequence;
	}
	public void setDsequence(java.lang.String dsequence) {
		this.dsequence = dsequence;
	}
	public java.lang.String getDparentid() {
		return dparentid;
	}
	public void setDparentid(java.lang.String dparentid) {
		this.dparentid = dparentid;
	}
	public java.lang.String getDparentcode() {
		return dparentcode;
	}
	public void setDparentcode(java.lang.String dparentcode) {
		this.dparentcode = dparentcode;
	}
	public String getDstatus() {
		return dstatus;
	}
	public void setDstatus(String dstatus) {
		this.dstatus = dstatus;
	}
	public java.lang.String getDdescription() {
		return ddescription;
	}
	public void setDdescription(java.lang.String ddescription) {
		this.ddescription = ddescription;
	}
	public java.lang.String getDcontentprovider() {
		return dcontentprovider;
	}
	public void setDcontentprovider(java.lang.String dcontentprovider) {
		this.dcontentprovider = dcontentprovider;
	}
	public String getPicpath() {
		return picpath;
	}
	public void setPicpath(String picpath) {
		this.picpath = picpath;
	}
	public String getPosterpath() {
		return posterpath;
	}
	public void setPosterpath(String posterpath) {
		this.posterpath = posterpath;
	}
	public String getDtype() {
		return dtype;
	}
	public void setDtype(String dtype) {
		this.dtype = dtype;
	}
	public String getParentCode() {
		return ParentCode;
	}
	public void setParentCode(String parentCode) {
		ParentCode = parentCode;
	}

}

%>