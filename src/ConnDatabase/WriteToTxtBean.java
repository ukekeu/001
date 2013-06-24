// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   WriteToTxtBean.java

package ConnDatabase;

import java.io.*;
import java.sql.SQLException;

public class WriteToTxtBean
{

    public WriteToTxtBean()
    {
    }

    public String WriteToTXT(String s, String s1, String s2)
    {
        String s3 = "";
        String s4 = "";
        try
        {
            PrintWriter printwriter = new PrintWriter(new FileOutputStream(s2));
            printwriter.println(s);
            printwriter.println(s1);
            printwriter.close();
            s3 = "ok";
        }
        catch(IOException ioexception)
        {
            s3 = "error";
            System.out.println(ioexception.getMessage());
        }
        return s3;
    }

    public String ReadTXT(String s)
        throws Exception
    {
        String s1 = "";
        Object obj = null;
        try
        {
            File file = new File(s);
            if(!file.exists())
                throw new SQLException();
            BufferedReader bufferedreader = new BufferedReader(new InputStreamReader(new BufferedInputStream(new FileInputStream(file))));
            for(String s2 = ""; (s2 = bufferedreader.readLine()) != null;)
                if(s1.equals(""))
                    s1 = s2;
                else
                    s1 = s1 + "|" + s2;

        }
        catch(Exception exception)
        {
            throw exception;
        }
        return s1;
    }
}
