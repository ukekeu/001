// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   DateInfo.java

package common;

import java.sql.Timestamp;

public class DateInfo
{

    public DateInfo()
    {
    }

    public static int currentYear()
    {
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        int i;
        try
        {
            i = Integer.parseInt(timestamp.toString().substring(0, 4));
        }
        catch(Exception exception)
        {
            i = 2001;
        }
        return i;
    }

    public static int currentMonth()
    {
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        int i;
        try
        {
            i = Integer.parseInt(timestamp.toString().substring(5, 7));
        }
        catch(Exception exception)
        {
            i = 1;
        }
        return i;
    }

    public static int currentDay()
    {
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        int i;
        try
        {
            i = Integer.parseInt(timestamp.toString().substring(8, 10));
        }
        catch(Exception exception)
        {
            i = 1;
        }
        return i;
    }
}
