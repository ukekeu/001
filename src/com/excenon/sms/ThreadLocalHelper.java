// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ThreadLocalHelper.java

package com.excenon.sms;

import java.util.HashMap;

public class ThreadLocalHelper
{

    public ThreadLocalHelper()
    {
    }

    public static void init()
    {
        if(s_var.get() != null)
        {
            throw new IllegalStateException("There is already a thread local exists, call init() already or forgot to call cleanup()???");
        } else
        {
            HashMap map = new HashMap(4);
            s_var.set(map);
            return;
        }
    }

    public static void cleanup()
    {
        s_var.remove();
    }

    public static Object get(String key)
    {
        HashMap map = (HashMap)s_var.get();
        if(map == null)
            throw new IllegalStateException("Thread local not exists!");
        else
            return map.get(key);
    }

    public static void set(String key, Object obj)
    {
        HashMap map = (HashMap)s_var.get();
        if(map == null)
            throw new IllegalStateException("Thread local not exists!");
        if(obj == null)
            map.remove(key);
        else
            map.put(key, obj);
    }

    private static final ThreadLocal s_var = new ThreadLocal();

}
