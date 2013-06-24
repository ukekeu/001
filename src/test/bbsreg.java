// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   bbsreg.java

package test;

import java.io.PrintStream;
import java.sql.*;

public class bbsreg
{

    public bbsreg()
    {
        conn = null;
        rs = null;
        sDBDriver = "com.microsoft.jdbc.sqlserver.SQLServerDriver";
        sConnStr = "jdbc:microsoft:sqlserver://127.0.0.1:1433";
        user = "crm";
        pass = "crm";
        database = "shcrm";
        conn = null;
        rs = null;
        stmt = null;
        transactionFlag = true;
        try
        {
            Class.forName(sDBDriver);
            setConnection();
            conn.setCatalog(database);
            stmt = conn.createStatement();
        }
        catch(ClassNotFoundException classnotfoundexception)
        {
            System.err.println((new StringBuilder()).append("ConnDatabase(): ").append(classnotfoundexception.getMessage()).toString());
        }
        catch(SQLException sqlexception)
        {
            System.err.println((new StringBuilder()).append("ConnDatabase(): ").append(sqlexception.getMessage()).toString());
        }
    }

    public void setConnection()
        throws SQLException
    {
        conn = DriverManager.getConnection(sConnStr, user, pass);
    }

    public ResultSet executeQuery(String s)
    {
        rs = null;
        try
        {
            Statement statement = conn.createStatement();
            rs = statement.executeQuery(s);
        }
        catch(SQLException sqlexception)
        {
            System.err.println((new StringBuilder()).append("aq.executeQuery: ").append(sqlexception.getMessage()).toString());
            System.err.println((new StringBuilder()).append("aq.executeQuerystrSQL: ").append(s).toString());
        }
        return rs;
    }

    public void executeUpdate(String s)
    {
        try
        {
            Statement statement = conn.createStatement();
            statement.executeUpdate(s);
        }
        catch(SQLException sqlexception)
        {
            System.err.println((new StringBuilder()).append("aq.executeUpdate: ").append(sqlexception.getMessage()).toString());
            System.err.println((new StringBuilder()).append("aq.executeUpadatestrSQL: ").append(s).toString());
        }
    }

    Connection conn;
    ResultSet rs;
    String sDBDriver;
    String sConnStr;
    String user;
    String pass;
    String database;
    Statement stmt;
    boolean transactionFlag;
}
