// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   relaDateInfo.java

package relaDateInfo;

import java.sql.Timestamp;
import java.util.Date;

public class relaDateInfo
{

    public relaDateInfo()
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

    public static int currentMonth(int i)
    {
        Timestamp timestamp = new Timestamp(System.currentTimeMillis() + (long)i);
        int j;
        try
        {
            j = Integer.parseInt(timestamp.toString().substring(5, 7));
        }
        catch(Exception exception)
        {
            j = 1;
        }
        return j;
    }

    public static String relaDay(int i, int j, int k, int l)
    {
        String s = "";
        Timestamp timestamp = new Timestamp(k, l, j, 0, 0, 0, 0);
        Timestamp timestamp1 = new Timestamp(timestamp.getTime() + (long)i);
        try
        {
            s = timestamp1.toString().substring(0, 10);
        }
        catch(Exception exception)
        {
            s = "";
        }
        return s;
    }
}
