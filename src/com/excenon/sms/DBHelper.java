// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   DBHelper.java

package com.excenon.sms;

import java.sql.*;

// Referenced classes of package com.excenon.sms:
//            Config

public class DBHelper
{

    public DBHelper()
    {
    }

    public static Connection getConnection()
        throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException
    {
        Class.forName(driverName).newInstance();
        Connection con = DriverManager.getConnection(url, username, password);
        con.setCatalog(dbName);
        con.setAutoCommit(true);
        return con;
    }

    public static void close(Connection conn)
    {
        if(conn != null)
            try
            {
                conn.close();
            }
            catch(SQLException sqlexception) { }
    }

    private static String dbName;
    private static String sConnStr;
    private static String driverName;
    private static String username;
    private static String password;
    private static String url;

    static 
    {
        dbName = Config.getProperty(Config.Settings.DATABASE_NAME);
        sConnStr = Config.getProperty(Config.Settings.DATABASE_CONNSTR);
        driverName = Config.getProperty(Config.Settings.DATABASE_DBDRIVER);
        username = Config.getProperty(Config.Settings.DATABASE_USER);
        password = Config.getProperty(Config.Settings.DATABASE_PASSWD);
        url = sConnStr;
    }
}
