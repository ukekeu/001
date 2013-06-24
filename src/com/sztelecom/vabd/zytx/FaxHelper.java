package com.sztelecom.vabd.zytx;

import com.sztelecom.vabd.zytx.common.Const;
import com.sztelecom.vabd.zytx.common.util.Md5;
import java.net.URL;
import javax.xml.rpc.ParameterMode;
import org.apache.axis.MessageContext;
import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.axis.encoding.XMLType;
import org.apache.log4j.Logger;

public class FaxHelper
{
  private static Logger log = Logger.getLogger(FaxHelper.class.getName());

  public static SendFaxRets SendFax(String desAddr, int fileSize) {
    Service service = new Service();

    String ret = "-1";
    String uc = Const.HWWebServiceUser;
    SendFaxRets rets = null;
    try
    {
      Call call = (Call)service.createCall();
      call.setTargetEndpointAddress(Const.HWWebServiceRegisterURL);
      call.setOperationName("getRandom");
      call.setReturnType(XMLType.XSD_STRING);
      call.getMessageContext().setUsername("test");
      call.getMessageContext().setPassword("test");

      ret = (String)call.invoke(new Object[0]);
      log.info("random=           " + ret);
      String rand = ret;
      String pw = Md5.MD5(rand + Const.HWWebServiceUserPasswd + 
        Const.HWWebServiceUserPasswd);

      call = (Call)service.createCall();
      call.setTargetEndpointAddress(new URL(
        Const.HWWebServiceRegisterURL));
      call.setOperationName("setCallBackAddr");
      call.addParameter("uc", XMLType.XSD_STRING, ParameterMode.IN);
      call.addParameter("pw", XMLType.XSD_STRING, ParameterMode.IN);
      call.addParameter("rand", XMLType.XSD_STRING, ParameterMode.IN);
      call.addParameter("url", XMLType.XSD_STRING, ParameterMode.IN);
      call.setReturnType(XMLType.XSD_STRING);
      call.getMessageContext().setUsername("test");
      call.getMessageContext().setPassword("test");
      String myUrl = Const.CallBackURL;

      ret = (String)call.invoke(new Object[] { uc, pw, rand, 
        myUrl });
      log.info("connId:" + ret);
      String connId = ret;

      call = (Call)service.createCall();
      call.setTargetEndpointAddress(Const.HWWebServiceRegisterURL);
      call.setOperationName("getRandom");
      call.setReturnType(XMLType.XSD_STRING);
      call.getMessageContext().setUsername("test");
      call.getMessageContext().setPassword("test");

      ret = (String)call.invoke(new Object[0]);
      log.info("random:" + ret);
      rand = ret;
      pw = Md5.MD5(rand + Const.HWWebServiceUserPasswd + 
        Const.HWWebServiceUserPasswd);

      call = (Call)service.createCall();
      call.setTargetEndpointAddress(new URL(
        Const.HWWebServiceSMSURL));
      call.setOperationName("sendSMS");

      call.addParameter("ucNumber", XMLType.XSD_STRING, ParameterMode.IN);
      call.addParameter("randStr", XMLType.XSD_STRING, ParameterMode.IN);
      call.addParameter("secInfoStr", XMLType.XSD_STRING, 
        ParameterMode.IN);
      call.addParameter("desAddr", XMLType.XSD_STRING, ParameterMode.IN);
      call.addParameter("connID", XMLType.XSD_STRING, ParameterMode.IN);
      call
        .addParameter("fileSize", XMLType.XSD_INTEGER, 
        ParameterMode.IN);
      call.setReturnType(XMLType.XSD_ANYTYPE);

      call.getMessageContext().setUsername("test");
      call.getMessageContext().setPassword("test");

      log.info("desAddr:" + desAddr);

      log.info("fileSize:" + fileSize);

      rets = (SendFaxRets)call.invoke(new Object[] { uc, rand, 
        pw, desAddr, connId, Integer.valueOf(fileSize) });

      log.info("status:" + ret);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return rets;
  }

  public String[] FindFaxFile() {
    return new String[0];
  }

  public boolean DownloadFax() {
    boolean ret = false;

    return ret;
  }
  public class SendFaxRets {
    private String m_res;
    private String m_authCode;
    private String m_unNumber;

    public SendFaxRets() {
    }
    public String getAuthCode() { return this.m_authCode; }

    public void setAuthCode(String authCode)
    {
      this.m_authCode = authCode;
    }

    public String getRes()
    {
      return this.m_res;
    }

    public void setRes(String res) {
      this.m_res = res;
    }

    public String getUnNumber() {
      return this.m_unNumber;
    }

    public void setUnNumber(String unNumber) {
      this.m_unNumber = unNumber;
    }
  }
}