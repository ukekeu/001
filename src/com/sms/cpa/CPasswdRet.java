// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CPasswdRet.java

package com.sms.cpa;

import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CPasswdRet extends CParam
    implements Serializable
{

    public CPasswdRet(String sUser)
    {
        super((byte)-112, sUser);
    }

    public CPasswdRet(byte b[])
        throws Exception
    {
        super(b);
        if(super.bCommand != -112)
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
        bStatus = b[0];
    }

    protected void makeBody()
    {
        super.body = new byte[1];
        super.body[0] = bStatus;
    }

    public String toString()
    {
        return "status=".concat(String.valueOf(String.valueOf(bStatus)));
    }

    public static final byte CMD = -112;
    public byte bStatus;

}
