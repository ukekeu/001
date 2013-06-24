// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CMoReq.java

package com.sms.cpa;

import com.sms.pub.Tools;
import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CMoReq extends CParam
    implements Serializable
{

    public CMoReq(String sUser, String sAgnt)
    {
        super((byte)5, sUser);
        sRid = null;
        sAgent = sAgnt;
    }

    public void setMessage(String sId, String sWork, byte bFmt, byte bMsg[])
    {
        sMoid = sId;
        sService = sWork;
        bFormat = bFmt;
        if(bMsg == null)
        {
            iLength = 0;
            bMessage = null;
        } else
        {
            iLength = bMsg.length;
            bMessage = new byte[iLength];
            System.arraycopy(bMsg, 0, bMessage, 0, iLength);
        }
    }

    public void setInfo(String sTs, String sTr, String sFr, String sTo)
    {
        sTimeSend = sTs;
        sTimeLand = sTr;
        sFrom = sFr;
        sTarget = sTo;
    }

    public CMoReq(byte b[])
        throws Exception
    {
        super(b);
        sRid = null;
        if(super.bCommand != 5)
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
        sMoid = Tools.b2s(b, 6, 10, (byte)32);
        sTimeSend = Tools.b2s(b, 16, 14, (byte)32);
        sTimeLand = Tools.b2s(b, 30, 14, (byte)32);
        sFrom = Tools.b2s(b, 44, 21, (byte)32);
        sTarget = Tools.b2s(b, 65, 21, (byte)32);
        sService = Tools.b2s(b, 86, 10, (byte)32);
        bFormat = b[96];
        iLength = Tools.b2i(b, 97, 4);
        if(iLength < 1)
        {
            bMessage = null;
        } else
        {
            bMessage = new byte[iLength];
            System.arraycopy(b, 101, bMessage, 0, iLength);
        }
    }

    protected void makeBody()
    {
        super.body = new byte[101 + iLength];
        Tools.s2b(sAgent, super.body, 0, 6, (byte)32);
        Tools.s2b(sMoid, super.body, 6, 10, (byte)32);
        Tools.s2b(sTimeSend, super.body, 16, 14, (byte)32);
        Tools.s2b(sTimeLand, super.body, 30, 14, (byte)32);
        Tools.s2b(sFrom, super.body, 44, 21, (byte)32);
        Tools.s2b(sTarget, super.body, 65, 21, (byte)32);
        Tools.s2b(sService, super.body, 86, 10, (byte)32);
        super.body[96] = bFormat;
        Tools.i2b(iLength, super.body, 97, 4);
        Tools.addb(bMessage, super.body, 101, iLength, (byte)0);
    }

    public String toString()
    {
        String sTmp = null;
        try
        {
            sTmp = new String(bMessage);
        }
        catch(Exception exception) { }
        if(sTmp == null)
            sTmp = String.valueOf(String.valueOf((new StringBuffer("{Len=")).append(iLength).append(",Data=").append(bMessage).append("}")));
        String s = String.valueOf(String.valueOf((new StringBuffer("\r\nAgent:")).append(sAgent).append("'").append("\r\n From:").append(sFrom).append("'").append("\r\n   To:").append(sTarget).append("'").append("\r\n  Msg:").append(sTmp)));
        return s;
    }

    public static final byte CMD = 5;
    public String sAgent;
    public String sMoid;
    public String sTimeSend;
    public String sTimeLand;
    public String sFrom;
    public String sTarget;
    public String sService;
    public byte bFormat;
    public int iLength;
    public byte bMessage[];
    public String sRid;

}
