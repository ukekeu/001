// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ListUser.java

package online;

import java.io.PrintStream;
import java.io.Serializable;
import java.util.Date;
import java.util.Vector;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ConnDatabase.SDatabase;

public class ListUser
    implements HttpSessionBindingListener ,Serializable
{
	private static Logger logger = LoggerFactory.getLogger(SDatabase.class);

    public ListUser()
    {
        users = new Vector();
    }

    public int getCount()
    {
        users.trimToSize();
        return users.capacity();
    }

    public boolean existUser(String s)
    {
        users.trimToSize();
        boolean flag = false;
        int i = 0;
        do
        {
            if(i >= users.capacity())
                break;
            if(s.equals((String)users.get(i)))
            {
                flag = true;
                break;
            }
            i++;
        } while(true);
        return flag;
    }

    public boolean deleteUser(String s)
    {
        users.trimToSize();
        if(existUser(s))
        {
            int i = -1;
            int j = 0;
            do
            {
                if(j >= users.capacity())
                    break;
                if(s.equals((String)users.get(j)))
                {
                    i = j;
                    break;
                }
                j++;
            } while(true);
            if(i != -1)
            {
                users.remove(i);
                users.trimToSize();
                return true;
            }
        }
        return false;
    }

    public Vector getOnLineUser()
    {
        return users;
    }

    public void valueBound(HttpSessionBindingEvent httpsessionbindingevent)
    {
        users.trimToSize();
        if(!existUser(httpsessionbindingevent.getName()) && !httpsessionbindingevent.getName().equals(""))
        {
            users.add(httpsessionbindingevent.getName());
            logger.info((new StringBuilder()).append(httpsessionbindingevent.getName()).append("\t  login system \t").append(new Date()).toString());
            logger.info((new StringBuilder()).append("     online \uFF1A").append(getCount()).toString());
        } else
        {
        	logger.info((new StringBuilder()).append(httpsessionbindingevent.getName()).append("exist").toString());
        }
    }

    public void valueUnbound(HttpSessionBindingEvent httpsessionbindingevent)
    {
        users.trimToSize();
        String s = httpsessionbindingevent.getName();
        deleteUser(s);
        logger.info((new StringBuilder()).append(s).append("\t  logout\t").append(new Date()).toString());
        logger.info((new StringBuilder()).append("    online\uFF1A").append(getCount()).toString());
    }

    public Vector users;
}
