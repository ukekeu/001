// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Const.java

package com.sztelecom.vabd.zytx.common;

import com.excenon.sms.Config;

public class Const
{

    public Const()
    {
    }

    public static String CallBackURL;
    public static String HWWebServiceRegisterURL;
    public static String HWWebServiceCTDCallURL;
    public static String HWWebServiceCTCCallURL;
    public static String HWWebServiceFAXURL;
    public static String HWWebServiceFindFAXURL;
    public static String HWWebServiceSMSURL;
    public static String HWWebServiceUser;
    public static String HWWebServiceUserPasswd;
    public static int CTD_SERVICE = 100;
    public static int CTC_SERVICE = 101;
    public static int SMS_SERVICE = 102;
    public static int FAX_SERVICE = 103;
    public static int MAX_DEST_NUMS = 254;
    public static int MAX_CONTENT = 150;
    public static int ID_SMS_EVENT_SEND = 100;
    public static int E_SMS_SUCCESS = 0;
    public static int E_SYSTEM_EXCEPTION = -1;
    public static int E_INVALID_PASSWD = -2;
    public static int E_INVALID_UCNO = -3;
    public static int E_ILLEGAL_UCNO = -4;
    public static int E_RANDOM_TIMEOUT = -5;
    public static int E_SMS_ILLEGALNUM = -100;
    public static int E_SMS_MAXNUM = -101;
    public static int E_SMS_MAXCONTENT = -102;
    public static int E_SMS_CONTENTNULL = -103;
    public static int E_SMS_NOTSUPPORT = -104;
    public static int E_SMS_DESTADDR = -105;
    public static int E_SMS_OTHER = -106;

    static 
    {
        CallBackURL = Config.getProperty(com.excenon.sms.Config.Settings.SMS_CALLBACK_URL);
        HWWebServiceRegisterURL = Config.getProperty(com.excenon.sms.Config.Settings.SMS_REGISTER_URL);
        HWWebServiceCTDCallURL = Config.getProperty(com.excenon.sms.Config.Settings.SMS_CTDCALL_URL);
        HWWebServiceCTCCallURL = Config.getProperty(com.excenon.sms.Config.Settings.SMS_CTCCALL_URL);
        HWWebServiceFAXURL = Config.getProperty(com.excenon.sms.Config.Settings.SMS_SENDFAX_URL);
        HWWebServiceFindFAXURL = Config.getProperty(com.excenon.sms.Config.Settings.SMS_FINDFAX_URL);
        HWWebServiceSMSURL = Config.getProperty(com.excenon.sms.Config.Settings.SMS_SENDSMS_URL);
        HWWebServiceUser = Config.getProperty(com.excenon.sms.Config.Settings.SMS_USER);
        HWWebServiceUserPasswd = Config.getProperty(com.excenon.sms.Config.Settings.SMS_PASSWD);
    }
}
