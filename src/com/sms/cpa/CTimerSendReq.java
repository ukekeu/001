// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CTimerSendReq.java

package com.sms.cpa;

import com.sms.pub.Tools;
import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CTimerSendReq extends CParam
    implements Serializable
{

    public CTimerSendReq(String tUser, String tFrom, String tTo, int tReport)
    {
        super((byte)18, tUser);
        sAgent = "";
        sFrom = "";
        sTarget = "";
        iReport = 0;
        bFeeUser = 0;
        sFeePhone = "";
        sFeeType = "";
        sService = "";
        predate = "";
        sAgent = "";
        sFrom = tFrom;
        sTarget = tTo;
        iReport = tReport;
    }

    public CTimerSendReq(String tUser)
    {
        super((byte)18, tUser);
        sAgent = "";
        sFrom = "";
        sTarget = "";
        iReport = 0;
        bFeeUser = 0;
        sFeePhone = "";
        sFeeType = "";
        sService = "";
        predate = "";
        sAgent = "";
    }

    public void setParament(byte tFeeUser, String tService, String tFeePhone, String tFeeType, int tFee, byte tFormat)
    {
        sFeeType = tFeeType;
        bFeeUser = tFeeUser;
        sFeePhone = tFeePhone;
        iFee = tFee;
        sService = tService;
        bFormat = tFormat;
    }

    public void setMessage(byte bFmt, byte bData[], String sOm)
    {
        bFormat = bFmt;
        if(bData != null)
        {
            iLength = bData.length;
            bMessage = bData;
        } else
        {
            bData = null;
            iLength = 0;
        }
    }

    public void setAddress(String s1, String s2)
    {
        sFrom = s1;
        sTarget = s2;
    }

    public void setTimer(String s1)
    {
        predate = s1;
    }

    public void setFee(int iPay, String sCode, int iValue)
    {
        bFeeUser = (byte)iPay;
        sFeeType = sCode;
        iFee = iValue;
    }

    public CTimerSendReq(byte b[])
        throws Exception
    {
        super(b);
        sAgent = "";
        sFrom = "";
        sTarget = "";
        iReport = 0;
        bFeeUser = 0;
        sFeePhone = "";
        sFeeType = "";
        sService = "";
        predate = "";
        if(super.bCommand != 18)
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
        sFrom = Tools.b2s(b, 6, 21, (byte)32);
        sTarget = Tools.b2s(b, 27, 21, (byte)32);
        bFeeUser = b[48];
        sFeePhone = Tools.b2s(b, 49, 21, (byte)32);
        sService = Tools.b2s(b, 70, 10, (byte)32);
        sFeeType = Tools.b2s(b, 80, 6, (byte)32);
        iFee = Tools.b2i(b, 86, 4);
        bFormat = b[90];
        predate = Tools.b2s(b, 91, 20, (byte)32);
        iLength = Tools.b2i(b, 111, 4);
        if(iLength > 0)
        {
            bMessage = new byte[iLength];
            System.arraycopy(b, 115, bMessage, 0, iLength);
        }
    }

    protected void makeBody()
    {
        if(bMessage == null)
            iLength = 0;
        else
            iLength = bMessage.length;
        if(sFrom == null)
            sFrom = "";
        if(sAgent == null)
            sAgent = "";
        if(sService == null)
            sService = "SURGESMS";
        int iLen = 115 + iLength;
        super.body = new byte[iLen];
        Tools.s2b(sAgent, super.body, 0, 6, (byte)32);
        Tools.s2b(sFrom, super.body, 6, 21, (byte)32);
        Tools.s2b(sTarget, super.body, 27, 21, (byte)32);
        super.body[48] = bFeeUser;
        Tools.s2b(sFeePhone, super.body, 49, 21, (byte)32);
        Tools.s2b(sService, super.body, 70, 10, (byte)32);
        Tools.s2b(sFeeType, super.body, 80, 6, (byte)32);
        Tools.i2b(iFee, super.body, 86, 4);
        super.body[90] = bFormat;
        Tools.s2b(predate, super.body, 91, 20, (byte)32);
        Tools.i2b(iLength, super.body, 111, 4);
        Tools.addb(bMessage, super.body, 115, iLength, (byte)0);
    }

    public String toString()
    {
        String sTmp = null;
        try
        {
            sTmp = new String(bMessage);
            if(sTmp == null)
                sTmp = String.valueOf(String.valueOf((new StringBuffer("{Len=")).append(iLength).append(",Data=").append(bMessage).append("}")));
            String s = String.valueOf(String.valueOf((new StringBuffer("To:")).append(sTarget).append(",From:").append(sFrom).append("\r\n Msg:").append(sTmp)));
            return s;
        }
        catch(Exception e)
        {
            String s1 = "";
            return s1;
        }
    }

    public static final byte CMD = 18;
    public String sAgent;
    public String sFrom;
    public String sTarget;
    public int iReport;
    public byte bFeeUser;
    public String sFeePhone;
    public String sFeeType;
    public int iFee;
    public String sService;
    public byte bFormat;
    public String predate;
    public int iLength;
    public byte bMessage[];

}
