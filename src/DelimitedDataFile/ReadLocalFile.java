// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ReadLocalFile.java

package DelimitedDataFile;

import java.io.*;

public class ReadLocalFile
{

    public ReadLocalFile()
    {
    }

    public static void ReadLocal(String s)
    {
        try
        {
            File file = new File("c:\\tools\\test.txt");
            FileReader filereader = new FileReader(file);
            System.out.println(file.length());
            char ac[] = new char[(int)file.length()];
            InputStreamReader inputstreamreader = new InputStreamReader(new FileInputStream(file));
            inputstreamreader.read(ac);
            String s1 = new String(ac);
            System.out.println(s1);
            System.out.println(s1.length());
            s1 = s1.trim();
            System.out.println(s1.length());
            System.out.println(s1);
        }
        catch(Exception exception)
        {
            System.out.print(exception);
        }
    }
}
