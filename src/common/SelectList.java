// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   selectList.java

package common;

import ConnDatabase.SDatabase;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

public class SelectList
{

    public SelectList()
    {
    }

    public void getList(String s, String s1, String s2)
    {
        firstCode = "";
        firstValue = "";
        SDatabase sdatabase = new SDatabase();
        try
        {
            ResultSet resultset = sdatabase.executeQuery(s);
            hmap = new HashMap();
            int i = 0;
            String s3;
            String s4;
            for(; resultset.next(); hmap.put(s3, s4))
            {
                i++;
                s3 = resultset.getString(s1);
                s4 = resultset.getString(s2);
                if(i == 1)
                {
                    firstCode = s3;
                    firstValue = s4;
                }
            }

        }
        catch(Exception exception)
        {
            System.out.println(exception.getMessage());
        }
    }

    public String getFirstCode()
    {
        return firstCode;
    }

    public String getFirstValue()
    {
        return firstValue;
    }

    public String getValue(String s)
    {
        System.out.println(s);
        return (String)hmap.get(s);
    }

    public Map getMap()
    {
        return hmap;
    }

    private String firstCode;
    private String firstValue;
    private HashMap hmap;
}
