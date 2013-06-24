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
import sun.misc.BASE64Encoder;

public class SMSHelper
{
  private static Logger log = Logger.getLogger(SMSHelper.class.getName());

  public static String SendSMS(String[] mobileNum, int msgId, String msg) {
    Service service = new Service();

    String ret = "-1";
    String uc = Const.HWWebServiceUser;
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

      call.addParameter("uc", XMLType.XSD_STRING, ParameterMode.IN);
      call.addParameter("pw", XMLType.XSD_STRING, ParameterMode.IN);
      call.addParameter("rand", XMLType.XSD_STRING, ParameterMode.IN);
      call.addParameter("callee", XMLType.XSD_ANYTYPE, ParameterMode.IN);
      call.addParameter("isreturn", XMLType.XSD_STRING, ParameterMode.IN);
      call.addParameter("cont", XMLType.XSD_STRING, ParameterMode.IN);
      call.addParameter("msgid", XMLType.XSD_INTEGER, ParameterMode.IN);
      call.addParameter("connID", XMLType.XSD_STRING, ParameterMode.IN);
      call.setReturnType(XMLType.XSD_STRING);

      call.getMessageContext().setUsername("test");
      call.getMessageContext().setPassword("test");

      msg = 
        new BASE64Encoder().encode(msg.getBytes("gb2312"));
      log.info("msg:" + msg);

      log.info("MSGID:" + msgId);

      ret = (String)call.invoke(new Object[] { uc, pw, rand, 
        mobileNum, "1", msg, Integer.valueOf(msgId), connId });

      log.info("status:" + ret);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return ret;
  }
}