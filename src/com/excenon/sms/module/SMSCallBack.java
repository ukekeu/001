// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   SMSCallBack.java

package com.excenon.sms.module;


public class SMSCallBack
{

    public SMSCallBack()
    {
    }

    public String getPara1()
    {
        return m_para1;
    }

    public void setPara1(String para1)
    {
        m_para1 = para1;
    }

    public int getScb_event()
    {
        return m_scb_event;
    }

    public void setScb_event(int scb_event)
    {
        m_scb_event = scb_event;
    }

    public String getScb_res()
    {
        return m_scb_res;
    }

    public void setScb_res(String scb_res)
    {
        m_scb_res = scb_res;
    }

    public String getScb_session()
    {
        return m_scb_session;
    }

    public void setScb_session(String scb_session)
    {
        m_scb_session = scb_session;
    }

    public int getScb_time()
    {
        return m_scb_time;
    }

    public void setScb_time(int scb_time)
    {
        m_scb_time = scb_time;
    }

    public int getSms_callbackId()
    {
        return m_sms_callbackId;
    }

    public void setSms_callbackId(int sms_callbackId)
    {
        m_sms_callbackId = sms_callbackId;
    }

    private int m_sms_callbackId;
    private int m_scb_time;
    private int m_scb_event;
    private String m_scb_session;
    private String m_scb_res;
    private String m_para1;
}
