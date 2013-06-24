// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CLogoutRet.java

package com.sms.cpa;

import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CLogoutRet extends CParam
    implements Serializable
{

    public CLogoutRet(String sUser, byte bs)
    {
        super((byte)-126, sUser);
        status = -1;
        status = bs;
    }

    public CLogoutRet(byte b[])
        throws Exception
    {
        super(b);
        status = -1;
        if(super.bCommand != -126)
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
        status = b[0];
    }

    protected void makeBody()
    {
        super.body = new byte[1];
        super.body[0] = status;
    }

    public static final byte CMD = -126;
    public byte status;

}
