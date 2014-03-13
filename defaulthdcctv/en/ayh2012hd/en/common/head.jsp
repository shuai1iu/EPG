<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!-- S 时间 -->
<!--<div class="medals-num">
		<iframe name="playscreen" id="playscreen" src="http://119.147.52.183:8081/2012/ChinaMedals.html" frameborder="0" width="440" height="80" allowtransparency="true" style="background:transparent" ></iframe>	
	</div>-->
<div class="date" id="currentDate" ></div>
<script type="text/javascript">
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "8"; iPanel.defaultFocusColor = "#2A5BB8";}
Authentication.CTCSetConfig("key_ctrl_ex", "0");
showCurrentDate('currentDate','hh:mi');
setInterval("showCurrentDate('currentDate','hh:mi')",60000);
</script> 
    <!-- E 时间 -->
    <!-- S 导航 --> 
    <div class="menu">
        <div class="item <% if ( "_1000".equals(currentPageId) ) {%> item-focus <%}%> " style="left:0px;">
            <!--
            默认 className = item item-f2
            当前 className = item item-f2_select
            其他 item-f2 item-f3 item-f4 亦同
            -->
            <div class="link"><a href="<%=static_en%>/page/index.jsp" id="_1000"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt">奥运会</div>
        </div>
        <div class="item <% if ( "_1001".equals(currentPageId) ) {%> item-focus <%}%>" style="left:148px;">
            <div class="link"><a href="<%=static_en%>/page/hd-arena.jsp" id="_1001"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt">高清赛场</div>
        </div>
        <div class="item <% if ( "_1002".equals(currentPageId) ) {%> item-focus <%}%>" style="left:296px;">
            <div class="link"><a href="<%=static_en%>/page/zrjp.jsp" id="_1002"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt">金牌赛事</div>
        </div>
        <div class="item <% if ( "_1003".equals(currentPageId) ) {%> china-select <%}%>" style="left:444px;">
            <div class="link"><a href="<%=static_en%>/page/china.jsp" id="_1003"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt">中国</div>
        </div>
        <div class="item <% if ( "_1004".equals(currentPageId) ) {%> item-focus <%}%>" style="left:592px;">
            <div class="link"><a href="<%=static_en%>/page/dibbling.jsp" id="_1004"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt">赛事点播</div>
        </div>
        <div class="item <% if ( "_1005".equals(currentPageId) ) {%> item-focus <%}%>" style="left:740px;">
            <div class="link"><a href="<%=static_en%>/page/ayml.jsp" id="_1005"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt">奥运名栏</div>
        </div>
        <div class="item <% if ( "_1006".equals(currentPageId) ) {%> item-focus <%}%>" style="left:888px;">
            <div class="link"><a href="<%=static_en%>/page/medals-list.jsp" id="_1006"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt">奖牌榜</div>
        </div>
        <div class="item <% if ( "_1007".equals(currentPageId) ) {%> item-focus <%}%>" style="left:1037px;">
            <div class="link"><a href="<%=static_en%>/page/search.jsp" id="_1007"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt">搜索</div>
        </div>
    </div>
     <div class="icon-come-on"><img src="<%=static_url%>/images/icon-come-on.png" /></div>
    <script type="text/javascript"> 
      var _currentFlag="<%=currentPageId%>";
      document.getElementById(_currentFlag).focus();
    </script>
    <!-- E 导航 -->