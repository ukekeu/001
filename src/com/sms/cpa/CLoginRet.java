// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CLoginRet.java

package com.sms.cpa;

import com.sms.pub.Tools;
import java.io.Serializable;

// Referenced classes of package com.sms.cpa:
//            CParam

public class CLoginRet extends CParam
    implements Serializable
{

    public CLoginRet(String sUser, byte bs)
    {
        super((byte)-127, sUser);
        bStatus = -1;
        passwd = null;
        bStatus = bs;
    }

    public void setPasswd(byte b[])
    {
        if(b != null)
        {
            passwd = new byte[b.length];
            for(int i = 0; i < b.length; i++)
                passwd[i] = b[i];

        }
    }

    public byte[] getPasswd()
    {
        return passwd;
    }

    public CLoginRet(byte b[])
        throws Exception
    {
        super(b);
        bStatus = -1;
        passwd = null;
        if(super.bCommand != -127)
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
        passwd = Tools.cutb(b, 1, 16, (byte)0);
    }

    protected void makeBody()
    {
        super.body = new byte[17];
        super.body[0] = bStatus;
        Tools.addb(passwd, super.body, 1, 16, (byte)0);
    }

    public String toString()
    {
        String s = super.toString();
        s = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(s)))).append("\r\n").append("STUS=").append(bStatus).append("\r\n")));
        if(passwd == null)
            s = String.valueOf(String.valueOf(s)).concat("Pwd=null");
        else
            s = String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(s)))).append("Pwd=").append(new String(passwd))));
        return s;
    }

    public static final byte CMD = -127;
    public byte bStatus;
    public byte passwd[];

}
