var xml = ''; //深圳标清央视
xml += "<?xml version='1.0'?>";
xml += '<global_keytable>';

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
