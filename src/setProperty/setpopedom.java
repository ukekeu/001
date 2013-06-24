// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   setpopedom.java

package setProperty;

import java.io.Serializable;
import java.util.Hashtable;

public class setpopedom implements Serializable
{

    public setpopedom()
    {
        popedomlist = null;
        sectionlist = null;
        dic = null;
    }

    public void setSectionlist(String s)
    {
        sectionlist = s;
    }

    public String getSectionlist()
    {
        return sectionlist;
    }

    public void setPopedomlist(String s)
    {
        popedomlist = s;
    }

    public String getPopedomlist()
    {
        return popedomlist;
    }

    public void setDic(Hashtable hashtable)
    {
        dic = hashtable;
    }

    public Hashtable getDic()
    {
        return dic;
    }

    String popedomlist;
    String sectionlist;
    Hashtable dic;
}
