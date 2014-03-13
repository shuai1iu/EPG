<%!
//key_number
final static short KEY_0 = 48;//0x0030;
final static short KEY_1 = 49;//0x0031;
final static short KEY_2 = 50;//0x0032;
final static short KEY_3 = 51;//0x0033;

final static short KEY_4 = 52;//0x0034;
final static short KEY_5 = 53;//0x0035;
final static short KEY_6 = 54;//0x0036;
final static short KEY_7 = 55;//0x0037;
final static short KEY_8 = 56;//0x0038;
final static short KEY_9 = 57;//0x0039;

// key_direction
final static short KEY_UP = 38;//0x0026;
final static short KEY_DOWN = 40;//0x0028;
final static short KEY_LEFT = 37;//0x0025;
final static short KEY_RIGHT = 39;//0x0027;

// key_page
final static short KEY_PAGEUP = 33;//0x0021;
final static short KEY_PAGEDOWN = 34;//0x0022;

// key_back
final static short KEY_RETURN = 8;//0x0018;
final static short KEY_BACKSPACE = 8;//0x0008;
final static short KEY_ENTER = 13;//0x000D;
final static short KEY_OK = 13;//0x000D;
final static short KEY_SPACEBAR = 15;//0x000E;

// key_function
final static short KEY_PORTAL = 272;//0x0110;
final static short KEY_RED = 275;//0x0113;
final static short KEY_GREEN = 276;//0x0114;
final static short KEY_YELLOW = 277;//0x0115;
final static short KEY_BLUE = 278;//0x0116;
final static short KEY_GREY = 279;//0x0117;
final static short KEY_SWITCH = 280;//0x0118;
final static short KEY_FAVOURITE = 281;//0x0119; 
final static short KEY_BOOKMARK = 282;//0x011A;
final static short KEY_HELP = 284;//0x011C;


final static short KEY_LOCK = KEY_GREEN; 
final static short KEY_PLAY = KEY_BLUE;

final static short KEY_POWER_RED = 133;//0x0085;
final static short KEY_STUDY_TV_SET = 134;//0X0086
final static short KEY_STUEY_CHANNEL_UP = 135;//0X0087
final static short KEY_STUEY_CHANNEL_DOWN = 136;//0X0088
final static short KEY_TV_VOL_UP = 137;//0x0089;
final static short KEY_TV_VOL_DOWN = 138;//0x008A;

final static short KEY_POWER  = 256;//0x0100;
final static short KEY_CHANNEL_UP = 257;//0x0101;
final static short KEY_CHANNEL_DOWN = 258;//0x0102;
final static short KEY_VOL_UP = 259;//0x0103;
final static short KEY_VOL_DOWN = 260;//0x0104;
final static short KEY_MUTE = 261;//0x0105;
final static short KEY_TRACK = 262;//0x0106;
final static short KEY_PAUSE_PLAY = 263;//0x0107;
// key_play
final static short KEY_FAST_FORWARD = 264;//0x0108;
final static short KEY_FAST_REWIND = 265;//0x0109;
final static short KEY_FASTFORWARD = 264;//0x0108;
final static short KEY_FASTBACK = 265;//0x0109;
final static short KEY_GO_END = 266;//0x010A;
final static short KEY_GO_BEGINNING = 267;//0x010B;
final static short KEY_INFO = 268;//0x010C;
final static short KEY_INTERX = 269;//0x010D;
final static short KEY_STOP = 270;//0x010E;
final static short KEY_POS = 271;//0x010F;

//#?
final static short KEY_POUND = 105;//0x0069;
//
final static short KEY_STAR = 106;//0x006A;
final static short KEY_F1 = 107;//0x0070;
final static short KEY_F2 = 108;//0x0071;
final static short KEY_F3 = 109;//0x0072;
final static short KEY_F4 = 110;//0x0073;


//
final static short KEY_TV_IPTV = 129;//0x0081;
final static short KEY_TV_PC = 130;//0x0082;
final static short KEY_SOURCE = 131;//0x0083;
final static short KEY_PIP = 132;//0x0084;
final static short KEY_SEEK = 1032;//0x0084;


final static short KEY_INFO_URL = KEY_BLUE;
final static short KEY_APPLICATION_URL = KEY_GREY;
final static short KEY_SELFSERVICE = 100;
final static short KEY_USERSPACE = 101;



final static short EVENT_MEDIA_BEGIN = 421;//0x01A5;
final static short EVENT_MEDIA_END = 422;//0x01A4;
final static short EVENT_MEDIA_ERROR = 423;//0x01A6;
final static short EVENT_UTILITY = 768;//0x01A6;

///////////////TVMS///////////////////////
final static int KEY_CHANGE_FOCUS = 00000;
final static short KEY_IPTV_EVENT = 768;

final static short KEY_SEARCH = 0x0451;//0x0451  搜索   
final static short KEY_NVOD = 0x0458;//0x0458    轮播
final static short KEY_NPVR = 0x0453;//0x0453    pvr键

final static short KEY_BTV = 0x0454;//0x0454     频道
final static short KEY_VOD = 0x0455;//0x0455     点播
final static short KEY_TVOD = 0x0456;//0x0456    回看
final static short KEY_FAVORITE = 0x0119;//0x0119 收藏
//通信
final static short KEY_COMM = 0x0457;//0x0457

final static short KEY_BOTTOMLINE = 283 ;//频道下划线 A2规范中没有，扩展按键
//预览次数
final static int KEY_PREVIEWTIMES = 0x9902;
//预览时间
final static int KEY_PREVIEWTIME = 0x9903;
//频道列表中存在，机顶盒中不存在
final static int KEY_STBNOCHANNEL = 0x9904;
%>
