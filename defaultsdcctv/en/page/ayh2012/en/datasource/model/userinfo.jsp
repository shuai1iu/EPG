<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%!
/**
 * 保存在Session中用户基本信息对象.
 * <p>Title:用户信息 </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: ZTE Corporation</p>
 * @version 2.0
 */

public class PkitUserInfo  implements java.io.Serializable      
{
    private String sUserId; //用户编号
    private String sUserName; //用户名称
    private String sUserLoginName; //用户登录名
    private String sUserLoginPwd; //登录密码
    private String sUserLockPwd; //限制密码，童锁
    private String sUserSetId; //用户组编号
    private String sUserMainUrl; //用户主页（即表示风格模板StyleID）
    private String sUserIP; //用户IP
    private String sStbId; //机顶盒编号
    private String sLanguage; //语言
    private int iAutoLogin; //是否自动登录
    private String sBoId; //运营商编号
    private int iIsLocked; //限制状态：1,限制，0,不限制
    private String sSvrIP; //组播控制器IP
    private String sSvrPort; //组播控制器Port
    private String sUserGrpId; //用户集团ID
    private String sPopCode; //用户缺省流媒体服务Pop点编号

    private String sUserToken; //用户唯一标识
    private String sAccountNo; //用户宽带帐号
    private int iUserLoginType; //用户登陆方式  普通用户1;vNet用户2

    private int iIntegral; //用户积分

    //STB缓存数据
    private String sCrtChannelID; //当前混排频道号
    private String sCrtURL; //当前URL
    private String sCrtPlayPosition; //当前播放位置

    //新增加的
    private int serviceterminalid = 0; //用户应该享受的EPG服务器的teminalid;
    private String epgserverip = ""; //用户应该享受的EPG服务器的IP;
    private String epgserverurl = ""; // 用户需要document.location的新EPG服务器的url；
    private boolean needlocation = false;
    private int usertype = 0; //用户付费类型 0：后付费 1：预付费

    private int levelvalue = 10; //用户可看频道/节目的默认级别限制

    private String alarmMsg = ""; // 流量告警信息
    private String accessmethod = ""; //用户接入方式

    private String smartcard = ""; //智能卡号

    private int timestatistic = 0; //是否进行登录时长统计 0:不进行统计 1：进行统计
    private String logindate = ""; //用户登录时间
    private String logoutdate = ""; //用户退出时间

    private String cryptkey = ""; //解密密钥
    private int cryptmode = 0; //加密方式
    //用户使用得模板为旧模板还是新模板,0:旧的;1:新的
    private int frameflag = 0;
    //用户pop节点类型
    private int popType = 1;
    private String popIP = "";
    private int popPort;
    private String authId = "";
    private int stbtype = 0; //STB是否支持直接加入组播
    private String citycode = "";

  /////////////全球眼相关的///////////////////////
    private String cuid;
    private String puboid;
    private String rgmip;
    private int rgmport;
    private String cdnip;
    private int cdnport;
    private String vcdnid;
    private String nodeid;
    private String popunit;
    private String networkid;
    private String customid;
    private String profileid;
    private String token;

    //上海2.2规范增加字段
    private String encrypttoken;
    private String vendorid;
    private String userTokenExpiretime;
    //阿网应急功能状态标志 1：功能启动 0：功能不启动
    //Added by KingKumg 20081113
    private String emgstatus = "0";

    /**
     * setEmgstatus
     *
     * @param emgstatus String
     */
    public void setEmgstatus(String emgstatus)
    {
        this.emgstatus = emgstatus;
    }

    /**
     * getEmgstatus
     *
     * @return String
     */
    public String getEmgstatus()
    {
        return this.emgstatus;
    }

    /**
     *
     * @param token String
     */
    public void setToken(String token)
    {
        this.token = token;
    }
    /**
     *
     * @return String
     */
    public String getToken()
    {
        return this.token;
    }

    /////////////全球眼相关的//////////////////////
    /**
     *
     * @return String
     */
    public String getEpgserverip()
    {
        return epgserverip;
    }

    /**
     * setServiceTerminalid
     * @param serviceterminalid int



     */
    public void setServiceTerminalid(int serviceterminalid)
    {
        this.serviceterminalid = serviceterminalid;
    }

    /**
     * setEpgserverip
     * @param epgserverip String



     */
    public void setEpgserverip(String epgserverip)
    {
        this.epgserverip = epgserverip;
    }

    /**
     * setEpgserverurl
     * @param epgserverurl String



     */
    public void setEpgserverurl(String epgserverurl)
    {
        this.epgserverurl = epgserverurl;
    }

    /**
     * setNeedlocation
     * @param needlocation boolean



     */
    public void setNeedlocation(boolean needlocation)
    {
        this.needlocation = needlocation;
    }

    /**
     * setLevelvalue
     * @param levelvalue int



     */
    public void setLevelvalue(int levelvalue)
    {
        this.levelvalue = levelvalue;
    }

    /**
     * setUsertype
     * @param usertype int



     */
    public void setUsertype(int usertype)
    {
        this.usertype = usertype;
    }

    /**
     * setAlarmMsg
     * @param alarmMsg String



     */
    public void setAlarmMsg(String alarmMsg)
    {
        this.alarmMsg = alarmMsg;
    }

    /**
     * setAccessmethod
     * @param accessmethod String



     */
    public void setAccessmethod(String accessmethod)
    {
        this.accessmethod = accessmethod;
    }

    /**
     * setSmartcard
     * @param smartcard String



     */
    public void setSmartcard(String smartcard)
    {
        this.smartcard = smartcard;
    }

    /**
     * setTimestatistic
     * @param timestatistic int



     */
    public void setTimestatistic(int timestatistic)
    {
        this.timestatistic = timestatistic;
    }

    /**
     * setLogindate
     * @param logindate String



     */
    public void setLogindate(String logindate)
    {
        this.logindate = logindate;
    }

    /**
     * setLogoutdate
     * @param logoutdate String



     */
    public void setLogoutdate(String logoutdate)
    {
        this.logoutdate = logoutdate;
    }

    /**
     * setCryptmode
     * @param cryptmode int



     */
    public void setCryptmode(int cryptmode)
    {
        this.cryptmode = cryptmode;
    }

    /**
     * setCryptkey
     * @param cryptkey String



     */
    public void setCryptkey(String cryptkey)
    {
        this.cryptkey = cryptkey;
    }

    /**
     * setFrameflag
     * @param frameflag int



     */
    public void setFrameflag(int frameflag)
    {
        this.frameflag = frameflag;
    }

    /**
     * setRgmport
     * @param rgmport int



     */
    public void setRgmport(int rgmport)
    {
        this.rgmport = rgmport;
    }

    /**
     * setRgmip
     * @param rgmip String



     */
    public void setRgmip(String rgmip)
    {
        this.rgmip = rgmip;
    }

    /**
     * setPuboid
     * @param puboid String



     */
    public void setPuboid(String puboid)
    {
        this.puboid = puboid;
    }

    /**
     * setPopunit
     * @param popunit String



     */
    public void setPopunit(String popunit)
    {
        this.popunit = popunit;
    }

    /**
     * setNodeid
     * @param nodeid String



     */
    public void setNodeid(String nodeid)
    {
        this.nodeid = nodeid;
    }

    /**
     * setNetworkid
     * @param networkid String



     */
    public void setNetworkid(String networkid)
    {
        this.networkid = networkid;
    }

    /**
     * setCustomid
     * @param customid String



     */
    public void setCustomid(String customid)
    {
        this.customid = customid;
    }

    /**
     * setCuid
     * @param cuid String



     */
    public void setCuid(String cuid)
    {
        this.cuid = cuid;
    }

    /**
     * setCdnport
     * @param cdnport int



     */
    public void setCdnport(int cdnport)
    {
        this.cdnport = cdnport;
    }

    /**
     * setCdnip
     * @param cdnip String



     */
    public void setCdnip(String cdnip)
    {
        this.cdnip = cdnip;
    }

    /**
     * setVcdnid
     * @param vcdnid String



     */
    public void setVcdnid(String vcdnid)
    {
        this.vcdnid = vcdnid;
    }

    /**
     * setPopType
     * @param popType int



     */
    public void setPopType(int popType)
    {
        this.popType = popType;
    }

    /**
     * setPopIP
     * @param popIP String



     */
    public void setPopIP(String popIP)
    {
    	this.popIP = popIP;
    }

    /**
     * setPopPort
     * @param popPort int



     */
    public void setPopPort(int popPort)
    {
        this.popPort = popPort;
    }

    /**
     * setAuthId
     * @param authId String



     */
    public void setAuthId(String authId)
    {
        this.authId = authId;
    }

    /**
     *
     * @param stbtype int
     */
    public void setStbtype(int stbtype)
  {
    this.stbtype = stbtype;
  }
  /**
   *
   * @param profileid String
   */
  public void setProfileid(String profileid)
    {
        this.profileid = profileid;
    }

    public void setCitycode(String citycode)
    {
        this.citycode = citycode;
    }

    public void setVendorid(String vendorid)
    {
        this.vendorid = vendorid;
    }

    public void setUserTokenExpiretime(String userTokenExpiretime)
    {
        this.userTokenExpiretime = userTokenExpiretime;
    }

    public void setEncrypttoken(String encrypttoken)
    {
        this.encrypttoken = encrypttoken;
    }

    /**
     * getServiceTerminalid
     * @return int
     */
    public int getServiceTerminalid()
    {
        return serviceterminalid;
    }

    /**
     * getEpgserverurl
     * @return String
     */
    public String getEpgserverurl()
    {
        return epgserverurl;
    }

    /**
     * isNeedlocation
     * @return boolean
     */
    public boolean isNeedlocation()
    {
        return needlocation;
    }

    /**
     * getLevelvalue
     * @return int
     */
    public int getLevelvalue()
    {
        return levelvalue;
    }

    /**
     * getUsertype
     * @return int
     */
    public int getUsertype()
    {
        return usertype;
    }

    /**
     * getAlarmMsg
     * @return String
     */
    public String getAlarmMsg()
    {
        return alarmMsg;
    }

    /**
     * getAccessmethod
     * @return String
     */
    public String getAccessmethod()
    {
        return accessmethod;
    }

    /**
     * getSmartcard
     * @return String
     */
    public String getSmartcard()
    {
        return smartcard;
    }

    /**
     * getTimestatistic
     * @return int
     */
    public int getTimestatistic()
    {
        return timestatistic;
    }

    /**
     * getLogindate
     * @return String
     */
    public String getLogindate()
    {
        return logindate;
    }

    /**
     * getLogoutdate
     * @return String
     */
    public String getLogoutdate()
    {
        return logoutdate;
    }

    /**
     * getCryptmode
     * @return int
     */
    public int getCryptmode()
    {
        return cryptmode;
    }

    /**
     * getCryptkey
     * @return String
     */
    public String getCryptkey()
    {
        return cryptkey;
    }

    /**
     * getFrameflag
     * @return int
     */
    public int getFrameflag()
    {
        return frameflag;
    }

    /**
     * getRgmport
     * @return int
     */
    public int getRgmport()
    {
        return rgmport;
    }

    /**
     * getRgmip
     * @return String
     */
    public String getRgmip()
    {
        return rgmip;
    }

    /**
     * getPuboid
     * @return String
     */
    public String getPuboid()
    {
        return puboid;
    }

    /**
     * getPopunit
     * @return String
     */
    public String getPopunit()
    {
        return popunit;
    }

    /**
     * getNodeid
     * @return String
     */
    public String getNodeid()
    {
        return nodeid;
    }

    /**
     * getNetworkid
     * @return String
     */
    public String getNetworkid()
    {
        return networkid;
    }

    /**
     * getCustomid
     * @return String
     */
    public String getCustomid()
    {
        return customid;
    }

    /**
     * getCuid
     * @return String
     */
    public String getCuid()
    {
        return cuid;
    }

    /**
     * getCdnport
     * @return int
     */
    public int getCdnport()
    {
        return cdnport;
    }

    /**
     * getCdnip
     * @return String
     */
    public String getCdnip()
    {
        return cdnip;
    }

    /**
     * getVcdnid
     * @return String
     */
    public String getVcdnid()
    {
        return vcdnid;
    }

    /**
     * getPopType
     * @return int
     */
    public int getPopType()
    {
        return popType;
    }

    /**
     * getPopIP
     * @return String
     */
    public String getPopIP()
    {
        return popIP;
    }

    /**
     * getPopPort
     * @return int
     */
    public int getPopPort()
    {
        return popPort;
    }

    /**
     * getAuthId
     * @return String
     */
    public String getAuthId()
    {
        return authId;
    }
    /**
     *
     * @return int
     */
    public int getStbtype()
  {
    return stbtype;
  }
  /**
   *
   * @return String
   */
  public String getProfileid()
    {
        return profileid;
    }

    public String getCitycode()
    {
        return citycode;
    }

    public String getVendorid()
    {
        return vendorid;
    }

    public String getUserTokenExpiretime()
    {
        return userTokenExpiretime;
    }

    public String getEncrypttoken()
    {
        return encrypttoken;
    }

    //initialize all attribute
    /**
     * constructor PkitUserInfo
     */
    public PkitUserInfo()
    {
        sUserId = "";
        sUserName = "";
        sUserLoginName = "";
        sUserLoginPwd = "";
        sUserLockPwd = "";
        sUserSetId = "";
        sUserMainUrl = "";
        sUserIP = "";
        sStbId = "";
        sLanguage = "cn";
        iAutoLogin = 0;
        sBoId = "";
        iIsLocked = 0;
        sSvrIP = "";
        sSvrPort = "";
        sUserGrpId = "";
        sPopCode = "";
        sUserToken = "";
        sAccountNo = "";
        iUserLoginType = 0;
        iIntegral = 0;
        sCrtChannelID = "";
        sCrtURL = "";
        sCrtPlayPosition = "";
    }

    /**
     * getUserId
     * @return String
     */
    public String getUserId()
    {
        return sUserId;
    }

    /**
     * setUserId
     * @param sUserId String



     */
    public void setUserId(String sUserId)
    {
        this.sUserId = sUserId;
    }

    /**
     * getUserName
     * @return String
     */
    public String getUserName()
    {
        return sUserName;
    }

    /**
     * setUserName
     * @param sUserName String



     */
    public void setUserName(String sUserName)
    {
        this.sUserName = sUserName;
    }

    /**
     * getUserLoginName
     * @return String
     */
    public String getUserLoginName()
    {
        return sUserLoginName;
    }

    /**
     * setUserLoginName
     * @param sUserLoginName String



     */
    public void setUserLoginName(String sUserLoginName)
    {
        this.sUserLoginName = sUserLoginName;
    }

    /**
     * getUserLoginPwd
     * @return String
     */
    public String getUserLoginPwd()
    {
        return sUserLoginPwd;
    }

    /**
     * setUserLoginPwd
     * @param sUserLoginPwd String



     */
    public void setUserLoginPwd(String sUserLoginPwd)
    {
        this.sUserLoginPwd = sUserLoginPwd;
    }

    /**
     * getUserLockPwd
     * @return String
     */
    public String getUserLockPwd()
    {
        return sUserLockPwd;
    }

    /**
     * setUserLockPwd
     * @param sUserLockPwd String



     */
    public void setUserLockPwd(String sUserLockPwd)
    {
        this.sUserLockPwd = sUserLockPwd;
    }

    /**
     * getUserSetId
     * @return String
     */
    public String getUserSetId()
    {
        return sUserSetId;
    }

    /**
     * setUserSetId
     * @param sUserSetId String



     */
    public void setUserSetId(String sUserSetId)
    {
        this.sUserSetId = sUserSetId;
    }

    /**
     * getUserMainUrl
     * @return String
     */
    public String getUserMainUrl()
    {
        return sUserMainUrl;
    }

    /**
     * getUserModel
     * @return String
     */
    public String getUserModel()
    {
        int index = sUserMainUrl.indexOf("/");
        if (index < 0)
        {
            return sUserMainUrl;
        } else
        {
            return sUserMainUrl.substring(0, index);
        }
    }

    /**
     * setUserMainUrl
     * @param sUserMainUrl String



     */
    public void setUserMainUrl(String sUserMainUrl)
    {
        this.sUserMainUrl = sUserMainUrl;
    }

    /**
     * getUserIP
     * @return String
     */
    public String getUserIP()
    {
        return sUserIP;
    }

    /**
     * setUserIP
     * @param sUserIP String



     */
    public void setUserIP(String sUserIP)
    {
        this.sUserIP = sUserIP;
    }

    /**
     * getStbId
     * @return String
     */
    public String getStbId()
    {
        return sStbId;
    }

    /**
     * setStbId
     * @param sStbId String



     */
    public void setStbId(String sStbId)
    {
        this.sStbId = sStbId;
    }

    /**
     * getLanguage
     * @return String
     */
    public String getLanguage()
    {
        return sLanguage;
    }

    /**
     * setLanguage
     * @param sLanguage String



     */
    public void setLanguage(String sLanguage)
    {
        this.sLanguage = sLanguage;
    }

    /**
     * getAutoLogin
     * @return int
     */
    public int getAutoLogin()
    {
        return iAutoLogin;
    }

    /**
     * setAutoLogin
     * @param iAutoLogin int



     */
    public void setAutoLogin(int iAutoLogin)
    {
        this.iAutoLogin = iAutoLogin;
    }

    /**
     * getBoId
     * @return String
     */
    public String getBoId()
    {
        return sBoId;
    }

    /**
     * setBoId
     * @param sBoId String



     */
    public void setBoId(String sBoId)
    {
        this.sBoId = sBoId;
    }

    /**
     * getIsLocked
     * @return int
     */
    public int getIsLocked()
    {
        return iIsLocked;
    }

    /**
     * setIsLocked
     * @param iIsLocked int



     */
    public void setIsLocked(int iIsLocked)
    {
        this.iIsLocked = iIsLocked;
    }

    /**
     * getSvrIP
     * @return String
     */
    public String getSvrIP()
    {
        return sSvrIP;
    }

    /**
     * setSvrIP
     * @param sSvrIP String



     */
    public void setSvrIP(String sSvrIP)
    {
        this.sSvrIP = sSvrIP;
    }

    /**
     * getSvrPort
     * @return String
     */
    public String getSvrPort()
    {
        return sSvrPort;
    }

    /**
     * setSvrPort
     * @param sSvrPort String



     */
    public void setSvrPort(String sSvrPort)
    {
        this.sSvrPort = sSvrPort;
    }

    /**
     * getUserGrpId
     * @return String
     */
    public String getUserGrpId()
    {
        return sUserGrpId;
    }

    /**
     * setUserGrpId
     * @param sUserGrpId String



     */
    public void setUserGrpId(String sUserGrpId)
    {
        this.sUserGrpId = sUserGrpId;
    }

    /**
     * getPopCode
     * @return String
     */
    public String getPopCode()
    {
        return sPopCode;
    }

    /**
     * setPopCode
     * @param sPopCode String



     */
    public void setPopCode(String sPopCode)
    {
        this.sPopCode = sPopCode;
    }

    /**
     * getUserToken
     * @return String
     */
    public String getUserToken()
    {
        return sUserToken;
    }

    /**
     * setUserToken
     * @param sUserToken String



     */
    public void setUserToken(String sUserToken)
    {
        this.sUserToken = sUserToken;
    }

    /**
     * getAccountNo
     * @return String
     */
    public String getAccountNo()
    {
        return sAccountNo;
    }

    /**
     * setAccountNo
     * @param sAccountNo String



     */
    public void setAccountNo(String sAccountNo)
    {
        this.sAccountNo = sAccountNo;
    }

    /**
     * getUserLoginType
     * @return int
     */
    public int getUserLoginType()
    {
        return iUserLoginType;
    }

    /**
     * setUserLoginType
     * @param iUserLoginType int



     */
    public void setUserLoginType(int iUserLoginType)
    {
        this.iUserLoginType = iUserLoginType;
    }

    /**
     * getIntegral
     * @return int
     */
    public int getIntegral()
    {
        return iIntegral;
    }

    /**
     * setIntegral
     * @param iIntegral int



     */
    public void setIntegral(int iIntegral)
    {
        this.iIntegral = iIntegral;
    }

    /**
     * getCrtChannelID
     * @return String
     */
    public String getCrtChannelID()
    {
        return sCrtChannelID;
    }

    /**
     * setCrtChannelID
     * @param sCrtChannelID String



     */
    public void setCrtChannelID(String sCrtChannelID)
    {
        this.sCrtChannelID = sCrtChannelID;
    }

    /**
     * getCrtURL
     * @return String
     */
    public String getCrtURL()
    {
        return sCrtURL;
    }

    /**
     * setCrtURL
     * @param sCrtURL String



     */
    public void setCrtURL(String sCrtURL)
    {
        this.sCrtURL = sCrtURL;
    }

    /**
     * getCrtPlayPosition
     * @return String
     */
    public String getCrtPlayPosition()
    {
        return sCrtPlayPosition;
    }

    /**
     * setCrtPlayPosition
     * @param sCrtPlayPosition String



     */
    public void setCrtPlayPosition(String sCrtPlayPosition)
    {
        this.sCrtPlayPosition = sCrtPlayPosition;
    }


    /**
     * equals
     * @param obj Object


     * @return boolean
     */
    public boolean equals(Object obj)
    {
        if (obj == null)
        {
            return false;
        }
        if (this == obj)
        {
            return true;
        }
        if (!this.getClass().getName().equals(obj.getClass().getName()))
        {
            return false;
        }
        return this.toString().equals(obj.toString());
    }
}

%>