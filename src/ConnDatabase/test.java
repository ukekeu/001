// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   test.java

package ConnDatabase;

import java.io.FileOutputStream;
import java.io.PrintWriter;

public class test
{

    public test()
    {
    }

    public String WriteToExcel(String s, String s1, String as[], int i, String s2)
        throws Exception
    {
        String s3 = "";
        String s4 = "";
        PrintWriter printwriter = new PrintWriter(new FileOutputStream(s2));
        printwriter.println(s);
        printwriter.println("                               " + s1);
        boolean flag = false;
        int k = 0;
        boolean flag1 = false;
        for(int j = 0; j < as.length; j++)
        {
            k++;
            printwriter.println(as[j]);
        }

        s3 = "ok";
        return s3;
    }
}
