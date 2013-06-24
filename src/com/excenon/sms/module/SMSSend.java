// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   SMSSend.java

package com.excenon.sms.module;


public class SMSSend
{

    public SMSSend()
    {
    }

    public int getSms_sendId()
    {
        return m_sms_sendId;
    }

    public void setSms_sendId(int sms_sendId)
    {
        m_sms_sendId = sms_sendId;
    }

    public String getSs_content()
    {
        return m_ss_content;
    }

    public void setSs_content(String ss_content)
    {
        m_ss_content = ss_content;
    }

    public int getSs_mid()
    {
        return m_ss_mid;
    }

    public void setSs_mid(int ss_mid)
    {
        m_ss_mid = ss_mid;
    }

    public int getSs_module()
    {
        return m_ss_module;
    }

    public void setSs_module(int ss_module)
    {
        m_ss_module = ss_module;
    }

    public int getSs_msgId()
    {
        return m_ss_msgId;
    }

    public void setSs_msgId(int ss_msgId)
    {
        m_ss_msgId = ss_msgId;
    }

    public String getSs_receiver()
    {
        return m_ss_receiver;
    }

    public void setSs_receiver(String ss_receiver)
    {
        m_ss_receiver = ss_receiver;
    }

    public String getSs_sender()
    {
        return m_ss_sender;
    }

    public void setSs_sender(String ss_sender)
    {
        m_ss_sender = ss_sender;
    }

    public int getSs_status()
    {
        return m_ss_status;
    }

    public void setSs_status(int ss_status)
    {
        m_ss_status = ss_status;
    }

    public int getSs_time()
    {
        return m_ss_time;
    }

    public void setSs_time(int ss_time)
    {
        m_ss_time = ss_time;
    }

    private int m_sms_sendId;
    private int m_ss_time;
    private String m_ss_sender;
    private String m_ss_receiver;
    private String m_ss_content;
    private int m_ss_msgId;
    private int m_ss_module;
    private int m_ss_mid;
    private int m_ss_status;
}
