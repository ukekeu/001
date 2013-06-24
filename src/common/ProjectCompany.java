// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ProjectCompany.java

package common;


public class ProjectCompany
{

    public ProjectCompany(int i, int j, String s, String s1, String s2, String s3)
    {
        id = i;
        projectId = j;
        companyName = s1;
        companyType = s;
        companyAddress = s2;
        companyTelephone = s3;
    }

    public void setId(int i)
    {
        id = i;
    }

    public int getId()
    {
        return id;
    }

    public void setProjectId(int i)
    {
        projectId = i;
    }

    public int getProjectId()
    {
        return projectId;
    }

    public void setCompanyType(String s)
    {
        companyType = s;
    }

    public String getCompanyType()
    {
        return companyType;
    }

    public void setCompanyName(String s)
    {
        companyName = s;
    }

    public String getCompanyName()
    {
        return companyName;
    }

    public void setCompanyAddress(String s)
    {
        companyAddress = s;
    }

    public String getCompanyAddress()
    {
        return companyAddress;
    }

    public void setCompanyTelephone(String s)
    {
        companyTelephone = s;
    }

    public String getCompanyTelephone()
    {
        return companyTelephone;
    }

    private int id;
    private int projectId;
    private String companyType;
    private String companyName;
    private String companyAddress;
    private String companyTelephone;
}
