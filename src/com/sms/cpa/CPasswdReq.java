// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CPasswdReq.java

package com.sms.cpa;

import com.sms.pub.Tools;
import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CPasswdReq extends CParam
    implements Serializable
{

    public CPasswdReq(String sUser)
    {
        super((byte)16, sUser);
        sPasswd0 = "";
        sPasswd1 = "";
    }

    public CPasswdReq(byte b[])
        throws Exception
    {
        super(b);
        sPasswd0 = "";
        sPasswd1 = "";
        if(super.bCommand != 16)
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
        sPasswd0 = Tools.b2s(b, 0, 8, (byte)32);
        sPasswd1 = Tools.b2s(b, 8, 8, (byte)32);
    }

    protected void makeBody()
    {
        super.body = new byte[16];
        Tools.s2b(sPasswd0, super.body, 0, 8, (byte)32);
        Tools.s2b(sPasswd1, super.body, 8, 8, (byte)32);
    }

    public static final byte CMD = 16;
    public static final byte BODY_LEN = 16;
    public String sPasswd0;
    public String sPasswd1;

}
