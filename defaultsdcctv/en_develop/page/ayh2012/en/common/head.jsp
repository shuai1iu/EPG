<%@ page language="java" pageEncoding="UTF-8"%>
<style type="text/css">
<!--
.activity .link,.activity .link img { 
		height:46px;
		left:260px;
		top:10px; 
		width:284px;
	}
	.activity .link {
		left:258px;
		top:8px; 
	}
	.activity .pic { 
		height:42px;
		left:260px;
		top:10px; 
		width:280px;
	}
-->
</style>
<%
String itvUserId = (String)session.getAttribute("USERID");
%>
<!-- S 时间 -->
<div class="headTime" id="currentDate"></div>


<div class="activity">
<div class="link"><a href="#" onclick="goVas(1)"><img src="<%=static_url%>/images/t.gif" /></a></div>
<div class="pic">
<iframe id="jpframe" name="jpframe" border="0" width="276" height="38"></iframe>
</div>
</div>

<script type="text/javascript">
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "2"; iPanel.defaultFocusColor = "#FCFF05";}
Authentication.CTCSetConfig("key_ctrl_ex", "0");

showCurrentDate('currentDate','hh:mi');
setInterval("showCurrentDate('currentDate','hh:mi')",60000);
</script> 
    <!-- E 时间 -->

    <!-- S 导航 -->
    <div class="nav">
        <div class="item item-f2" style="left:0px;">
            <!--
            默认 className = item item-f2
            当前 className = item item-f2_select
            其他 item-f2 item-f3 item-f4 亦同
            -->
            <div class="link"><a href="<%=static_en%>/page/index.jsp" id="_1000"><% if ( "_1000".equals(currentPageId) ) {%><img src="<%=static_url%>/images/nav-item-f2_select.gif" /> <%}else { %><img src="<%=static_url%>/images/t.gif" /><%} %> </a></div>
            <div class="txt">首页</div>
        </div>
        
        <div class="item item-f4" style="left:60px;">
            <div class="link"><a href="<%=static_en%>/page/live.jsp" id="_1001"><% if ( "_1001".equals(currentPageId) ) {%> <img src="<%=static_url%>/images/nav-item-f4_select.gif" /> <%}else { %><img src="<%=static_url%>/images/t.gif" /><%} %></a></div>
            <div class="txt">直播大厅</div>
        </div>
        
        <div class="item  item-f4" style="left:163px;">
            <div class="link"><a href="<%=static_en%>/page/zrjp.jsp" id="_1002"><% if ( "_1002".equals(currentPageId) ) {%> <img src="<%=static_url%>/images/nav-item-f4_select.gif" /> <%}else { %><img src="<%=static_url%>/images/t.gif" /><%} %></a></div>
            <div class="txt">中国军团</div>
        </div>
       
        <div class="item item-f4" style="left:267px;">
            <div class="link"><a href="<%=static_en%>/page/ssdb.jsp" id="_1003"><% if ( "_1003".equals(currentPageId) ) {%> <img src="<%=static_url%>/images/nav-item-f4_select.gif" /> <%}else { %><img src="<%=static_url%>/images/t.gif" /><%} %></a></div>
            <div class="txt">赛事点播</div>
        </div>
      
        <div class="item item-f4" style="left:371px;">
            <div class="link"><a href="<%=static_en%>/page/oyml.jsp" id="_1004"><% if ( "_1004".equals(currentPageId) ) {%> <img src="<%=static_url%>/images/nav-item-f4_select.gif" /> <%}else { %><img src="<%=static_url%>/images/t.gif" /><%} %></a></div>
            <div class="txt">奥运名栏</div>
        </div>
        
        <div class="item item-f3" style="left:474px;">
            <div class="link"><a href="<%=static_en%>/page/jpb.jsp" id="_1005"> <% if ( "_1005".equals(currentPageId) ) {%> <img src="<%=static_url%>/images/nav-item-f3_select.gif" /> <%}else { %><img src="<%=static_url%>/images/t.gif" /><%} %></a></div>
            <div class="txt">奖牌榜</div>
        </div>
 
        <div class="item item-f2" style="left:555px;">
            <div class="link"><a href="<%=static_en%>/page/search.jsp" id="_1006"><% if ( "_1006".equals(currentPageId) ) {%> <img src="<%=static_url%>/images/nav-item-f2_select.gif" /> <%}else { %><img src="<%=static_url%>/images/t.gif" /><%} %></a></div>
            <div class="txt">搜索</div>
        </div>
    </div>
    <iframe name="hidden_frame" id="hidden_frame" frameborder="0" width="1px" height="1px"></iframe>
    <script type="text/javascript"> 
      var _currentFlag="<%=currentPageId%>";
      document.getElementById(_currentFlag).focus();
	  setTimeout(loadTop,1000);
	  function loadTop(){
		  jpframe.location.href = "http://119.147.52.183:8081/2012/ChinaMedals-bq.html";
	  }
	  function goVas(num){
		  location.href = "http://14.31.15.70:8001/EPG.aspx?itvno=<%=itvUserId%>&endUrl="+location.href;
	  }
    </script>
    <!-- E 导航 -->
