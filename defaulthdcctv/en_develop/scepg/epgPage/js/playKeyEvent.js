var linkMap=new Map();  
var currentSelectObjectId="";
var isPlayArea = true;
var isInputArea = false;

var KEY_BACK = 8;
var KEY_OK = 13;
var KEY_LEFT = 37;
var KEY_UP = 38;
var KEY_RIGHT = 39;
var KEY_DOWN = 40;
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
var KEY_VOLDOWN = 260;
var KEY_MUTE = 261;
var KEY_PLAY = 263;
var KEY_FASTFORWARD = 264;
var KEY_FASTREWIND = 265;
var KEY_STOP = 270;
var KEY_SEEK = 271;
var KEY_AUDIO_TRACK = 262;
var KEY_EVENT = 768;


function CommonProcess() {
	this.default_EVENT = function() {};
	this.KEY_NUMBER_EVENT = function(num) {};
	this.KEY_UP_EVENT = function() {
		this.moveFocus(0)
	};
	this.KEY_DOWN_EVENT = function() {
		this.moveFocus(2)
	};
	this.KEY_LEFT_EVENT = function() {
		this.moveFocus(3)
	};
	this.KEY_RIGHT_EVENT = function() {
		this.moveFocus(1)
	};
	this.KEY_OK_EVENT = function() {
		this.doSelect()
	};
	this.KEY_BACK_EVENT = function() {
	};
	this.KEY_PAGEUP_EVENT = function() {
		if(isUserTrickMode){
     //MediaPlayerEx.gotoStartEvent();
		}
	};
	this.KEY_PAGEDOWN_EVENT = function() {
		if(isUserTrickMode){
     // MediaPlayerEx.gotoEndEvent();
		}
	};

	this.KEY_FASTFORWARD_EVENT = function() {
		isUserTrickMode=true;
		if(isUserTrickMode)          
      MediaPlayerEx.fastForwardEvent();
	};
	this.KEY_FASTREWIND_EVENT = function() {
		isUserTrickMode=true;
		if(isUserTrickMode)          
       MediaPlayerEx.fastRewindEvent();
	};
	this.KEY_MUTE_EVENT = function() {
		isUserTrickMode=true;
		if(isUserTrickMode) 
     MediaPlayerEx.setMuteFlagEvent();
	};
	this.KEY_SEEK_EVENT = function() {
		if(isUserTrickMode) 
     MediaPlayerEx.seekEvent();
	};
	this.KEY_CHANNELUP_EVENT = function() {
		if(isUserTrickMode)
     MediaPlayerEx.dropEvent();
	};
	this.KEY_CHANNELDOWN_EVENT = function() {};
	this.KEY_PLAY_EVENT = function() {
		isUserTrickMode=true;
		if(isUserTrickMode)
      MediaPlayerEx.playOrPauseEvent();
	};
	this.KEY_STOP_EVENT = function() {
		isUserTrickMode=true;
	   if(isUserTrickMode)
      MediaPlayerEx.dropEvent();
	};
	this.KEY_VOLUP_EVENT = function() {
		isUserTrickMode=true;
		 if(isUserTrickMode)       
      MediaPlayerEx.volumeUpEvent();
	};
	this.KEY_VOLDOWN_EVENT = function() {
		isUserTrickMode=true;
		if(isUserTrickMode)        
       MediaPlayerEx.volumeDownEvent();
	};
	this.KEY_AUDIO_TRACK_EVENT = function() {
		if(isUserTrickMode)        
      MediaPlayerEx.audioChannelEvent();
	};
	
	this.MEDIA_ERROR_EVENT = function(eventJson) {
	    var error_code = eventJson.error_code;
      var error_message = eventJson.error_message;
      if (parseInt(error_code,10) == 1) {
          MediaPlayerPanel.showMediaError(); //显示错误
      }
	};
	this.PLAYMODE_CHANGE_EVENT = function(eventJson) {
		  MediaPlayerEx.changeEvent(eventJson);
	};
	this.MEDIA_END_EVENT = function(eventJson) {
		 MediaPlayerEx.endEvent(eventJson);
	};
	this.MEDIA_BEGINING_EVENT = function(eventJson) {
		MediaPlayerEx.begingEvent(eventJson);
	};
	this.GO_CHANNEL_EVENT = function(eventJson) {
		 MediaPlayerEx.channelEvent(eventJson);
	};
	this.REMINDER_EVENT = function(eventJson) {
		 //var message = eventJson.message;
	};
	this.TVMS_MESSAGE_EVENT = function(eventJson) {
		//var Msg_content = eventJson.Msg_content;
	};
	
	this.clearFocus_EVENT = function() {};
	this.showFocus_EVENT = function() {};
	this.moveFocus = function(direction) {
		var objs = linkMap.get(currentSelectObjectId);
		if (objs != undefined && objs[direction] != undefined && objs[direction] != "") {
			var strs = objs[direction].split(",");
			for (var i = 0; i < strs.length; i++) {
				if (document.getElementById(strs[i]) != null) {
					this.clearFocus_EVENT();
					currentSelectObjectId = strs[i];
					this.showFocus_EVENT();
					break
				}
			}
		}
	};
	this.doSelect = function() {
		var obj = document.getElementById(currentSelectObjectId);
		var strs = obj.title;
		if (strs == undefined || strs == null || strs == "") {
			return
		}
		eval("var _addressObj = " + strs);
		if (_addressObj != undefined && _addressObj != null && _addressObj.length > 0) {
			var jsname = _addressObj[0].js;
			var str = _addressObj[0].url;
			if (_addressObj.length == 2) {
				if (_addressObj[0].js != undefined && _addressObj[0].js != null) {
					jsname = _addressObj[0].js;
					str = _addressObj[1].url
				} else {
					jsname = _addressObj[1].js;
					str = _addressObj[0].url
				}
			}
			var jsresult = true;
			if (jsname != undefined && jsname != null && jsname != "") {
				try {
					jsresult = eval(jsname)
				} catch(e) {
					jsresult = false
				}
			}
			if (str != undefined && str != null && str != "") {
				var temp = str.split("?");
				str = temp[0];
				if (temp.length > 1) {
					str += "?" + encodeURI(temp[1])
				}
				if (jsresult == true) {
					window.location.href = str
				}
			}
			return jsresult
		}
	}
}
function getConfig(A) {
	var B = Authentication.CUGetConfig(A);
	return B
}


function CommonEvent() {
	var process;
	this.setProcess = function(obj) {
		process = obj
	};
	this.getProcess = function() {
		return process
	};
	this.processEvent = function() {
		if (event == null) {
			return
		}
		var key_code = event.which ? event.which: event.keyCode;
		switch (key_code) {
		case KEY_0:
		case KEY_1:
		case KEY_2:
		case KEY_3:
		case KEY_4:
		case KEY_5:
		case KEY_6:
		case KEY_7:
		case KEY_8:
		case KEY_9:
			process.KEY_NUMBER_EVENT(key_code - 48);
			break; 	
		case KEY_UP:
			if(isPlayArea)
			   process.KEY_VOLUP_EVENT();
			else
			   process.KEY_UP_EVENT();
			break;
		case KEY_DOWN:
			if(isPlayArea)
				process.KEY_VOLDOWN_EVENT();
			else
			    process.KEY_DOWN_EVENT();
			break;
		case KEY_LEFT:
			if(isPlayArea)
			 process.KEY_FASTREWIND_EVENT();
			else
			 process.KEY_LEFT_EVENT();	
			break;
		case KEY_RIGHT:
			if(isPlayArea)
			{
			  process.KEY_FASTFORWARD_EVENT();
			}
			else
			  process.KEY_RIGHT_EVENT();	
			break;
		case 13:
		case KEY_OK:
			/*if(isPlayArea)
				 process.KEY_PLAY_EVENT();
			else*/
			     process.KEY_OK_EVENT();
			break;
		case 32:
		case KEY_BACK:
			if(isPlayArea)
				MediaPlayerEx.backEvent();
			else
			    process.KEY_BACK_EVENT();
			break;
		case KEY_PAGEUP:
			process.KEY_PAGEUP_EVENT();
			break;
		case KEY_PAGEDOWN:
			process.KEY_PAGEDOWN_EVENT();
			break;
		
		case KEY_PLAY:
			process.KEY_PLAY_EVENT();
			break;
		case KEY_STOP:
			process.KEY_STOP_EVENT();
			break;
		case KEY_VOLUP:
			process.KEY_VOLUP_EVENT();
			break;
		case KEY_VOLDOWN:
			process.KEY_VOLDOWN_EVENT();
			break;
		case KEY_FASTFORWARD:
			process.KEY_FASTFORWARD_EVENT();
			break;
		case KEY_FASTREWIND:
			process.KEY_FASTREWIND_EVENT();
			break;
		case KEY_EVENT:
      eval("eventJson = " + Utility.getEvent());
      var typeStr = eventJson.type;
			switch (typeStr) {
			case "EVENT_MEDIA_ERROR":
				process.MEDIA_ERROR_EVENT(eventJson);
				break;
			case "EVENT_PLAYMODE_CHANGE":
				process.PLAYMODE_CHANGE_EVENT(eventJson);
				break;
			case "EVENT_MEDIA_END":
				process.MEDIA_END_EVENT(eventJson);
				break;
			case "EVENT_MEDIA_BEGINING":
				process.MEDIA_BEGINING_EVENT(eventJson);
				break;
			case "EVENT_GO_CHANNEL":
				process.GO_CHANNEL_EVENT(eventJson);
				break;
			case "EVENT_REMINDER":
				process.REMINDER_EVENT(eventJson);
				break;
			case "EVENT_TVMS_MESSAGE":
				process.TVMS_MESSAGE_EVENT(eventJson);
				break
			}
			break;
		case KEY_MUTE:
			process.KEY_MUTE_EVENT();
			break;
		case KEY_SEEK:
			process.KEY_SEEK_EVENT();
			break;
		case KEY_CHANNELUP:
			process.KEY_CHANNELUP_EVENT();
			break;
		case KEY_CHANNELDOWN:
			process.KEY_CHANNELDOWN_EVENT();
			break;
		case KEY_AUDIO_TRACK:
			process.KEY_AUDIO_TRACK_EVENT();
			
		default:
			process.default_EVENT()
		}
	}
}


function BaseProcess() {}
BaseProcess.prototype = new CommonProcess();
var _proc_0 = new BaseProcess();
function _eventProc() {
	var A = new CommonEvent();
	A.setProcess(_proc_0);
	A.processEvent();
	//return false; //适应联通中间件，阻止盒端自动执行
}
function keyBinds() {
	if (navigator.appName.indexOf("Panel") > 1) {
		document.onkeypress = _eventProc
	} else {
		document.onkeydown = _eventProc
	}
};
