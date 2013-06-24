// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Log.java

package com.excenon.sms;

import java.io.PrintStream;
import java.util.Enumeration;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public final class Log
{

    protected Log()
    {
    }

    /*public static final Logger ENCORE = LoggerFactory.getLogger("excenon");
    public static final Logger SECURITY = LoggerFactory.getLogger("excenon.security");
    public static final Logger UTILS = LoggerFactory.getLogger("excenon.utils");
    public static final Logger APP = LoggerFactory.getLogger("excenon.app");
    public static final Logger ORE = LoggerFactory.getLogger("excenon.encore.ore");
    public static final Logger EML = LoggerFactory.getLogger("excenon.encore.eml");
    public static final Logger OQL = LoggerFactory.getLogger("excenon.encore.ore.oql");
    public static final Logger TK = LoggerFactory.getLogger("excenon.toolkit");
    public static final Logger UI = LoggerFactory.getLogger("excenon.ui");
    public static final Logger KWS = LoggerFactory.getLogger("excenon.keyword.search");*/

   /* static 
    {	
        if(!Logger.getRootLogger().getAllAppenders().hasMoreElements())
        {
            System.out.println("Attempt to config toolkit logger");
            ConsoleAppender appender = new ConsoleAppender(new SimpleLayout());
            BasicConfigurator.configure(appender);
            Logger.getRootLogger().setLevel(Level.INFO);
        }
    }*/
}
