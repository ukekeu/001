// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   IOUtils.java

package com.excenon.sms;

import java.io.*;
import java.net.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


// Referenced classes of package com.excenon.sms:
//            Log

public class IOUtils
{

    public IOUtils()
    {
    }

    public static byte[] readInputStream(InputStream is)
        throws IOException
    {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte buffer[] = new byte[BUFFER_SIZE];
        int len;
        while((len = is.read(buffer)) != -1) 
            baos.write(buffer, 0, len);
        return baos.toByteArray();
    }

    public static long copyStream(InputStream is, OutputStream os)
        throws IOException
    {
        byte buffer[] = new byte[BUFFER_SIZE];
        int len;
        long total;
        for(total = 0L; (len = is.read(buffer)) != -1; total += len)
            os.write(buffer, 0, len);

        return total;
    }

    public static void closeStream(Object streams[])
    {
        Object aobj[];
        int j = (aobj = streams).length;
        for(int i = 0; i < j; i++)
        {
            Object stream = aobj[i];
            if(stream instanceof InputStream)
                try
                {
                    ((InputStream)stream).close();
                }
                catch(IOException ioexception) { }
            else
            if(stream instanceof OutputStream)
                try
                {
                    ((OutputStream)stream).close();
                }
                catch(IOException ioexception1) { }
            else
            if(stream != null)
                logger.warn((new StringBuilder("Can not close ")).append(stream.toString()).toString());
        }

    }

    public static void copyFile(File inf, File outf)
        throws IOException
    {
        InputStream is = new FileInputStream(inf);
        OutputStream os = new FileOutputStream(outf);
        copyStream(is, os);
        closeStream(new Object[] {
            is, os
        });
    }

    public static void closeWriter(Writer writers[])
    {
        Writer awriter[];
        int j = (awriter = writers).length;
        for(int i = 0; i < j; i++)
        {
            Writer writer = awriter[i];
            if(writer != null)
                try
                {
                    writer.close();
                }
                catch(IOException ioexception) { }
        }

    }

    public static void closeReader(Reader readers[])
    {
        Reader areader[];
        int j = (areader = readers).length;
        for(int i = 0; i < j; i++)
        {
            Reader reader = areader[i];
            if(reader != null)
                try
                {
                    reader.close();
                }
                catch(IOException ioexception) { }
        }

    }

    public static InputStream getPackageRes(Class c, String fn)
    {
        String name = c.getPackage().getName().replace('.', '/');
        name = (new StringBuilder(String.valueOf(name))).append("/").append(fn).toString();
        InputStream is = c.getClassLoader().getResourceAsStream(name);
        return is;
    }

    public static boolean deleteAll(File f)
    {
        if(f.isDirectory())
        {
            File contents[] = f.listFiles();
            for(int i = 0; i < contents.length; i++)
                deleteAll(contents[i]);

        }
        return f.delete();
    }

    public static boolean saveUrlFileAs(String u, String fileName)
    {
        try
        {
            URL url = new URL(u);
            HttpURLConnection connection = (HttpURLConnection)url.openConnection();
            DataInputStream in = new DataInputStream(connection.getInputStream());
            DataOutputStream out = new DataOutputStream(new FileOutputStream(fileName));
            byte buffer[] = new byte[4096];
            for(int count = 0; (count = in.read(buffer)) > 0;)
                out.write(buffer, 0, count);

            out.close();
            in.close();
        }
        catch(Exception e)
        {
            return false;
        }
        return true;
    }

    public static String getUrlDocumentAt(String urlString)
    {
        StringBuffer document = new StringBuffer();
        try
        {
            URL url = new URL(urlString);
            URLConnection conn = url.openConnection();
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            for(String line = null; (line = reader.readLine()) != null;)
                document.append((new StringBuilder(String.valueOf(line))).append("\n").toString());

            reader.close();
        }
        catch(MalformedURLException e)
        {
        	logger.error((new StringBuilder("Unable to connect to URL: ")).append(urlString).toString());
        }
        catch(IOException e)
        {
        	logger.error((new StringBuilder("IOException when connecting to URL: ")).append(urlString).toString());
        }
        return document.toString();
    }

    public InputStream getInputStreamByUrl(String urlString)
    {
        try
        {
            URL url = new URL(urlString);
            URLConnection conn = url.openConnection();
            return conn.getInputStream();
        }
        catch(MalformedURLException e)
        {
        	logger.error((new StringBuilder("Unable to connect to URL: ")).append(urlString).toString());
        }
        catch(IOException e)
        {
        	logger.error((new StringBuilder("IOException when connecting to URL: ")).append(urlString).toString());
        }
        return null;
    }

    public byte[] getBytesByUrl(String urlString)
        throws IOException
    {
        return readInputStream(getInputStreamByUrl(urlString));
    }

    public static Logger logger =  LoggerFactory.getLogger(IOUtils.class);
    public static int BUFFER_SIZE = 4096;

}
