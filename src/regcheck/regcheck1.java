// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   regcheck1.java

package regcheck;

import ConnDatabase.SDatabase;
import crypt.MD4;
import java.io.PrintStream;
import java.sql.ResultSet;

// Referenced classes of package regcheck:
//            writereadregedit, HardWareID

public class regcheck1
{

    public regcheck1()
    {
        day = 0;
        fg = 0;
        state = 1;
        alertmess = "";
        userregno = "";
    }

    public String reginfo()
    {
        alertmess = "";
        alertmess += "<center>";
        alertmess += " <p align='center'><font size=3 class=FontColor><b>\u586B\u5199\u6CE8\u518C\u8D44\u6599</b></font></p>";
        alertmess += "<form name=frm method='post'  action='alert.jsp'> ";
        alertmess += "<table BORDER=0 width='100%' CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor='#000000' class='tablefill'>";
        alertmess += "<tr ALIGN=left >";
        alertmess += " <td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;\u516C\u53F8\u540D\u79F0</td>  ";
        alertmess += " <td width='35%'  class=roomright>&nbsp;<input type=text name=companyname  readonly value='\u6DF1\u5733\u5E02\u4E2D\u84DD\u8F6F\u4EF6' size=25  onkeydown='key(document.frm.companytel)'  ><font color=red>*</font></td>";
        alertmess += " </tr>";
        alertmess += "<tr ALIGN=left>";
        alertmess += "  <td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;\u516C\u53F8\u7535\u8BDD</td>  ";
        alertmess += "  <td width='35%' class=roomright >&nbsp;<input type=text name=companytel value='' size=25 onkeydown='key(document.frm.companyfax)'><font color=red>*</font></td>";
        alertmess += "</tr>";
        alertmess += "<tr ALIGN=left>";
        alertmess += " <td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;\u516C\u53F8\u4F20\u771F</td>  ";
        alertmess += "<td width='35%' class=roomright >&nbsp;<input type=text name=companyfax value='' size=25 onkeydown='key(document.frm.companyaddr)'><font color=red>*</font></td>";
        alertmess += " </tr>";
        alertmess += " <tr ALIGN=left>";
        alertmess += "  <td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;\u516C\u53F8\u5730\u5740</td>  ";
        alertmess += "  <td width='35%' class=roomright  >&nbsp;<input type=text name=companyaddr value=''  size=25 onkeydown='key(document.frm.companyman)'><font color=red>*</font></td>";
        alertmess += "</tr>";
        alertmess += " <tr ALIGN=left>";
        alertmess += " <td width='15%' class=roomleft  >&nbsp;&nbsp;&nbsp;&nbsp;\u516C\u53F8\u6CD5\u4EBA</td>";
        alertmess += " <td width='35%'  class=roomright  >&nbsp;<input type=text name=companyman  value='' size=25 onkeydown='key(document.frm.post)'><font color=red>*</font></td>";
        alertmess += "</tr>";
        alertmess += " <tr ALIGN=left>";
        alertmess += "<td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;\u90AE&nbsp;&nbsp;&nbsp;\u7F16</td>  ";
        alertmess += " <td width='35%' class=roomright  >&nbsp;<input type=text name=post value='' size=25 ><font color=red>*</font></td>";
        alertmess += " </tr>";
        alertmess += " <tr ALIGN=left>";
        alertmess += " <td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;\u8F6F\u4EF6\u7248\u672C</td>  ";
        alertmess += "<td width='35%' class=roomright  >&nbsp;<input type=text name=softver value='V7.4' readonly  size=25 readonly><font color=red>*</font></td>";
        alertmess += "</tr>";
        alertmess += "  <tr ALIGN=left>";
        alertmess += " <td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;\u8F6F\u4EF6\u7F16\u7801</td>  ";
        alertmess += " <td width='35%' class=roomright  >&nbsp;<input type=text name=code value='ZLTC2007HCRM110455'  readonly  size=25 ><font color=red>*</font></td>";
        alertmess += " </tr>";
        alertmess += " <tr ALIGN=left>";
        alertmess += " <td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;\u4F7F\u7528\u9879\u76EE</td>  ";
        alertmess += "  <td width='35%' class=roomright  >&nbsp;<select name='project' style='width : 80'>";
        alertmess += "<option value=1>\u4E00\u4E2A\u697C\u76D8</option>";
        alertmess += "</select></td>";
        alertmess += "</tr>";
        alertmess += "<tr ALIGN=left>";
        alertmess += " <td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;\u4F7F\u7528\u7528\u6237\u6570</td>  ";
        alertmess += " <td width='35%' class=roomright  >&nbsp;<select name='usernum' style='width : 80'>";
        alertmess += "<option value=1>1\u4E2A\u7528\u6237</option>";
        alertmess += "</select>";
        alertmess += "</td>";
        alertmess += "</tr>";
        alertmess += " <tr ALIGN=left>";
        alertmess += " <td width='15%' class=roomleft  >&nbsp;&nbsp;&nbsp;&nbsp;\u8F6F\u4EF6\u63D0\u4F9B\u5546</td>";
        alertmess += " <td width='35%'  class=roomright  >&nbsp;<input type=text name=saleperson readonly  value='\u6DF1\u5733\u5E02\u4E2D\u84DD\u79D1\u6280\u6709\u9650\u516C\u53F8' size=25 onkeydown='key(document.frm.phone)'></td>";
        alertmess += "  </tr>";
        alertmess += "    <tr ALIGN=left>";
        alertmess += "   <td width='15%' class=roomleft  >&nbsp;&nbsp;&nbsp;&nbsp;\u5F00\u53D1\u5546\u7F51\u7AD9</td>";
        alertmess += "   <td width='35%'  class=roomright  >&nbsp;<input type=text name=saleurl  readonly value='www.zltc.net' size=25 onkeydown='key(document.frm.phone)'></td>";
        alertmess += " </tr>";
        alertmess += "   <tr ALIGN=left>";
        alertmess += " <td width='15%' class=roomleft  >&nbsp;&nbsp;&nbsp;&nbsp;\u6280\u672F\u652F\u6301</td>";
        alertmess += "  <td width='35%'  class=roomright  >&nbsp;<input type=text name=person  value='\u6DF1\u5733\u4E2D\u84DD\u8F6F\u4EF6\u5BA2\u6237\u670D\u52A1' size=25 onkeydown='key(document.frm.phone)'><font color=red>*</font></td>";
        alertmess += "</tr>";
        alertmess += "   <tr ALIGN=left>";
        alertmess += "   <td width='15%' class=roomleft  >&nbsp;&nbsp;&nbsp;&nbsp;\u670D\u52A1\u7535\u8BDD</td>";
        alertmess += "    <td width='35%'  class=roomright  >&nbsp;<input type=text name=phone  value='0755-86105570 86237272' size=25 ><font color=red>*</font></td>";
        alertmess += "  </tr>";
        alertmess += "  </table>";
        alertmess += " <p align='center'> ";
        alertmess += "        &nbsp;&nbsp; <input type=button name=save value='\u6FC0 \u6D3B' onclick='save1();'>&nbsp;&nbsp;<input type=button name=winclose value='\u9000 \u51FA' onclick='window.close();'>";
        alertmess += "       </P>";
        alertmess += "  <input type=hidden name=save value='\u786E\u5B9A'>";
        alertmess += " <table BORDER=0 width='90%' CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor='#000000' class='tablefill'>";
        alertmess += "   <tr><td>\u54A8\u8BE2\u7535\u8BDD:0755-86105570 86237272 </td></tr>";
        alertmess += "  <tr><td>\u5730\u5740\uFF1A\u6DF1\u5733\u5E02\u79D1\u6280\u56ED\u79D1\u4E8C\u4E2D\u8DEF\u8F6F\u4EF6\u56ED1\u680B502  </td></tr>";
        alertmess += "   <tr><td>E-MAIL:zlsale@vip.163.com \u7F51\u5740\uFF1Awww.zltc.net</td></tr>";
        alertmess += " </table>";
        alertmess += "</center>";
        return alertmess;
    }

    public String checkREG()
    {
        Object obj = null;
        String s = "";
        SDatabase sdatabase = new SDatabase();
        writereadregedit regdate = new writereadregedit();
        String infodate = regdate.readRegDate();
        String infosdate = regdate.readRegsDate();
        if(infodate.equals(""))
            infodate = "2000-01-01";
        String infoState = regdate.readRegState();
        if(infoState.equals("0"))
        {
            String s1 = "select  datediff(d,getdate(),'" + infodate + "') as day from  user_reg  where  convert(char(10),DATEADD(day, -6, '" + infodate + "'),120)<convert(char(10),getdate(),120) and  convert(char(10),'" + infodate + "',120)>convert(char(10),getdate(),120) and convert(char(10),'" + infosdate + "',120)<=convert(char(10),getdate(),120) and userregno='' and state=" + infoState;
            try
            {
                ResultSet resultset = sdatabase.executeQuery(s1);
                s1 = "";
                if(resultset.next())
                {
                    day = resultset.getInt("day");
                    if(day <= 0)
                        s = "\u7CFB\u7EDF\u5DF2\u8FC7\u671F\uFF0C\u8BF7\u53CA\u65F6\u8054\u7CFB\u6DF1\u5733\u5E02\u4E2D\u84DD\u79D1\u6280\u6709\u9650\u516C\u53F8\u8FDB\u884C\u7CFB\u7EDF\u6CE8\u518C \u7535\u8BDD::0755-86105570 86237272 13798375094  ";
                    else
                    if(day < 7 && day > 0)
                        s = "\u7CFB\u7EDF\u8FD8\u53EF\u4EE5\u6B63\u5E38\u4F7F\u7528" + day + "\u5929,\u8BF7\u5C3D\u5FEB\u6CE8\u518C\u7CFB\u7EDF\uFF0C\u4EE5\u52C9\u5F71\u54CD\u7CFB\u7EDF\u8FD0\u884C!\u6DF1\u5733\u5E02\u4E2D\u84DD\u79D1\u6280\u6709\u9650\u516C\u53F8 \u7535\u8BDD::0755-86105570 86237272 13798375094 ";
                    else
                        s = "";
                }
                resultset.close();
            }
            catch(Exception exception) { }
        }
        return s;
    }

    public String checkREGYear()
    {
        Object obj = null;
        String s = "";
        writereadregedit writedate = new writereadregedit();
        if(!writedate.writeinfo().trim().equals(""))
        {
            SDatabase sdatabase = new SDatabase();
            String infoState = writedate.readRegState();
            String infodate = writedate.readRegDate();
            String s1 = "select  datediff(d,getdate(),'" + infodate + "') as day,state from  user_reg  where   state=" + infoState;
            try
            {
                ResultSet resultset = sdatabase.executeQuery(s1);
                s1 = "";
                if(resultset.next())
                {
                    day = resultset.getInt("day");
                    if(resultset.getInt("state") == 1)
                        if(day <= 0)
                        {
                            day = day;
                            s = "\u7CFB\u7EDF\u5DF2\u8FC7\u7EF4\u62A4\u671F" + day + "\u5929,\u907F\u514D\u5F71\u54CD\u7CFB\u7EDF\u8FD0\u884C,\u8BF7\u53CA\u65F6\u8054\u7CFB\u6DF1\u5733\u5E02\u4E2D\u84DD\u79D1\u6280\u6709\u9650\u516C\u53F8\u8FDB\u884C\u7EED\u7EF4\u62A4\u534F\u8BAE \u7535\u8BDD:0755-86105570 86237272 13798375094 ";
                        } else
                        if(day < 15 && day > 0)
                            s = "\u7CFB\u7EDF\u8FD8\u5DEE" + day + "\u5929\u5C31\u8FC7\u7EF4\u62A4\u671F,\u907F\u514D\u5F71\u54CD\u7CFB\u7EDF\u8FD0\u884C,\u8BF7\u53CA\u65F6\u8054\u7CFB\u6DF1\u5733\u5E02\u4E2D\u84DD\u79D1\u6280\u6709\u9650\u516C\u53F8\u8FDB\u884C\u7EED\u7EF4\u62A4\u534F\u8BAE \u7535\u8BDD:0755-86105570 8623727213798375094 ";
                        else
                            s = "";
                }
                resultset.close();
            }
            catch(Exception exception)
            {
                System.out.print(exception);
            }
            if(!s.equals(""))
            {
                s1 = "  <script language=javascript>";
                s1 = s1 + " alert(\"" + s + "\"); ";
                s1 = s1 + "</script>";
                s = s1;
            }
        }
        return s;
    }

    public void checkREGIN()
    {
        SDatabase sdatabase = new SDatabase();
        String s1 = "select datediff(d,getdate(),end_date) as day,state,userregno  from user_reg ";
        try
        {
            ResultSet resultset = sdatabase.executeQuery(s1);
            if(resultset.next())
            {
                day = resultset.getInt("day");
                state = resultset.getInt("state");
                userregno = resultset.getString("userregno");
                fg = 1;
            }
            resultset.close();
        }
        catch(Exception exception) { }
        if(fg == 0)
        {
            alertmess = "<font color=red>\u7CFB\u7EDF\u672A\u6FC0\u6D3B\uFF0C\u8BF7\u53CA\u65F6\u8054\u7CFB\u6DF1\u5733\u5E02\u4E2D\u84DD\u79D1\u6280\u6709\u9650\u516C\u53F8\u8FDB\u884C\u7CFB\u7EDF\u6CE8\u518C \u7535\u8BDD:0755-86105570 8623727213798375094</font>";
            System.out.close();
        }
    }

    public String checkIn(String s)
    {
        String mess = "";
        if(s == null)
        {
            mess = "Error\uFF01";
            mess = "<script>";
            mess = mess + "window.open('../index.jsp');";
            mess = mess + " window.close();";
            mess = mess + " </script>";
        }
        return mess;
    }

    public String GetRegInfo(String s1, String s2, String s3, String s4, String s5, String s6, String s7, 
            String s8, String s9)
    {
        Object obj = null;
        String ss = "";
        SDatabase sdatabase = new SDatabase();
        String SQL = "";
        try
        {
            SQL = "insert into company(companyname,companytel,companyaddr,";
            SQL = SQL + "companyman,zip_code,companyfax,usernum,project) values('" + s1 + "','";
            SQL = SQL + s2 + "','" + s3 + "','" + s4 + "','" + s5 + "','" + s6 + "','" + s8 + "','" + s9 + "')";
            sdatabase.executeUpdate("delete company");
            sdatabase.executeUpdate("delete user_reg");
            sdatabase.executeUpdate(SQL);
            sdatabase.sendtomaill("customer\uFF1A" + s1 + ",phone:" + s2 + ",address:" + s3 + ",\u7248\u672C:" + s8 + "," + s9);
            sdatabase.executeUpdate("insert into  user_reg(reg_date,end_date,state,column_b)   select getdate(),dateadd(dd,7,getdate()),0,1");
            SQL = " insert into logrecord  (dengluren , jinrushijian , jinrumokuai , dongzuomiaoxu )  values (  '" + s7 + "' , " + " getDate() , " + " 'system regster' , " + " 'ok' " + " ) ";
            writereadregedit writedate = new writereadregedit();
            ResultSet resultset = sdatabase.executeQuery("select dateadd(d,15,getdate()) cc,getdate() sd ");
            if(resultset.next())
                writedate.readinfo(resultset.getString("cc"), "0", s8, s9, resultset.getString("sd"));
            resultset.close();
            SQL = "<script>";
            SQL = SQL + "alert('\u7CFB\u7EDF\u5DF2\u6FC0\u6D3B\uFF0C\u8BF7\u57287\u5929\u540E\u518D\u6B21\u8FDB\u884C\u6CE8\u518C\u3002');";
            SQL = SQL + "window.close();";
            SQL = SQL + "opener.window.close();";
            SQL = SQL + "</script>";
        }
        catch(Exception exception)
        {
            SQL = exception.getMessage();
        }
        return SQL;
    }

    public String checkREGMess()
    {
        Object obj = null;
        String mess = "";
        SDatabase sdatabase = new SDatabase();
        String s1 = "select * from user_reg where state=1";
        try
        {
            ResultSet resultset = sdatabase.executeQuery(s1);
            if(resultset.next())
            {
                mess = "<br><br><br>&nbsp;&nbsp;<br>";
                mess = mess + "&nbsp;&nbsp;\u6CE8\u518C\u65E5\u671F\uFF1A" + resultset.getString("column_b");
                mess = mess + "<br>&nbsp;&nbsp;\u4EA7\u54C1\u53F7\uFF1A" + resultset.getString("code");
                mess = mess + "<br>&nbsp;&nbsp;\u7248\u672C\u53F7\uFF1A" + resultset.getString("softver");
                mess = mess + "<br>&nbsp;&nbsp;\u6DF1\u5733\u4E2D\u84DD\u79D1\u6280\u6709\u9650\u516C\u53F8\u7248\u6743\u6240\u6709";
            }
            resultset.close();
        }
        catch(Exception exception) { }
        return mess;
    }

    public String checkREGInfo(String s, String s1, String s2)
    {
        Object obj = null;
        String mess = "";
        String aaaa = "";
        String userCompayname = "";
        int regnum = 0;
        String online = "0";
        String project = "0";
        SDatabase sdatabase = new SDatabase();
        HardWareID HID = new HardWareID();
        MD4 md5 = new MD4();
        String sql = "select  top 1 CompanyName,project,usernum,regnum from company";
        try
        {
            ResultSet resultset = sdatabase.executeQuery(sql);
            if(resultset.next())
            {
                regnum = resultset.getInt("regnum");
                online = resultset.getString("usernum").trim();
                project = resultset.getString("project").trim();
                mess = resultset.getString("regnum").trim() + resultset.getString("project").trim() + resultset.getString("usernum").trim() + s2 + resultset.getString("CompanyName").trim() + HardWareID.getMacAddress();
                userCompayname = md5.getMD4ofStr(mess);
            }
            resultset.close();
            String regtype = "";
            if(s2.equals("0"))
                regtype = "dd,7";
            else
                regtype = "mm,1";
            if(userCompayname.equals(s))
            {
                int r = 0;
                r = sdatabase.executeUpdate("update  company set regnum=regnum+1");
                if(regnum == 4 && !s2.equals("0"))
                    r = sdatabase.executeUpdate("update  user_reg set column_b=convert(char(10),getdate(),120),end_date=DATEADD(mm, 11, '" + s1 + "'),state=1,userregno='" + md5.getMD4ofStr(s) + "'");
                else
                if(regnum == 3)
                    r = sdatabase.executeUpdate("update  user_reg set column_b=convert(char(10),getdate(),120),end_date=DATEADD(" + regtype + ", '" + s1 + "'),regnum=regnum+1");
                else
                if(regnum == 2)
                    r = sdatabase.executeUpdate("update  user_reg set column_b=convert(char(10),getdate(),120),end_date=DATEADD(" + regtype + ", '" + s1 + "'),regnum=regnum+1");
                else
                if(regnum == 1)
                    r = sdatabase.executeUpdate("update  user_reg set column_b=convert(char(10),getdate(),120),end_date=DATEADD(" + regtype + ", '" + s1 + "'),regnum=regnum+1");
                writereadregedit awritedate = new writereadregedit();
                String infoState = awritedate.readRegsDate();
                resultset = sdatabase.executeQuery("select convert(char(10),end_date,120),end_date,state,convert(char(10),getdate(),120) sd from user_reg ");
                if(resultset.next())
                    awritedate.readinfo(resultset.getString("end_date"), resultset.getString("state"), project, online, infoState);
                resultset.close();
                mess = "\u6B22\u8FCE\u9009\u62E9\u6DF1\u5733\u5E02\u4E2D\u84DD\u79D1\u6280\u6709\u9650\u516C\u53F8\u5F00\u53D1\u7684\u552E\u697C\u7BA1\u7406\u8F6F\u4EF6<br>\u5BA2\u6237\u670D\u52A1\u7535\u8BDD:0755-86105570 86237272 <br>\u5982\u679C\u60A8\u662F\u8FC7\u671F\u540E\u624D\u8FDB\u884C\u6CE8\u518C\uFF0C\u6CE8\u518C\u540E\u5FC5\u987B\u91CD\u65B0\u767B\u5F55\u7CFB\u7EDF\u3002";
            } else
            {
                mess = "\u6CE8\u518C\u5931\u8D25!\u8BF7\u786E\u8BA4\u4F60\u7684\u6CE8\u518C\u7801\u662F\u5426\u6B63\u786E";
            }
        }
        catch(Exception exception)
        {
            System.err.println(exception.getMessage());
        }
        return mess;
    }

    public int day;
    public int fg;
    public int state;
    public String alertmess;
    public String userregno;
}
