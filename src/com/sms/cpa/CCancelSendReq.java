// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CCancelSendReq.java

package com.sms.cpa;

import com.sms.pub.Tools;
import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CCancelSendReq extends CParam
    implements Serializable
{

    public CCancelSendReq(String sUser)
    {
        super((byte)19, sUser);
        sPhone = "";
        sPredate = "";
        sContent = "";
    }

    public CCancelSendReq(byte b[])
        throws Exception
    {
        super(b);
        sPhone = "";
        sPredate = "";
        sContent = "";
        if(super.bCommand != 19)
        {
            throw new Exception("Invalid command!");
        } else
        {
            init();
            return;
        }
    }

    protected void init()
    {
        byte b[] = super.body;
        sPhone = Tools.b2s(b, 0, 21, (byte)32);
        sPredate = Tools.b2s(b, 21, 20, (byte)32);
        sContent = Tools.b2s(b, 41, 18, (byte)32);
    }

    protected void makeBody()
    {
        super.body = new byte[59];
        Tools.s2b(sPhone, super.body, 0, 21, (byte)32);
        Tools.s2b(sPredate, super.body, 21, 20, (byte)32);
        Tools.s2b(sContent, super.body, 41, 18, (byte)32);
    }

    public static final byte CMD = 19;
    public static final byte BODY_LEN = 59;
    public String sPhone;
    public String sPredate;
    public String sContent;

}
