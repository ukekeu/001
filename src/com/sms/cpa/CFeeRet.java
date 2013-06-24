// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CFeeRet.java

package com.sms.cpa;

import com.sms.pub.Tools;
import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CFeeRet extends CParam
    implements Serializable
{

    public CFeeRet(String sUser, byte bs)
    {
        super((byte)-120, sUser);
        iNumRec = 0;
        sCode = null;
        sNum = null;
        bStatus = bs;
    }

    public void setInfo(String sN1, String sc[], String sd[])
    {
        sFeeLeft = sN1;
        if(sc == null || sd == null || sc.length != sd.length)
        {
            iNumRec = 0;
            return;
        }
        iNumRec = sc.length;
        sCode = new String[iNumRec];
        sNum = new String[iNumRec];
        for(int i = 0; i < iNumRec; i++)
        {
            sCode[i] = sc[i];
            sNum[i] = sd[i];
        }

    }

    public CFeeRet(byte b[])
        throws Exception
    {
        super(b);
        iNumRec = 0;
        sCode = null;
        sNum = null;
        if(super.bCommand != -120)
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
        sFeeLeft = Tools.b2s(b, 1, 10, (byte)32);
        sFee = Tools.b2s(b, 11, 6, (byte)32);
        iNumRec = Tools.b2i(b, 17, 4);
        if(iNumRec < 1 || iNumRec > 100)
        {
            sCode = null;
            sNum = null;
            return;
        }
        sCode = new String[iNumRec];
        sNum = new String[iNumRec];
        int iFrom = 21;
        for(int i = 0; i < iNumRec; i++)
        {
            sCode[i] = Tools.b2s(b, iFrom, 2, (byte)32);
            sNum[i] = Tools.b2s(b, iFrom + 2, 10, (byte)32);
            iFrom += 12;
        }

    }

    protected void makeBody()
    {
        super.body = new byte[21 + 12 * iNumRec];
        super.body[0] = bStatus;
        Tools.s2b(sFeeLeft, super.body, 1, 10, (byte)32);
        Tools.s2b(sFee, super.body, 11, 6, (byte)32);
        Tools.i2b(iNumRec, super.body, 17, 4);
        if(iNumRec < 1)
            return;
        int iFrom = 21;
        for(int i = 0; i < iNumRec; i++)
        {
            Tools.s2b(sCode[i], super.body, iFrom, 2, (byte)32);
            Tools.s2b(sNum[i], super.body, iFrom + 2, 10, (byte)32);
            iFrom += 12;
        }

    }

    public String toString()
    {
        return String.valueOf(String.valueOf((new StringBuffer("User=")).append(super.sUserID).append(",FeeLeft=").append(sFeeLeft).append(",Fee=").append(sFee)));
    }

    public static final byte CMD = -120;
    public byte bStatus;
    public String sFeeLeft;
    public String sFee;
    public int iNumRec;
    public String sCode[];
    public String sNum[];

}
