// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   bbsboard.java

package test;

import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;

// Referenced classes of package test:
//            bbsreg

public class bbsboard
{

    public bbsboard()
    {
        dbconn = new bbsreg();
        rs = null;
        boardname = "";
        boardmaster = "";
        masterpwd = "";
        masterword = "";
        masteremail = "";
        boardid = 0;
        boardhits = 0;
        boardtopics = 0;
    }

    public boolean checkBoardMaster(int j, String s, String s1)
    {
        rs = null;
        strSQL = "select * from board where boardmaster='" + s + "' and masterpwd='" + s1 + "' and boardid=" + j;
        try
        {
            rs = dbconn.executeQuery(strSQL);
            if(rs.next())
            {
                yesorno = true;
                getBoardInfo(j);
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

    public boolean checkBoardName(String s)
    {
        rs = null;
        yesorno = true;
        strSQL = "select * from board where boardname='" + s + "'";
        try
        {
            rs = dbconn.executeQuery(strSQL);
            if(rs.next())
                yesorno = false;
            rs.close();
        }
        catch(SQLException sqlexception)
        {
            System.err.println("aq.executeQuery: " + sqlexception.getMessage());
            System.err.println("countUser.STRSQL:: " + strSQL);
        }
        return yesorno;
    }

    public int countBoard()
    {
        strSQL = "SELECT COUNT(*) AS aa FROM board";
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
            System.err.println("aq.executeQuery: " + sqlexception.getMessage());
            System.err.println("countUser.STRSQL:: " + strSQL);
        }
        return i;
    }

    public void delBoard(int j)
    {
        strSQL = "delete from board where boardid=" + j;
        dbconn.executeUpdate(strSQL);
        strSQL = "delete from bbs where boardid=" + boardid;
        dbconn.executeUpdate(strSQL);
    }

    public int getBoardHits()
    {
        return boardhits;
    }

    public int getBoardId()
    {
        return boardid;
    }

    public boolean getBoardInfo(int j)
    {
        rs = null;
        strSQL = "select * from board where boardid=" + j;
        try
        {
            rs = dbconn.executeQuery(strSQL);
            if(rs.next())
            {
                yesorno = true;
                boardid = rs.getInt("boardid");
                boardname = rs.getString("boardname");
                boardmaster = rs.getString("boardmaster");
                masterpwd = rs.getString("masterpwd");
                masterword = rs.getString("masterword");
                masteremail = rs.getString("masteremail");
                boardhits = rs.getInt("boardhits");
                boardtopics = rs.getInt("boardtopics");
            } else
            {
                yesorno = false;
            }
            rs.close();
        }
        catch(SQLException sqlexception)
        {
            System.err.println("aq.executeQuery: " + sqlexception.getMessage());
            System.err.println("aq.STRSQL:: " + strSQL);
        }
        return yesorno;
    }

    public String getBoardMaster()
    {
        return boardmaster;
    }

    public String getBoardMasteremail()
    {
        return masteremail;
    }

    public String getBoardMasterpwd()
    {
        return masterpwd;
    }

    public String getBoardMasterword()
    {
        return masterword;
    }

    public String getBoardName()
    {
        return boardname;
    }

    public int getBoardTopics()
    {
        return boardtopics;
    }

    public ResultSet listBoard(int j)
    {
        rs = null;
        switch(j)
        {
        case 1: // '\001'
            strSQL = "select * from board order by boardid desc";
            break;

        case 2: // '\002'
            strSQL = "select * from board order by boardhits desc";
            break;

        case 3: // '\003'
            strSQL = "select * from board order by boardtopics desc";
            break;

        default:
            strSQL = "select * from board";
            break;
        }
        rs = dbconn.executeQuery(strSQL);
        return rs;
    }

    public void newBoard()
    {
        strSQL = "insert into board(boardname,boardmaster,masterpwd,masteremail,masterword,boardhits,boardtopics) values('" + boardname + "','" + boardmaster + "','" + masterpwd + "','" + masteremail + "','" + masterword + "'," + boardhits + "," + boardtopics + ")";
        dbconn.executeUpdate(strSQL);
    }

    public void setBoardHits(int j)
    {
        boardhits = j;
    }

    public void setBoardMaster(String s)
    {
        boardmaster = s;
    }

    public void setBoardMasteremail(String s)
    {
        masteremail = s;
    }

    public void setBoardMasterpwd(String s)
    {
        masterpwd = s;
    }

    public void setBoardMasterword(String s)
    {
        masterword = s;
    }

    public void setBoardName(String s)
    {
        boardname = s;
    }

    public void setBoardTopics(int j)
    {
        boardtopics = j;
    }

    public void updateBoard(int j)
    {
        strSQL = "update board set boardmaster='" + boardmaster + "',masterpwd='" + masterpwd + "',masteremail='" + masteremail + "',masterword='" + masterword + "' where boardid=" + j;
        dbconn.executeUpdate(strSQL);
    }

    public void updateBoardHits(int j, int k)
    {
        strSQL = "update board set boardhits=boardhits+" + k + " where boardid=" + j;
        dbconn.executeUpdate(strSQL);
    }

    public void updateBoardTopics(int j, int k)
    {
        strSQL = "update board set boardtopics=boardtopics+" + k + " where boardid=" + j;
        dbconn.executeUpdate(strSQL);
    }

    bbsreg dbconn;
    ResultSet rs;
    String strSQL;
    int i;
    boolean yesorno;
    String boardname;
    String boardmaster;
    String masterpwd;
    String masterword;
    String masteremail;
    int boardid;
    int boardhits;
    int boardtopics;
}
