// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CFeeReq.java

package com.sms.cpa;

import com.sms.pub.Tools;
import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CFeeReq extends CParam
    implements Serializable
{

    public CFeeReq(String sUser, String sAgnt)
    {
        super((byte)8, sUser);
        sAgent = sAgnt;
    }

    public void setInfo(String sDf, String sDt)
    {
        sFdate = sDf;
        sTdate = sDt;
    }

    public CFeeReq(byte b[])
        throws Exception
    {
        super(b);
        if(super.bCommand != 8)
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
        sAgent = Tools.b2s(b, 0, 6, (byte)32);
        sFdate = Tools.b2s(b, 6, 8, (byte)32);
        sTdate = Tools.b2s(b, 14, 8, (byte)32);
    }

    protected void makeBody()
    {
        super.body = new byte[22];
        Tools.s2b(sAgent, super.body, 0, 6, (byte)32);
        Tools.s2b(sFdate, super.body, 6, 8, (byte)32);
        Tools.s2b(sTdate, super.body, 14, 8, (byte)32);
    }

    public static final byte CMD = 8;
    public String sAgent;
    public String sFdate;
    public String sTdate;

}
