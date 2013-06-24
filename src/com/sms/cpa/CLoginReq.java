// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CLoginReq.java

package com.sms.cpa;

import com.sms.pub.Tools;
import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CLoginReq extends CParam
    implements Serializable
{

    public CLoginReq(String sUser, String sPass)
    {
        super((byte)1, sUser);
        sPasswd = "";
        sMethod = "";
        iType = 2;
        sPasswd = sPass;
    }

    public CLoginReq(byte b[])
        throws Exception
    {
        super(b);
        sPasswd = "";
        sMethod = "";
        iType = 2;
        if(super.bCommand != 1)
        {
            throw new Exception("Invalid command!");
        } else
        {
            init();
            return;
        }
    }

    public void setMethod(String sMo)
    {
        sMethod = sMo;
    }

    public String getMethod()
    {
        return sMethod;
    }

    protected void init()
    {
        byte b[] = super.body;
        sPasswd = Tools.b2s(b, 0, 8, (byte)32);
        sMethod = Tools.b2s(b, 8, 8, (byte)32);
        iType = Tools.b2i(b, 16, 1);
        sAgentList = Tools.b2s(b, 17, 100, (byte)32);
    }

    protected void makeBody()
    {
        super.body = new byte[117];
        Tools.s2b(sPasswd, super.body, 0, 8, (byte)32);
        Tools.s2b(sMethod, super.body, 8, 8, (byte)32);
        Tools.i2b(iType, super.body, 16, 1);
        Tools.s2b(sAgentList, super.body, 17, 100, (byte)32);
    }

    public static final byte CMD = 1;
    public static final byte BODY_LEN = 117;
    public String sPasswd;
    public String sMethod;
    public int iType;
    public String sAgentList;

}
