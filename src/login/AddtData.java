// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Addtdata.java

package login;


public class AddtData
{

    public AddtData()
    {
        userid = null;
        username = null;
        userdept = null;
        logintime = null;
        userjob = null;
        userstate = null;
        workingID = null;
        id = null;
    }

    public void setId(String s)
    {
        id = s;
    }

    public String getId()
    {
        return id;
    }

    public void setUserid(String s)
    {
        userid = s;
    }

    public String getUserid()
    {
        return userid;
    }

    public void setUsername(String s)
    {
        username = s;
    }

    public String getUsername()
    {
        return username;
    }

    public void setUserdept(String s)
    {
        userdept = s;
    }

    public String getUserdept()
    {
        return userdept;
    }

    public void setLogintime(String s)
    {
        logintime = s;
    }

    public String getLogintime()
    {
        return logintime;
    }

    public void setUserjob(String s)
    {
        userjob = s;
    }

    public String getUserjob()
    {
        return userjob;
    }

    public void setUserstate(String s)
    {
        userstate = s;
    }

    public String getUserstate()
    {
        return userstate;
    }

    public void setWorkingID(String s)
    {
        workingID = s;
    }

    public String getWorkingID()
    {
        return workingID;
    }

    String userid;
    String username;
    String userdept;
    String logintime;
    String userjob;
    String userstate;
    String workingID;
    String id;
}
