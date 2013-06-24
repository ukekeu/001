// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CLinkRet.java

package com.sms.cpa;

import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CLinkRet extends CParam
    implements Serializable
{

    public CLinkRet(String sUser)
    {
        super((byte)-125, sUser);
        bStatus = 1;
    }

    public CLinkRet(byte b[])
        throws Exception
    {
        super(b);
        bStatus = 1;
        if(super.bCommand != -125)
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
        return String.valueOf(String.valueOf((new StringBuffer("UserID=")).append(super.sUserID).append(",Link_status=").append(bStatus)));
    }

    public static final byte CMD = -125;
    public byte bStatus;

}
