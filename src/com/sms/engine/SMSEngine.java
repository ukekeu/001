// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   SMSEngine.java

package com.sms.engine;

import com.sms.cpa.*;
import com.sms.pub.Connector;
import com.sms.pub.Tools;
import java.io.*;
import java.net.Socket;
import java.util.ResourceBundle;
import java.util.Vector;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

// Referenced classes of package com.sms.engine:
//            MO

public class SMSEngine
{
	private static Logger logger = LoggerFactory.getLogger(SMSEngine.class);

    class Empty
    {

        Empty()
        {
        }
    }

    class MoActive extends Thread { private boolean _$1383 = true;

    MoActive() {  } 
    public void stopMe() { this._$1383 = false; }


    public void run()
    {
      while (this._$1383)
        try {
          if (SMSEngine.this._$1279 != null) {
            Object ob = SMSEngine.this._$1379();
            int i = 0;
            while ((ob != null) && (!(ob instanceof CSendRet)) && (i < 100)) {
              ob = SMSEngine.this._$1379();
              i++;
            }
          }
          Thread.currentThread(); Thread.sleep(SMSEngine._$1305);
          if (SMSEngine.this._$1363() > 8) SMSEngine.this._$1372();
          Thread.currentThread(); Thread.sleep(SMSEngine._$1306);
        }
        catch (Exception localException)
        {
        }
    }
  }


    public SMSEngine()
    {
        _$1279 = null;
        _$1297 = null;
        _$1299 = null;
        _$1318 = "";
        _$1319 = null;
        _$1320 = 0;
        _$1321 = "";
        _$1322 = "";
        _$1323 = "SURGESMS";
        _$1324 = "02";
        _$1325 = "0";
        _$1326 = "0";
        _$1327 = "1";
        _$1328 = "";
        _$1329 = "";
        m_iRevTimes = 0;
        m_iSendTimes = 0;
        m_iFeeTotal = 0;
        m_lLastTime = 0L;
        file = null;
        _$1299 = new Vector();
        try
        {
            file = new File(".", "smsSend.log");
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    public SMSEngine(String sIp, int iPort, String sAcc, String sPwd)
    {
        this();
        setSurgeIP(sIp.trim());
        setSurgePort(iPort);
        setUserName(sAcc.trim());
        setPassWD(sPwd.trim());
    }

    public int IntialConfig()
    {
        ResourceBundle r = ResourceBundle.getBundle("sms_engine");
        try
        {
            _$1302 = r.getString("ServerIP");
            _$1303 = Integer.parseInt(r.getString("ServerPort"));
            _$1304 = r.getString("username");
            _$1307 = r.getString("password");
            _$1301 = r.getString("MO_class_name");
            _$1313 = r.getString("logflag");
            _$1315 = Integer.parseInt(r.getString("loginnum"));
            _$1314 = _$1315;
        }
        catch(Exception e)
        {
        	logger.error("-[\u77ED\u4FE1\u63A5\u53E3]\u8BFB\u914D\u7F6E\u6587\u4EF6\u6570\u636E\u9519\u8BEF\uFF01");
            byte byte0 = -1;
            return byte0;
        }
        return 0;
    }

    public int SetIntialConfig()
    {
        ResourceBundle r = ResourceBundle.getBundle("sms_engine");
        try
        {
            _$1302 = r.getString("ServerIP");
            _$1303 = Integer.parseInt(r.getString("ServerPort"));
            _$1304 = r.getString("username");
            _$1307 = r.getString("password");
            _$1301 = r.getString("MO_class_name");
            _$1313 = r.getString("logflag");
            _$1315 = Integer.parseInt(r.getString("loginnum"));
            _$1314 = _$1315;
        }
        catch(Exception e)
        {
        	logger.error("-[\u77ED\u4FE1\u63A5\u53E3]\u8BFB\u914D\u7F6E\u6587\u4EF6\u6570\u636E\u9519\u8BEF\uFF01");
            byte byte0 = -1;
            return byte0;
        }
        return 0;
    }

    private void _$1361()
    {
        m_lLastTime = System.currentTimeMillis();
    }

    private int _$1363()
    {
        int i = (int)(System.currentTimeMillis() - m_lLastTime) / 1000;
        return i;
    }

    public int getLoginNum()
    {
        return _$1315;
    }

    private void _$1366()
    {
        _$1361();
        if(_$1297 == null)
        {
        	logger.info("-[\u77ED\u4FE1\u63A5\u53E3]\u94FE\u8DEF\u8FDE\u63A5\u68C0\u6D4B\u7EBF\u7A0B,\u542F\u52A8\u63A5\u6536\u77ED\u4FE1\u7EBF\u7A0B--");
            _$1297 = new MoActive();
            _$1297.start();
        }
    }

    public boolean getMTStatus()
    {
        return _$1279 != null;
    }

    public boolean getMOStatus()
    {
        return _$1279 != null && _$1297 != null;
    }

    private void _$1370()
    {
        if(_$1297 != null)
        {
        	logger.info("-[\u77ED\u4FE1\u63A5\u53E3]\u94FE\u8DEF\u8FDE\u63A5\u68C0\u6D4B\u7EBF\u7A0B,\u505C\u6B62\u63A5\u6536\u7EBF\u7A0B--");
            _$1297.stopMe();
            _$1297 = null;
            _$1279 = null;
        }
    }

    private void _$1372()
    {
        _$1361();
        if(_$1279 == null && _$1315 >= 0)
        {
        	logger.info("-[\u77ED\u4FE1\u63A5\u53E3]\u7EBF\u8DEF\u4E2D\u65AD\uFF0C\u6B63\u5728\u4E3B\u52A8\u8FDE\u63A5...!\u91CD\u590D\u6B21\u6570:".concat(String.valueOf(String.valueOf(_$1315))));
            CmdLoginReq();
            return;
        }
        CLinkReq cr = new CLinkReq(_$1304);
        if(!_$1279.write(cr.toBytes()))
        {
            CmdLoginReq();
            return;
        } else
        {
            return;
        }
    }

    private synchronized Object _$1379()
    {
        if(_$1279 == null)
            return null;
        int iLen = _$1279.available();
        if(iLen == 0)
            return new Empty();
        if(iLen < 0)
            return null;
        byte b[] = _$1279.read(4);
        iLen = Tools.b2i(b, 0, 4) - 4;
        if(iLen > 1000 || iLen <= 0)
            for(; iLen > 0; iLen -= 64)
                if(iLen > 64)
                    b = _$1279.read(64);
                else
                    b = _$1279.read(iLen);

        b = _$1279.read(iLen);
        Object o = CTools.get(b);
        if(o == null)
            return null;
        _$1361();
        if(o instanceof CSendRet)
            _$1391((CSendRet)o);
        else
        if(o instanceof CLinkRet)
            _$1393((CLinkRet)o);
        else
        if(o instanceof CMoReq)
            _$1395((CMoReq)o);
        else
        if(o instanceof CFeeRet)
            _$1397((CFeeRet)o);
        else
        if(o instanceof CPasswdRet)
            _$1399((CPasswdRet)o);
        else
        if(o instanceof CLogoutRet)
            _$1401((CLogoutRet)o);
        else
        if(o instanceof CTimerSendRet)
            _$1403((CTimerSendRet)o);
        else
        if(o instanceof CCancelSendRet)
            _$1405((CCancelSendRet)o);
        return o;
    }

    private void _$1405(CCancelSendRet f)
    {
    	logger.info(String.valueOf(String.valueOf((new StringBuffer("-[\u77ED\u4FE1\u63A5\u53E3]\u5B9A\u65F6\u53D6\u6D88:")).append(f.bStatus).append("(0,\u672A\u627E\u5230,1=\u6210\u529F,2\u77ED\u4FE1\u5DF2\u7ECF\u53D1\u9001)\r\n"))));
        _$1316 = String.valueOf(f.bStatus);
    }

    private void _$1403(CTimerSendRet f)
    {
    	logger.info(String.valueOf(String.valueOf((new StringBuffer("-[\u77ED\u4FE1\u63A5\u53E3]\u5B9A\u65F6\u53D1\u9001:")).append(f.bStatus).append("(1=\u6210\u529F\uFF0C\u5176\u4ED6\u5931\u8D25)\r\n"))));
        _$1317 = String.valueOf(f.bStatus);
    }

    private void _$1391(CSendRet f)
    {
        _$1309 = String.valueOf(f.bStatus);
    }

    private void _$1399(CPasswdRet f)
    {
        _$1307 = f.toString();
    }

    private void _$1393(CLinkRet f)
    {
        _$1310 = "0";
    }

    private void _$1397(CFeeRet f)
    {
        _$1308 = f.sFeeLeft;
    }

    private void _$1401(CLogoutRet clogoutret)
    {
    }

    private void _$1395(CMoReq m)
    {
        Class c = null;
        try
        {
            byte b[] = m.bMessage;
            String sContent = new String(b);
            if(Tools.haveChina(b))
                if(sContent.length() > 70)
                    sContent = sContent.substring(0, 70);
                else
                if(sContent.length() > 160)
                    sContent = sContent.substring(0, 160);
            if(_$1313.equals("1"))
            	logger.info(String.valueOf(String.valueOf((new StringBuffer("-[\u77ED\u4FE1\u63A5\u53E3]\u4E0A\u884C\u4FE1\u606F,\u53D1\u9001\u4EBA:")).append(m.sFrom).append(",\u63A5\u6536\u4EBA:").append(m.sTarget))));
            c = Class.forName(_$1301);
            MO moSample = (MO)c.newInstance();
            moSample.Notify(m.sMoid, m.sService, m.sFrom, m.sTarget, sContent);
            if(_$1313.equals("1"))
            	logger.info(String.valueOf(String.valueOf((new StringBuffer("-[\u77ED\u4FE1\u63A5\u53E3]\u4E0A\u884C\u4FE1\u606F,\u670D\u52A1\u4EE3\u7801:")).append(m.sService).append(",\u5185\u5BB9:").append(sContent))));
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    public int CmdLoginReq()
    {
        _$1315--;
        CmdLogoutReq();
        _$1366();
        try
        {
            Connector c = new Connector(new Socket(_$1302, _$1303));
            CLoginReq cl = new CLoginReq(_$1304, _$1307);
            byte b[] = cl.toBytes();
            c.write(b);
            b = c.read(4);
            b = c.read(Tools.b2i(b, 0, 4) - 4);
            CParam cp = CTools.get(b);
            if(cp == null || !(cp instanceof CLoginRet))
            {
            	logger.info("-[\u77ED\u4FE1\u63A5\u53E3]\u6536\u5230\u6570\u636E\u62A5\u683C\u5F0F\u53C2\u6570\u9519\u8BEF!");
                int i = 1;
                return i;
            }
            CLoginRet cr = (CLoginRet)cp;
            if(cr.bStatus == 1)
            {
            	logger.info("-[\u77ED\u4FE1\u63A5\u53E3]\u767B\u5F55\u6210\u529F--");
                _$1315 = _$1314;
                _$1279 = c;
                _$1361();
                CmdQueryFee();
                _$1366();
                int j = 0;
                return j;
            } else
            {
            	logger.info("-[\u77ED\u4FE1\u63A5\u53E3]\u767B\u9646\u5931\u8D25\uFF0C\u8FD4\u56DE\u503C:".concat(String.valueOf(String.valueOf(cr.bStatus))));
            	logger.info("-[\u77ED\u4FE1\u63A5\u53E3]\u5931\u8D25\u63D0\u793A:1 \u767B\u5F55\u6210\u529F,-1 \u901A\u8BAF\u5931\u8D25");
            	logger.info("-[\u77ED\u4FE1\u63A5\u53E3]2 \u65E0\u6548\u7684\u5BA2\u6237\u72B6\u53F7");
            	logger.info("-[\u77ED\u4FE1\u63A5\u53E3]18 \u8D26\u53F7\u6216\u5BC6\u7801\u9519\u8BEF 20 \u5BA2\u6237\u6743\u9650\u4E0D\u5BF9");
            	logger.info("-[\u77ED\u4FE1\u63A5\u53E3]21 \u4E0D\u7B26\u5408\u7CFB\u7EDF\u6CE8\u518C\u7684IP");
            	logger.info("-[\u77ED\u4FE1\u63A5\u53E3]22 \u5DF2\u7ECF\u8D85\u8FC7\u7CFB\u7EDF\u5728\u7EBF\u8282\u70B9,\u8BF7\u7A0D\u540E\u767B\u9646!");
            	logger.info("-[\u77ED\u4FE1\u63A5\u53E3]\u5176\u4ED6\u53C2\u6570\u683C\u5F0F\u4E0D\u5BF9\u6216\u8005\u9519\u8BEF\u7684\u6307\u4EE4");
            	logger.info("-[\u77ED\u4FE1\u63A5\u53E3]\u64CD\u4F5C\u63D0\u793A:\u9000\u51FA\u7CFB\u7EDF\uFF0C\u8BF7\u8C03\u7528CmdLogoutReq\u6307\u4EE4");
                int k = 1;
                return k;
            }
        }
        catch(Exception exception)
        {
            return -1;
        }
    }

    public int CmdLogoutReq()
    {
        if(_$1279 == null)
        {
            return 0;
        } else
        {
            CLogoutReq cl = new CLogoutReq(_$1304);
            _$1279.write(cl.toBytes());
            _$1297.stopMe();
            _$1297 = null;
            return 0;
        }
    }

    public void CmdQueryFee()
    {
        if(_$1279 == null)
        {
            return;
        } else
        {
            CFeeReq cr = new CFeeReq(_$1304, "");
            _$1279.write(cr.toBytes());
            return;
        }
    }

    public void CmdLinkReq()
    {
        if(_$1279 == null)
        {
            return;
        } else
        {
            CLinkReq cr = new CLinkReq(_$1304);
            _$1279.write(cr.toBytes());
            return;
        }
    }

    public void CmdModifyPasswd(String _newpass)
    {
        if(_$1279 == null)
            return;
        if(_newpass.length() == 0)
        {
            return;
        } else
        {
            CPasswdReq cr = new CPasswdReq(_$1304);
            cr.sPasswd0 = _$1307.trim();
            cr.sPasswd1 = _newpass.trim();
            _$1279.write(cr.toBytes());
            return;
        }
    }

    public void setSurgeIP(String _ip)
    {
        if(_ip != null && !_ip.equals(""))
            _$1302 = _ip;
    }

    public String getSurgeIP()
    {
        return _$1302;
    }

    public void setSurgePort(int _port)
    {
        _$1303 = _port;
    }

    public int getSurgePort()
    {
        return _$1303;
    }

    public void setUserName(String _name)
    {
        if(_name != null && !_name.equals(""))
            _$1304 = _name;
    }

    public String getUserName()
    {
        return _$1304;
    }

    public void setPassWD(String _pwd)
    {
        if(_pwd != null && !_pwd.equals(""))
            _$1307 = _pwd;
    }

    public String getPassWD()
    {
        return _$1307;
    }

    public void setFromNum(String fum)
    {
        if(fum != null && !fum.equals(""))
            _$1318 = fum;
    }

    public String getFromNum()
    {
        return _$1318;
    }

    public void setToNum(String tNum)
    {
        if(tNum != null && !tNum.equals(""))
            _$1299.add(tNum);
    }

    public void addToNum(String tNum)
    {
        if(tNum != null && !tNum.equals(""))
            _$1299.add(tNum);
    }

    public void setPayNum(String _pnum)
    {
        if(_pnum != null && !_pnum.equals(""))
            _$1321 = _pnum;
    }

    public String getPayNum()
    {
        return _$1321;
    }

    public void setText(String _text)
    {
        if(_text != null && !_text.equals(""))
            _$1322 = _text.trim();
    }

    public String getText()
    {
        return _$1322;
    }

    public void setServiceID(String _service)
    {
        if(_service != null && !_service.equals(""))
            _$1323 = _service;
    }

    public String getServiceID()
    {
        return _$1323;
    }

    public void setFeeType(String _ftype)
    {
        if(_ftype != null && !_ftype.equals(""))
            _$1324 = _ftype;
    }

    public String getFeeType()
    {
        return _$1324;
    }

    public void setFeeUserType(String _fUserType)
    {
        if(_fUserType != null && !_fUserType.equals(""))
            _$1325 = _fUserType;
    }

    public String getFeeUserType()
    {
        return _$1325;
    }

    public void setFee(String _strFee)
    {
        if(_strFee != null && !_strFee.equals(""))
            _$1326 = _strFee;
    }

    public String getFee()
    {
        return _$1326;
    }

    public void setFormat(String _strFormat)
    {
        if(_strFormat != null && !_strFormat.equals(""))
            _$1327 = _strFormat;
    }

    public String getFormat()
    {
        return _$1327;
    }

    public void setMoID(String _strMoID)
    {
        if(_strMoID != null && !_strMoID.equals(""))
            _$1328 = _strMoID;
    }

    public String getMoID()
    {
        return _$1328;
    }

    public void setPresendTime(String _pTime)
    {
        if(_pTime != null && !_pTime.equals(""))
            _$1329 = _pTime;
    }

    public String getPresendTime()
    {
        return _$1329;
    }

    private int _$1482()
    {
        if(_$1279 == null)
            return -1;
        if(_$1319[0].startsWith("86"))
        {
            String tmps = _$1319[0].substring(0, 5).trim();
            if(tmps.compareTo("86130") >= 0 && tmps.compareTo("86133") <= 0)
                _$1318 = "";
        } else
        {
            String tmps = _$1319[0].substring(0, 3).trim();
            if(tmps.compareTo("130") >= 0 && tmps.compareTo("133") <= 0)
                _$1318 = "";
        }
        if(_$1318 == null)
            _$1318 = "";
        CSendReq cs = new CSendReq(_$1304, _$1318, _$1319[0], 1);
        cs.setParament((byte)Integer.parseInt(_$1325), _$1323, _$1321, _$1324, Integer.parseInt(_$1326), (byte)Integer.parseInt(_$1327));
        _$1311 = cs.iErrorCode;
        _$1312 = cs.sErrorCode;
        byte b[] = _$1322.trim().getBytes();
        try
        {
            String sBody = new String(b);
            String sSubBody = "";
            int iNumSend = 0;
            int iTimes = 0;
            if(Tools.haveChina(b))
            {
                iTimes = (sBody.length() - 1) / 70 + 1;
                for(int i = 0; i < iTimes; i++)
                {
                    if(i == iTimes - 1)
                    {
                        sSubBody = sBody.substring(i * 70, sBody.length());
                        cs.iLength = b.length - i * 70;
                    } else
                    {
                        sSubBody = sBody.substring(i * 70, i * 70 + 70);
                        cs.iLength = 140;
                    }
                    cs.bMessage = sSubBody.getBytes();
                    if(_$1313.equals("1"))
                    {
                    	logger.info(String.valueOf(String.valueOf((new StringBuffer("-[\u77ED\u4FE1\u63A5\u53E3]\u5355\u53D1\u77ED\u4FE1,\u53D1\u9001\u4EBA:")).append(cs.sFrom).append(",\u63A5\u6536\u4EBA:").append(cs.sTarget))));
                    	logger.info("-[\u77ED\u4FE1\u63A5\u53E3]\u5355\u53D1\u5185\u5BB9:".concat(String.valueOf(String.valueOf(sSubBody))));
                    }
                    if(_$1279.write(cs.toBytes()))
                    {
                        iNumSend++;
                    } else
                    {
                        CmdLoginReq();
                        byte byte1 = -1;
                        return byte1;
                    }
                }

                _$1320 = 0;
                _$1321 = "";
                int j = 1;
                return j;
            }
            iTimes = sBody.length() / 160 + 1;
            for(int i = 0; i < iTimes; i++)
            {
                if(i == iTimes - 1)
                {
                    sSubBody = sBody.substring(i * 160, sBody.length() - i * 160);
                    cs.iLength = b.length - i * 160;
                } else
                {
                    sSubBody = sBody.substring(i * 160, 160);
                    cs.iLength = 160;
                }
                cs.bMessage = sSubBody.getBytes();
                if(_$1313.equals("1"))
                {
                	logger.info(String.valueOf(String.valueOf((new StringBuffer("-[\u77ED\u4FE1\u63A5\u53E3]\u5355\u53D1\u77ED\u4FE1,\u53D1\u9001\u4EBA:")).append(cs.sFrom).append(",\u63A5\u6536\u4EBA:").append(cs.sTarget))));
                	logger.info("-[\u77ED\u4FE1\u63A5\u53E3]\u5355\u53D1\u5185\u5BB9:".concat(String.valueOf(String.valueOf(sSubBody))));
                }
                if(_$1279.write(cs.toBytes()))
                {
                    iNumSend++;
                } else
                {
                    CmdLoginReq();
                    byte byte2 = -1;
                    return byte2;
                }
            }

            _$1320 = 0;
            _$1321 = "";
            int k = 1;
            return k;
        }
        catch(Exception e)
        {
        	logger.error("Send a Single Message Error!");
        }
        _$1320 = 0;
        _$1321 = "";
        byte byte0 = -1;
        return byte0;
    }

    public int send()
    {
        if(_$1322.equals(""))
            return 1;
        if(_$1279 == null)
            return -1;
        int sendResult = 0;
        int sendNum = 1;
        _$1320 = _$1299.size();
        try
        {
            if(_$1320 == 1)
            {
                _$1319 = new String[_$1299.size()];
                for(int i = 0; i < _$1299.size(); i++)
                    _$1319[i] = (String)_$1299.get(i);

                if(_$1482() == 1)
                    sendResult = 1;
            } else
            {
                String cmpp[] = new String[50];
                String sgip[] = new String[50];
                String cdma[] = new String[50];
                int iCmpp = 0;
                int iSgip = 0;
                int iCdma = 0;
                for(int i = 0; i < _$1299.size(); i++)
                {
                    String mobile = ((String)_$1299.get(i)).trim();
                    if(mobile.startsWith("86"))
                        mobile = mobile.substring(2);
                    String tmps = mobile.substring(0, 3).trim();
                    if(tmps.compareTo("133") >= 0 && tmps.compareTo("133") <= 0)
                    {
                        _$1318 = "";
                        cdma[iCdma] = mobile;
                        iCdma++;
                        if(iCdma < 50)
                            continue;
                        if(_$1554(iCdma, cdma) < 0)
                        {
                            sendResult = -1;
                            break;
                        }
                        sendResult = 1;
                        iCdma = 0;
                        continue;
                    }
                    if(tmps.compareTo("130") >= 0 && tmps.compareTo("134") <= 0)
                    {
                        _$1318 = "";
                        sgip[iSgip] = mobile;
                        iSgip++;
                        if(iSgip < 50)
                            continue;
                        if(_$1554(iSgip, sgip) < 0)
                        {
                            sendResult = -1;
                            break;
                        }
                        sendResult = 1;
                        iSgip = 0;
                        continue;
                    }
                    cmpp[iCmpp] = mobile;
                    iCmpp++;
                    if(iCmpp < 50)
                        continue;
                    if(_$1554(iCmpp, cmpp) < 0)
                    {
                        sendResult = -1;
                        break;
                    }
                    sendResult = 1;
                    iCmpp = 0;
                }

                if(sendResult != -1)
                {
                    if(iCdma > 0)
                        if(_$1554(iCdma, cdma) < 0)
                        {
                            sendResult = -1;
                        } else
                        {
                            sendResult = 1;
                            iCdma = 0;
                        }
                    if(iSgip > 0)
                        if(_$1554(iSgip, sgip) < 0)
                        {
                            sendResult = -1;
                        } else
                        {
                            sendResult = 1;
                            iSgip = 0;
                        }
                    if(iCmpp > 0)
                        if(_$1554(iCmpp, cmpp) < 0)
                        {
                            sendResult = -1;
                        } else
                        {
                            sendResult = 1;
                            boolean flag = false;
                        }
                }
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
            _$1299 = new Vector();
            _$1321 = "";
            sendResult = -1;
        }
        if(sendResult == 1)
        {
            _$1299 = new Vector();
            _$1321 = "";
            _$1361();
        }
        return sendResult;
    }

    private int _$1554(int iiTarget, String ssTarget[])
        throws Exception
    {
        if(_$1279 == null)
            return -1;
        if(_$1318 == null)
            _$1318 = "";
        CSendClusterReq cs = new CSendClusterReq(_$1304, _$1318, 1);
        cs.setParament((byte)Integer.parseInt(_$1325), _$1323, _$1321, _$1324, Integer.parseInt(_$1326), (byte)Integer.parseInt(_$1327));
        _$1311 = cs.iErrorCode;
        _$1312 = cs.sErrorCode;
        cs.SetTarget(iiTarget, ssTarget);
        byte b[] = _$1322.trim().getBytes();
        try
        {
            String sBody = new String(b);
            String sSubBody = "";
            int iNumSend = 0;
            int iTimes = 0;
            if(Tools.haveChina(b))
            {
                iTimes = (sBody.length() - 1) / 70 + 1;
                for(int i = 0; i < iTimes; i++)
                {
                    if(i == iTimes - 1)
                    {
                        sSubBody = sBody.substring(i * 70, sBody.length());
                        cs.iLength = b.length - i * 70;
                    } else
                    {
                        sSubBody = sBody.substring(i * 70, (i + 1) * 70);
                        cs.iLength = 70;
                    }
                    cs.bMessage = sSubBody.getBytes();
                    if(_$1313.equals("1"))
                    	logger.info(String.valueOf(String.valueOf((new StringBuffer("-[\u77ED\u4FE1\u63A5\u53E3]\u7FA4\u53D1\u77ED\u4FE1,\u53D1\u9001\u4EBA:")).append(cs.sFrom).append("\u7FA4\u53D1\u5185\u5BB9:").append(sSubBody).append("\u53D1\u9001\u7ED9:").append(iiTarget).append("\u4EBA"))));
                    if(_$1279.write(cs.toBytes()))
                    {
                        iNumSend++;
                    } else
                    {
                        CmdLoginReq();
                        iNumSend = -1;
                        byte byte0 = -1;
                        return byte0;
                    }
                }

                int j = iNumSend;
                return j;
            }
            iTimes = sBody.length() / 160 + 1;
            for(int i = 0; i < iTimes; i++)
            {
                if(i == iTimes - 1)
                {
                    sSubBody = sBody.substring(i * 160, sBody.length() - i * 160);
                    cs.iLength = b.length - i * 160;
                } else
                {
                    sSubBody = sBody.substring(i * 160, 160);
                    cs.iLength = 160;
                }
                cs.bMessage = sSubBody.getBytes();
                if(_$1313.equals("1"))
                	logger.info(String.valueOf(String.valueOf((new StringBuffer("-[\u77ED\u4FE1\u63A5\u53E3]\u7FA4\u53D1\u77ED\u4FE1,\u53D1\u9001\u4EBA:")).append(cs.sFrom).append("\u7FA4\u53D1\u5185\u5BB9:").append(sSubBody).append("\u53D1\u9001\u7ED9:").append(iiTarget).append("\u4EBA"))));
                if(_$1279.write(cs.toBytes()))
                {
                    iNumSend++;
                } else
                {
                    CmdLoginReq();
                    iNumSend = -1;
                    byte byte1 = -1;
                    return byte1;
                }
            }

            int k = iNumSend;
            return k;
        }
        catch(Exception e)
        {
        	logger.error("Send Message Error!");
            throw e;
        }
    }

    public int timerSend(String tPhone, String tText, String tTime)
    {
        if(tText == null || tText.trim().equals(""))
            return 1;
        if(_$1279 == null)
            return -1;
        CTimerSendReq cs = new CTimerSendReq(_$1304, "", tPhone, 1);
        cs.setParament((byte)Integer.parseInt(_$1325), _$1323, _$1321, _$1324, Integer.parseInt(_$1326), (byte)Integer.parseInt(_$1327));
        cs.setTimer(tTime.trim());
        byte b[] = tText.trim().getBytes();
        try
        {
            String sBody = new String(b);
            String sSubBody = "";
            int iNumSend = 0;
            int iTimes = 0;
            if(Tools.haveChina(b))
            {
                iTimes = (sBody.length() - 1) / 70 + 1;
                for(int i = 0; i < iTimes; i++)
                {
                    if(i == iTimes - 1)
                    {
                        sSubBody = sBody.substring(i * 70, sBody.length());
                        cs.iLength = b.length - i * 70;
                    } else
                    {
                        sSubBody = sBody.substring(i * 70, (i + 1) * 70);
                        cs.iLength = 70;
                    }
                    cs.bMessage = sSubBody.getBytes();
                    if(_$1313.equals("1"))
                    	logger.info(String.valueOf(String.valueOf((new StringBuffer("-[\u77ED\u4FE1\u63A5\u53E3]\u5B9A\u5236\u77ED\u4FE1,\u53D1\u9001\u4EBA:")).append(cs.sFrom).append("\u5B9A\u5236\u5185\u5BB9:").append(sSubBody))));
                    if(_$1279.write(cs.toBytes()))
                    {
                        iNumSend++;
                    } else
                    {
                        CmdLoginReq();
                        byte byte1 = -1;
                        return byte1;
                    }
                }

                _$1320 = 0;
                _$1321 = "";
                int j = iNumSend;
                return j;
            }
            iTimes = sBody.length() / 160 + 1;
            for(int i = 0; i < iTimes; i++)
            {
                if(i == iTimes - 1)
                {
                    sSubBody = sBody.substring(i * 160, sBody.length() - i * 160);
                    cs.iLength = b.length - i * 160;
                } else
                {
                    sSubBody = sBody.substring(i * 160, 160);
                    cs.iLength = 160;
                }
                cs.bMessage = sSubBody.getBytes();
                if(_$1313.equals("1"))
                	logger.info(String.valueOf(String.valueOf((new StringBuffer("-[\u77ED\u4FE1\u63A5\u53E3]\u5B9A\u5236\u77ED\u4FE1,\u53D1\u9001\u4EBA:")).append(cs.sFrom).append("\u5B9A\u5236\u5185\u5BB9:").append(sSubBody))));
                if(_$1279.write(cs.toBytes()))
                {
                    iNumSend++;
                } else
                {
                    CmdLoginReq();
                    byte byte2 = -1;
                    return byte2;
                }
            }

            _$1320 = 0;
            _$1321 = "";
            int k = iNumSend;
            return k;
        }
        catch(Exception e)
        {
        	logger.error("Timer Message Error!");
        }
        _$1320 = 0;
        _$1321 = "";
        byte byte0 = -1;
        return byte0;
    }

    public int CancelTimer(String tPhone, String tText, String tTime)
    {
        if(_$1279 == null)
            return -1;
        String time = tTime.trim();
        if(time.length() == 0)
        {
            logger.info("-[\u77ED\u4FE1\u63A5\u53E3]\u8BF7\u586B\u5199\u5B9A\u65F6\u65F6\u95F4\u683C\u5F0F[2003-8-1 09:01:01]--!\r\n");
            return 0;
        }
        String recv = tPhone.trim();
        if(recv.length() == 0)
        {
        	logger.info("-[\u77ED\u4FE1\u63A5\u53E3]\u8BF7\u586B\u5199\u5B9A\u65F6\u63A5\u6536\u4EBA\u624B\u673A\u53F7\u7801--!\r\n");
            return 0;
        } else
        {
            CCancelSendReq cs = new CCancelSendReq(_$1304);
            cs.sPhone = recv;
            cs.sPredate = time;
            cs.sContent = tText.trim();
            _$1279.write(cs.toBytes());
            return 1;
        }
    }

    private static final int _$1294 = 50;
    private Connector _$1279;
    private MoActive _$1297;
    private Vector _$1299;
    private static String _$1301 = "com.sms.engine.SampleMO";
    private static String _$1302 = "";
    private static int _$1303 = 6688;
    private static String _$1304 = "";
    private static int _$1305 = 10000;
    private static int _$1306 = 1000;
    private static String _$1307 = "";
    private static String _$1308 = "";
    private static String _$1309 = "";
    private static String _$1310 = "";
    private static int _$1311 = 0;
    private static String _$1312 = "";
    private static String _$1313 = "1";
    private static int _$1314 = 20;
    private static int _$1315 = 20;
    private static String _$1316 = "";
    private static String _$1317 = "";
    private String _$1318;
    private String _$1319[];
    private int _$1320;
    private String _$1321;
    private String _$1322;
    private String _$1323;
    private String _$1324;
    private String _$1325;
    private String _$1326;
    private String _$1327;
    private String _$1328;
    private String _$1329;
    int m_iRevTimes;
    int m_iSendTimes;
    int m_iFeeTotal;
    long m_lLastTime;
    public FileOutputStream fo;
    public File file;







}
