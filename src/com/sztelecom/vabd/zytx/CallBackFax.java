package com.sztelecom.vabd.zytx;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CallBackFax
{
  private static Logger log = LoggerFactory.getLogger(CallBackFax.class);

  public void NotifyStatus(int eventID, String sessionID, int res, String para1)
  {
    log.info("-------------------into NotifyStatus-----------------");
    log.info("eventID=" + eventID);
    log.info("sessionID=" + sessionID);
    log.info("res=" + res);
    log.info("para1=" + para1);
    log
      .info("-------------------end of NotifyStatus------------------------------");
  }

  public String EchoOfSendFax(String res, String callerNum, String calleeNum, int faxId, String uploadURL)
  {
    log.info("-------------------into EchoOfSendFax-----------------");
    log.info("res=" + res);
    log.info("callerNum=" + callerNum);
    log.info("calleeNum=" + calleeNum);
    log.info("faxId=" + faxId);
    log.info("uploadURL=" + uploadURL);
    log
      .info("-------------------end of EchoOfSendFax------------------------------");

    String ret = "-1";

    ret = "0";

    return ret;
  }

  public void RecvFaxEndNotify(int eventID, int res, String callerNum, String calleeNum, String downUrl, String faxFileName)
  {
    log.info("-------------------into RecvFaxEndNotify-----------------");
    log.info("eventID=" + eventID);
    log.info("res=" + res);
    log.info("callerNum=" + callerNum);
    log.info("calleeNum=" + calleeNum);
    log.info("downUrl=" + downUrl);
    log.info("faxFileName=" + faxFileName);
    log
      .info("-------------------end of RecvFaxEndNotify------------------------------");
  }
}