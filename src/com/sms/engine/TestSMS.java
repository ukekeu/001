// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   TestSMS.java

package com.sms.engine;

import java.io.PrintStream;

// Referenced classes of package com.sms.engine:
//            SMSEngine

public class TestSMS
{

    public TestSMS()
    {
    }

    public String mt()
    {
        try
        {
            SMSEngine smsengine = new SMSEngine("61.144.211.194", 6688, "bjsoft", "666666");
            if(smsengine.CmdLoginReq() != 0)
            {
                String s = "\u5931\u8D25";
                return s;
            }
            smsengine.setFromNum("");
            smsengine.setToNum("13798375094");
            smsengine.addToNum("13600000000");
            smsengine.setText("\u63A5\u53E3\u6D4B\u8BD5");
            if(smsengine.send() == 1)
                System.out.println("--send ok--");
            smsengine.timerSend("13100000000", "\u5B9A\u65F6\u6D4B\u8BD5", "2003-11-20 08:02:03");
            smsengine.CancelTimer("13100000000", "\u5B9A\u65F6\u6D4B\u8BD5", "2003-11-20 08:02:03");
            smsengine.CmdLogoutReq();
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        finally { }
        return "ok";
    }
}
