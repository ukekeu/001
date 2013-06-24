// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   SampleMO.java

package com.sms.engine;

import java.io.PrintStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ConnDatabase.SDatabase;

// Referenced classes of package com.sms.engine:
//            MO

public class SampleMO
    implements MO
{
	private static Logger logger = LoggerFactory.getLogger(SampleMO.class);

    public SampleMO()
    {
    }

    public void Notify(String MOID, String serviceID, String fromNum, String toNum, String text)
    {
    	logger.info(String.valueOf(String.valueOf((new StringBuffer("1-")).append(MOID).append("&2-").append(serviceID).append("&3-").append(fromNum).append("&4-").append(toNum).append("&5-").append(text))));
    }

    public static void main(String args[])
    {
    	logger.info("Hello World!");
    }
}
