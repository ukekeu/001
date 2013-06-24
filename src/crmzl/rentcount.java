// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   rentcount.java

package crmzl;

import ConnDB.ConnODBC;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.util.HashMap;

public class rentcount
{

    public rentcount()
    {
        sectionRS = null;
        hm = null;
    }

    public void countcharges(String s, String s1, String s2, String s3, String s4, String s5)
    {
        ConnODBC connodbc = new ConnODBC();
        ConnODBC connodbc1 = new ConnODBC();
        ConnODBC connodbc2 = new ConnODBC();
        String s6 = "";
        String s7 = "";
        boolean flag = true;
        try
        {
            ResultSet resultset = null;
            Object obj = null;
            if(s3.equals("1"))
            {
                s6 = (new StringBuilder()).append("select  rentno,charges, money-f_money qk,convert(char(10),c_date,120) olddate,dateadd(m,1,c_date) md,datediff(d, c_date,dateadd(m,1,c_date))  dd from Rent_Charges where  rentno in (select ID from PM_GETRENTDETAIL where uptown_id='").append(s5).append("' AND CONVERT(char(7), BeginDate, 120) <= '").append(s).append("-").append(s1).append("') and fg<2 and  convert(char(7),c_date,120)< convert(char(7),CAST('").append(s).append("-").append(s1).append("-1' AS SMALLDATETIME),120)").toString();
                System.out.println((new StringBuilder()).append(s6).append("<br>").toString());
                for(resultset = connodbc1.executeQuery(s6); resultset.next(); connodbc2.executeUpdate(s6))
                {
                    String s8 = resultset.getString("rentno");
                    String s10 = resultset.getString("charges");
                    String s13 = resultset.getString("qk");
                    String s15 = resultset.getString("md");
                    String s18 = resultset.getString("dd");
                    String s21 = resultset.getString("olddate");
                    s6 = (new StringBuilder()).append("update  Rent_Charges  set fg=3 where  rentno in (select ID from PM_GETRENTDETAIL where  uptown_id='").append(s5).append("' AND counttype<2  ) and convert(char(10),c_date,120)='").append(s21).append("'  and fg<2 and rentno=").append(s8).toString();
                    connodbc2.executeUpdate(s6);
                    s6 = " insert into Rent_Charges(rentno,charges,money,c_date,charges_type) values(";
                    s6 = (new StringBuilder()).append(s6).append(s8).append(",'").append(s10).append("(\u4E0A\u6708\u6B20)").append("',").append(s13).append(",'").append(s15).append("',1)").toString();
                }

                resultset.close();
            }
            String s9 = "1";
            String s11 = "1";
            String s14 = "1";
            String s16 = "1";
            String s19 = "1";
            resultset = connodbc1.executeQuery("select * from  zljday");
            if(resultset.next())
            {
                int i = resultset.getInt("skday");
                if(i < 10)
                    s9 = (new StringBuilder()).append("0").append(String.valueOf(i)).toString();
                else
                    s9 = String.valueOf(i);
                String s12 = resultset.getString("monthtype");
                s14 = resultset.getString("jzd");
            }
            resultset.close();
            if(s14.equals("1"))
                s6 = (new StringBuilder()).append("select id,RentCharge*rent_count_fs as RentCharge,managetotal*glf_count_fs as managetotal,yxdsf,btwxj,ktf ,ccbxf,internet_c,'").append(s).append("-").append(s1).append("-").append(s9).append("' md,rent_count_fs,glf_count_fs from PM_GETRENTDETAIL where uptown_id='").append(s5).append("' AND counttype<2 and CONVERT(char(7), BeginDate, 120) <= '").append(s).append("-").append(s1).append("'  and SUBSTRING(CONVERT(CHAR(10), dateadd(mm,1,getdate()), 120), 1, 7) <=SUBSTRING(CONVERT(CHAR(10), EndDate, 120), 1, 7) and  flag=0   order by id ").toString();
            else
            if(s14.equals("2"))
                s6 = (new StringBuilder()).append("select id,RentCharge*rent_count_fs as RentCharge,managetotal*glf_count_fs as managetotal ,yxdsf,btwxj,ktf ,ccbxf,internet_c,day(begindate) md,month(getdate()) mmmm,datediff(day, datename(year, getdate()) + '-02-01', dateadd(mm, 1,datename(year, getdate()) + '-02-01')) mdd,rent_count_fs,glf_count_fs  from PM_GETRENTDETAIL where uptown_id='").append(s5).append("' AND counttype<2 and CONVERT(char(7), BeginDate, 120) <= '").append(s).append("-").append(s1).append("'  and SUBSTRING(CONVERT(CHAR(10), dateadd(mm,1,getdate()), 120), 1, 7) <=SUBSTRING(CONVERT(CHAR(10), EndDate, 120), 1, 7) and  flag=0 ").toString();
            resultset = connodbc2.executeQuery(s6);
            System.out.println(s6);
            for(; resultset.next(); connodbc1.executeUpdate("delete  rent_yj_money where  money<=0"))
            {
                String s22 = resultset.getString("id");
                String s23 = resultset.getString("RentCharge");
                if(s23 == null)
                    s23 = "0";
                String s24 = resultset.getString("managetotal");
                if(s24 == null)
                    s24 = "0";
                String s25 = resultset.getString("yxdsf");
                if(s25 == null)
                    s25 = "0";
                String s26 = resultset.getString("btwxj");
                if(s26 == null)
                    s26 = "0";
                String s27 = resultset.getString("ktf");
                if(s27 == null)
                    s27 = "0";
                String s28 = resultset.getString("ccbxf");
                if(s28 == null)
                    s28 = "0";
                String s29 = resultset.getString("internet_c");
                if(s29 == null)
                    s29 = "0";
                String s17 = resultset.getString("rent_count_fs");
                String s20 = resultset.getString("glf_count_fs");
                if(s17 == null)
                    s17 = "1";
                if(s20 == null)
                    s20 = "1";
                String s30 = "";
                boolean flag2 = false;
                boolean flag3 = false;
                boolean flag4 = false;
                if(s14.equals("1"))
                    s30 = resultset.getString("md");
                else
                if(s14.equals("2"))
                {
                    int j = resultset.getInt("md");
                    int k = resultset.getInt("mdd");
                    int l = Integer.parseInt(s1);
                    if((s1.equals("04") || s1.equals("06") || s1.equals("09") || s1.equals("11")) && j == 31)
                        j = 30;
                    if(j < 10)
                        s30 = (new StringBuilder()).append(s).append("-").append(s1).append("-0").append(String.valueOf(j)).toString();
                    else
                        s30 = (new StringBuilder()).append(s).append("-").append(s1).append("-").append(String.valueOf(j)).toString();
                    if(l == 2)
                        if(j > k)
                            s30 = (new StringBuilder()).append(s).append("-").append(s1).append("-").append(String.valueOf(k)).toString();
                        else
                            s30 = (new StringBuilder()).append(s).append("-").append(s1).append("-").append(String.valueOf(j)).toString();
                }
                s6 = (new StringBuilder()).append("select * from Rent_Charges    where rentno=").append(s22).append(" and  charges='\u79DF\u91D1' and  convert(char(10),e_date,120)>= convert(char(10),'").append(s30).append("',120) ").toString();
                String s31 = "";
                String s32 = "0";
                String s33 = "0";
                String s34 = "";
                Object obj1 = null;
                ResultSet resultset3 = connodbc.executeQuery(s6);
                if(!resultset3.next())
                {
                    s6 = (new StringBuilder()).append("select money,code,yj_date,charges from  rent_yj_money where charges='\u79DF\u91D1' AND  rentno=").append(s22).toString();
                    ResultSet resultset1 = connodbc1.executeQuery(s6);
                    if(resultset1.next())
                    {
                        s32 = resultset1.getString("money");
                        s33 = resultset1.getString("code");
                        s34 = resultset1.getString("yj_date");
                        s31 = resultset1.getString("charges");
                    }
                    resultset1.close();
                    String s35 = "0";
                    if(Float.parseFloat(s23) > 0.0F)
                    {
                        if(Float.parseFloat(s32) > 0.0F && Float.parseFloat(s32) - Float.parseFloat(s23) < 0.0F)
                            s35 = s32;
                        s6 = " insert into Rent_Charges(rentno,charges,money,c_date,s_date,e_date";
                        if(Float.parseFloat(s32) > 0.0F && s31.equals("\u79DF\u91D1"))
                            s6 = (new StringBuilder()).append(s6).append(",yjstate,yj_date,f_money").toString();
                        s6 = (new StringBuilder()).append(s6).append(") values(").toString();
                        s6 = (new StringBuilder()).append(s6).append(s22).append(",'\u79DF\u91D1',").append(s23).append(",'").append(s30).append("',").append("'").append(s30).append("',").append("dateadd(mm,").append(s17).append(",'").append(s30).append("')").toString();
                        if(Float.parseFloat(s32) > 0.0F && s31.equals("\u79DF\u91D1"))
                            s6 = (new StringBuilder()).append(s6).append(",1,'").append(s34).append("',").append(s35).toString();
                        s6 = (new StringBuilder()).append(s6).append(")").toString();
                        connodbc1.executeUpdate(s6);
                        s6 = " insert into Tax_charges(rentno,charges,money,c_date) values(";
                        s6 = (new StringBuilder()).append(s6).append(s22).append(",'\u5370\u82B1\u7A0E',").append(s23).append("*").append(s2).append("/100.0,'").append(s30).append("')").toString();
                        connodbc1.executeUpdate(s6);
                        s6 = " insert into Tax_charges(rentno,charges,money,c_date) values(";
                        s6 = (new StringBuilder()).append(s6).append(s22).append(",'\u5408\u540C\u7BA1\u7406\u8D39',").append(s23).append("*").append(s4).append("/100.0,'").append(s30).append("')").toString();
                        connodbc1.executeUpdate(s6);
                        connodbc1.executeUpdate("delete Tax_charges where money=0 or money is null");
                        if(Float.parseFloat(s32) > 0.0F && s31.equals("\u79DF\u91D1"))
                            connodbc1.executeUpdate((new StringBuilder()).append("update rent_yj_money set  money=money-").append(s23).append(" where code=").append(s33).toString());
                    }
                }
                resultset3.close();
                s6 = (new StringBuilder()).append("select * from Rent_Charges    where rentno=").append(s22).append(" and  charges='\u7BA1\u7406\u8D39' and  convert(char(10),e_date,120)>= convert(char(10),'").append(s30).append("',120) ").toString();
                resultset3 = connodbc.executeQuery(s6);
                if(!resultset3.next())
                {
                    s6 = (new StringBuilder()).append("select money,code,yj_date,charges from  rent_yj_money where charges='\u7BA1\u7406\u8D39' AND  rentno=").append(s22).toString();
                    ResultSet resultset2 = connodbc1.executeQuery(s6);
                    if(resultset2.next())
                    {
                        s32 = resultset2.getString("money");
                        s33 = resultset2.getString("code");
                        s34 = resultset2.getString("yj_date");
                        s31 = resultset2.getString("charges");
                    }
                    resultset2.close();
                    String s36 = "0";
                    if(Float.parseFloat(s24) > 0.0F)
                    {
                        if(Float.parseFloat(s32) > 0.0F && Float.parseFloat(s32) - Float.parseFloat(s24) < 0.0F)
                            s36 = s32;
                        s6 = " insert into Rent_Charges(rentno,charges,money,c_date,s_date,e_date ";
                        if(Float.parseFloat(s32) > 0.0F && s31.equals("\u7BA1\u7406\u8D39"))
                            s6 = (new StringBuilder()).append(s6).append(",yjstate,yj_date,f_money").toString();
                        s6 = (new StringBuilder()).append(s6).append(") values(").toString();
                        s6 = (new StringBuilder()).append(s6).append(s22).append(",'\u7BA1\u7406\u8D39',").append(s24).append(",'").append(s30).append("',").append("'").append(s30).append("',").append("dateadd(mm,").append(s20).append(",'").append(s30).append("')").toString();
                        if(Float.parseFloat(s32) > 0.0F && s31.equals("\u7BA1\u7406\u8D39"))
                            s6 = (new StringBuilder()).append(s6).append(",1,'").append(s34).append("',").append(s36).toString();
                        s6 = (new StringBuilder()).append(s6).append(")").toString();
                        connodbc1.executeUpdate(s6);
                        if(Float.parseFloat(s32) > 0.0F && s31.equals("\u7BA1\u7406\u8D39"))
                            connodbc1.executeUpdate((new StringBuilder()).append("update rent_yj_money set  money=money-").append(s23).append(" where code=").append(s33).toString());
                    }
                }
                resultset3.close();
                if(Float.parseFloat(s27) > 0.0F)
                {
                    s6 = (new StringBuilder()).append("select * from Rent_Charges    where rentno=").append(s22).append(" and  charges='\u7A7A\u8C03\u8D39' and  convert(char(10),e_date,120)>= convert(char(10),'").append(s30).append("',120) ").toString();
                    resultset3 = connodbc.executeQuery(s6);
                    if(!resultset3.next())
                    {
                        s6 = " insert into Rent_Charges(rentno,charges,money,c_date,s_date,e_date) values(";
                        s6 = (new StringBuilder()).append(s6).append(s22).append(",'\u7A7A\u8C03\u8D39',").append(s27).append(",'").append(s30).append("'").append(",'").append(s30).append("'").append(",'").append(s30).append("')").toString();
                        connodbc1.executeUpdate(s6);
                    }
                    resultset3.close();
                }
                if(Float.parseFloat(s26) > 0.0F)
                {
                    s6 = (new StringBuilder()).append("select * from Rent_Charges    where rentno=").append(s22).append(" and  charges='\u672C\u4F53\u7EF4\u4FEE\u91D1' and  convert(char(10),e_date,120)>= convert(char(10),'").append(s30).append("',120) ").toString();
                    resultset3 = connodbc.executeQuery(s6);
                    if(!resultset3.next())
                    {
                        s6 = " insert into Rent_Charges(rentno,charges,money,c_date,s_date,e_date) values(";
                        s6 = (new StringBuilder()).append(s6).append(s22).append(",'\u672C\u4F53\u7EF4\u4FEE\u91D1',").append(s26).append(",'").append(s30).append("'").append(",'").append(s30).append("'").append(",'").append(s30).append("')").toString();
                        connodbc1.executeUpdate(s6);
                    }
                    resultset3.close();
                }
                if(Float.parseFloat(s25) > 0.0F)
                {
                    s6 = (new StringBuilder()).append("select * from Rent_Charges    where rentno=").append(s22).append(" and  charges='\u6709\u7EBF\u7535\u89C6\u8D39' and  convert(char(10),e_date,120)>= convert(char(10),'").append(s30).append("',120) ").toString();
                    resultset3 = connodbc.executeQuery(s6);
                    if(!resultset3.next())
                    {
                        s6 = " insert into Rent_Charges(rentno,charges,money,c_date,s_date,e_date) values(";
                        s6 = (new StringBuilder()).append(s6).append(s22).append(",'\u6709\u7EBF\u7535\u89C6\u8D39',").append(s25).append(",'").append(s30).append("'").append(",'").append(s30).append("'").append(",'").append(s30).append("')").toString();
                        connodbc1.executeUpdate(s6);
                    }
                    resultset3.close();
                }
                if(Float.parseFloat(s29) > 0.0F)
                {
                    s6 = (new StringBuilder()).append("select * from Rent_Charges    where rentno=").append(s22).append(" and  charges='\u5BBD\u5E26\u8D39' and  convert(char(10),e_date,120)>= convert(char(10),'").append(s30).append("',120) ").toString();
                    resultset3 = connodbc.executeQuery(s6);
                    if(!resultset3.next())
                    {
                        s6 = " insert into Rent_Charges(rentno,charges,money,c_date,s_date,e_date) values(";
                        s6 = (new StringBuilder()).append(s6).append(s22).append(",'\u5BBD\u5E26\u8D39',").append(s29).append(",'").append(s30).append("'").append(",'").append(s30).append("'").append(",'").append(s30).append("')").toString();
                        connodbc1.executeUpdate(s6);
                    }
                    resultset3.close();
                }
                if(Float.parseFloat(s28) <= 0.0F)
                    continue;
                s6 = (new StringBuilder()).append("select * from Rent_Charges    where rentno=").append(s22).append(" and  charges='\u8D22\u4EA7\u4FDD\u9669\u8D39' and  convert(char(10),e_date,120)>= convert(char(10),'").append(s30).append("',120) ").toString();
                resultset3 = connodbc.executeQuery(s6);
                if(!resultset3.next())
                {
                    s6 = " insert into Rent_Charges(rentno,charges,money,c_date,s_date,e_date) values(";
                    s6 = (new StringBuilder()).append(s6).append(s22).append(",'\u8D22\u4EA7\u4FDD\u9669\u8D39',").append(s28).append(",'").append(s30).append("'").append(",'").append(s30).append("'").append(",'").append(s30).append("')").toString();
                    connodbc1.executeUpdate(s6);
                }
                resultset3.close();
            }

            resultset.close();
            s6 = (new StringBuilder()).append("insert into  countFlag(count_date,checker,updown) values('").append(s).append("-").append(s1).append("-1','\u7CFB\u7EDF\u8BA1\u7B97','").append(s5).append("')").toString();
            connodbc2.executeUpdate(s6);
            connodbc2.executeUpdate("delete rent_charges where money=0");
            System.out.print("\u6210\u529F\u751F\u6210\u79DF\u8D41\u8D39\u7528\uFF01");
        }
        catch(Exception exception)
        {
            System.out.print((new StringBuilder()).append(exception).append(s6).toString());
            boolean flag1 = false;
            System.out.print((new StringBuilder()).append(exception.getMessage()).append("\u751F\u6210\u79DF\u8D41\u6570\u636E\u5931\u8D25\uFF0C\u8BF7\u8054\u7CFB\u7CFB\u7EDF\u5F00\u53D1\u5546\uFF01").append(s6).toString());
        }
        try
        {
            connodbc.closeConnection();
            connodbc1.closeConnection();
            connodbc2.closeConnection();
        }
        catch(Exception exception1) { }
    }

    ResultSet sectionRS;
    HashMap hm;
    String outStr;
}
