// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CLogoutReq.java

package com.sms.cpa;

import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CLogoutReq extends CParam
    implements Serializable
{

    public CLogoutReq(String sUser)
    {
        super((byte)2, sUser);
    }

    public CLogoutReq(byte b[])
        throws Exception
    {
        super(b);
        if(super.bCommand != 2)
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

    public static final byte CLOSE = 0;
    public static final byte OPEN = 1;
    public static final byte CMD = 2;

}
