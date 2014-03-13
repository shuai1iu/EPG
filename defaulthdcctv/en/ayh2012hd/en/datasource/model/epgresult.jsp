<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="cmschannel.jsp"%>
<%@ include file="cmsvod.jsp"%>
<%@ include file="cmscategory.jsp"%>
<%@ include file="rollinfo.jsp"%>
<%@ include file="cmsvascategory.jsp"%>
<%!
/**
 * EpgResult 类用来作数据传输，从service向view中返回数据，返回的是集合，则用datas保存，并对itemCount这些赋值
 * 如果是单个对象，则用oneObject保存
 */
public class EpgResult
{
    private int resultcode;
    private String resultdesc;
	private int pageSize;//每页大小
    private int pageIndex;//页码
    private int pageCount;//总页数
    private int itemCount;//记录数量
    private Object oneObject;
    private Object datas;
    
	public int getResultcode() {
		return resultcode;
	}

	public void setResultcode(int resultcode) {
		this.resultcode = resultcode;
	}

	public String getResultdesc() {
		return resultdesc;
	}

	public void setResultdesc(String resultdesc) {
		this.resultdesc = resultdesc;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getItemCount() {
		return itemCount;
	}

	public void setItemCount(int itemCount) {
		this.itemCount = itemCount;
	}

	public Object getOneObject() {
		return oneObject;
	}

	public void setOneObject(Object oneObject) {
		this.oneObject = oneObject;
	}

	public Object getDatas() {
		return datas;
	}

	public void setDatas(Object datas) {
		this.datas = datas;
	}
	
	public String toString(){
		return "resultcode:"+resultcode+"**** "+"resultdesc:"+resultdesc+"**** "
		+"pageSize:"+pageSize+"**** "+"pageIndex:"+pageIndex+"**** "+"pageCount:"+pageCount+"**** "
		+"itemCount:"+itemCount+"**** "+"oneObject:"+oneObject+"**** "+"datas:"+datas+"**** ";
	}

}
%>