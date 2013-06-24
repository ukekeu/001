// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CompanyListTag.java

package common;

import ConnDatabase.ConnDatabase;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.util.*;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

// Referenced classes of package common:
//            ProjectCompany, CompanyPerson

public class CompanyListTag extends TagSupport
{

    public void setProjectId(String s)
    {
        projectId = s.trim();
        if(projectId.equals(""))
            projectIdStr = "";
        else
            projectIdStr = " and projectid=" + projectId;
    }

    public int doStartTag()
        throws JspTagException
    {
        companys = getCompanys();
        persons = getPersons();
        return 1;
    }

    public int doEndTag()
    {
        companys = null;
        persons = null;
        return 6;
    }

    public List getCompanys()
    {
        String s = "select id,projectid,companytype,companyname,companyaddress,companytelephone from jl_projectcompany where id>0 " + projectIdStr;
        ArrayList arraylist = new ArrayList();
        try
        {
            ConnDatabase conndatabase = new ConnDatabase();
            ResultSet resultset = conndatabase.executeQuery(s);
            boolean flag = false;
            boolean flag1 = false;
            String s1 = "";
            String s3 = "";
            String s5 = "";
            String s7 = "";
            ProjectCompany projectcompany;
            for(; resultset.next(); arraylist.add(projectcompany))
            {
                int i = resultset.getInt("id");
                int j = resultset.getInt("projectid");
                String s2 = resultset.getString("companytype");
                String s4 = resultset.getString("companyName");
                String s6 = resultset.getString("companyaddress");
                String s8 = resultset.getString("companytelephone");
                projectcompany = new ProjectCompany(i, j, s2, s4, s6, s8);
            }

        }
        catch(Exception exception)
        {
            System.out.println("companylisttag ++ " + exception);
        }
        return arraylist;
    }

    public List getPersons()
    {
        String s = "select id,projectid,companytype,companyid,personname,personposition,persontrust,persontelephone from jl_companyperson where id>0  " + projectIdStr;
        boolean flag = false;
        boolean flag1 = false;
        String s1 = "";
        boolean flag2 = false;
        String s3 = "";
        String s5 = "";
        String s7 = "";
        String s9 = "";
        ArrayList arraylist = new ArrayList();
        try
        {
            ConnDatabase conndatabase = new ConnDatabase();
            CompanyPerson companyperson;
            for(ResultSet resultset = conndatabase.executeQuery(s); resultset.next(); arraylist.add(companyperson))
            {
                int i = resultset.getInt("id");
                int j = resultset.getInt("projectId");
                String s2 = resultset.getString("companytype");
                int k = resultset.getInt("companyId");
                String s4 = resultset.getString("personName");
                String s6 = resultset.getString("personposition");
                String s8 = resultset.getString("persontrust");
                String s10 = resultset.getString("personTelephone");
                companyperson = new CompanyPerson(i, j, s2, k, s4, s6, s8, s10);
            }

        }
        catch(Exception exception)
        {
            System.out.println("companylisttag-getpersons+++ " + exception);
        }
        return arraylist;
    }

    public CompanyListTag()
    {
    }

    private String projectId;
    Collection companys;
    Collection persons;
    String projectIdStr;
}
