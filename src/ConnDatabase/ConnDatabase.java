// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ConnDatabase.java

package ConnDatabase;

import java.io.PrintStream;
import java.sql.*;

public class ConnDatabase
{

    public ConnDatabase()
    {
        sDBDriver = "sun.jdbc.odbc.JdbcOdbcDriver";
        sConnStr = "jdbc:odbc:ftdc";
        conn = null;
        rs = null;
        stmt = null;
        transactionFlag = true;
        try
        {
            Class.forName(sDBDriver);
            setConnection();
            stmt = conn.createStatement();
        }
        catch(ClassNotFoundException classnotfoundexception)
        {
            System.err.println("ConnDatabase(): " + classnotfoundexception.getMessage());
        }
        catch(SQLException sqlexception)
        {
            System.err.println("ConnDatabase(): " + sqlexception.getMessage());
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
        conn = DriverManager.getConnection(sConnStr);
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
    Connection conn;
    ResultSet rs;
    Statement stmt;
    boolean transactionFlag;
}
