<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%!
/**
 * 滚动信息 
 */
public class TblRollInfo
{
	private String drollname;//发布的信息的内容 	
	private int drollspeed;// 循环的速度	
	private int drolltime;//循环的次数 
  
	public String getDrollname() {
		return drollname;
	}
	public void setDrollname(String drollname) {
		this.drollname = drollname;
	}
	public int getDrollspeed() {
		return drollspeed;
	}
	public void setDrollspeed(int drollspeed) {
		this.drollspeed = drollspeed;
	}
	public int getDrolltime() {
		return drolltime;
	}
	public void setDrolltime(int drolltime) {
		this.drolltime = drolltime;
	}
}
%>