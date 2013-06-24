// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CMoRet.java

package com.sms.cpa;

import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CMoRet extends CParam
    implements Serializable
{

    public CMoRet(String sUser, byte st)
    {
        super((byte)-123, sUser);
        bStatus = st;
    }

    public CMoRet(byte b[])
        throws Exception
    {
        super(b);
        if(super.bCommand != -123)
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

    public static final byte CMD = -123;
    public byte bStatus;

}
