// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   autoCount.java

package crmzl;

import java.io.PrintStream;
import java.sql.ResultSet;
import java.util.HashMap;

// Referenced classes of package crmzl:
//            crmzl, rentcount

public class autoCount
{

    public autoCount()
    {
        sectionRS = null;
        hm = null;
    }

    public String checkCount()
    {
        crmzl crmzl1 = new crmzl();
        crmzl crmzl2 = new crmzl();
        String s = "";
        try
        {
            ResultSet resultset = null;
            String s1 = "select counttype,c_day from RENT_DAY";
            resultset = crmzl1.executeQuery(s1);
            String s2 = "0";
            String s3 = "10";
            if(resultset.next())
            {
                s2 = resultset.getString("counttype");
                s3 = resultset.getString("c_day");
            }
            resultset.close();
            if(s2.equals("1"))
            {
                String s4 = "";
                String s5 = "";
                String s6 = "";
                String s7 = "";
                String s8 = "select contract_id,ids,state,id,rentype,ren,year(date1) as yy,month(date1) as mm,convert(char(10),getdate(),120) as dd,ContractID from PM_GETAPPENDDETAIL where state=0   And owner_id in (select owner_id from PM_GETOWNERROOM_VIEW where now_owner=1) And  ";
                s8 = (new StringBuilder()).append(s8).append("   owner_id in (select owner_id from PM_GETOWNERROOM_VIEW where now_owner=1)  ").toString();
                s8 = (new StringBuilder()).append(s8).append(" and convert(char(10),date1,120)<= convert(char(10),DATEADD(dd,").append(s3).append(",getdate()),120) order by date1").toString();
                for(resultset = crmzl1.executeQuery(s8); resultset.next(); crmzl2.executeUpdate(s8))
                {
                    String s10 = "  \u542F\u7528\u4EBA\uFF1A\u7CFB\u7EDF\u81EA\u52A8\u66F4\u65B0;\u542F\u7528\u65E5\u671F\uFF1A'+convert(char(10),getdate(),120)+';\u542F\u7528\u539F\u56E0\uFF1A\u7CFB\u7EDF\u68C0\u67E5\u5230\u5230\u671F";
                    s8 = (new StringBuilder()).append("update Rent_Contract1 set state=1,notes='").append(s10).append("'").toString();
                    s8 = (new StringBuilder()).append(s8).append(" where ID=").append(resultset.getString("ids")).toString();
                }

                resultset.close();
            }
            resultset = crmzl1.executeQuery("select *,day(getdate()) currday,case when monthtype=1 then month(getdate())+1   else  month(getdate()) end   mm,year(getdate())   yy,state,taxrate from  zljday ");
            boolean flag = false;
            int j = 0;
            int k = 0;
            int l = 0;
            String s9 = "0";
            String s11 = "";
            String s12 = "0";
            String s13 = "0";
            if(resultset.next())
            {
                int i = resultset.getInt("skday");
                j = resultset.getInt("currday");
                k = resultset.getInt("c_day");
                if(resultset.getInt("mm") < 10)
                    s11 = (new StringBuilder()).append("0").append(resultset.getString("mm")).toString();
                else
                    s11 = resultset.getString("mm");
                l = resultset.getInt("yy");
                s9 = resultset.getString("state");
                s12 = resultset.getString("taxrate");
                s13 = resultset.getString("htglf");
            }
            resultset.close();
            if(k <= j)
            {
                if(s11.length() == 0)
                    s11 = (new StringBuilder()).append("0").append(s11).toString();
                if(s11.equals("12"))
                    l++;
                rentcount rentcount1 = new rentcount();
                rentcount1.countcharges(String.valueOf(l), s11, s12, s9, s13, "");
            }
            s = "ok";
        }
        catch(Exception exception)
        {
            System.out.print(exception.getMessage());
            s = exception.getMessage();
        }
        return s;
    }

    ResultSet sectionRS;
    HashMap hm;
}
