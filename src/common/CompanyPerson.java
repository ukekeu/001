// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CompanyPerson.java

package common;


public class CompanyPerson
{

    public CompanyPerson(int i, int j, String s, int k, String s1, String s2, String s3, 
            String s4)
    {
        id = i;
        projectId = j;
        companyType = s;
        companyId = k;
        personName = s1;
        personPosition = s2;
        personTrust = s3;
        personTelephone = s4;
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

    public void setCompanyId(int i)
    {
        companyId = i;
    }

    public int getCompanyId()
    {
        return companyId;
    }

    public void setPersonName(String s)
    {
        personName = s;
    }

    public String getPersonName()
    {
        return personName;
    }

    public void setPersonPosition(String s)
    {
        personPosition = s;
    }

    public String getPersonPosition()
    {
        return personPosition;
    }

    public void setPersonTrust(String s)
    {
        personTrust = s;
    }

    public String getPersonTrust()
    {
        return personTrust;
    }

    public void setPersonTelephone(String s)
    {
        personTelephone = s;
    }

    public String getPersonTelephone()
    {
        return personTelephone;
    }

    private int id;
    private int projectId;
    private String companyType;
    private int companyId;
    private String personName;
    private String personPosition;
    private String personTrust;
    private String personTelephone;
}
