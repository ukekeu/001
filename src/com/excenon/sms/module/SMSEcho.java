// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   SMSEcho.java

package com.excenon.sms.module;


public class SMSEcho
{

    public SMSEcho()
    {
    }

    public String getSc_cee()
    {
        return m_sc_cee;
    }

    public void setSc_cee(String sc_cee)
    {
        m_sc_cee = sc_cee;
    }

    public int getSc_msgId()
    {
        return m_sc_msgId;
    }

    public void setSc_msgId(int sc_msgId)
    {
        m_sc_msgId = sc_msgId;
    }

    public int getSc_res()
    {
        return m_sc_res;
    }

    public void setSc_res(int sc_res)
    {
        m_sc_res = sc_res;
    }

    public String getSc_ucnum()
    {
        return m_sc_ucnum;
    }

    public void setSc_ucnum(String sc_ucnum)
    {
        m_sc_ucnum = sc_ucnum;
    }

    public String getSc_vt()
    {
        return m_sc_vt;
    }

    public void setSc_vt(String sc_vt)
    {
        m_sc_vt = sc_vt;
    }

    public int getSms_echoId()
    {
        return m_sms_echoId;
    }

    public void setSms_echoId(int sms_echoId)
    {
        m_sms_echoId = sms_echoId;
    }

    private int m_sms_echoId;
    private String m_sc_ucnum;
    private String m_sc_cee;
    private int m_sc_msgId;
    private int m_sc_res;
    private String m_sc_vt;
}
