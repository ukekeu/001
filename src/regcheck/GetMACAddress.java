// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   GetMACAddress.java

package regcheck;

import java.io.*;

public class GetMACAddress
{

    public GetMACAddress()
    {
    }

    public String getMACAddress(String s)
    {
        String s1 = "";
        String s3 = "";
        String s4 = "";
        try
        {
            Process process = Runtime.getRuntime().exec((new StringBuilder()).append("nbtstat -a ").append(s).toString());
            InputStreamReader inputstreamreader = new InputStreamReader(process.getInputStream());
            LineNumberReader linenumberreader = new LineNumberReader(inputstreamreader);
            int i = 1;
            do
            {
                if(i >= 100)
                    break;
                String s2 = linenumberreader.readLine();
                if(s2 != null && s2.indexOf("MAC Address") > 1)
                {
                    s3 = s2.substring(s2.indexOf("MAC Address") + 14, s2.length());
                    break;
                }
                i++;
            } while(true);
        }
        catch(IOException ioexception)
        {
            return "Can't Get MAC Address!";
        }
        if(s3.length() < 17)
        {
            return "Error!";
        } else
        {
            String s5 = (new StringBuilder()).append(s3.substring(0, 2)).append("-").append(s3.substring(3, 5)).append("-").append(s3.substring(6, 8)).append("-").append(s3.substring(9, 11)).append("-").append(s3.substring(12, 14)).append("-").append(s3.substring(15, 17)).toString();
            return s5;
        }
    }

    public static void main(String args[])
    {
        GetMACAddress getmacaddress = new GetMACAddress();
    }

    public static String procAll(String s)
    {
        return procStringEnd(procFirstMac(procAddress(s)));
    }

    public static String procAddress(String s)
    {
        int i = s.indexOf("Physical Address");
        if(i > 0)
            return s.substring(i, s.length());
        else
            return s;
    }

    public static String procFirstMac(String s)
    {
        int i = s.indexOf("-");
        if(i > 0)
            return s.substring(i + 1, s.length()).trim();
        else
            return s;
    }

    public static String procStringEnd(String s)
    {
        int i = s.indexOf("\r");
        if(i > 0)
            return s.substring(0, i).trim();
        else
            return s;
    }
}
