// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   DelimitedDataFile.java

package DelimitedDataFile;

import java.io.*;
import java.util.StringTokenizer;

public class DelimitedDataFile
{

    public DelimitedDataFile()
    {
        currentRecord = null;
        path = null;
        file = new BufferedReader(new InputStreamReader(System.in), 1);
    }

    public DelimitedDataFile(String s)
        throws FileNotFoundException
    {
        currentRecord = null;
        path = null;
        path = s;
        file = new BufferedReader(new FileReader(path));
    }

    public void setPath(String s)
    {
        path = "d:\\tomcat\\webapps\\resm\\jsp\\jdbc.txt";
        try
        {
            file = new BufferedReader(new FileReader(path));
        }
        catch(FileNotFoundException filenotfoundexception)
        {
            System.out.println("file not found" + path + filenotfoundexception);
        }
    }

    public String getPath()
    {
        return path;
    }

    public void fileClose()
        throws IOException
    {
        file.close();
    }

    public int nextRecord()
    {
        int i = -1;
        try
        {
            currentRecord = file.readLine();
        }
        catch(IOException ioexception)
        {
            System.out.println("readLine problem, terminating.");
        }
        if(currentRecord == null)
        {
            i = -1;
        } else
        {
            token = new StringTokenizer(currentRecord);
            i = token.countTokens();
        }
        return i;
    }

    public String returnRecord()
    {
        return currentRecord;
    }

    private String currentRecord;
    private BufferedReader file;
    private String path;
    private StringTokenizer token;
}
