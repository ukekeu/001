// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   TQueryClientRet.java

package com.sms.cpa;

import com.sms.pub.Tools;
import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class TQueryClientRet extends CParam
    implements Serializable
{

    public TQueryClientRet(String sUser)
    {
        super((byte)-107, sUser);
        iNumClient = 0;
        sClient = null;
    }

    public TQueryClientRet(byte b[])
        throws Exception
    {
        super(b);
        iNumClient = 0;
        sClient = null;
        if(super.bCommand != -107)
        {
            throw new Exception("Invalid command!");
        } else
        {
            init();
            return;
        }
    }

    public void setClient(String s[])
    {
        iNumClient = 0;
        if(s == null)
        {
            sClient = null;
        } else
        {
            iNumClient = s.length;
            sClient = new String[s.length];
            for(int i = 0; i < s.length; i++)
                sClient[i] = s[i];

        }
    }

    public int getClientNum()
    {
        return iNumClient;
    }

    protected void init()
    {
        byte b[] = super.body;
        bStatus = super.body[0];
        int iNum = Tools.b2i(b, 1, 4);
        if(iNum < 1)
        {
            sClient = null;
            iNumClient = 0;
        } else
        {
            iNumClient = iNum;
            sClient = new String[iNum];
            for(int i = 0; i < iNum; i++)
                sClient[i] = Tools.b2s(b, 5 + i * 8, 8, (byte)32);

        }
    }

    protected void makeBody()
    {
        super.body = null;
        int iNum = 0;
        if(sClient != null)
            iNum = sClient.length;
        super.body = new byte[5 + iNum * 10];
        super.body[0] = bStatus;
        Tools.i2b(iNum, super.body, 1, 4);
        for(int i = 0; i < iNum; i++)
            Tools.s2b(sClient[i], super.body, 5 + i * 8, 8, (byte)32);

    }

    public String toString()
    {
        String s = String.valueOf(String.valueOf((new StringBuffer("Status:")).append(bStatus).append(",NumClient:").append(iNumClient).append(",List:")));
        if(sClient != null)
        {
            for(int i = 0; i < sClient.length; i++)
                s = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(s)))).append(sClient[i]).append(",")));

        } else
        {
            s = String.valueOf(String.valueOf(s)).concat("null");
        }
        return s;
    }

    public static final byte CMD = -107;
    public byte bStatus;
    public int iNumClient;
    public String sClient[];

}
