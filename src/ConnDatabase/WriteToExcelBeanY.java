// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   WriteToExcelBeanY.java

package ConnDatabase;

import java.io.*;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

// Referenced classes of package ConnDatabase:
//            ConnDatabase

public class WriteToExcelBeanY
{

    public WriteToExcelBeanY()
    {
    }

    public String WriteToExcel(ConnDatabase conndatabase, String s, String s1, String s2)
    {
        String s3 = "";
        String s4 = "";
        try
        {
            PrintWriter printwriter = new PrintWriter(new FileOutputStream(s2));
            printwriter.println(s);
            try
            {
                Object obj = null;
                ResultSet resultset = conndatabase.executeQuery(s1);
                int i = 0;
                if(resultset == null)
                {
                    System.out.println("commonresult is null");
                } else
                {
                    ResultSetMetaData resultsetmetadata = resultset.getMetaData();
                    i = resultsetmetadata.getColumnCount();
                }
                String s5;
                for(; resultset.next(); printwriter.println(s5))
                {
                    s5 = "";
                    for(int j = 1; j <= i; j++)
                        if(j == i)
                            s5 = s5 + resultset.getObject(j).toString().trim();
                        else
                            s5 = s5 + resultset.getObject(j).toString().trim() + ",";

                }

                resultset.close();
                s3 = "\u6587\u4EF6\u5DF2\u5199\u5B8C\uFF0C\u7528EXCEL\u6253\u5F00\u540E\u53EF\u4EE5\u770B\u5230\u6570\u636E";
            }
            catch(Exception exception)
            {
                System.out.println("commonlistbean error");
            }
            printwriter.close();
        }
        catch(IOException ioexception)
        {
            System.out.println(ioexception.getMessage());
        }
        return s3;
    }
}
