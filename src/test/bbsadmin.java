// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   bbsadmin.java

package test;

import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;

// Referenced classes of package test:
//            bbsreg

public class bbsadmin
{

    public bbsadmin()
    {
        dbconn = new bbsreg();
        rs = null;
        id = 0;
        adminname = "";
        adminpwd = "";
    }

    public boolean checkAdminPassword(String s, String s1)
    {
        rs = null;
        strSQL = "select * from admin where adminname='" + s + "' and adminpwd='" + s1 + "'";
        try
        {
            rs = dbconn.executeQuery(strSQL);
            if(rs.next())
            {
                yesorno = true;
                adminname = rs.getString("adminname");
                adminpwd = rs.getString("adminpwd");
            } else
            {
                yesorno = false;
            }
            rs.close();
        }
        catch(SQLException sqlexception)
        {
            System.err.println("aq.executeQuery: " + sqlexception.getMessage());
            System.err.println("checkuserpassword.STRSQL:: " + strSQL);
        }
        return yesorno;
    }

    public String getAdminName()
    {
        return adminname;
    }

    public String getAdminPassword()
    {
        return adminpwd;
    }

    bbsreg dbconn;
    ResultSet rs;
    String strSQL;
    boolean yesorno;
    int id;
    String adminname;
    String adminpwd;
}
