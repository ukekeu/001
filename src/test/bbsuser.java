// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   bbsuser.java

package test;

import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

// Referenced classes of package test:
//            bbsreg

public class bbsuser
{

    public bbsuser()
    {
        dbconn = new bbsreg();
        rs = null;
        userid = 0;
        username = null;
        userpassword = null;
        useremail = null;
        userhomepage = null;
        hpname = null;
        usersex = null;
        comefrom = null;
        usersign = null;
        userclass = 0;
        userbirthday = new Date();
        dateandtime = new Date();
    }

    public void changeUserClass(String s, int j)
    {
        strSQL = (new StringBuilder()).append("update bbsuser set userclass=userclass+").append(j).append(" where username='").append(s).append("'").toString();
        dbconn.executeUpdate(strSQL);
    }

    public void changeUserPassword(String s, String s1)
    {
        strSQL = (new StringBuilder()).append("update bbsuser set userpassword='").append(s1).append("' where username='").append(s).append("'").toString();
        dbconn.executeUpdate(strSQL);
    }

    public boolean checkUserPassword(String s, String s1)
    {
        rs = null;
        strSQL = (new StringBuilder()).append("select * from bbsuser where username='").append(s).append("' and userpassword='").append(s1).append("'").toString();
        try
        {
            rs = dbconn.executeQuery(strSQL);
            if(rs.next())
            {
                isUser = true;
                getUserInfo(s);
            } else
            {
                isUser = false;
            }
            rs.close();
        }
        catch(SQLException sqlexception)
        {
            System.err.println((new StringBuilder()).append("aq.executeQuery: ").append(sqlexception.getMessage()).toString());
            System.err.println((new StringBuilder()).append("checkuserpassword.STRSQL:: ").append(strSQL).toString());
        }
        return isUser;
    }

    public int countUser()
    {
        strSQL = "SELECT COUNT(*) AS aa from bbsuser";
        i = 0;
        try
        {
            rs = dbconn.executeQuery(strSQL);
            if(rs.next())
                i = rs.getInt("aa");
            rs.close();
        }
        catch(SQLException sqlexception)
        {
            System.err.println((new StringBuilder()).append("aq.executeQuery: ").append(sqlexception.getMessage()).toString());
            System.err.println((new StringBuilder()).append("countUser.STRSQL:: ").append(strSQL).toString());
        }
        return i;
    }

    public void delUser(String s)
    {
        strSQL = (new StringBuilder()).append("delete from bbsuser where username='").append(s).append("'").toString();
        dbconn.executeUpdate(strSQL);
    }

    public Date getUserBirthday()
    {
        return userbirthday;
    }

    public int getUserClass()
    {
        return userclass;
    }

    public String getUserComefrom()
    {
        return comefrom;
    }

    public Date getUserDateandtime()
    {
        return dateandtime;
    }

    public String getUserEmail()
    {
        return useremail;
    }

    public String getUserHomepage()
    {
        return userhomepage;
    }

    public String getUserHomepagename()
    {
        return hpname;
    }

    public int getUserId()
    {
        return userid;
    }

    public boolean getUserInfo(String s)
    {
        rs = null;
        strSQL = (new StringBuilder()).append("select * from bbsuser where username='").append(s).append("'").toString();
        try
        {
            rs = dbconn.executeQuery(strSQL);
            if(rs.next())
            {
                isUser = true;
                userid = rs.getInt("userid");
                username = rs.getString("username");
                userpassword = rs.getString("userpassword");
                useremail = rs.getString("useremail");
                userhomepage = rs.getString("userhomepage");
                hpname = rs.getString("hpname");
                userbirthday = rs.getDate("userbirthday");
                usersex = rs.getString("usersex");
                comefrom = rs.getString("comefrom");
                userclass = rs.getInt("userclass");
                usersign = rs.getString("usersign");
                dateandtime = rs.getDate("dateandtime");
            } else
            {
                isUser = false;
            }
            rs.close();
        }
        catch(SQLException sqlexception)
        {
            System.err.println((new StringBuilder()).append("aq.executeQuery: ").append(sqlexception.getMessage()).toString());
            System.err.println((new StringBuilder()).append("aq.STRSQL:: ").append(strSQL).toString());
        }
        return isUser;
    }

    public String getUserName()
    {
        return username;
    }

    public String getUserPassword()
    {
        return userpassword;
    }

    public String getUserSex()
    {
        return usersex;
    }

    public String getUserSign()
    {
        return usersign;
    }

    public ResultSet listUser(int j)
    {
        rs = null;
        switch(j)
        {
        case 1: // '\001'
            strSQL = "select * from bbsuser order by userid desc";
            break;

        case 2: // '\002'
            strSQL = "select * from bbsuser order by username desc";
            break;

        case 3: // '\003'
            strSQL = "select * from bbsuser order by userclass desc";
            break;

        default:
            strSQL = "select * from bbsuser order by userid desc";
            break;
        }
        rs = dbconn.executeQuery(strSQL);
        return rs;
    }

    public void registryNewUser()
    {
        strSQL = (new StringBuilder()).append("INSERT INTO USER(username,userpassword,useremail,userhomepage,hpname,usersex,comefrom,userclass,usersign) values('").append(username).append("','").append(userpassword).append("','").append(useremail).append("','").append(userhomepage).append("','").append(hpname).append("','").append(usersex).append("','").append(comefrom).append("','").append(userclass).append("','").append(usersign).append("')").toString();
        dbconn.executeUpdate(strSQL);
    }

    public void setUserBirthday(Date date)
    {
        userbirthday = date;
    }

    public void setUserClass(int j)
    {
        userclass = j;
    }

    public void setUserComefrom(String s)
    {
        comefrom = s;
    }

    public void setUserDateandtime(Date date)
    {
        dateandtime = date;
    }

    public void setUserEmail(String s)
    {
        useremail = s;
    }

    public void setUserHomepage(String s)
    {
        userhomepage = s;
    }

    public void setUserHomepagename(String s)
    {
        hpname = s;
    }

    public void setUserName(String s)
    {
        username = s;
    }

    public void setUserPassword(String s)
    {
        userpassword = s;
    }

    public void setUserSex(String s)
    {
        usersex = s;
    }

    public void setUserSign(String s)
    {
        usersign = s;
    }

    public void updateUserInfo(String s)
    {
        strSQL = (new StringBuilder()).append("update bbsuser set useremail='").append(useremail).append("',userhomepage='").append(userhomepage).append("',hpname='").append(hpname).append("',usersex='").append(usersex).append("',comefrom='").append(comefrom).append("',usersign='").append(usersign).append("' where username='").append(s).append("'").toString();
        dbconn.executeUpdate(strSQL);
    }

    bbsreg dbconn;
    ResultSet rs;
    String strSQL;
    int i;
    boolean isUser;
    int userid;
    int userclass;
    String username;
    String userpassword;
    String useremail;
    String userhomepage;
    String hpname;
    String usersex;
    String comefrom;
    String usersign;
    Date userbirthday;
    Date dateandtime;
}
