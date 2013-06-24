// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   bbs.java

package test;

import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;

// Referenced classes of package test:
//            bbsreg, bbsuser

public class bbs
{

    public bbs()
    {
        dbconn = new bbsreg();
        bbsuser = new bbsuser();
        rs = null;
        bbsid = 0;
        parentid = 0;
        boardid = 0;
        child = 0;
        username = "";
        useremail = "";
        userip = "";
        expression = "";
        usersign = "";
        bbstopic = "";
        bbscontent = "";
        bbshits = 0;
        bbslength = 0;
        bbshot = "";
    }

    public String addNewBbs()
    {
        strSQL = (new StringBuilder()).append("INSERT INTO bbs(parentid,boardid,child,username,useremail,userip,expression,usersign,bbstopic,bbscontent,bbshits,length) VALUES(").append(parentid).append(",").append(boardid).append(",").append(child).append(",'").append(username).append("','").append(useremail).append("','").append(userip).append("','").append(expression).append("','").append(usersign).append("','").append(bbstopic).append("','").append(bbscontent).append("',").append(bbshits).append(",").append(bbslength).append(")").toString();
        dbconn.executeUpdate(strSQL);
        return strSQL;
    }

    public void changeBbsChild(int j, int k)
    {
        strSQL = (new StringBuilder()).append("update bbs set child=child+").append(k).append(" where bbsid=").append(j).toString();
        dbconn.executeUpdate(strSQL);
    }

    public void changeBbsHits(int j, int k)
    {
        strSQL = (new StringBuilder()).append("update bbs set bbshits=bbshits+").append(k).append(" where bbsid=").append(j).toString();
        dbconn.executeUpdate(strSQL);
    }

    public void delBbs(int j)
    {
        rs = null;
        if(getBbsInfo(j))
        {
            if(parentid == 0)
            {
                strSQL = (new StringBuilder()).append("delete from bbs where parentid=").append(bbsid).toString();
                dbconn.executeUpdate(strSQL);
                strSQL = (new StringBuilder()).append("update board set boardtopics=boardtopics-1 where boardid=").append(boardid).toString();
                dbconn.executeUpdate(strSQL);
            } else
            {
                strSQL = (new StringBuilder()).append("update bbs set child=child-1 where bbsid=").append(parentid).toString();
                dbconn.executeUpdate(strSQL);
            }
            bbsuser.changeUserClass(username, -3);
            strSQL = (new StringBuilder()).append("delete from bbs where bbsid=").append(bbsid).toString();
            dbconn.executeUpdate(strSQL);
        }
    }

    public int getBbsBoardid()
    {
        return boardid;
    }

    public int getBbsChild()
    {
        return child;
    }

    public String getBbsContent()
    {
        return bbscontent;
    }

    public String getBbsExpression()
    {
        return expression;
    }

    public int getBbsHits()
    {
        return bbshits;
    }

    public String getBbsHot()
    {
        return bbshot;
    }

    public boolean getBbsInfo(int j)
    {
        rs = null;
        strSQL = (new StringBuilder()).append("select * from bbs where bbsid=").append(j).toString();
        try
        {
            rs = dbconn.executeQuery(strSQL);
            if(rs.next())
            {
                yesorno = true;
                bbsid = rs.getInt("bbsid");
                parentid = rs.getInt("parentid");
                boardid = rs.getInt("boardid");
                child = rs.getInt("child");
                username = rs.getString("username");
                useremail = rs.getString("useremail");
                userip = rs.getString("userip");
                expression = rs.getString("expression");
                usersign = rs.getString("usersign");
                bbstopic = rs.getString("bbstopic");
                bbscontent = rs.getString("bbscontent");
                bbshits = rs.getInt("bbshits");
                bbslength = rs.getInt("length");
                bbshot = rs.getString("bbshot");
            } else
            {
                yesorno = false;
            }
            rs.close();
        }
        catch(SQLException sqlexception)
        {
            System.err.println((new StringBuilder()).append("aq.executeQuery: ").append(sqlexception.getMessage()).toString());
            System.err.println((new StringBuilder()).append("aq.STRSQL:: ").append(strSQL).toString());
        }
        return yesorno;
    }

    public int getBbsLength()
    {
        return bbslength;
    }

    public int getBbsParentid()
    {
        return parentid;
    }

    public String getBbsTopic()
    {
        return bbstopic;
    }

    public String getBbsUseremail()
    {
        return useremail;
    }

    public String getBbsUserip()
    {
        return userip;
    }

    public String getBbsUsername()
    {
        return username;
    }

    public String getBbsUsersign()
    {
        return usersign;
    }

    public int getRecordsCount(int j, int k, String s)
    {
        rs = null;
        i = 0;
        switch(j)
        {
        case 0: // '\0'
            strSQL = (new StringBuilder()).append("SELECT COUNT(*) AS aa FROM bbs WHERE parentid=0 and boardid=").append(k).toString();
            break;

        case 8: // '\b'
            strSQL = (new StringBuilder()).append("SELECT COUNT(*) AS aa FROM bbs WHERE parentid=0 and boardid=").append(k).toString();
            break;

        case 1: // '\001'
            strSQL = (new StringBuilder()).append("SELECT COUNT(*) AS aa FROM bbs where parentid=0 and boardid=").append(k).append(" and (bbstopic like '%").append(s).append("%')").toString();
            break;

        case 2: // '\002'
            strSQL = (new StringBuilder()).append("SELECT COUNT(*) AS aa FROM bbs where boardid=").append(k).append(" and (username like '%").append(s).append("%')").toString();
            break;

        case 3: // '\003'
            strSQL = (new StringBuilder()).append("SELECT COUNT(*) AS aa FROM bbs where boardid=").append(k).append(" and (dateandtime >=#").append(s).append("#)").toString();
            break;

        case 4: // '\004'
            strSQL = (new StringBuilder()).append("SELECT COUNT(*) AS aa FROM bbs where bbshot='ok' and boardid=").append(k).toString();
            break;

        case 5: // '\005'
        case 6: // '\006'
        case 7: // '\007'
        default:
            strSQL = (new StringBuilder()).append("SELECT COUNT(*) AS aa FROM bbs WHERE parentid=0 and boardid=").append(k).toString();
            break;
        }
        try
        {
            rs = dbconn.executeQuery(strSQL);
            if(rs.next())
                i = rs.getInt("aa");
        }
        catch(SQLException sqlexception)
        {
            System.err.println((new StringBuilder()).append("aq.executeQuery: ").append(sqlexception.getMessage()).toString());
            System.err.println((new StringBuilder()).append("aq.STRSQL:!#: ").append(strSQL).toString());
        }
        return i;
    }

    public int getRecordsStart(int j, int k, int l, int i1, String s)
    {
        rs = null;
        i = 0;
        int j1 = 0;
        if(l == 0)
            j1 = 0;
        else
            j1 = (l - 1) * k + 1;
        switch(j)
        {
        case 8: // '\b'
            strSQL = (new StringBuilder()).append("SELECT TOP ").append(j1).append(" * FROM bbs WHERE parentid=0 and boardid=").append(i1).append(" ORDER BY dateandtime DESC").toString();
            break;

        case 0: // '\0'
            strSQL = (new StringBuilder()).append("SELECT TOP ").append(j1).append(" * FROM bbs WHERE parentid=0 and boardid=").append(i1).append(" ORDER BY dateandtime DESC").toString();
            break;

        case 1: // '\001'
            strSQL = (new StringBuilder()).append("SELECT TOP ").append(j1).append(" * FROM bbs WHERE parentid=0 and boardid=").append(i1).append(" and (bbstopic like '%").append(s).append("%') ORDER BY dateandtime DESC").toString();
            break;

        case 2: // '\002'
            strSQL = (new StringBuilder()).append("SELECT TOP ").append(j1).append(" * FROM bbs where boardid=").append(i1).append(" and (username like '%").append(s).append("%') order by dateandtime desc").toString();
            break;

        case 3: // '\003'
            strSQL = (new StringBuilder()).append("SELECT TOP ").append(j1).append(" * FROM bbs where boardid=").append(i1).append(" and (dateandtime >=#").append(s).append("#) order by dateandtime desc").toString();
            break;

        case 4: // '\004'
            strSQL = (new StringBuilder()).append("SELECT TOP ").append(j1).append(" * FROM bbs where bbshot='ok' and boardid=").append(i1).append(" order by dateandtime desc").toString();
            break;

        case 5: // '\005'
        case 6: // '\006'
        case 7: // '\007'
        default:
            strSQL = (new StringBuilder()).append("SELECT TOP ").append(j1).append(" * FROM bbs WHERE parentid=0 and boardid=").append(i1).append(" ORDER BY dateandtime DESC").toString();
            break;
        }
        try
        {
            for(rs = dbconn.executeQuery(strSQL); rs.next();)
                i = rs.getInt("bbsid");

            rs.close();
        }
        catch(SQLException sqlexception)
        {
            System.err.println((new StringBuilder()).append("aq.executeQuery: ").append(sqlexception.getMessage()).toString());
            System.err.println((new StringBuilder()).append("aq.STRSQL:!#$$: ").append(strSQL).toString());
        }
        return i;
    }

    public ResultSet listBbs(int j, int k, int l, int i1, String s)
    {
        rs = null;
        i = getRecordsStart(j, k, l, i1, s);
        switch(j)
        {
        case 0: // '\0'
            strSQL = (new StringBuilder()).append("SELECT TOP ").append(k).append(" * FROM bbs WHERE parentid=0 and boardid=").append(i1).append(" and bbsid<=").append(i).append(" ORDER BY dateandtime DESC").toString();
            break;

        case 1: // '\001'
            strSQL = (new StringBuilder()).append("SELECT TOP ").append(k).append(" * FROM bbs WHERE parentid=0 and boardid=").append(i1).append(" and (bbstopic like '%").append(s).append("%') and bbsid<=").append(i).append(" ORDER BY bbsid DESC").toString();
            break;

        case 8: // '\b'
            strSQL = (new StringBuilder()).append("SELECT TOP ").append(k).append(" * FROM bbs WHERE parentid=0 and boardid=").append(i1).append(" and bbsid<=").append(i).append(" ORDER BY bbsid DESC").toString();
            break;

        case 2: // '\002'
            strSQL = (new StringBuilder()).append("SELECT TOP ").append(k).append(" * FROM bbs where boardid=").append(i1).append(" and (username like '%").append(s).append("%') and bbsid<=").append(i).append(" order by bbsid desc").toString();
            break;

        case 3: // '\003'
            strSQL = (new StringBuilder()).append("SELECT * FROM bbs where boardid=").append(i1).append(" and (dateandtime >=#").append(s).append("#) and bbsid<=").append(i).append(" order by bbsid desc").toString();
            break;

        case 4: // '\004'
            strSQL = (new StringBuilder()).append("SELECT * FROM bbs where bbshot='ok' and boardid=").append(i1).append(" and bbsid<=").append(i).append(" order by bbsid desc").toString();
            break;

        case 5: // '\005'
        case 6: // '\006'
        case 7: // '\007'
        default:
            strSQL = (new StringBuilder()).append("SELECT TOP ").append(k).append(" * FROM bbs WHERE parentid=0 and boardid=").append(i1).append(" and bbsid<=").append(i).append(" ORDER BY bbsid DESC").toString();
            break;
        }
        rs = dbconn.executeQuery(strSQL);
        return rs;
    }

    public ResultSet listBbsRe(int j)
    {
        rs = null;
        strSQL = (new StringBuilder()).append("select * from bbs where parentid=").append(j).toString();
        rs = dbconn.executeQuery(strSQL);
        return rs;
    }

    public void setBbsBoardid(int j)
    {
        boardid = j;
    }

    public void setBbsChild(int j)
    {
        child = j;
    }

    public void setBbsContent(String s)
    {
        bbscontent = s;
    }

    public void setBbsExpression(String s)
    {
        expression = s;
    }

    public void setBbsHits(int j)
    {
        bbshits = j;
    }

    public void setBbsHot(int j)
    {
        strSQL = (new StringBuilder()).append("update bbs set bbshot='ok' where bbsid=").append(j).toString();
        dbconn.executeUpdate(strSQL);
    }

    public void setBbsHot(String s)
    {
        bbshot = s;
    }

    public void setBbsLength(int j)
    {
        bbslength = j;
    }

    public void setBbsNohot(int j)
    {
        strSQL = (new StringBuilder()).append("update bbs set bbshot='no' where bbsid=").append(j).toString();
        dbconn.executeUpdate(strSQL);
    }

    public void setBbsParentid(int j)
    {
        parentid = j;
    }

    public void setBbsTopic(String s)
    {
        bbstopic = s;
    }

    public void setBbsUseremail(String s)
    {
        useremail = s;
    }

    public void setBbsUserip(String s)
    {
        userip = s;
    }

    public void setBbsUsername(String s)
    {
        username = s;
    }

    public void setBbsUsersign(String s)
    {
        usersign = s;
    }

    bbsreg dbconn;
    bbsuser bbsuser;
    ResultSet rs;
    String strSQL;
    boolean yesorno;
    int i;
    int bbsid;
    int parentid;
    int boardid;
    int child;
    int bbshits;
    int bbslength;
    String username;
    String useremail;
    String userip;
    String expression;
    String usersign;
    String bbstopic;
    String bbscontent;
    String bbshot;
}
