// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   SMSRecv.java

package com.excenon.sms.module;


public class SMSRecv
{

    public SMSRecv()
    {
    }

    public int getSms_recvId()
    {
        return m_sms_recvId;
    }

    public void setSms_recvId(int sms_recvId)
    {
        m_sms_recvId = sms_recvId;
    }

    public String getSr_caller()
    {
        return m_sr_caller;
    }

    public void setSr_caller(String sr_caller)
    {
        m_sr_caller = sr_caller;
    }

    public String getSr_content()
    {
        return m_sr_content;
    }

    public void setSr_content(String sr_content)
    {
        m_sr_content = sr_content;
    }

    public String getSr_time()
    {
        return m_sr_time;
    }

    public void setSr_time(String sr_time)
    {
        m_sr_time = sr_time;
    }

    public String getSr_ucnum()
    {
        return m_sr_ucnum;
    }

    public void setSr_ucnum(String sr_ucnum)
    {
        m_sr_ucnum = sr_ucnum;
    }

    private int m_sms_recvId;
    private String m_sr_time;
    private String m_sr_caller;
    private String m_sr_content;
    private String m_sr_ucnum;
}
