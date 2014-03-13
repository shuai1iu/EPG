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
function PageObj(curareaid,index,areas)
{
   /** 
   * @description Num 当前区域id（区域数组的存储顺序下标即为当前页面的id）
   * @field
   */
   this.curareaid=curareaid;
   /** 
   * @description Array(class:Area) 所有区域对象 
   * @field
   */
   this.areas=areas;
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
   * @description 页面数字按键事件
   * @Param num 按键的数字
   * @field
   */
   this.pageNumTypeEvent=undefined;
   //循环赋值每个区域的ID，和把页面对象付给每个区域
   for(i=0;i<this.areas.length;i++)
   {
       this.areas[i].id=i;
	   this.areas[i].pageobj=this;
    }
   //聚焦当前区域的首位
   if(areas!=undefined)
      areas[curareaid].changefocus(index,true);
   
   /** 
   * @description 页面移动按键执行方法 
   * @param {Num} dir 方向 0,1,2,3 上左下右
   */ 
   this.move=function(dir)
   {
	   var nextareadata=this.areas[this.curareaid].move(dir==0||dir==1?-1:1,dir);
	   if(nextareadata!=-1)
       {
	       this.curareaid=nextareadata[0];
	       this.areas[nextareadata[0]].areain(nextareadata[1],dir);
       }
   }
   /** 
   * @description 页面回车按键执行方法，会自动调用当前区域确定方法
   */ 
   this.ok=function()
   {
	   if(!!this.pageOkEvent)
	    this.pageOkEvent();
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
	   this.areas[this.curareaid].numType(num);
   }
    /** 
   * @description 获得当前区域聚焦的下标
   * @return {Num}  当前区域聚焦的下标
   */ 
   this.getfocusindex=function()
   {
	   return this.areas[this.curareaid].curindex;
   }
    /** 
   * @description 获得当前区域聚焦的焦点对象
   * @return {DomData}  当前区域聚焦的焦点对象
   */ 
   this.getfocusdom=function()
   {
	   return this.areas[this.curareaid].doms[this.areas[this.curareaid].curindex];
   }
}
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
   * @description bool 移出本区域时，样式是否改为失焦，或者保持聚焦样式 
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
   this.asyngetdata=undefined;
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
   for(i=0;i<this.doms.length;i++)
   {
	   this.doms[i].id=i;
	   this.doms[i].belongarea=this;   
   }
   //区域移动方法
   //num:移动偏量+-1
   //dirindex:移动的方向，0，1，2，3
   /**
   * @private
   */
   this.move=function(num,dirindex)
   {
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
			  if(!!this.datanum)
			  {
		        var tmpnextindex=this.curindex+num*this.numcolum;
		        if(tmpnextindex>this.datanum-1)
				{
		          cross=true;
				  isemptydom=true;
				}
			  }
		   }
		   //如果循环方向为上下方向
		   if(this.circledir==0)
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
				  if(!!this.datanum)
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
		   if(this.circledir==1)
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
			  if(!!this.areaOutingEvent)
			     this.areaOutingEvent();
			  //如果要移动的下个区域被锁定，不移动
			  if(this.pageobj.areas[this.directions[dirindex]].lockin||(!!this.pageobj.areas[this.directions[dirindex]].datanum&&this.pageobj.areas[this.directions[dirindex]].datanum<=0))
			     return -1;
			  //移出本区域是否需要保持当前焦点样式
			  if(!!this.outstaydir&&this.outstaydir==dirindex)
			  {
			  if(typeof(this.outstaystyle)!="boolean")
			  {
				 if(this.outstaystyle instanceof Array)
			        this.doms[this.curindex].changestyle(this.outstaystyle);
				 else
				    this.doms[this.curindex].changestyle(new Array(this.outstaystyle));
			  }
			  else if(!this.outstaystyle)
			    this.changefocus(this.curindex,false);	
			  }
			  else
			    this.changefocus(this.curindex,false);
			     
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
			  if(!!this.stayindexdir)
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
	          return new Array((!!tmpstablearea)?tmpstablearea:this.directions[dirindex],tmpstable);
		  }
		  else
		      return -1;
		  }
		  else
		  {
			 if(dirindex==0)
			   this.pageturn(-1);  
			 else if(dirindex==2)
			   this.pageturn(1);
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
   this.changefocus=function(index,focusornot)
   {
	   this.curindex=index;
	   this.doms[index].changefocus(focusornot);
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
	      this.areaIningEvent();
		  var tmpindex=0;
	   //如果指定了下标，就聚焦这个下标，否则如果要求记录移动出这区前的下标就用以前的下标，否则用首位
	   if(!!stableindex)
	   {
			if(!!this.datanum&&stableindex>this.datanum-1)
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
	   //如果指定了stayindexdir，则跳出本区到指定方向时，再从这个方向跳回来保持跳出时的下标，优先级高于固定下标stableindex
       //((dir+2)>3?(dir+2)%4:(dir+2))取指定方向dir相反的方向，数字问题
	   if(this.stayindexarray[1]!=-1&&this.stayindexarray[1]==((dir+2)>3?(dir+2)%4:(dir+2)))
	          tmpindex=this.stayindexarray[0];
	    this.changefocus(tmpindex,true);
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
   this.pageturn=function(num)
   {
	   if(!!this.curpage&&!!this.pagecount)
	   {
	   var nextpage=this.curpage+num;
	   if(nextpage>=1&&nextpage<=this.pagecount)
	   {
		   this.curpage=nextpage;
		   this.asyngetdata();
	   }
	   }
   }
   /** 
   * @description 页面跳转方法
   * @param {Num} num 要跳转的页码
   */
   this.pagego=function(num)
   {
	   if(!!this.curpage&&!!this.pagecount)
	   if(num>=1&&num<=pagecount)
	   {
		   curpage=num;
		   this.asyngetdata();
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
   * @description 如果当前下标大于数据量，则置回0
   */
   this.checkfocusover=function()
   {
	   if(!!this.pageobj&&this.curindex==this.pageobj.getfocusindex())
	   {
	     if(this.curindex>=this.datanum)
		 {
			 this.changefocus(this.curindex,false);
			 this.changefocus(0,true);
		 }
	   }
	   else
	   {
		 if(this.curindex>=this.datanum)
		 {
			 this.curindex=0;
		 }   
	   }
   }
   /** 
   * @description 设置翻页数据，翻页回调方法执行时调用，如果翻页时越界会自动把下标置为0
   * @param {Num} datanum
   */
   this.setpageturndata=function(datanum,pagecount)
   {
	   this.datanum=datanum;
	   this.pagecount=pagecount;
	   this.checkfocusover();
   }
   this.setstaystyle=function(staystyle,dir)
   {
	   this.outstaystyle=staystyle;
	   this.outstaydir=dir;
	   if(!!this.stayindexdir)
	       this.stayindexdir=this.stayindexdir+dir;
	   else 
	       this.stayindexdir=''+dir;
   }
   this.setcrossturnpage=function()
   {
	   this.crossturnpage=true;
   }
   
}

   function AreaCreator(numrow,numcolum,directions,domsidstring,domsfocusstyle,domsunfocusstyle)
   {
	   var doms=new Array();
	   for(i=0;i<numrow*numcolum;i++)
		 doms[i]=new DomData(domsidstring+i);
	   var area=new Area(numrow,numcolum,doms,directions);
	   if(!(domsfocusstyle instanceof Array))
	      domsfocusstyle=new Array(domsfocusstyle);
	   area.commonfocusstyle=domsfocusstyle;
	   if(!(domsunfocusstyle instanceof Array))
	      domsunfocusstyle=new Array(domsunfocusstyle);
	   area.commonunfocusstyle=domsunfocusstyle;
	   return area;
   }
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
	//初始化
	
	
	this.dom[0]=$(firstdomid);
	if(arguments.length>1)
	{
	this.focusstyle[0]=firstfocusstyle;
	this.unfocusstyle[0]=firstunfocusstyle;
	}
	this.contentdom=$(firstdomid);
	this.imgdom=$(firstdomid);
	/** 
   * @description 改变对象样式
   * @param {bool} focusornot 聚焦还是失焦
   * @private
   */
	this.changefocus=function(focusornot)
	{
		
		if(focusornot)
	   {
		   //如果本对象聚焦，控制需要的区域异步更新数据
		   if((!!this.dataurlorparam)&&(!!this.belongarea.dataarea))
		   {
		      this.belongarea.dataarea.asyngetdata(this.dataurlorparam);
		   }
		   if(!!this.cutcontent)
	        this.updatecontent("<marquee style='height:34px'>"+this.content+"</marquee>");
		   //聚焦事件
		   if(!!this.focusEvent)
		      this.focusEvent();
	   }
	   else
	   {
		   if(!!this.cutcontent)
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
		   if(!!this.unfocusstyle.length>0)
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
	         var tmpproerty=tmpstyle.split(':');
	         this.dom[j][tmpproerty[0]]=tmpproerty[1];
		   }
		   else
		   {
			   var tmp=tmpstyle.split(',');
			   for(i=0;i<tmp.length;i++)
			   {
				  var tmpproerty=tmp[i].split(':');
	              this.dom[j][tmpproerty[0]]=tmpproerty[1];  
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
    */
	this.setcontent=function(prefix,content,length)
	{
		this.content=content;
		var cutstring=getbytelength(content)>length;
		if(cutstring)
		{
			this.cutcontent=prefix+getcutedstring(content,length);
		    this.updatecontent(this.cutcontent);
		}
		else
		    this.updatecontent(prefix+content);
		//this.updatecontent(content);
			
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
function getcutedstring(sSource,iLen)
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
    for(var i=0; schar=sSource.charAt(i); i++)
     {
         str += schar;
         l += (schar.match(/[^\x00-\xff]/) != null ? 2 : 1);
        if(l >= iLen)
         {
            break;
         }
     }
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
var KEY_RED = 275;
var KEY_GREEN = 276;
var KEY_YELLOW = 277;
var KEY_BLUE =278 ;
var KEY_STAR=106;
var KEY_SHARP=105;
var KEY_F1 = 291;
var KEY_F2 = 292;
var KEY_F3 = 293;
var KEY_F4 = 294;
var KEY_F5 = 295;
var KEY_F6 = 296;

//事件 规范是0x300
var KEY_EVENT= 768;