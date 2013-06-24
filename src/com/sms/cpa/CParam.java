// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CParam.java

package com.sms.cpa;

import com.sms.pub.Tools;

public abstract class CParam
{

    public CParam(byte b[])
        throws Exception
    {
        iTotalLen = 0;
        bCommand = 0;
        sUserID = "";
        sSerialNo = "";
        iContentLen = 0;
        body = null;
        if(b == null || b.length < 23)
            throw new Exception("Invalid data package(1)!");
        iTotalLen = 4 + b.length;
        bCommand = b[0];
        sUserID = Tools.b2s(b, 1, 8, (byte)32);
        sSerialNo = Tools.b2s(b, 9, 10, (byte)32);
        iContentLen = Tools.b2i(b, 19, 4);
        if((iContentLen + 27) - 4 > b.length)
            throw new Exception("Invalid data package(2)!");
        if(iContentLen > 0)
        {
            body = new byte[iContentLen];
            System.arraycopy(b, 23, body, 0, iContentLen);
        }
    }

    public CParam(byte iCmd, String sUser)
    {
        iTotalLen = 0;
        bCommand = 0;
        sUserID = "";
        sSerialNo = "";
        iContentLen = 0;
        body = null;
        sUserID = sUser;
        if(sUserID == null)
            sUser = "";
        bCommand = iCmd;
    }

    public int setBody(byte b[])
    {
        body = b;
        return getTotal();
    }

    public int getTotal()
    {
        if(body == null)
            iContentLen = 0;
        else
            iContentLen = body.length;
        iTotalLen = 27 + iContentLen;
        return iTotalLen;
    }

    protected abstract void makeBody();

    public byte[] toBytes()
    {
        makeBody();
        int iLen = getTotal();
        byte b[] = new byte[iLen];
        Tools.i2b(iLen, b, 0, 4);
        b[4] = bCommand;
        Tools.s2b(sUserID, b, 5, 8, (byte)32);
        Tools.s2b(sSerialNo, b, 13, 10, (byte)32);
        Tools.i2b(iContentLen, b, 23, 4);
        if(iContentLen > 0)
            System.arraycopy(body, 0, b, 27, body.length);
        return b;
    }

    public static final int HEAD_LEN = 27;
    public int iTotalLen;
    public byte bCommand;
    public String sUserID;
    public String sSerialNo;
    public static String sTimeStamp = "";
    public int iContentLen;
    public byte body[];

}
