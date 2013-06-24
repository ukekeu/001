// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ExcelODBC.java

package ExcelODBC;

import java.io.PrintStream;
import java.sql.*;
import java.util.Properties;

public class ExcelODBC
{

    public void getDBdriver()
    {
        Properties properties = new Properties();
        java.io.InputStream inputstream = getClass().getResourceAsStream("../../DataSource.Properties");
        try
        {
            properties.load(inputstream);
        }
        catch(Exception exception)
        {
            System.out.print((new StringBuilder()).append(exception.getMessage()).append("can't   read   the   file").toString());
        }
        user = properties.getProperty("DataSource.sauser");
        pass = properties.getProperty("DataSource.sapass");
        database = properties.getProperty("DataSource.database");
        sConnStr = properties.getProperty("DataSource.sConnStr");
        sDBDriver = properties.getProperty("DataSource.sDBDriver");
    }

    public ExcelODBC()
    {
        sDBDriver = "com.microsoft.jdbc.sqlserver.SQLServerDriver";
        sConnStr = "jdbc:microsoft:sqlserver://127.0.0.1:1433";
        user = "";
        pass = "";
        database = "";
        conn = null;
        rs = null;
        stmt = null;
        transactionFlag = true;
        try
        {
            getDBdriver();
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

    public int executeUpdate(String s)
        throws SQLException
    {
        int i = stmt.executeUpdate(s);
        return i;
    }

    public ResultSet executeQuery(String s)
        throws SQLException
    {
        rs = null;
        rs = stmt.executeQuery(s);
        return rs;
    }

    public void setConnection()
        throws SQLException
    {
        conn = DriverManager.getConnection(sConnStr, user, pass);
    }

    public void startTransaction()
        throws SQLException
    {
        transactionFlag = false;
        conn.setAutoCommit(transactionFlag);
    }

    public void endTransaction()
        throws SQLException
    {
        transactionFlag = true;
        conn.setAutoCommit(transactionFlag);
    }

    public boolean isAutocommit()
    {
        return transactionFlag;
    }

    public void commit()
        throws SQLException
    {
        if(!isAutocommit())
        {
            conn.commit();
            System.out.println("commit");
        }
    }

    public void rollback()
        throws SQLException
    {
        if(!isAutocommit())
            conn.rollback();
    }

    String sDBDriver;
    String sConnStr;
    String user;
    String pass;
    String database;
    public Connection conn;
    ResultSet rs;
    Statement stmt;
    boolean transactionFlag;
}
