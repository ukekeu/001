// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CSendReq.java

package com.sms.cpa;

import com.sms.pub.Tools;
import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CSendReq extends CParam
    implements Serializable
{

    public CSendReq(String tUser, String tFrom, String tTo, int tReport)
    {
        super((byte)4, tUser);
        iErrorCode = 1;
        sErrorCode = "";
        sAgent = "";
        sFrom = "";
        sTarget = "";
        iReport = 0;
        bFeeUser = 0;
        sFeePhone = "";
        sFeeType = "";
        sService = "";
        sMoid = "";
        sAgent = "";
        sFrom = tFrom;
        sTarget = tTo;
        iReport = tReport;
        iErrorCode = 1;
        sErrorCode = "\u53C2\u6570\u672A\u8FDB\u884C\u9A8C\u8BC1";
    }

    public CSendReq(String tUser)
    {
        super((byte)4, tUser);
        iErrorCode = 1;
        sErrorCode = "";
        sAgent = "";
        sFrom = "";
        sTarget = "";
        iReport = 0;
        bFeeUser = 0;
        sFeePhone = "";
        sFeeType = "";
        sService = "";
        sMoid = "";
        sAgent = "";
        iErrorCode = 1;
        sErrorCode = "\u53C2\u6570\u672A\u8FDB\u884C\u9A8C\u8BC1";
    }

    public void setParament(byte tFeeUser, String tService, String tFeePhone, String tFeeType, int tFee, byte tFormat)
    {
        if(tFeeType == "01")
        {
            sFeeType = tFeeType;
            bFeeUser = 0;
            iFee = 0;
            sFeePhone = "";
            sService = tService;
        } else
        if(tFeeType == "02" || tFeeType == "03")
        {
            sFeeType = tFeeType;
            bFeeUser = tFeeUser;
            if(bFeeUser == 2)
            {
                iErrorCode = 2;
                sErrorCode = "\u53C2\u6570[sFeeUser]\u6709\u8BEF.";
                return;
            }
            sFeePhone = tFeePhone;
            iFee = tFee;
            sService = tService;
        } else
        {
            iErrorCode = 3;
            sErrorCode = "\u63A5\u53E3\u4FDD\u7559,tFeeType!=01/02/03";
            return;
        }
        bFormat = tFormat;
        iErrorCode = 0;
        sErrorCode = "\u53C2\u6570\u6B63\u786E.";
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
        sMoid = sOm;
    }

    public void setAddress(String s1, String s2)
    {
        sFrom = s1;
        sTarget = s2;
    }

    public void setFee(int iPay, String sCode, int iValue)
    {
        bFeeUser = (byte)iPay;
        sFeeType = sCode;
        iFee = iValue;
    }

    public CSendReq(byte b[])
        throws Exception
    {
        super(b);
        iErrorCode = 1;
        sErrorCode = "";
        sAgent = "";
        sFrom = "";
        sTarget = "";
        iReport = 0;
        bFeeUser = 0;
        sFeePhone = "";
        sFeeType = "";
        sService = "";
        sMoid = "";
        if(super.bCommand != 4)
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
        sMoid = Tools.b2s(b, 91, 10, (byte)32);
        iLength = Tools.b2i(b, 101, 4);
        if(iLength > 0)
        {
            bMessage = new byte[iLength];
            System.arraycopy(b, 105, bMessage, 0, iLength);
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
        int iLen = 105 + iLength;
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
        Tools.s2b(sMoid, super.body, 91, 10, (byte)32);
        Tools.i2b(iLength, super.body, 101, 4);
        Tools.addb(bMessage, super.body, 105, iLength, (byte)0);
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
        String s = String.valueOf(String.valueOf((new StringBuffer("To:")).append(sTarget).append(",From:").append(sFrom).append("\r\n Msg:").append(sTmp)));
        return s;
    }

    public static final byte CMD = 4;
    public int iErrorCode;
    public String sErrorCode;
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
    public String sMoid;
    public int iLength;
    public byte bMessage[];

}
