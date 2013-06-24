// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   jsyunew3.java

package jsyunew3;


public class jsyunew3
{

    public jsyunew3()
    {
    }

    static native int GetVersion(String s);

    static native int GetVersionEx(String s);

    static native long GetID_1(String s);

    static native long GetID_2(String s);

    static native long get_LastError();

    static native String FindPort(int i);

    static native String FindPort_2(int i, long l, long l1);

    static native int SetReadPassword(String s, String s1, String s2, String s3, String s4);

    static native int SetWritePassword(String s, String s1, String s2, String s3, String s4);

    static native long sRead(String s);

    static native int sWrite(long l, String s);

    static native int sWrite_2(long l, String s);

    static native int YRead(short word0, String s, String s1, String s2);

    static native String YReadString(short word0, short word1, String s, String s1, String s2);

    static native int YWrite(short word0, short word1, String s, String s1, String s2);

    static native int YWriteString(String s, short word0, String s1, String s2, String s3);

    static 
    {
        System.loadLibrary("jsyunew3");
    }
}
