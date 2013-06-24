// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   TQueryClientReq.java

package com.sms.cpa;

import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class TQueryClientReq extends CParam
    implements Serializable
{

    public TQueryClientReq(String sUser)
    {
        super((byte)21, sUser);
    }

    public TQueryClientReq(byte b[])
        throws Exception
    {
        super(b);
        if(super.bCommand != 21)
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
    }

    protected void makeBody()
    {
        super.body = null;
    }

    public static final byte CMD = 21;

}
