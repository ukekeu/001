// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CSendClusterReq.java

package com.sms.cpa;

import com.sms.pub.Tools;
import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CSendClusterReq extends CParam
    implements Serializable
{

    public CSendClusterReq(String tUser, String tFrom, int tReport)
    {
        super((byte)17, tUser);
        iErrorCode = 1;
        sErrorCode = "";
        sAgent = "";
        sFrom = "";
        iTarget = 0;
        gTarget = null;
        iReport = 0;
        bFeeUser = 0;
        sFeePhone = "";
        sFeeType = "";
        sService = "";
        sMoid = "";
        sAgent = "";
        sFrom = tFrom;
        iReport = tReport;
        iErrorCode = 1;
        sErrorCode = "\u53C2\u6570\u672A\u8FDB\u884C\u9A8C\u8BC1";
    }

    public CSendClusterReq(String tUser)
    {
        super((byte)17, tUser);
        iErrorCode = 1;
        sErrorCode = "";
        sAgent = "";
        sFrom = "";
        iTarget = 0;
        gTarget = null;
        iReport = 0;
        bFeeUser = 0;
        sFeePhone = "";
        sFeeType = "";
        sService = "";
        sMoid = "";
        gTarget = new String[100];
        sAgent = "";
        iErrorCode = 1;
        sErrorCode = "\u53C2\u6570\u672A\u8FDB\u884C\u9A8C\u8BC1";
    }

    public void SetTarget(int tnTarget, String tTarget[])
    {
        iTarget = tnTarget;
        if(iTarget < 1 || iTarget > 101)
        {
            iErrorCode = 2;
            sErrorCode = "\u53C2\u6570(iTarget<1)||(iTarget>101)\u6709\u8BEF.";
            return;
        }
        if(gTarget == null)
            gTarget = new String[iTarget];
        for(int i = 0; i < iTarget; i++)
            gTarget[i] = tTarget[i];

    }

    public void setParament(byte tFeeUser, String tService, String tFeePhone, String tFeeType, int tFee, byte tFormat)
    {
        if(tFeeType == "01")
        {
            sFeeType = tFeeType;
            bFeeUser = 0;
            iFee = 0;
            sService = "SURGESMS";
            sFeePhone = "0";
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

    public void setFee(int iPay, String sCode, int iValue)
    {
        bFeeUser = (byte)iPay;
        sFeeType = sCode;
        iFee = iValue;
    }

    public CSendClusterReq(byte b[])
        throws Exception
    {
        super(b);
        iErrorCode = 1;
        sErrorCode = "";
        sAgent = "";
        sFrom = "";
        iTarget = 0;
        gTarget = null;
        iReport = 0;
        bFeeUser = 0;
        sFeePhone = "";
        sFeeType = "";
        sService = "";
        sMoid = "";
        if(super.bCommand != 17)
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
        int iCurid = 0;
        byte b[] = super.body;
        sAgent = Tools.b2s(b, 0, 6, (byte)32);
        sFrom = Tools.b2s(b, 6, 21, (byte)32);
        iTarget = Tools.b2i(b, 27, 1);
        iCurid = 28;
        if(iTarget > 0)
        {
            gTarget = new String[iTarget];
            for(int i = 0; i < iTarget; i++)
                gTarget[i] = Tools.b2s(b, 28 + 21 * i, 21, (byte)32);

            iCurid = 28 + 21 * iTarget;
        } else
        if(iTarget == 0)
        {
            gTarget = new String[1];
            gTarget[0] = Tools.b2s(b, 28, 21, (byte)32);
            iCurid = 49;
        }
        bFeeUser = b[iCurid];
        sFeePhone = Tools.b2s(b, iCurid + 1, 21, (byte)32);
        sService = Tools.b2s(b, iCurid + 22, 10, (byte)32);
        sFeeType = Tools.b2s(b, iCurid + 32, 6, (byte)32);
        iFee = Tools.b2i(b, iCurid + 38, 4);
        bFormat = b[iCurid + 42];
        sMoid = Tools.b2s(b, iCurid + 43, 10, (byte)32);
        iLength = Tools.b2i(b, iCurid + 53, 4);
        if(iLength > 0)
        {
            bMessage = new byte[iLength];
            System.arraycopy(b, iCurid + 57, bMessage, 0, iLength);
        }
    }

    protected void makeBody()
    {
        int iLen = 0;
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
        if(iTarget == 0)
            iLen = 106 + iLength;
        else
        if(iTarget > 0)
            iLen = 85 + iLength + 21 * iTarget;
        super.body = new byte[iLen];
        Tools.s2b(sAgent, super.body, 0, 6, (byte)32);
        Tools.s2b(sFrom, super.body, 6, 21, (byte)32);
        int iCurid = 28;
        if(iTarget > 0)
        {
            if(gTarget.length < iTarget)
            {
                iTarget = gTarget.length;
                Tools.i2b(iTarget, super.body, 27, 1);
            } else
            {
                Tools.i2b(iTarget, super.body, 27, 1);
            }
            for(int i = 0; i < iTarget; i++)
                Tools.s2b(gTarget[i], super.body, 28 + 21 * i, 21, (byte)32);

            iCurid = 28 + 21 * iTarget;
        } else
        if(iTarget == 0)
        {
            Tools.i2b(iTarget, super.body, 27, 1);
            Tools.s2b(gTarget[0], super.body, 28, 21, (byte)32);
            iCurid = 49;
        }
        super.body[iCurid] = bFeeUser;
        Tools.s2b(sFeePhone, super.body, iCurid + 1, 21, (byte)32);
        Tools.s2b(sService, super.body, iCurid + 22, 10, (byte)32);
        Tools.s2b(sFeeType, super.body, iCurid + 32, 6, (byte)32);
        Tools.i2b(iFee, super.body, iCurid + 38, 4);
        super.body[iCurid + 42] = bFormat;
        Tools.s2b(sMoid, super.body, iCurid + 43, 10, (byte)32);
        Tools.i2b(iLength, super.body, iCurid + 53, 4);
        Tools.addb(bMessage, super.body, iCurid + 57, iLength, (byte)0);
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
        return String.valueOf(String.valueOf((new StringBuffer("\r\n Route:")).append(sAgent).append(",From:").append(sFrom).append(",Msg:").append(sTmp)));
    }

    public static final byte CMD = 17;
    public int iErrorCode;
    public String sErrorCode;
    public String sAgent;
    public String sFrom;
    public int iTarget;
    public String gTarget[];
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
