// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   OREException.java

package com.excenon.sms;


public class OREException extends RuntimeException
{

    public OREException(String msg)
    {
        super(msg);
    }

    public OREException(String msg, Throwable cause)
    {
        super(msg, cause);
    }

    private static final long serialVersionUID = 1L;
}
