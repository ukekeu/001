// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Connector.java

package com.sms.pub;

import java.io.*;
import java.net.InetAddress;
import java.net.Socket;

public class Connector
{

    public Connector(Socket s, int it)
    {
        _$5496 = -1;
        in = null;
        out = null;
        ip = "";
        try
        {
            s.setSoTimeout(10000);
        }
        catch(Exception exception) { }
        _$5496 = it;
        _$5454 = s;
        init();
    }

    public Connector(Socket s)
    {
        _$5496 = -1;
        in = null;
        out = null;
        ip = "";
        _$5454 = s;
        init();
    }

    public Socket getSocket()
    {
        return _$5454;
    }

    public void setType(int i)
    {
        _$5496 = i;
    }

    public int getType()
    {
        return _$5496;
    }

    public String getIPAddr()
    {
        return ip;
    }

    public boolean init()
    {
        if(in != null)
            return true;
        try
        {
            in = new DataInputStream(_$5454.getInputStream());
            out = new DataOutputStream(_$5454.getOutputStream());
            InetAddress ia = _$5454.getInetAddress();
            ip = ia.getHostAddress();
            boolean flag = true;
            return flag;
        }
        catch(Exception exception)
        {
            return false;
        }
    }

    public synchronized boolean write(byte b[])
    {
        if(_$5454 == null)
            return false;
        if(out == null)
            init();
        try
        {
            out.write(b);
            out.flush();
            boolean flag = true;
            return flag;
        }
        catch(Exception exception)
        {
            return false;
        }
    }

    public synchronized int write(byte b[], int iFrom, int iLen)
    {
        if(_$5454 == null)
            return -1;
        try
        {
            if(b != null && iFrom >= 0 && iFrom + iLen <= b.length)
            {
                out.write(b, iFrom, iLen);
                out.flush();
                int i = 0;
                return i;
            } else
            {
                int j = 1;
                return j;
            }
        }
        catch(Exception exception)
        {
            return -1;
        }
    }

    public synchronized int available()
    {
        if(_$5454 == null)
            return -1;
        if(in == null)
            init();
        int iLen = -1;
        try
        {
            iLen = in.available();
        }
        catch(Exception exception) { }
        return iLen;
    }

    public synchronized byte[] read(int iLen)
    {
        if(_$5454 == null)
            return null;
        if(iLen < 1)
            return null;
        byte b[] = new byte[iLen];
        int iRead = read(b, 0, iLen);
        if(iRead < 1)
            return null;
        if(iRead < iLen)
        {
            byte br[] = new byte[iRead];
            System.arraycopy(b, 0, br, 0, iRead);
            return br;
        } else
        {
            return b;
        }
    }

    public synchronized int read(byte b[], int iFrom, int iLen)
    {
        if(_$5454 == null)
            return -1;
        if(b == null || iLen < 1 || iFrom < 0 || b.length < iFrom + iLen)
            return 0;
        int iGot = 0;
        int iRead = 0;
        try
        {
            do
            {
                if(iRead >= iLen || iGot < 0)
                    break;
                iGot = in.read(b, iFrom + iRead, iLen - iRead);
                if(iGot > 0)
                    iRead += iGot;
            } while(true);
            int i = iRead;
            return i;
        }
        catch(Exception exception)
        {
            return -1;
        }
    }

    public void close()
    {
        try
        {
            in.close();
        }
        catch(Exception exception) { }
        try
        {
            out.close();
        }
        catch(Exception exception1) { }
        try
        {
            _$5454.close();
        }
        catch(Exception exception2) { }
        _$5454 = null;
    }

    private Socket _$5454;
    private int _$5496;
    public DataInputStream in;
    public DataOutputStream out;
    public String ip;
}
