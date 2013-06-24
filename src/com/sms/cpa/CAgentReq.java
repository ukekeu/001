// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CAgentReq.java

package com.sms.cpa;

import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CAgentReq extends CParam
    implements Serializable
{

    public CAgentReq(String sUser)
    {
        super((byte)9, sUser);
    }

    public CAgentReq(byte b[])
        throws Exception
    {
        super(b);
        if(super.bCommand != 9)
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

    public static final byte CMD = 9;

}
