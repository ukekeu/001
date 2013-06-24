// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   UserLogin.java

package login;

import ConnDatabase.SDatabase;
import crypt.MD5;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Hashtable;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import setProperty.setpopedom;

// Referenced classes of package login:
//            AddtData

public class UserLogin
{
	private static Logger logger = LoggerFactory.getLogger(UserLogin.class);

    public UserLogin()
    {
        str = "";
        okmess = "";
        strmm = "";
        ClssFile = "";
    }

    public String CheckUser(String s, String s1, String s2)
        throws Exception
    {
        boolean flag = false;
        String s3 = "";
        String s4 = "";
        String s6 = "";
        String s7 = "";
        boolean flag1 = false;
        SDatabase sdatabase = new SDatabase();
        MD5 md5 = new MD5();
        setpopedom setpopedom1 = new setpopedom();
        AddtData addtdata = new AddtData();
        Object obj = null;
        s7 = md5.getMD5ofStr(s1);
        s6 = md5.getMD5ofStr(s);
        s4 = "select state, SerialNo from  CortrolMan  where active=1 and IN_NO='" + s6 + "' and password='" + s7 + "'";
        try
        {
            ResultSet resultset = sdatabase.executeQuery(s4);
            if(resultset.next())
            {
                flag1 = resultset.getBoolean("state");
                s6 = resultset.getString("SerialNo");
                if(flag1)
                {
                	logger.info("<script> alert('\u6B64\u7528\u6237\u5DF2\u5728\u7EBF\uFF0C\u4E0D\u80FD\u518D\u6B21\u767B\u5F55\uFF0C\u8BF7\u79BB\u5F00\uFF01');");
                	logger.info(" window.location='../index.jsp';");
                	logger.info("</script>");
                }
            }
            resultset.close();
            if(!flag1)
            {
                boolean flag2 = false;
                String s8 = " select * from teaman inner join CortrolMan on teaman.mid = CortrolMan.id  where active=1 and   CortrolMan.SerialNo='" + s6 + "' and password='" + s7 + "'";
                ResultSet resultset2 = sdatabase.executeQuery(s8);
                if(resultset2.next())
                    flag2 = true;
                resultset2.close();
                String s5;
                if(flag2)
                    s5 = " select  ManModuleCortrol.section,   ManModuleCortrol.ManModule,  ManModuleCortrol.SellerId,  CortrolMan.job,CortrolMan.name, CortrolMan.dept, getdate() indatetime  from  ManModuleCortrol,CortrolMan,teaman  where  convert( varchar , teaman.tid ) = ManModuleCortrol.SellerId and  teaman.mid = CortrolMan.id and  CortrolMan.SerialNo in  (select SerialNo from CortrolMan where active=1 and   SerialNo = '" + s6 + "'  and password='" + s7 + "')";
                else
                    s5 = "select ManModuleCortrol.section,ManModuleCortrol.ManModule,ManModuleCortrol.SellerId,CortrolMan.job,CortrolMan.name, CortrolMan.dept,getdate() indatetime  from ManModuleCortrol,CortrolMan where  CortrolMan.SerialNo=ManModuleCortrol.SellerId and ManModuleCortrol.SellerId in(select SerialNo from CortrolMan where active=1 and   SerialNo='" + s6 + "'  and password='" + s7 + "')";
                ResultSet resultset1 = sdatabase.executeQuery(s5);
                Hashtable hashtable = new Hashtable();
                String s9 = "";
                String s10 = "";
                String s12 = "";
                String s13 = "";
                String s14 = "";
                String s15 = "";
                String s16 = "";
                String s17 = "";
                for(; resultset1.next(); System.out.println(s13))
                {
                    String s11 = resultset1.getString("section");
                    if(!s12.equals(""))
                    {
                        if(!s12.equals(s11))
                        {
                            s3 = s3 + "/" + s12;
                            s12 = s11;
                        }
                    } else
                    {
                        s12 = s11;
                        s3 = s3 + s12;
                    }
                    String s18 = resultset1.getString("ManModule");
                    strmm += "," + s18;
                    s9 = s9 + s18;
                    str += "," + s11;
                    hashtable.put(s18, s11);
                    s13 = resultset1.getString("SellerId");
                    s14 = resultset1.getString("job");
                    s15 = resultset1.getString("name");
                    s16 = resultset1.getString("dept");
                    s17 = resultset1.getString("indatetime");
                    s9 = s9 + s18;
                }

                resultset1.close();
                addtdata.setUserid(s13);
                addtdata.setUserjob(s14);
                addtdata.setUsername(s15);
                addtdata.setUserdept(s16);
                addtdata.setLogintime(s17);
                addtdata.setUserstate("1");
                addtdata.setId(s6);
                setpopedom1.setPopedomlist(s9);
                setpopedom1.setDic(hashtable);
                int i = 0;
                for(int j = 0; j < s3.length(); j++)
                    if(s3.substring(j, j + 1).equals("/"))
                        i++;

                s3 = s3 + "*" + s9 + "*" + s13 + "," + s14 + "," + s15 + "," + s16 + "," + s17 + "," + s6;
                String s19 = "select max(id)+1 AS ID from WorkingJournalRecord";
                String s20 = "";
                resultset1 = sdatabase.executeQuery(s19);
                if(resultset1.next())
                    s20 = resultset1.getString("ID");
                resultset1.close();
                if(s20 == null)
                    s20 = "1";
                addtdata.setWorkingID(s20);
                String s21 = "insert into WorkingJournalRecord(username,inDatetime,moudlename,ip) values('" + addtdata.getUsername() + "',getdate(),'\u767B\u5F55\u7CFB\u7EDF','" + s2 + "')";
                sdatabase.executeUpdate(s21);
            }
        }
        catch(SQLException sqlexception)
        {
            s3 = sqlexception.getMessage();
            logger.info("RoomList : " + sqlexception.getMessage());
        }
        return s3;
    }

    public void colorFace()
    {
        String s = "SELECT * FROM FactColor where Active=1";
        SDatabase sdatabase = new SDatabase();
        Object obj = null;
        try
        {
            ResultSet resultset = sdatabase.executeQuery(s);
            if(resultset.next())
                ClssFile = resultset.getString("ClssFile");
            resultset.close();
        }
        catch(Exception exception) { }
    }

    public String checkREG()
    {
        Object obj = null;
        String s = "";
        SDatabase sdatabase = new SDatabase();
        String s1 = "select  * from  user_reg  where  end_date<getdate() and state=1";
        try
        {
            ResultSet resultset = sdatabase.executeQuery(s1);
            if(resultset.next())
            {
                s = "\u7CFB\u7EDF\u8FC7\u671F\uFF0C\u8BF7\u5373\u65F6\u8054\u7CFB\u63D0\u4F9B\u5546";
                resultset.close();
            } else
            {
                resultset.close();
                String s2 = "select  * from  user_reg";
                resultset = sdatabase.executeQuery(s2);
                if(resultset.next())
                    okmess = "|ok";
                resultset.close();
                s = "manager/index.jsp";
            }
        }
        catch(Exception exception) { }
        return s + okmess;
    }

    public String str;
    public String okmess;
    public String strmm;
    public String ClssFile;
}
