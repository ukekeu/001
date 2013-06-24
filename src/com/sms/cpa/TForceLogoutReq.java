// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   TForceLogoutReq.java

package com.sms.cpa;

import com.sms.pub.Tools;
import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class TForceLogoutReq extends CParam
    implements Serializable
{

    public TForceLogoutReq(String sUser)
    {
        super((byte)22, sUser);
        logoutClientid = "";
    }

    public TForceLogoutReq(byte b[])
        throws Exception
    {
        super(b);
        logoutClientid = "";
        if(super.bCommand != 22)
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
        logoutClientid = Tools.b2s(b, 0, 8, (byte)32);
        logoutClientid.trim();
    }

    protected void makeBody()
    {
        super.body = new byte[8];
        Tools.s2b(logoutClientid, super.body, 0, 8, (byte)32);
    }

    public static final byte CMD = 22;
    public static final byte BODY_LEN = 8;
    public String logoutClientid;

}
