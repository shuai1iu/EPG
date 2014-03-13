function $(element)
{
	element = document.getElementById(element);
	return element;
}

function Util()
{

	//一般用于时间为个位数时补零
	this.addZero = function (str, num)
	{
		str = str.toString();
		for(var i = str.length; i < num; i++)
		{
			str = '0'+str;
		}
		return str;
	}

	//计算两段时间间隔的秒数，一般用在节目单长度定位
	this.getDurationS = function (t1, t2)
	{
		t1 = t1.split(":");
		t2 = t2.split(":");
		var duration = 0;
		duration = Math.floor(t2[0] - t1[0])*3600 + Math.floor(t2[1] - t1[1])*60 + Math.floor(t2[2] - t1[2]);
		if(duration < 0) duration = duration + 24*60*60;
		return duration;
	}

	//获取相应参数
	this.getURLParameter = function (param, url)
	{
		var params = (url.substr(url.indexOf("?") + 1)).split("&");
		if (params != null)
		{
			for(var i=0; i<params.length; i++)
			{
				var strs = params[i].split("=");
				if(strs[0] == param)
				{
					return strs[1];
				}
			} 
		}
		return "";
	}

	//获取链接地址的参数字符串
	this.getQueryString = function (url)
	{
		if(url.indexOf("?") == -1)
		{
			return "";
		}
		return url.substr(url.indexOf("?") + 1);
	}

	//截取字符串
	this.subLength = function (str, num)
	{
		str.toString();
		if(str.length > num)
		{
			return str.substring(0,num) + "...";
		}else
		{
			return str;
		}
	}
	this.strArr ={"Q":16, "W":19, "E":13, "R":14, "T":12, "Y":13, "U":14, "I":7, "O":16, "P":13, 

			"A":13, "S":13, "D":14, "F":12, "G":16, "H":14, "J":11, "K":13, "L":11, 

			"Z":12, "X":13, "C":14, "V":13, "B":13, "N":14, "M":18,

			

			"q":11, "w":14, "e":11, "r":8, "t":7, "y":11, "u":11, "i":5, "o":11, "p":11,

			"a":11, "s":11, "d":11, "f":7,"g":11, "h":11, "j":5, "k":11, "l":5, 

			"z":11, "x":11, "c":11, "v":11, "b":11, "n":11, "m":17, 

			

			"`":8, "1":11, "2":11, "3":11, "4":11, "5":11, "6":11, "7":11, "8":11, "9":11, "0":11, "-":8, "=":12, "~":12,

			"!":7, "@":20, "#":12, "$":11, "%":18, "^":10, "&":13, "*":10, "(":8, ")":8, "_":11, "+":12,

			"[":7, "]":7, ";":7, "'":5, ".":7, "/":8, "\\":8, "{":8, "}":8, ":":5, "\"":8, "<":12, ">":12,

			"?":11, "|":6," ":5};

	this.getStringLen = function(sourceStr, len)

	{

		var strWidth = 0;

		var retObj = {"isSub":false, "index":0};

		for(var i=0; i<sourceStr.length; i++)

		{

			var tempChar = sourceStr.charAt(i);

			var size = this.strArr[tempChar];

			strWidth = strWidth + (typeof(size)=="undefined"?20:size)*1;

			

			if (strWidth > len)

			{

				retObj.isSub = true;

				retObj.index = i;

				retObj.width = strWidth;

				return retObj;

			}

		}

		return retObj;

	}
	this.getStringLength = function(sourceStr)
	{
		var strWidth = 0;
		for(var i=0; i<sourceStr.length; i++)
		{

			var tempChar = sourceStr.charAt(i);

			var size = this.strArr[tempChar];

			strWidth = strWidth + (typeof(size)=="undefined"?20:size)*1;

		}
		return strWidth;
	}

	this.subStringFunction = function(sourceStr, row, len)

	{

		if(typeof(sourceStr) == "" || len<20)

		{

				return sourceStr;

		}

		var retStr = "";

		row = row<=0? 1: row;

		for(var i=0; i<row; i++)

		{

			var strObj = this.getStringLen(sourceStr, len);

			if(strObj.isSub)

			{

				if(i == row - 1)

				{

					retStr += sourceStr.substring(0, strObj.index - 1)+"...";

					break;

				}

				retStr += sourceStr.substring(0, strObj.index) + "</br>";

				sourceStr = sourceStr.substring(strObj.index, sourceStr.length);

			}

			else

			{

				retStr += sourceStr.substring(0, sourceStr.length);

				break;

			}

		}

		return retStr;

	}
	this.parseSTBTime = function(dateobj)
	{
		dateobj.setHours(dateobj.getHours()-8); //机顶盒给的是utc时间,则需要手动的加上8小时
		//var year =  dateobj.getYear(); 
		var year =  dateobj.getFullYear();  
		var month = dateobj.getMonth() + 1;
		var day = dateobj.getDate(); 
		hour = dateobj.getHours();
		var min = dateobj.getMinutes();
		var sec = dateobj.getSeconds();
		
		if (month < 10) month = "0" + month;
		if (day < 10) day = "0" + day;
		if (hour < 10) hour = "0" + hour;
		if (min < 10) min = "0" + min;
		if (sec < 10) sec = "0"+sec;
	
		var timeStamp = "" +  year + month + day + "T" + hour + min + sec + "Z";
		return timeStamp;
	}
	this.parseUtcTime = function(utcTime)
	{
		var year = parseInt(utcTime.substr(0, 4));
		var month = parseInt(utcTime.substr(4, 2));
		var day = parseInt(utcTime.substr(6, 2));
		var hour = parseInt(utcTime.substr(9, 2));
		var min = parseInt(utcTime.substr(11, 2));
		var sec = parseInt(utcTime.substr(13, 2)); 
	
		// 处理parseInt("0X")等于零的问题
		if (month == 0) month = parseInt(utcTime.substr(5,1));
		if (day == 0) day = parseInt(utcTime.substr(7,1));
		if (hour == 0) hour = parseInt(utcTime.substr(10,1));
		if (min == 0) min = parseInt(utcTime.substr(12,1));
		if (sec == 0) sec = parseInt(utcTime.substr(14,1));
		//by zh		
		var d =  new Date(year, month -1, day, hour + 8, min, sec); //由于是UTC时间所以统一加8,hour + 8
		//var d =  new Date(year, month -1, day, hour, min, sec);
		return d;   	 	
	}
	//把时间转化成字符串类型
	this.converDateToString = function(currPlayTime)
	{
		var sec = currPlayTime.getSeconds();
	//	if (sec >= 30) beginTime.setMinutes(min + 1);
		var hour = currPlayTime.getHours(); 
		var min = currPlayTime.getMinutes(); 	
		if (hour < 10) hour = "0" + hour;
		if (min < 10) min = "0" + min;
		if (sec < 10) sec = "0" + sec;
		return hour + ":" + min+":"+sec;    	
	}
	this.numToTime = function(num)
	{
		var hour = Util.addZero(parseInt(num/3600),2);
		var minute = Util.addZero(parseInt(num%3600/60),2);
		var second = Util.addZero(parseInt(num%3600%60),2);
		return hour + ":" + minute+":"+second;
	}
	
}

//封装一个时间工厂, 获得当前的小时 分钟 年月日
var timeFactory = (function(){
	var date = new Date();
	
	return {
		getHourAndMinute: function()
		{
			var d = new Date();
			var minute = d.getMinutes();
			var hour = d.getHours();
			var second = d.getSeconds();
			
			return Util.addZero(hour, 2) + ":" + Util.addZero(minute, 2);
		},
		
		getMonthAndDay: function()
		{
			var year = date.getYear();
			var month = date.getMonth() + 1;
			var dayOfMonth = date.getDate();			
			return year + "/" +Util.addZero(month, 2) + "/" + Util.addZero(dayOfMonth, 2);
		},
		
		getDayOfWeek: function()
		{
			var weekDays = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]; 	
			return weekDays[date.getDay()]
		},
		getFullMinutes: function()
		{
			var minute = date.getMinutes();
			var hour = date.getHours();
			return minute + hour*60;
		}
	}
})();
var Util = new Util();
