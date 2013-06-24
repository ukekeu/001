// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CAgentRet.java

package com.sms.cpa;

import com.sms.pub.Tools;
import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CAgentRet extends CParam
    implements Serializable
{

    public CAgentRet(String sUser)
    {
        super((byte)-119, sUser);
        iNumAgent = 0;
        sAgent = null;
    }

    public void setAgent(String s[])
    {
        iNumAgent = 0;
        if(s == null)
        {
            sAgent = null;
        } else
        {
            iNumAgent = s.length;
            sAgent = new String[s.length];
            for(int i = 0; i < s.length; i++)
                sAgent[i] = s[i];

        }
    }

    public int getAgentNum()
    {
        return iNumAgent;
    }

    public CAgentRet(byte b[])
        throws Exception
    {
        super(b);
        iNumAgent = 0;
        sAgent = null;
        if(super.bCommand != -119)
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
        int iNum = Tools.b2i(b, 0, 4);
        if(iNum < 1)
        {
            sAgent = null;
            iNumAgent = 0;
        } else
        {
            iNumAgent = iNum;
            sAgent = new String[iNum];
            for(int i = 0; i < iNum; i++)
                sAgent[i] = Tools.b2s(b, 4 + i * 6, 6, (byte)32);

        }
    }

    protected void makeBody()
    {
        super.body = null;
        int iNum = 0;
        if(sAgent != null)
            iNum = sAgent.length;
        super.body = new byte[4 + iNum * 10];
        Tools.i2b(iNum, super.body, 0, 4);
        for(int i = 0; i < iNum; i++)
            Tools.s2b(sAgent[i], super.body, 4 + i * 6, 6, (byte)32);

    }

    public String toString()
    {
        String s = String.valueOf(String.valueOf((new StringBuffer("NumAgent:")).append(iNumAgent).append(",List:")));
        if(sAgent != null)
        {
            for(int i = 0; i < sAgent.length; i++)
                s = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(s)))).append(sAgent[i]).append(",")));

        } else
        {
            s = String.valueOf(String.valueOf(s)).concat("null");
        }
        return s;
    }

    public static final byte CMD = -119;
    public int iNumAgent;
    public String sAgent[];

}
