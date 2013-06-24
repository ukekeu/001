// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CCode.java

package com.sms.cpa;


public class CCode
{

    public CCode()
    {
    }

    public static final byte SUCESS = 1;
    public static final byte ERR_SYS = 2;
    public static final byte ERR_PARAM = -120;
    public static final byte ERR_ACCOUNT = 18;
    public static final byte ERR_RIGHT = 20;
    public static final byte ERR_IP = 21;
    public static final byte ERR_EXIST = 22;
    public static final byte ERR_DATA = -1;
    public static final byte CLOSE_CNT = 0;
    public static final byte KEEP_CNT = 1;
    public static final byte TEXT_MSG = 1;
    public static final byte ICON_MSG = 2;
    public static final byte RING_MSG = 3;
    public static final byte BIN_MSG = 4;
    public static final byte DIS_AGENT = 50;
    public static final byte DIS_SMSC = 51;
    public static final byte DIS_ASMS = 52;
    public static final byte ERR_SUBMIT = 53;
    public static final byte ERR_FEE = 54;
    public static final byte NO_MT_RIGHT = 55;
    public static final byte NO_MT_ROUTE = 56;
    public static final byte HAVE_DEL = 81;
    public static final byte CANT_DEL = 82;
    public static final byte NO_DEL_RIGHT = 83;
    public static final byte UNKNOW = 96;
    public static final byte IN_QUEUE = 97;
    public static final byte HAVE_SENT = 98;
    public static final byte HAVE_DONE = 99;
    public static final byte ERR_EXEC = 114;
    public static final byte TARGET_PAY = 0;
    public static final byte SOURCE_PAY = 1;
    public static final byte SP_PAY = 2;
    public static final int CFREEMT = 0;
    public static final int CMT = 1;
    public static final int CMO = 2;
    private static final byte _$43094[][] = {
        {
            1, 1
        }, {
            2, 2
        }, {
            3, 3
        }, {
            4, 4
        }, {
            1, 1
        }, {
            97, 2
        }, {
            98, 3
        }, {
            99, 4
        }, {
            81, 5
        }, {
            96, 8
        }, {
            53, 0
        }
    };

}
