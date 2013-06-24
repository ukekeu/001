package com.sztelecom.vabd.zytx;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.excenon.sms.moduleUtil.SMSCallBackUtil;
import com.excenon.sms.moduleUtil.SMSEchoUtil;
import com.excenon.sms.moduleUtil.SMSRecvUtil;

public class CallBack
{
  private static Logger log = LoggerFactory.getLogger(CallBack.class);

  public void NotifyStatus(int eventID, String sessionID, int res, String para1)
  {
    log.info("-------------------into NotifyStatus-----------------");
    log.info("eventID=" + eventID);
    log.info("sessionID=" + sessionID);
    log.info("res=" + res);
    log.info("para1=" + para1);
    log
      .info("-------------------end of NotifyStatus------------------------------");

    SMSCallBackUtil.insertSMSCallBack(eventID, sessionID, 
      String.valueOf(res), para1);
  }

  public void EchoOfSendSMS(String ucNum, String cee, int msgid, int res, String recvt)
  {
    log.info("-------------------into EchoOfSendSMS-----------------");
    log.info("ucNum=" + ucNum);
    log.info("cee=" + cee);
    log.info("msgid=" + msgid);
    log.info("res=" + res);
    log.info("recvt=" + recvt);
    log
      .info("-------------------end of EchoOfSendSMS------------------------------");

    SMSEchoUtil.insertSMSEcho(ucNum, cee, msgid, res, recvt);
  }

  public String RecvSMS(String caller, String time, String cont, String ucNum)
  {
    log.info("-------------------into RecvSMS-----------------");
    log.info("caller=" + caller);
    log.info("time=" + time);
    String msg = cont;

    log.info("cont=" + msg);
    log.info("ucNum=" + ucNum);
    log
      .info("-------------------end of RecvSMS------------------------------");

    String ret = "-1";
    if (SMSRecvUtil.insertSMSRecv(time, caller, msg, ucNum)) {
      ret = "0";
    }
    return ret;
  }
}