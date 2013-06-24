// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CSendClusterRet.java

package com.sms.cpa;

import com.sms.pub.Tools;
import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CSendClusterRet extends CParam
    implements Serializable
{

    public CSendClusterRet(String sUser)
    {
        super((byte)-111, sUser);
        bStatus = 0;
        sMsg = "";
    }

    public CSendClusterRet(byte b[])
        throws Exception
    {
        super(b);
        bStatus = 0;
        sMsg = "";
        if(super.bCommand != -111)
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
        sReqID = Tools.b2s(b, 0, 10, (byte)32);
        sAgent = Tools.b2s(b, 10, 6, (byte)32);
        bStatus = b[16];
        try
        {
            sMsg = new String(b, 17, b.length - 17);
        }
        catch(Exception exception) { }
    }

    protected void makeBody()
    {
        byte b[] = new byte[0];
        if(sMsg != null || sMsg.length() > 0)
            b = sMsg.getBytes();
        super.body = new byte[17 + b.length];
        Tools.s2b(sReqID, super.body, 0, 10, (byte)32);
        Tools.s2b(sAgent, super.body, 10, 6, (byte)32);
        super.body[16] = bStatus;
        for(int i = 17; i < 17 + b.length; i++)
            super.body[i] = b[i - 17];

    }

    public String toString()
    {
        return String.valueOf(String.valueOf((new StringBuffer("Status=")).append(bStatus).append(",ReqID=").append(sReqID).append(",Route:").append(sAgent).append(",Msg=").append(sMsg)));
    }

    public static final byte CMD = -111;
    public String sReqID;
    public String sAgent;
    public byte bStatus;
    public String sMsg;

}
