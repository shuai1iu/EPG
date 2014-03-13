/**
* @description 页面对象
*/
var pageobj;
var channelNum = 0; //用来记录直播号
var cTempChannelNum = ''; //用来记录临时的直播号
var tempChannelNum = 0;
var channelNumCount = 0; //用来记录输入直播号几位
var delayTime = 2000;
var tmpthis;
/** 
* @fileOverview *EPG2.0页面逻辑控制JS库
<br/>代码说明:本JS库封装了EPG页面焦点移动和异步数据获取的大部分情况，使用简洁，只需要简短的代码就可以实现页面逻辑控制，简化了EPG的开发<br/>
作者：XX<br/>
时间：2011.5.3<br/>
修改时间:2011.6.20<br/>
命名规则：<br/>
1 类每个单词开头字母大写<br/>
2 方法全小写<br/>
功能描述:<br/>
1 支持基本焦点移动和区域切换
2 支持区域中焦点移动循环和页面中区域移动循环<br/>
3 支持一个区域内多行多列焦点对象<br/>
4 支持区域间固定焦点到固定焦点的移动<br/>
5 支持一个区域的所有对象共用一个焦点对象，目前用于焦点切换共用一张图片的情况<br/>
6 支持一个焦点的改变修改多个dom对象的样式<br/>
7 支持一个dom对象的样式改变修改多个属性 <br/>
8 支持移出区域时记录焦点<br/>
9 支持移出区域保留本区域样式<br/>
10 支持根据实际数据个数移动焦点
11 支持异步获得数据，并加锁<br/>
12 支持翻页<br/>
13 支持部分事件 <br/>
14 支持弹出窗口 <br/>

* @author xx 
* @version 1.1
*/  
/** 
* @author xx
* @constructor PageObj 
* @description 页面类，负责管理管理整个页面区域的移动和事件控制
* @example new PageObj(0,0,new Area(area1,area2,area3)); 
* @since version 1.1 
* @param {Num} curareaid 当前区域号 
* @param {Num} index 当前区域内焦点下标号
* @param {Array(class:Area)} areas 所有区域对象,Area对象在areas数组中存数的下标即为这个Area对象的id
* @class 页面控制类<br/>
*/
var firstblood=true;
function PageObj(areas,popups)
{
   /** 
   * @description Num 当前区域id（区域数组的存储顺序下标即为当前页面的id）
   * @field
   */
   this.curareaid=0;
   /** 
   * @description Array(class:Area) 所有区域对象 
   * @field
   */
   this.areas=areas;
   /** 
   * @description class:Popup 弹出窗口对象数组
   * @field
   */
   this.popups=popups;
   /** 
   * @description string 返回页面url，给此参数赋值，点击返回按钮会跳转到此值的页面
   * @field
   */
   this.backurl=undefined;
   /** 
   * @description any 存储可使用对象，任何类型 
   * @field
   */
   this.youwanauseobj=undefined;
   /** 
   * @description 页面确定事件
   * @field
   */
   this.pageOkEvent=undefined;
   /** 
   * @description 页面返回事件
   * @field
   */
   this.goBackEvent=undefined;
   /** 
   * @description 页面数字按键事件（目前用于直播数字快捷键）
   * @Param num 按键的数字
   * @field
   */
   this.pageNumTypeEvent=undefined;
   this.pageVolChangeEvent=undefined;
   this.pageSetMuteFlagEvent=undefined;
   this.jumpToChannelSBM=undefined;
   
   this.pageNumTypeEvent=function(num)
   {
	   if(isTextBox!=undefined){
			return;
		}
		if(numkey) return;
		showChannelNum(num);
		if(t_num!=undefined)
		clearTimeout(t_num);
		t_num=setTimeout(showJumpInfoAndPause,1000);
   }
   
	 function jumpToChannelSBM()
	 {
	 		mp.stop();			
			var channelUrl = "play_ControlChannel.jsp?COMEFROMFLAG=3&CHANNELNUM=" + channelNum;
			window.location.href =  channelUrl;
			
	 }
	function showChannelNum(num)
	{
		channelNumCount++;
	    if(channelNumCount > 4)
		{
			return true;
		}
		tempChannelNum = tempChannelNum * 10 + num;
		channelNum = tempChannelNum;
		//alert("channelNum:"+channelNum);
	    //document.all.PlayTrailer.showChannelNum(channelNum);
	}
	
   	/**
	*显示跳转到直播层并暂停视频
	*/
	function showJumpInfoAndPause()
	{
		var t2=setTimeout(showJumpToChannelInfo,500);
	}

	function showJumpToChannelInfo()
	{		
		jumpToChannelSBM();
	} 
	function jumpToChannel()
	{
		mp.stop();
		
		window.location.href = channelUrl + channelNum;
	}  
   
   
   
   
   /** 
   * @description 页面翻页键事件
   * @Param num -1上页，1下页
   * @field
   */
   this.pageTurnEvent=undefined;
   //循环赋值每个区域的ID，和把页面对象付给每个区域
   if(this.areas!=undefined)
   for(i=0;i<this.areas.length;i++)
   {
       this.areas[i].id=i;
	   this.areas[i].pageobj=this;
    }

   //设置弹出层
   if(this.popups!=undefined)
   {
         for(i=0;i<this.popups.length;i++)
            this.popups[i].pageobj=this;
   }
   /** 
   * @description 页面移动按键执行方法 
   * @param {Num} dir 方向 0,1,2,3 上左下右
   */ 
   this.move=function(dir)
   {
	   if(this.areas!=undefined)
	   {
	      var nextareadata=this.areas[this.curareaid].move(dir==0||dir==1?-1:1,dir);
	      if(nextareadata!=-1)
          {
	          this.curareaid=parseInt(nextareadata[0]);
	          this.areas[parseInt(nextareadata[0])].areain(nextareadata[1]!=undefined?parseInt(nextareadata[1]):undefined,dir);
          }
	   }
   }
   /** 
   * @description 页面回车按键执行方法，会自动调用当前区域确定方法
   */ 
   this.ok=function()
   {
	   if(!!this.pageOkEvent)
	    this.pageOkEvent();
		if(this.areas!=undefined)
	      this.areas[this.curareaid].ok(); 
   }
   /** 
   * @description 页面数字按键执行方法，会自动调用当前区域数字按键方法
   * @param {Num} num 数字 
   */ 
   this.numType=function(num)
   {
	   if(!!this.pageNumTypeEvent)
	      this.pageNumTypeEvent(num);
	   if(this.areas!=undefined)
	      this.areas[this.curareaid].numType(num);
   }
   
   /** 
   * @description 翻页按键执行方法
   * @param {Num} num 数字
   */ 
   this.pageTurn=function(num)
   {
	   if(this.areas!=undefined)
	     this.areas[this.curareaid].pageTurn(num);
	   if(!!this.pageTurnEvent)
	      this.pageTurnEvent(num);
   }
   /** 
   * @description 返回按键执行方法 
   */ 
   this.goBack=function()
   {
	   if(this.areas!=undefined)
	   {
	     if(!this.areas[this.curareaid].goback())
		 {
	         if(!!this.goBackEvent)
	            this.goBackEvent();
	         if(this.backurl!=undefined)
			 {	 
	            window.location.href=this.backurl;
		      }
		 }
	   }
   }
   /** 
   * @description 设置初始化时候的焦点，因为默认焦点是在没数据的时候焦点的，如果遇到滚动就不行
   */ 
   this.setinitfocus=function(areaid,indexid)
   {
	   if(this.areas!=undefined)
      this.areas[areaid].changefocus(indexid,true);
	  this.curareaid=areaid;
   }
    /** 
   * @description 获得当前区域聚焦的下标
   * @return {Num}  当前区域聚焦的下标
   */ 
   this.getfocusindex=function()
   {
	   if(this.areas!=undefined)
	      return this.areas[this.curareaid].curindex;
   }
    /** 
   * @description 获得当前区域聚焦的焦点对象
   * @return {DomData}  当前区域聚焦的焦点对象
   */ 
   this.getfocusdom=function()
   {
	   if(this.areas!=undefined)
	      return this.areas[this.curareaid].doms[this.areas[this.curareaid].curindex];
   }
   this.changefocus=function(areaid,index)
   {
	   if(this.areas!=undefined)
	   for(i=0;i<this.areas.length;i++)
       {
		   
             this.areas[i].clearfocus();
		   if(i==areaid)
		     this.areas[i].changefocus(index,true);
		   this.curareaid=areaid;
       }
   }
   /** 
   * @description 声音改变
   * @param {Num} num 数字 +1增加  -1减去
   */ 
   this.volChange=function(num)
   {
	   if(!!this.pageVolChangeEvent)
	       this.pageVolChangeEvent(num);   
   }
   /** 
   * @description 设置静音
   */ 
   this.setMuteFlag=function()
   {
	    if(!!this.pageSetMuteFlagEvent)
		    this.pageSetMuteFlagEvent();   
   }
}
var t1;
Area.names=new Array();
/** 
* @author xx
* @constructor Area 
* @description EPG中的区域类（比如切换焦点时由一个区域切换到另一个)
* @example new Area(2,3,new Array(dom1.dom2,dom3),new Array(-1,1,-1,2),false); 
* @since version 1.0 
* @param {Num} numrow 行数
* @param {Num} numcolum 列数
* @param {Array(class:DomData)} doms 区域内焦点对象，DomData焦点对象在doms数组中存数的下标即为这个焦点对象的id
* @param {Array(Num)} directions 长度为4的数组，代表上左下右四个方向可移动到的区域的id,-1为无法向这个方向移动
* @class 区域类<br/>
*/  
function Area(numrow,numcolum,doms,directions)
{
   /** 
   * @description class:Area 指定本区域变焦时影响数据变化的区域，需要给该区域所有焦点对象的dataurlorparam属性赋值<br/>
   例子：<br/>
   var newscode=new Array("1138","1139","1140","1141","1142");<br/>
   var newsid=new Array(1,2,3,4,5);<br/>
   area0.dataarea=area2;<br/>
   for(i=0;i<5;i++)<br/>
	{<br/>
	    doms0[i].dataurlorparam= new Array(newscode[i],newsid[i]);<br/>
	}<br/>
   //area2区域对象异步获取数据方法实现<br/>
   area2.asyngetdata=function(data)<br/>
	{<br/>
	    //加锁<br/>
		area2.lockin=true;<br/>
		//通过iframe异步获取数据<br/>
		$('hidden_frame').src="newsasyndata1.jsp?code="+data[0]+"&newsid="+data[1];<br/>
	}<br/>
   //数据获取的回调方法<br/>
   function callback(data)
	{<br/>
	    //赋值area2的数据实际个数<br/>
		area2.datanum=data.length;<br/>
		for(i=0;i<area2.doms.length;i++)<br/>
			{<br/>
				if(i<data.length)<br/>
			   {<br/>
				   area2.doms[i].updatecontent("·"+data[i].VODNAME);<br/>
			       area2.doms[i].mylink="mediadetail.jsp?mediaid="+data[i].VODID+"&returnurl="+escape(window.location.href);<br/>
			   }<br/>
			   else<br/>
				area2.doms[i].updatecontent("");<br/>
			}<br/>
		//解锁<br/>
		area2.lockin=true;<br/>
	}<br/>
   * @field
   */
   this.dataarea=undefined;
   	/** 
    * @description 移动焦点改变其他区域数据时，是否延迟500毫秒
	* @field
    */
   this.delay=true;
   /** 
   * @description Num 数据个数
   * @field
   */
   this.datanum=undefined;
   /** 
   * @description Num 当前内容下标
   * @field
   */
   this.curindex=0;
   /** 
   * @description Num 设置一个方向，如果从该方向的其他区移动到这个区域，会移动到本区域保存的下标，此位置优先级优先于固定位置定义
   * @field
   */
   this.stayindexdir=undefined;
   /** 
   * @description Array(class:DataDom) 这个区域里所有焦点对象 
   * @field
   */
   this.doms=doms;
   /** 
   * @description bool 如果这个值为true，那么不能从任何方向向这个区域移动，主要用于异步获取数据时锁定区域，以免造成界面错误
   * @field
   */
   this.lockin=undefined;
   /** 
   * @description Array(string,Num) 长度为4的字符和数字混合数组，代表4个方向，用于指定位置移动，格式"{Num:本区域内的焦点id}-{Num:将移动到的区域内的焦点id}"或"{Num:本区域内的焦点id}-{Num:指定区域号，用于特殊移动要求}>{Num:将移动到的区域内的焦点id}"或者-1代表不指定该方向的固定移动位置</br>
      例子:</br>
	  var area7=new Area(1,3,doms7,new Array(6,4,8,-1));</br>
	  area7.stablemoveindex=new Array("0-3>0,1-1,2-1",-1,"0-0,1-0,2-1",-1);</br>
	  区域7初始化时指定了4个方向将移动的区域号，那么固定区域数组0下标位置的"0-3>0,1-1,2-1"意思是本区域内的0下标焦点位置向上移动会移动到id为3的区域内的0位置焦点，1下标焦点位置向上移动到6区的1下标位置，2下标焦点位置向上移动也移动到6区1下标位置；固定区域数组1下标位置的-1代表向4区域不指定固定位置，那么默认下个区的0位置；
   * @field
   */
   this.stablemoveindex=undefined;
   /** 
   * @description Array 移出本区域时，样式是否改为失焦，或者保持聚焦样式 
   * @field
   */
   this.outstaystyle=false;
   /** 
   * @description any 存储可使用对象，任何类型 
   * @field
   */
   this.youwanauseobj=undefined;
   /** 
   * @description Num 当前页码，初始化值为1（如果这是一个可翻页区域，需要在异步获取方法asyngetdata中调用这个值，而且需要在取得数据方法中给这个属性赋值，否者不可调用pageturn和pagego方法）<br/>
   例子：<br/>
   //area0区域对象异步获取数据方法的实现<br/>
   area0.asyngetdata=function()<br/>
   {<br/>
        //锁定本区域<br/>
        this.lockin=true;<br/>
		//用于翻页，调用本区域的curpage属性，这样便可以调用pageturn和pagego方法<br/>
		$('hidden_frame').src="newslistasyndata.jsp?curpage="+this.curpage+"&code=1234";<br/>
   }<br/>
   function getdata(data,count)<br/>
   {<br/>
        //这个函数会给赋值数据实际个数和总个页面，并且判断翻页时是否超出当前页面数据个数，如果超过下标置为0<br/>
		this.setpageturndata(data.length,parseInt(count));<br/>
	    for(i=0;i<area0.doms.length;i++)<br/>
	    {<br/>
	    	 if(i<data.length)<br/>
			 {<br/>
				 area0.doms[i].updatecontent("·"+data[i].VODNAME);<br/>
				 area0.doms[i].mylink="mediadetail.jsp?mediaid="+data[i].VODID+"&returnurl="+escape(window.location.href);<br/>
			 }<br/>
			 else<br/>
			    area0.doms[i].updatecontent("");	<br/>
		 }<br/>
		 //页面显示<br/>
		 $('page').innerHTML=area0.curpage+"/"+count;<br/>
		 //解锁本区域<br/>
		 area0.lockin=false;<br/>
	}<br/>
   * @field
   */
   this.curpage=1;
   /** 
   * @description Num 页面总数（如果这是一个可翻页区域，需要给这个属性赋值）
   * @field
   */
   this.pagecount=undefined;
   /** 
   * @description 异步获取数据方法
   */ 
   this.urltemplate=undefined;
   this.getdata=undefined;
   this.isajax=true;
   this.mydatafunc=undefined;
   this.mymovelock=false;
   this.myparam=undefined;
   this.liandong=undefined;
   this.fanye=undefined;
   this.setSimulationAjax=function(func)
   {
	   this.isajax=false;
	   this.mydatafunc=func;
   }
   this.setTrueAjax=function(templateurl,func,param)
   {
	   this.getdata=func;
	   this.isajax=true;
	   this.urltemplate=templateurl;
	   this.myparam=param;
   }
   this.asyngetdata=function(tmpfunction)
   {
	   var tmpthis=this;
	   var param=new Array();
	   param[0]=tmpfunction;
	  //判断是翻页，还是联动
	  if(this.mydatafunc!=undefined&&this.getdata!=undefined)
	  if(tmpfunction==undefined)
	  {
	      //是联动
		  if(liandong!=undefined)
		    this.isajax=liandong;
	  }
	  else
	  {
	     //是翻页
		 if(fanye!=undefined)
		    this.isajax=fanye;
	  }
	  //可选择执行ajax还是执行自己的方法来取数据
	  if(this.isajax)
	  {
		  this.mymovelock=true;
	      if(this.myparam!=undefined)
	      param[1]=this.myparam;
		  var url;
		  if(this.urltemplate!=undefined)
		  {
			  //使用正则表达式替换字符为最新数据
			  var urlarray=this.urltemplate.split('#');
			  if(urlarray!=null)
			  {
			  var url=this.urltemplate;
			  for(var i=1;i<urlarray.length;i++)
			  {
				   var tmpvalue=urlarray[i].substring(1,urlarray[i].lastIndexOf(')'));
				   url=url.replace('#('+tmpvalue+')',''+eval(tmpvalue));
				   
			  }
			  }
		  }
	      getAJAXData(url,this.mycallback,param,tmpthis); 
          if(firstblood)
		  {
			    getAJAXData(url,this.mycallback,param,tmpthis); 
				firstblood=false;
		  }
	  }
      else
	  {
		  //自定义的取数据方法，不是异步
	      this.mydatafunc();
		  param[0]();
	  }
   };
   
   this.mycallback=function(responseText,param,obj)
   {
	   //执行回调
	      obj.getdata(responseText,param[1]);
	   //执行回调
	     if(param[0]!=undefined)
	      param[0]();
	   //解锁
		  obj.mymovelock=false;  
   }
   /** 
   * @description 将异步获取的数据解析并显示的方法 
   * @param {json} data 数据 
   */ 
   this.showasyndata=undefined;
   /** 
   * @description 区域确认事件 
   */ 
   this.areaOkEvent=undefined;
   /** 
   * @description 区域进入时事件 
   */ 
   this.areaIningEvent=undefined;
   /** 
   * @description 区域进入完成事件 
   */ 
   this.areaInedEvent=undefined;
   /** 
   * @description 区域移出时事件 
   */ 
   this.areaOutingEvent=undefined
   /** 
   * @description 区域移出完成事件 
   */ 
   this.areaOutedEvent=undefined;
   /** 
   * @description 数字按键事件 
   * @param {Num} num 数字 
   */ 
   this.areaNumTypeEvent=undefined;
   /** 
   * @description 翻到首页事件 
   */ 
   this.firstpageEvent=undefined;
   /** 
   * @description 翻到首页事件 
   */ 
   this.lastpageEvent=undefined;
   /** 
   * @description 区域改变焦点前事件 
   */ 
   this.changefocusingEvent=undefined;
   /** 
   * @description 区域改变焦点后事件 
   */ 
   this.changefocusedEvent=undefined;
   /** 
   * @description 区域翻页事件(使用上下页按钮) 
   * @param {Num} num 数字 
   */ 
   this.areaPageTurnEvent=undefined;
   /** 
   * @description 区域翻页后事件 
   */ 
   this.areaPageTurnEvent1=undefined;
   /** 
   * @description 返回键事件
   */ 
   this.goBackEvent=undefined;
   // Num 区域ID
   this.id=undefined;
   //Num 内容行数 
   this.numrow=numrow;
   // Num 内容列数 
   this.numcolum=numcolum;
   // Array(Num) 上左下右四个方向将移动到的区域的id,-1为无法向这个方向移动 
   this.directions=directions;
   // PageObj 页面对象
   this.pageobj=undefined;
   // bool 标志是否此区域对象共用一个焦点对象，指定该属性不需要指定该区的焦点对象的失焦样式
   this.useoneobj=false;
   // bool 标志此区域是否在某个方向循环，0位置上下方向，1为左右方向
   this.circledir=undefined;
   //标志是否四个方向的可移动性
   this.directionsallow=new Array(directions[0]==-1?false:true,directions[1]==-1?false:true,directions[2]==-1?false:true,directions[3]==-1?false:true);
   //保存每个方向的记录下标
   this.stayindexarray=new Array(-1,-1);
   this.outstaydir=undefined;
   this.crossturnpage=false;
   this.commonfocusstyle=undefined;
   this.commonunfocusstyle=undefined;
   this.upattention=undefined;
   this.downattention=undefined;
   this.darkness=false;
   for(i=0;i<this.doms.length;i++)
   {
	   this.doms[i].id=i;
	   this.doms[i].belongarea=this;   
   }
   this.flag=Area.names.length;
   Area.names[this.flag]=this;
   //区域移动方法
   //num:移动偏量+-1
   //dirindex:移动的方向，0，1，2，3
   /**
   * @private
   */
   this.move=function(num,dirindex)
   {
	   if(this.mymovelock==true)
	     return -1;
	   if(num!=-1&&num!=1)
	     return -1;
	   //根据方向设置数据
	   var cross;
	   var isemptydom=false;
	   if(dirindex==0||dirindex==2)
	   {
		   
		   //判断行是否越界
		   var currow=parseInt(this.curindex/this.numcolum);
	       if(num>0)
	          cross=(currow+num)>this.numrow-1;
	       else
	          cross=(currow+num)<0;
		   if(!cross)
		   {
			   //如果行没有越界，判断将要移动到的dom是否为空，如果为空则越界，并记录是空dom造成的越界
			  if(this.datanum!=undefined)
			  {
		        var tmpnextindex=this.curindex+num*this.numcolum;
		        if(tmpnextindex>this.datanum-1)
				{
		          cross=true;
				  isemptydom=true;
				}
			  }
		   }
		   //如果循环方向为上下方向,加上是否有多页的，有多页的就需要再最后一页循环
		   if(this.circledir==0&&this.pagecount==undefined)
			  return this.insidemove(true,dirindex,num,cross);
	   }
	   else if(dirindex==1||dirindex==3)
	   {
		   //判断列是否越界
		   var curcolum=this.curindex%this.numcolum;
		   if(num>0)
	          cross=(curcolum+num)>this.numcolum-1;
	       else
	          cross=(curcolum+num)<0;
			  //如果列没有越界，判断将要移动到的dom是否为空，如果为空则越界，并记录是空dom造成的越界
			  if(!cross)
			  {
				  if(this.datanum!=undefined)
			     {
				   var tmpnextindex=this.curindex+num;
				   if(tmpnextindex>this.datanum-1)
				   {
		             cross=true;
				     isemptydom=true;
				   }
				 }
			  }
		   //如果循环方不为左右方向
		   if(this.circledir==1&&this.pagecount==undefined)
			  return this.insidemove(true,dirindex,num,cross);
	   }
	   //判断是否越界
	   if(cross)
	   {
		  if(!this.crossturnpage||dirindex==1||dirindex==3)
		  {
		  //判断是否有下个区域,如果有，返回将要移动的区域ID，如果没得有返回-1代表不可移动
		  if(this.directionsallow[dirindex])
		  {
			  pageobj.lastareaid = pageobj.curareaid;
			  if(!!this.areaOutingEvent)
			     if(this.areaOutingEvent(dirindex))
				   return -1;
			  //如果要移动的下个区域被锁定，不移动
			  if(this.pageobj.areas[this.directions[dirindex]].lockin||(this.pageobj.areas[this.directions[dirindex]].datanum!=undefined&&this.pageobj.areas[this.directions[dirindex]].datanum<=0))
			     return -1;
			  //移出本区域是否需要保持当前焦点样式
			  if(this.outstaydir!=undefined&&this.outstaydir==dirindex)
			  {
				  this.darkness=true;
			  if(typeof(this.outstaystyle)!="boolean")
			  {
				 if(this.outstaystyle.constructor==Array)
			        this.doms[this.curindex].changestyle(this.outstaystyle);
				 else
				    this.doms[this.curindex].changestyle(new Array(this.outstaystyle));
			  }
			  else if(!this.outstaystyle)
			    this.changefocus(this.curindex,false);	
			  }
			  else
			  {
				this.darkness=false;
			    this.changefocus(this.curindex,false);
			  }
			     
			  //计算将要移动到的区域的固定位置
			  var tmpstable;
			  var tmpstablearea;
			  if(this.stablemoveindex!=undefined)
			  if(this.stablemoveindex[dirindex]!=-1)
			  {
			  var tmpmoveindex=this.stablemoveindex[dirindex].split(',');
			  var stableindex;
			  //如果为空dom越界，计算此方向边缘的dom的序列
			  if(isemptydom)
			  {
			     //计算出此方向的边缘
				 if(dirindex==2)
				 {
				   var lastcolumindex= (this.numrow-1)*this.numcolum;
				   var tmpcolum=this.curindex%this.numcolum;
				   stableindex=lastcolumindex+tmpcolum;
				 }
				 else if(dirindex==3)
				 {
					 var tmprow=parseInt((this.curindex+1)/this.numcolum);
					 stableindex=(tmprow+1)*this.numcolum-1;
				 }
			  }
			  else
			     stableindex=this.curindex;
			  //计算下个要移动的区和他的固定位置
			  for(k=0;k<tmpmoveindex.length;k++)
			  {
				  var tmp=tmpmoveindex[k].split('-');
				  if(parseInt(tmp[0])==stableindex)
				  {
					  if(tmp[1].indexOf('>')==-1)
				         tmpstable=parseInt(tmp[1]);
					  else
					  {
						  tmpstablearea = tmp[1].split('>')[0];
						  tmpstable = tmp[1].split('>')[1];
					  }
					  break;
				  }
			  }
			  }
			  //如果指定当前方向需要保留下标则记录下来
			  if(this.stayindexdir!=undefined)
			  if(this.stayindexdir.indexOf(''+dirindex)!=-1)
			  {
			    this.stayindexarray[0]=this.curindex;
				this.stayindexarray[1]=dirindex;
			  }
			  else
			  {
				  this.stayindexarray[1]=-1;
			  }
			  if(!!this.areaOutedEvent)
			     this.areaOutedEvent();
	          return new Array((tmpstablearea!=undefined)?tmpstablearea:this.directions[dirindex],tmpstable);
		  }
		  else{
			 if(this.pageturnDir == dirindex){
				 if(dirindex==0)
						this.pageturn(-1); 
					  else if(dirindex==2)
						this.pageturn(1);
			  }
			  return -1;
		  	}
		  }
		  else
		  {
			 if(dirindex==0)
			   this.pageturn(-1); 
			 else if(dirindex==2)
			   this.pageturn(1);
			   return -1;
		  }
	   }
	   else
	   {
		    return this.insidemove(false,dirindex,num);
	   }
   }
   
   //区域内的移动
   //circle:循环方向
   //dirindex:操作方向
   //num：移动偏量
   //cross:是否越界循环
   /**
   * @private
   */
   this.insidemove=function(circle,dirindex,num,cross)
   {
	   //使用同一个dom作为焦点移动
	   if(!this.useoneobj)
		     this.changefocus(this.curindex,false);
		  var nextindex;
		  if(dirindex==0||dirindex==2)
		     nextindex=!circle?(this.curindex+num*this.numcolum):(num>0?(cross?(this.curindex-(this.numrow-1)*this.numcolum):(this.curindex+num*this.numcolum)):(cross?(this.curindex+(this.numrow-1)*this.numcolum):(this.curindex+num*this.numcolum)));
		  else
		     nextindex=!circle?(this.curindex+num):(num>0?(cross?(this.curindex-this.numcolum+1):(this.curindex+num)):(cross?(this.curindex+this.numcolum-1):(this.curindex+num)));
		  this.changefocus(nextindex,true);
		  this.curindex=nextindex;
		  return -1;
   }

   //改变焦点状态
   //index:要改变的下标
   //focusornot:true为聚焦，false为失焦
   /**
   * @private
   */
   this.changefocus=function(index,focusornot,backnochanggedata)
   {
	  
	   if(!!this.changefocusingEvent)
	     if(focusornot)
	      if(this.changefocusingEvent())
		     return;
	   this.curindex=index;
	   this.doms[index].changefocus(focusornot,backnochanggedata);
	   if(!!this.changefocusedEvent)
	       if(focusornot)
		   this.changefocusedEvent();
   }
   //区域获得焦点
   //stableindex:下标
   //dir:进入的方向
   /**
   * @private
   */
   this.areain=function(stableindex,dir)
   {
	   if(!!this.areaIningEvent)
	      if(this.areaIningEvent())
		    return;
		  var tmpindex=0;
	   //如果指定了下标，就聚焦这个下标，否则如果要求记录移动出这区前的下标就用以前的下标，否则用首位
	   if(stableindex!=undefined)
	   {
			if(this.datanum!=undefined&&stableindex>this.datanum-1)
			{
				if(dir==0)
				{
					var ifheng=true;
					for(i=1;i<this.numrow;i++)
			          if(stableindex-this.numcolum*i<=this.datanum-1)
					  {
						  tmpindex=stableindex-this.numcolum*i;
						  ifheng=false;
						  break;
					  }
					if(ifheng)
					{
					   	 for(i=1;i<this.numcolum;i++)
					     if(this.numcolum-i-1<=this.datanum-1)
						 {
							 tmpindex=this.numcolum-i-1;
							 break;
						 }
					}
				}
				else if(dir==1)
				{
				    for(i=1;i<this.numcolum*this.numrow;i++)
					{
					     if(stableindex-i<=this.datanum-1)
						 {
							 tmpindex=stableindex-i;
							 break;
						 }
					}
				}
				else if(dir==2)
				{
					var tmp=stableindex%this.numcolum+1;
					for(i=1;i<tmp;i++)
					     if(tmp-i<=this.datanum-1)
						 {
							 tmpindex=tmp-i;
							 break;
						 }
				}
				else if(dir==3)
				{
				    	for(i=1;i<this.numrow;i++)
			          if(stableindex-this.numcolum*i<=this.datanum-1)
					  {
						  tmpindex=stableindex-this.numcolum*i;
						  break;
					  }
				}
			}
			else
			   tmpindex=stableindex;
	   }
	   var backnochanggedata=false;
	   //如果指定了stayindexdir，则跳出本区到指定方向时，再从这个方向跳回来保持跳出时的下标，优先级高于固定下标stableindex
       //((dir+2)>3?(dir+2)%4:(dir+2))取指定方向dir相反的方向，数字问题
	   if(this.stayindexarray[0]!=-1&&this.stayindexarray[1]==((dir+2)>3?(dir+2)%4:(dir+2)))
	   {
	          tmpindex=this.stayindexarray[0];
			  backnochanggedata=true;
	   }
	    this.changefocus(tmpindex,true,backnochanggedata);
		if(!!this.areaInedEvent)
	      this.areaInedEvent();
   }
   /**
   * @private
   */
   this.ok=function()
   {
	   if(this.areaOkEvent!=undefined)
	      this.areaOkEvent();
	   this.doms[this.curindex].ok();
   }
   /** 
   * @description 设置本区域内，某个方向循环移焦
   * @param {Num} circledir 循环方向，0代表上下，1代表左右
   */
   this.setfocuscircle=function(circledir)
   {
	   this.circledir=circledir;
   }
   /** 
   * @description 设置本区域的内容是否使用同一个焦点对象
   * @param {bool} yesoront true代表使用同一个焦点对象，false相反
   */
   this.setonlyoneobj=function(yesoront)
   {
	   this.useoneobj=yesoront;
   }
   /** 
   * @description 获得本区域id，即为存储到数组时的下标
   * @return 本区域id
   */
   this.getid=function()
   {
	   return this.id;   
   }

   /** 
   * @description 翻页方法
   * @param {Num} num 翻页数量
   */
   this.pageturn=function(num,pagebtn)
   {
	   tmpthis=this;
	   if(this.curpage!=undefined&&this.pagecount!=undefined)
	   {
		   var nextpage=this.curpage+num;
		   //2012.4.12 真实异步
	       if(nextpage>=1&&nextpage<=this.pagecount)
	       {
		       this.curpage=nextpage;
			   this.datanum=0;	   
		       //如果通过移动到边缘翻页
		       if(!pagebtn)
			   {
		        if(this.crossturnpage)
			    {
			    	if(num>0)
			    	{
			    		this.changefocus(this.curindex,false);
						this.tmpfunction=function()
						{
			                tmpthis.changefocus(0,true);	
						}
						var tmpfunc=this.tmpfunction;
						this.asyngetdata(tmpfunc);
						
			    	}
			    	else if(num<0)
			    	{
			    		this.changefocus(this.curindex,false);
						this.tmpfunction=function()
						{
			                tmpthis.changefocus((tmpthis.numrow*tmpthis.numcolum)-1,true);
						}
						var tmpfunc=this.tmpfunction;
						this.asyngetdata(tmpfunc);
						
			    	}
			    }
			   }
				else
				{
					this.tmpfunction=function()
					{
						if(tmpthis.curindex>=tmpthis.datanum)
						   tmpthis.changefocus(tmpthis.datanum-1,true);
						else
						   tmpthis.changefocus(tmpthis.curindex,true);
					}
					//如果在翻到的是最后一页，有可能改变焦点，但是前面又无法判断，所以在最后一页都先把焦点设为false
					if(this.curpage==this.pagecount)
					   this.changefocus(this.curindex,false);
					var tmpfunc=this.tmpfunction;
					this.asyngetdata(tmpfunc);
				}
	       }
	       else if(this.circledir==0)
	       {
		         if(nextpage>this.pagecount)
			    	 nextpage=1;
			     else
			    	 nextpage=this.pagecount;
			     this.curpage=nextpage;
			     this.datanum=0;
		       //如果通过移动到边缘翻页
		       if(!pagebtn)
			   {
		        if(this.crossturnpage)
			    {
			    	if(num>0)
				    {
				    	this.changefocus(this.curindex,false);
						this.tmpfunction=function()
						{
			                tmpthis.changefocus(0,true);	
						}
						var tmpfunc=this.tmpfunction;
						this.asyngetdata(tmpfunc);						
				    }
				    else if(num<0)
				    {
				    	this.changefocus(this.curindex,false);
				    	//第一页翻到最后一页不能聚焦最后一个焦点
				    	   if(nextpage>=1)
						   {
							   this.tmpfunction=function()
								{
									tmpthis.changefocus(tmpthis.datanum-1,true);
								}
								var tmpfunc=this.tmpfunction;
							   this.asyngetdata(tmpfunc);
						   }
				    	       
				    }
		    	}
			   }
				else
				{
					this.tmpfunction=function()
					{
						if(tmpthis.curindex>=tmpthis.datanum)
						   tmpthis.changefocus(tmpthis.datanum-1,true);
						else
						   tmpthis.changefocus(tmpthis.curindex,true);
					}
					if(this.curpage==this.pagecount)
					   this.changefocus(this.curindex,false);
					var tmpfunc=this.tmpfunction;
					this.asyngetdata(tmpfunc);
				}
				
	       }
	       
		   
		   if(this.curpage==1&&!!this.firstpageEvent)
		     this.firstpageEvent();
		   else if(this.curpage==this.pagecount&&!!this.lastpageEvent)
		     this.lastpageEvent();
		   if(!!this.areaPageTurnEvent1)
	          this.areaPageTurnEvent1();
	   }
   }
   /** 
   * @description 设置翻页时会改变的提示按钮
   * @param {String} up 上按钮id字符串
   * @param {String} canup 可以向上翻图片
   * @param {String} cantup 不可以向上翻图片
   * @param {String} down 下按钮id字符串
   * @param {String} candown 可以向下翻图片
   * @param {String} candown 不可以向下翻图片
   */
   this.setpageturnattention=function(up,canup,cantup,down,candown,cantdown)
   {
	   this.upattention=new Array($(up),canup,cantup);
	   this.downattention=new Array($(down),candown,cantdown);
   }
   /** 
   * @description 页面跳转方法
   * @param {Num} num 要跳转的页码
   */
   this.pagego=function(num)
   {
	   if(this.curpage!=undefined&&this.pagecount!=undefined)
	   if(num>=1&&num<=pagecount)
	   {
		   this.curpage=num;
		   this.tmpfunction=function()
		   {
				if(tmpthis.curindex>=tmpthis.datanum)
					tmpthis.changefocus(tmpthis.datanum-1,true);
				else
				    tmpthis.changefocus(tmpthis.curindex,true);
		   }
		   if(this.curpage==this.pagecount)
			   this.changefocus(this.curindex,false);
		   var tmpfunc=this.tmpfunction;
		   this.asyngetdata(tmpfunc);
	   }
   }
   /**
   * @private
   */
   this.numType=function(num)
   {
	   if(!!this.areaNumTypeEvent)
	      this.areaNumTypeEvent(num);
   }
   /**
   * @private
   */
   this.pageTurn=function(num)
   {
	   if(!!this.areaPageTurnEvent)
	      this.areaPageTurnEvent(num);
	    this.pageturn(num,true);
		//2012.4.12修改，要延迟就要延迟所有翻页事件，包括切换焦点，不能光延迟数据，不然会造成取数据的异步，这样就会导致焦点移动的时候不是最新数据
		//clearTimeout(t1);
		//t1=setTimeout("Area.names['"+this.flag+"'].pageturn('"+num+","+true+"')",300);
   }
  
   /** 
   * @description 设置翻页数据，翻页回调方法执行时调用，如果翻页时越界会自动把下标置为0
   * @param {Num} datanum
   */
   this.setpageturndata=function(datanum,pagecount)
   {
	   this.datanum=datanum;
	   this.pagecount=pagecount;
	   if(this.upattention!=undefined&&this.downattention!=undefined)
	   if(this.pagecount==1||this.pagecount==0)
	   {
	      this.upattention[0].src=this.upattention[2];
		  this.downattention[0].src=this.downattention[2];
	   }
	   else
	   {
		  if(this.curpage==1)
		  {
		     this.upattention[0].src=this.upattention[2];//上灰
			 this.downattention[0].src=this.downattention[1];//下白
		  }
		  else if(this.curpage==this.pagecount)
		  {
		     this.downattention[0].src=this.downattention[2];//下灰
			 this.upattention[0].src=this.upattention[1];//上白
		  }
		  else
		  {
			 this.downattention[0].src=this.downattention[1];//下灰
			 this.upattention[0].src=this.upattention[1];//上白
		  }
	   }
   }
   /** 
   * @description 设置向某方向移出本区时，是否保留样式或者更换新样式
   * @param {staystyle} staystyle可为true即保持样式，或者为字符串"className:xxx"，使用新样式
   * @param {dir} dir为方向0，1，2，3
   **/
   this.setstaystyle=function(staystyle,dir)
   {
	   this.outstaystyle=staystyle;
	   this.outstaydir=dir;
	   this.stayindexarray[1]=dir;
	   if(this.stayindexdir!=undefined)
	       this.stayindexdir=this.stayindexdir+dir;
	   else 
	       this.stayindexdir=''+dir;
   }
   /** 
   * @description 设置本区域上下移动到头是否翻页
   **/
   this.setcrossturnpage=function()
   {
	   this.crossturnpage=true;
   }
   
   /** 
   * @description 设置本区指定下标变为指定的暗焦点
   **/
   this.setdarknessfocus = function(index) {
	   this.darkness=true;
       this.curindex = index;
       this.stayindexarray[0] = index;
       
	   if (!this.outstaystyle)
               this.changefocus(this.curindex, true);
       else {
           if (this.outstaystyle.constructor == Array)
               this.doms[index].changestyle(this.outstaystyle);
           else
               this.doms[index].changestyle(new Array(this.outstaystyle));
       }
   }
   this.clearfocus=function()
   {
		this.changefocus(this.curindex,false);
		this.curindex=0;
   }
   this.goback=function()
   {
	   if(!!this.goBackEvent){
	      if(!this.doms[this.curindex].goback())
		   {
			    return this.goBackEvent(); 
		   }
	   }
   }
}

   function AreaCreator(numrow,numcolum,directions,domsidstring,domsfocusstyle,domsunfocusstyle)
   {
	   var doms=new Array();
	   for(i=0;i<numrow*numcolum;i++)
	   {
		 if(!(domsidstring.constructor==Array))
		 {
			 
		   doms[i]=new DomData(domsidstring+i);
		 }
		 else
		 {
		   doms[i]=new DomData();
		   for(j=0;j<domsidstring.length;j++)
		     doms[i].dom[j]=$(domsidstring[j]+i);
		 }
	   }
	   var area=new Area(numrow,numcolum,doms,directions);
	   if(domsfocusstyle!=undefined&&!(domsfocusstyle.constructor==Array))
	      domsfocusstyle=new Array(domsfocusstyle);
	   area.commonfocusstyle=domsfocusstyle;
	   if(domsunfocusstyle!=undefined&&!(domsunfocusstyle.constructor==Array))
	      domsunfocusstyle=new Array(domsunfocusstyle);
	   area.commonunfocusstyle=domsunfocusstyle;
	   return area;
   }
DomData.names=new Array();
var t;
/** 
* @author xx
* @constructor DomData
* @description 所有焦点数据类
* @since version 1.0 
* @class 焦点数据类</br>
因为一个焦点的变换可能会作用于多个文档对象才能实现焦点变换效果，所以焦点对象是以数组的形式存在，并且跟一个聚焦样式数组和一个失焦样式数组匹配，构造方法传递的一个焦点对象id和一对聚焦失焦样式作为各自数组的第一个，这种方法方便快捷用于多数情况
* @param {string} firstdomid 第一个dom对象的id，而且如果不指定放内容的dom，这个默认为放置内容dom
* @param {string} firstfocusstyle 第一个dom对象聚焦的样式
* @param {string} firstunfocusstyle 第一个dom对象失焦的样式
*/  
function DomData(firstdomid,firstfocusstyle,firstunfocusstyle)
{
	// Num 焦点对象id
	this.id=undefined;
	/** 
    * @description Array(document) 焦点改变作用文档对象数组
    * @field
    */
    this.dom=new Array();
	/** 
    * @description Array(string) 聚焦样式数组，跟文档对象数组匹配
    * @field
    */
	this.focusstyle=new Array();
	/** 
    * @description Array(string) 失焦样式数组，跟文档对象数组匹配
    * @field
    */
	this.unfocusstyle=new Array();
	/** 
    * @description (string) 如果给这个参数赋值，那么点击确定事件发生时会根据当前焦点的mylink值跳转页面
    * @field
    */
	this.mylink=undefined;
	/** 
    * @description document 内容dom对象，如果不另外付值，会默认焦点对象为内容对象
    * @field
    */
    this.contentdom=undefined;
	/** 
    * @description document 图片dom对象，如果不另外付值，会默认焦点对象为图片对象
    * @field
    */
	this.imgdom=undefined;
	/**
    * @description any 存储可使用对象，任何类型
    * @field
    */
    this.youwanauseobj=undefined;
	/**
    * @description string or Array 异步获取数据的url或者参数数组，和所属区域dataarea属性联用
    * @field
    */
	this.dataurlorparam=undefined;
	// 本焦点对象所属区域对象
	this.belongarea=undefined;
   /** 
   * @description 聚焦事件
   * @field
   */
	this.focusEvent=undefined;
	/** 
    * @description 失焦事件
	* @field
    */
	this.unfocusEvent=undefined;
	/** 
    * @description 焦点对象确认事件
	* @field
    */
	this.domOkEvent=undefined;
	/** 
    * @description 焦点对象数字按键事件
	* @field
    */
	this.domNumTypeEvent=undefined;
	/**
	* @description 返回键事件
	*/
    this.goBackEvent=undefined;
	//初始化
	this.dom[0]=$(firstdomid);
	if(arguments.length>1)
	{
	this.focusstyle[0]=firstfocusstyle;
	this.unfocusstyle[0]=firstunfocusstyle;
	}
	this.contentdom=$(firstdomid);
	this.imgdom=$(firstdomid);
	
	this.flag=DomData.names.length;
    DomData.names[this.flag]=this;
    
	
	this.dotime=function(){ 
		           this.belongarea.dataarea.asyngetdata();
			   }
	/** 
   * @description 改变对象样式
   * @param {bool} focusornot 聚焦还是失焦
   * @private
   */
	this.changefocus=function(focusornot,backnochanggedata)
	{
		if(focusornot)
	   {
		   //如果本对象聚焦，控制需要的区域异步更新数据
		   if(!!this.belongarea.dataarea&&!backnochanggedata)
		   {
			   if(this.belongarea.delay)
			   {
				  this.belongarea.dataarea.datanum=0; 
				  if(t!=undefined)
			      //clearTimeout(t);
			      //t=setTimeout("DomData.names['"+this.flag+"'].dotime()",300);
				  DomData.names[this.flag].dotime()
			   }
			   else
			     this.dotime();
		   }
		   if(this.cutcontent!=undefined)
	        this.updatecontent("<marquee style='height:34px'>"+this.content+"</marquee>");
		   //聚焦事件
		   if(!!this.focusEvent)
		      this.focusEvent();
	   }
	   else
	   {
		   if(this.cutcontent!=undefined)
		   this.updatecontent(this.cutcontent);

		   //失焦事件
		   if(!!this.unfocusEvent)
		      this.unfocusEvent();
	   }
	   if(focusornot)
	   {
		  if(this.focusstyle.length>0)
	         this.changestyle(this.focusstyle);
		  else if(!!this.belongarea.commonfocusstyle)
		     this.changestyle(this.belongarea.commonfocusstyle);
	   }
	   else
	   {
		   if(this.unfocusstyle.length>0)
	         this.changestyle(this.unfocusstyle);
		   else if(!!this.belongarea.commonunfocusstyle)
		     this.changestyle(this.belongarea.commonunfocusstyle);
	   }
	}
	this.changestyle=function(newstyle)
	{
		
		for(j=0;j<newstyle.length;j++)
	   {
		      tmpstyle=newstyle[j];
		   if(tmpstyle!=undefined)
	      {
		   if(tmpstyle.indexOf(',')==-1)
		   {
			 var tempvisibility;
			 var tempdisplay;
			 if(tmpstyle=='afocus')
		     {
		          this.dom[j].focus();
			      continue;	
	         }
	         else if(tmpstyle=='ablur')
		     {
		          this.dom[j].blur();
			      continue;	
		     }
			 if(this.dom[j].style.visibility=="hidden"){
					tempvisibility = "hidden";
			 }
	         var tmpproerty=tmpstyle.split(':');
	         this.dom[j][tmpproerty[0]]=tmpproerty[1];
			 
			 if(tempvisibility=="hidden"){
					this.dom[j].style.visibility = "hidden";
			 }
		   }
		   else
		   {
			   var tmp=tmpstyle.split(',');
			   for(i=0;i<tmp.length;i++)
			   {
				 var tempvisibility;
				 var tempdisplay;
				 if(tmpstyle=='afocus')
		         {
		             this.dom[j].focus();
			         continue;	
	             }
	             else if(tmpstyle=='ablur')
		         {
		             this.dom[j].blur();
			         continue;	
		         }
				 if(this.dom[j].style.visibility=="hidden"){
						tempvisibility = "hidden";
				 }
				  var tmpproerty=tmp[i].split(':');
	              this.dom[j][tmpproerty[0]]=tmpproerty[1];
				  
				  if(tempvisibility=="hidden"){
					this.dom[j].style.visibility = "hidden";
					}
			   }
		   }
	      }
	   }
	   
	}
	/**
	* @private
	*/
	this.ok=function()
	{
		if(this.domOkEvent!=undefined)
		  this.domOkEvent();
		this.gotolink();
	}
	/** 
    * @description 跳转页面到指定的mylink
    */
	this.gotolink=function()
	{
		if(this.mylink!=undefined)
		  window.location.href=this.mylink;
	}
	/** 
    * @description 更新指定内容dom中内容
	* @param {string} content 内容文字
    */
	this.updatecontent=function(content)
	{
	     this.contentdom.innerHTML=content;
	}
	/** 
    * @description 如果需要切字符串的焦点区域，使用这个方法设置内容
	* @param {string} content 内容文字
	* @param {Num} length 想切取的长度
	* @param {bool} roll 想切取的长度
    */
	this.setcontent=function(prefix,content,length,roll,dot)
	{
		this.content=content;
		var cutstring=getbytelength(content)>length;
		if(cutstring)
		{
			cutstring=prefix+getcutedstring(content,length,dot);
		    this.updatecontent(cutstring);
			if(roll!=false)
			this.cutcontent=cutstring;
		}
		else
		{
			this.content=undefined;
			this.cutcontent=undefined;
		    this.updatecontent(prefix+content);
		}
		//this.updatecontent(content);	
	}
	this.settext=function(num,content,prefix,length)
	{
		var dom=this.dom[num];
		
		if(prefix==undefined&&length==undefined)
		{
			
		    dom.innerHTML=content;
		}
		else
			dom.innerHTML=prefix+getcutedstring(content,length,dot);
	}
	/** 
    * @description 更新指定图片dom的图片
	* @param {string} imgsrc 图片地址
    */
	this.updateimg=function(imgsrc)
	{
		this.imgdom.src=imgsrc;
	}
	/** 
    * @description 获得本焦点对象id，即为存储到数组时的下标
    * @return 本焦点对象id
    */
    this.getid=function()
    {
	    return this.id;   
    }
	/** 
    *@private 
	*/
	this.numType=function(num)
    {
	   if(!!this.domNumTypeEvent)
	      this.domNumTypeEvent(num);
    }
	this.goback=function()
    {
	   if(!!this.goBackEvent)
			 return this.goBackEvent(); 
    }
}
Popup.names=new Array();
var t2;
/** 
* @author xx
* @constructor Popup
* @description 弹出窗口对象，继承于页面对象
* @since version 1.0 
* @class 弹出窗口类</br>
跟页面对象有相同性质
* @param {string} popupdom 弹出框的id字符串
* @param {string} areas 区域对象数组
* @param {string} areaid 点击关闭窗口的按钮所属区域id
* @param {string} index 点击关闭窗口的按钮所属区域的下标
*/  
function Popup(popupdom,areas,areaid,index)
{
	//继承
    PageObj.call(this, 0, 0, areas);
    /** 
    * @description Num  自动关闭弹出窗口时间，秒为单位
    * @field
    */
	this.closetime=undefined;
	/** 
    * @description Num  弹出窗口对象
    * @field
    */
	this.popupdom=$(popupdom);
	//所属页面对象
	this.pageobj=undefined;
	this.popareaid=areaid;
	this.popindex=index;
	/** 
    * @description Num  弹出窗口关闭事件
    * @field
    */
	this.closemedEvent=undefined;
	//静态属性
	this.flag=Popup.names.length;
    Popup.names[this.flag]=this;
	this.popupdom.style.display="none";
	/** 
    * @description 弹出窗口
    */
	this.showme=function()
	{
	    this.popupdom.style.display="block";
		this.pageobj=pageobj;
		pageobj=this;
		if(this.closetime!=undefined)
		{
			if(t2!=undefined)
			clearTimeout(t2);
		   t2=setTimeout("Popup.names['"+this.flag+"'].closeme()",this.closetime*1000);
		}
	}
		/** 
    * @description 关闭窗口
    */
	this.closeme=function()
	{
		
		if(!!this.pageobj)
		pageobj=this.pageobj;
	    this.popupdom.style.display="none";
		if(!!this.closemedEvent)
		    this.closemedEvent();
	}
	/** 
    *@private 
	*/
	this.pageOkEvent=function()
	{
		if(this.popareaid!=undefined&&this.popindex!=undefined)
		if(this.curareaid==this.popareaid&&this.getfocusindex()==this.popindex)
	       this.closeme();
	}
}
/**
* @description 你懂的
*/
function $(id) {
    return document.getElementById(id);
}
function getbytelength(str){
	var byteLen=0,len=str.length;
	if(str){
		for(var i=0;i<len;i++)
		{
		   if(str.charCodeAt(i)>255)
		      byteLen+=2;
		   else
		      byteLen++;
		}
	    return byteLen;
	}
	    return 0;
}
function getcutedstring(sSource,iLen,dot)
{
	/*var endstr="...";
	for(i=0;i<len;i++)
	   if(str.charCodeAt(i)>255)
	     len--;
	str=str.substr(0,len)+endstr;
	return str;*/
    var str = "";
    var l = 0;
    var schar;
	if(!dot)
	  iLen=iLen-2;
    for(var i=0; schar=sSource.charAt(i); i++)
     {
         str += schar;
         l += (schar.match(/[^\x00-\xff]/) != null ? 2 : 1);
        if(l >= iLen)
         {
            break;
         }
     }
	if(dot)
      return str;
	else 
	  return str+"...";
}

// JScript 文件
var	KEY_TV_IPTV=1290;
var	KEY_POWEROFF=1291;
var	KEY_SUBTITLE=1292;
var	KEY_BOOKMARK =1293;
var	KEY_PIP=1294;
var KEY_LOCAL=1295;
var KEY_REFRESH=1296;
var KEY_SETUP=282;
var KEY_HOME=292;
var KEY_BACK = 8;
var KEY_DEL  = 8;
var KEY_ENTER=13;
var KEY_OK =13;
var KEY_HELP = 284;
var KEY_LEFT=37;
var KEY_UP=38;
var KEY_RIGHT=39;
var KEY_DOWN=40;
var KEY_PAGEUP = 33;
var KEY_PAGEDOWN = 34;
var KEY_0 = 48;
var KEY_1 = 49;
var KEY_2 = 50;
var KEY_3 = 51;
var KEY_4 = 52;
var KEY_5 = 53;
var KEY_6 = 54;
var KEY_7 = 55;
var KEY_8 = 56;
var KEY_9 = 57;
var KEY_CHANNELUP = 257;
var KEY_CHANNELDOWN = 258;
var KEY_VOLUP = 259;
var KEY_VOLDOWN =260;
var KEY_MUTE =261;
var KEY_PLAY=263;
var KEY_PAUSE=263;
var KEY_SEEK=271;
var KEY_SWITCH = 280;
var KEY_FAVORITE = 281;
var KEY_AUDIOCHANNEL=286;
var KEY_IME= 283;
var KEY_FASTFORWARD=264;
var KEY_FASTREWIND=265;
var KEY_SEEKEND=266;
var KEY_SEEKBEGIN=267;
var KEY_STOP=270;
var KEY_MENU=290;
//var KEY_RED = 275;
//var KEY_GREEN = 276;
//var KEY_YELLOW = 277;
var KEY_RED = 1108;
var KEY_GREEN = 1110;
var KEY_YELLOW = 1109;
var KEY_BLUE =278 ;
var KEY_STAR=106;
var KEY_SHARP=105;
var KEY_F1 = 291;
var KEY_F2 = 292;
var KEY_F3 = 293;
var KEY_F4 = 294;
var KEY_F5 = 295;
var KEY_F6 = 296;
var KEY_SEARCH = 1105;
var KEY_COLLECT=281;

//事件 规范是0x300
var KEY_EVENT= 768;

document.onirkeypress = keyEvent;
document.onkeypress = keyEvent;
document.onkeydown = keyEvent;
function keyEvent()
{
	var val = event.which ? event.which : event.keyCode;
	//alert(val);
	return keypress(val);
	
}
function keypress(keyval)
{
	switch(keyval)
	{
		case 48:
		case KEY_0:
		    pageobj.numType(0);
            return 0;
		case 49:
		case KEY_1:
		    pageobj.numType(1);
            return 0;
		case 50:	
		case KEY_2:
		    pageobj.numType(2);
            return 0;
		case 51:	
		case KEY_3:
		    pageobj.numType(3);
            return 0;
		case 52:	
		case KEY_4:
		    pageobj.numType(4);
            return 0;
		case 53:	
		case KEY_5:
		    pageobj.numType(5);
            return 0;
		case 54:
		case KEY_6:
		    pageobj.numType(6);
            return 0;
		case 55:
		case KEY_7:
		    pageobj.numType(7);
            return 0;
		case 56:
		case KEY_8:
		    pageobj.numType(8);
            return 0;
		case 57:
		case KEY_9:
		    pageobj.numType(9);
            return 0;
        case 87: //up
        case KEY_UP:			
            pageobj.move(0);
            return 0;
		case 65: //left
        case KEY_LEFT: 
            pageobj.move(1);
            return 0;
        case 83: //down
        case KEY_DOWN:
            pageobj.move(2);
            return 0;
        case 68: //right
        case KEY_RIGHT: //right
            pageobj.move(3);
            return 0;
		 case 13:
        case KEY_OK: //enter
            pageobj.ok();
            return 0;
		case 32:    // 空格
        case KEY_BACK:
		    pageobj.goBack();
            return 0;
		case 188:
		case KEY_PAGEUP:
		    pageobj.pageTurn(-1);
		    return 0;
		case 190:
        case KEY_PAGEDOWN:
		    pageobj.pageTurn(1);
		    return 0;
	    case KEY_COLLECT:
		    if(!redkey&&fourcolorkey[5]!=undefined)
		        window.location.href=fourcolorkey[5];
			return 0;
		case KEY_SEARCH:
		    if(!redkey&&fourcolorkey[4]!=undefined)
		        window.location.href=fourcolorkey[4];
			return 0;
		case KEY_BLUE:
		    if(!bluekey&&fourcolorkey[3]!=undefined)
		    window.location.href=fourcolorkey[3];
			return 0;
		case KEY_YELLOW:
		case 277:
		    if(!yellowkey&&fourcolorkey[2]!=undefined)
		        window.location.href=fourcolorkey[2];
			return 0;
		case KEY_GREEN:
		case 276:
		    if(!greenkey&&fourcolorkey[1]!=undefined)
		        window.location.href=fourcolorkey[1];
			return 0;
		case KEY_RED:
		case 275:
		    if(!redkey&&fourcolorkey[0]!=undefined)
		        window.location.href=fourcolorkey[0];
			return 0;
	    
		case KEY_VOLUP:
			pageobj.volChange(1);
			return false; 
		case KEY_VOLDOWN:
			pageobj.volChange(-1);
			return false;
		case KEY_MUTE:
			pageobj.setMuteFlag();
			return false;
		default:
			return 0;	
    }
    return 0;
}
var readyList=[];
var readyBound = false;
function ready(func)
{
	if ( readyBound ) return;
	readyBound = true;
	if ( document.addEventListener ) {
		// Use the handy event callback
		document.addEventListener( "DOMContentLoaded", function(){
			document.removeEventListener( "DOMContentLoaded", arguments.callee, false );
			for(i=0;i<readyList.length;i++)
			{
				eval(readyList[i]);
			}
		}, false );
	} else if ( document.attachEvent ) {
		// ensure firing before onload,
		// maybe late but safe also for iframes
		document.attachEvent("onreadystatechange", function(){
			if ( document.readyState === "complete" ) {
				document.detachEvent( "onreadystatechange", arguments.callee );
				for(i=0;i<readyList.length;i++)
			    {
				   eval(readyList[i]);
			    }
			}
		});
	}
    	readyList.push( func );
}
   var _in_ajax = window.ActiveXObject ? new ActiveXObject("Microsoft.XMLHTTP") : new XMLHttpRequest();

//传入的successMethed有一个字符串参数，处理成功后将服务器返回的信息做参数传入
function getAJAXData(url, successMethed,param) {
    if (url != undefined && url != null && url != "") {
        var temp = url.split("?"); url = temp[0];
        if (temp.length > 1) { url += "?" + encodeURI(temp[1]); }
    }
    _in_ajax.open("POST", url, false);
    _in_ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
    _in_ajax.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    _in_ajax.send(null);
    //_in_ajax.onreadystatechange=successMethed;
    if (_in_ajax.readyState == 4) { if (_in_ajax.status == 200) { successMethed(_in_ajax.responseText,param); } } 
}
function getAJAXData(url, successMethed,param,obj) {
    if (url != undefined && url != null && url != "") {
        var temp = url.split("?"); url = temp[0];
        if (temp.length > 1) { url += "?" + encodeURI(temp[1]); }
    }
    _in_ajax.open("POST", url, false);
    _in_ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
    _in_ajax.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    _in_ajax.send(null);
    //_in_ajax.onreadystatechange=successMethed;
    if (_in_ajax.readyState == 4) { if (_in_ajax.status == 200) { successMethed(_in_ajax.responseText,param,obj); } } 
}


