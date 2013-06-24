// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Md5.java

package com.sztelecom.vabd.zytx.common.util;

import java.io.PrintStream;
import java.security.MessageDigest;

public class Md5
{

    public Md5()
    {
    }

    public static final String MD5(String s)
    {
        char hexDigits[] = {
            '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
            'a', 'b', 'c', 'd', 'e', 'f'
        };
        try
        {
            byte strTemp[] = s.getBytes();
            MessageDigest mdTemp = MessageDigest.getInstance("MD5");
            mdTemp.update(strTemp);
            byte md[] = mdTemp.digest();
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for(int i = 0; i < j; i++)
            {
                byte byte0 = md[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }

            return new String(str);
        }
        catch(Exception e)
        {
            return null;
        }
    }

    public static void main(String args[])
    {
        System.out.println(MD5("xiehengjun"));
    }
}
