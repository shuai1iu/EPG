<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%!
/**
 * 增值业务栏目 
 */
public class TblCmsVasCategory
{
	private int dvasId;//增值业务编号
	private String dvasname;//增值业务名称
	private String dresume;//增值业务描述
	private String dsupplylang;//增值业务语种
	private String dproducedate;//出品日期
	private String dvasprice;//增值业务价格
	private String dposterpath0;//老的海报,取多海报的第一个
	private String dposterpath;//增值业务海报,根据传入的值进行获取相应的图片
	private List dserviceid;//服务编号数组
	private List dareaid;//区域编号数组
	private String dcode;//增值业务描述
	private String dstyle;//增值业务风格
	private String dtheme;//增值业务主题
	private String dintroduce;//增值业务介绍
	private String dnation;//国家信息
	private String dspname;//服务供应商名称
	private String dvasurl;//增值业务地址
	
	public int getDvasId() {
		return dvasId;
	}
	public void setDvasId(int dvasId) {
		this.dvasId = dvasId;
	}
	public String getDvasname() {
		return dvasname;
	}
	public void setDvasname(String dvasname) {
		this.dvasname = dvasname;
	}
	public String getDresume() {
		return dresume;
	}
	public void setDresume(String dresume) {
		this.dresume = dresume;
	}
	public String getDsupplylang() {
		return dsupplylang;
	}
	public void setDsupplylang(String dsupplylang) {
		this.dsupplylang = dsupplylang;
	}
	public String getDproducedate() {
		return dproducedate;
	}
	public void setDproducedate(String dproducedate) {
		this.dproducedate = dproducedate;
	}
	public String getDvasprice() {
		return dvasprice;
	}
	public void setDvasprice(String dvasprice) {
		this.dvasprice = dvasprice;
	}
	public String getDposterpath0() {
		return dposterpath0;
	}
	public void setDposterpath0(String dposterpath0) {
		this.dposterpath0 = dposterpath0;
	}
	public String getDposterpath() {
		return dposterpath;
	}
	public void setDposterpath(String dposterpath) {
		this.dposterpath = dposterpath;
	}
	public List getDserviceid() {
		return dserviceid;
	}
	public void setDserviceid(List dserviceid) {
		this.dserviceid = dserviceid;
	}
	public List getDareaid() {
		return dareaid;
	}
	public void setDareaid(List dareaid) {
		this.dareaid = dareaid;
	}
	public String getDcode() {
		return dcode;
	}
	public void setDcode(String dcode) {
		this.dcode = dcode;
	}
	public String getDstyle() {
		return dstyle;
	}
	public void setDstyle(String dstyle) {
		this.dstyle = dstyle;
	}
	public String getDtheme() {
		return dtheme;
	}
	public void setDtheme(String dtheme) {
		this.dtheme = dtheme;
	}
	public String getDintroduce() {
		return dintroduce;
	}
	public void setDintroduce(String dintroduce) {
		this.dintroduce = dintroduce;
	}
	public String getDnation() {
		return dnation;
	}
	public void setDnation(String dnation) {
		this.dnation = dnation;
	}
	public String getDspname() {
		return dspname;
	}
	public void setDspname(String dspname) {
		this.dspname = dspname;
	}
	public String getDvasurl() {
		return dvasurl;
	}
	public void setDvasurl(String dvasurl) {
		this.dvasurl = dvasurl;
	}

}
%>