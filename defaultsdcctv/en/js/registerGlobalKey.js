var xml = ''; //深圳标清央视
xml += "<?xml version='1.0'?>";
xml += '<global_keytable>';
xml += '<response_define>';
xml += '<key_name>KEY_POWER</key_name>';
xml += '<response_type>0</response_type>'; //0:stb  1:EPG 2:功能键
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_VOL_UP</key_name>';
xml += '<response_type>0</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_VOL_DOWN</key_name>';
xml += '<response_type>0</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_MUTE</key_name>';
xml += '<response_type>0</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_AUDIO</key_name>';
xml += '<response_type>0</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_BACK</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_UP</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_DOWN</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_LEFT</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_RIGHT</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_0</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_1</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_2</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_3</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_4</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_5</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_6</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_7</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_8</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_9</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_CHANNEL_UP</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_CHANNEL_DOWN</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_SWITCH</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_PAUSE_PLAY</key_name>';
xml += '<response_type>0</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_FAST_FORWARD</key_name>';
xml += '<response_type>0</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_FAST_BACK</key_name>';
xml += '<response_type>0</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_GO_END</key_name>';
xml += '<response_type>0</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_GO_BEGINNING</key_name>';
xml += '<response_type>0</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_MEDIA_STOP</key_name>'; //0:STB 1:EPG 2:有
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_PAGE_UP</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_PAGE_DOWN</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_OK</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>KEY_INTERX</key_name>';//互动键
xml += '<response_type>2</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>EVENT_MEDIA_END</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>EVENT_MEDIA_BEGINING</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>EVENT_MEDIA_ERROR</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_name>EVENT_PLAYMODE_CHANGE</key_name>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_code>KEY_PORTAL</key_code>';//首页地址
xml += '<response_type>2</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_code>KEY_VOD_MENU</key_code>';	//点播地址
xml += '<response_type>2</response_type>';
xml += '<service_url>/EPG/jsp/defaultsdcctv/en/page/vod.jsp</service_url>';
xml += '</response_define>';
xml += '<response_define>';			
xml += '<key_code>KEY_TV_MENU</key_code>';//直播频道地址
xml += '<response_type>2</response_type>';
xml += '<service_url>/EPG/jsp/defaultsdcctv/en/page/live.jsp</service_url>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_code>KEY_TVOD_MENU</key_code>';     // 20130905 hxt �ط�Ƶ����ַ
xml += '<response_type>2</response_type>';
xml += '<service_url>/EPG/jsp/defaultsdcctv/en/page/playback.jsp</service_url>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_code>KEY_RED</key_code>';     //红色键定义：直播
xml += '<response_type>2</response_type>';
xml += '<service_url>/EPG/jsp/defaultsdcctv/en_develop/page/index.jsp</service_url>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_code>KEY_GREEN</key_code>';	//绿色键定义：回看
xml += '<response_type>2</response_type>';
xml += '<service_url>/EPG/jsp/defaultsdcctv/en/page/playback.jsp</service_url>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_code>KEY_YELLOW</key_code>';	//黄色键定义：点播
xml += '<response_type>2</response_type>';
xml += '<service_url>/EPG/jsp/defaultsdcctv/en/page/vod.jsp</service_url>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_code>KEY_BLUE</key_code>';		//蓝色键定义：活动
xml += '<response_type>2</response_type>';
xml += '<service_url>/EPG/jsp/defaultsdcctv/en/page/sztvpgq/page/activityindex.jsp</service_url>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_code>KEY_HELP</key_code>';		//帮助键定义
xml += '<response_type>2</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_code>KEY_FAVORITE</key_code>';	//收藏键定义
xml += '<response_type>2</response_type>';
xml += '<service_url>/EPG/jsp/defaultsdcctv/en/page/space_collect.jsp</service_url>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_code>KEY_NVOD</key_code>';	//轮播定义
xml += '<response_type>2</response_type>';
xml += '<service_url></service_url>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_code>KEY_SEARCH</key_code>';	//搜索定义
xml += '<response_type>2</response_type>';
xml += '<service_url>/EPG/jsp/defaultsdcctv/en/page/search.jsp</service_url>';
xml += '</response_define>';
xml += '<response_define>';  //定位�hwwebkit
xml += '<key_name>KEY_SEEK</key_name>';
xml += '<response_type>0</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_code>EVENT_GO_CHANNEL</key_code>';
xml += '<event_type>EVENT_GO_CHANNEL</event_type>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_code>EVENT_REMINDER</key_code>';
xml += '<event_type>EVENT_REMINDER</event_type>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '<response_define>';
xml += '<key_code>KEY_IPTV_EVENT</key_code>';
xml += '<event_type>EVENT_MEDIA_END</event_type>';
xml += '<response_type>1</response_type>';
xml += '</response_define>';
xml += '</global_keytable>';

Authentication.CTCSetConfig("GlobalKeyTable",xml);
