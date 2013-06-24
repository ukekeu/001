// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   UserLogin1.java

package login;

import ConnDatabase.SDatabase;
import crypt.MD4;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Hashtable;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import setProperty.setpopedom;

// Referenced classes of package login:
//            AddtData

public class UserLogin1
{
	private static Logger logger = LoggerFactory.getLogger(UserLogin1.class);

    public UserLogin1()
    {
    }

    public String CheckUser(String s, String s1, String s2,String mac)
        throws Exception
    {
        SDatabase sdatabase = new SDatabase();
        setpopedom setpopedom1 = new setpopedom();
        AddtData addtdata = new AddtData();
        String s3 = "";
        String s4 = "";
        String s5 = "";
        String s6 = "";
        boolean flag1 = false;
        MD4 md5 = new MD4();
        s6 = md5.getMD4ofStr(s1);
        s5 = md5.getMD4ofStr(s);
        s4 = "select state, SerialNo from  CortrolMan  where active=1 and IN_NO='" + s5 + "' and password='" + s6 + "'";
        ResultSet resultset;
        try
        {
            resultset = sdatabase.executeQuery(s4);
            if(resultset.next())
            {
                flag1 = resultset.getBoolean("state");
                s5 = resultset.getString("SerialNo");
                if(flag1)
                {
                	logger.info("<script> alert('\u6B64\u7528\u6237\u5DF2\u5728\u7EBF\uFF0C\u4E0D\u80FD\u518D\u6B21\u767B\u5F55\uFF0C\u8BF7\u79BB\u5F00\uFF01');");
                	logger.info(" window.location='../index.jsp';");
                	logger.info("</script>");
                }
            }
            resultset.close();
        }
        catch(SQLException sqlexception) { }
        boolean flag2 = false;
        String s7 = " select * from teaman inner join CortrolMan on teaman.mid = CortrolMan.id  where active=1 and   CortrolMan.SerialNo='" + s5 + "' and password='" + s6 + "'";
        ResultSet resultset1 = sdatabase.executeQuery(s7);
        if(resultset1.next())
            flag2 = true;
        resultset1.close();
        if(flag2)
            s4 = " select  ManModuleCortrol.section,   ManModuleCortrol.ManModule,  ManModuleCortrol.SellerId,  CortrolMan.job,CortrolMan.name, CortrolMan.dept, getdate() indatetime  from  ManModuleCortrol,CortrolMan,teaman  where  convert( varchar , teaman.tid ) = ManModuleCortrol.SellerId and  teaman.mid = CortrolMan.id and  CortrolMan.SerialNo in  (select SerialNo from CortrolMan where active=1 and   SerialNo = '" + s5 + "'  and password='" + s6 + "')";
        else
            s4 = "select ManModuleCortrol.section,ManModuleCortrol.ManModule,ManModuleCortrol.SellerId,CortrolMan.job,CortrolMan.name, CortrolMan.dept,getdate() indatetime  from ManModuleCortrol,CortrolMan where  CortrolMan.SerialNo=ManModuleCortrol.SellerId and ManModuleCortrol.SellerId in(select SerialNo from CortrolMan where active=1 and   SerialNo='" + s5 + "'  and password='" + s6 + "')";
        resultset = sdatabase.executeQuery(s4);
        Hashtable hashtable = new Hashtable();
        String s8 = "";
        String s11 = "";
        String s12 = "";
        String s13 = "";
        String s14 = "";
        String s15 = "";
        String s16 = "";
        for(; resultset.next(); System.out.println(s12))
        {
            String s10 = resultset.getString("section");
            if(!s11.equals(""))
            {
                if(!s11.equals(s10))
                {
                    s3 = s3 + "/" + s11;
                    s11 = s10;
                }
            } else
            {
                s11 = s10;
                s3 = s3 + s11;
            }
            String s17 = resultset.getString("ManModule");
            str += "," + s17;
            hashtable.put(s17, s10);
            s12 = resultset.getString("SellerId");
            s13 = resultset.getString("job");
            s14 = resultset.getString("name");
            s15 = resultset.getString("dept");
            s16 = resultset.getString("indatetime");
            s8 = s8 + s17;
        }

        resultset.close();
        addtdata.setUserid(s12);
        addtdata.setUserjob(s13);
        addtdata.setUsername(s14);
        addtdata.setUserdept(s15);
        addtdata.setLogintime(s16);
        addtdata.setUserstate("1");
        addtdata.setId(s5);
        setpopedom1.setPopedomlist(s8);
        setpopedom1.setDic(hashtable);
        int i = 0;
        for(int j = 0; j < s3.length(); j++)
            if(s3.substring(j, j + 1).equals("/"))
                i++;

        s3 = s3 + "*" + s8 + "*" + s12 + "," + s13 + "," + s14 + "," + s15 + "," + s16 + "," + s5;
        String s18 = "select max(id)+1 AS ID from WorkingJournalRecord";
        String s19 = "";
        resultset = sdatabase.executeQuery(s18);
        if(resultset.next())
            s19 = resultset.getString("ID");
        resultset.close();
        if(s19 == null)
            s19 = "1";
        addtdata.setWorkingID(s19);
        String s20 = "insert into WorkingJournalRecord(username,inDatetime,moudlename,ip) values('" + addtdata.getUsername() + "',getdate(),'\u767B\u5F55\u7CFB\u7EDF','" + s2 + "')";
        sdatabase.executeUpdate(s20);
        logger.info(s3 + s4);
        return s3;
    }

    public void colorFace()
    {
        String s = "SELECT * FROM FactColor where Active=1";
        SDatabase sdatabase = new SDatabase();
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
