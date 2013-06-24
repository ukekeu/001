package regcheck;

import ConnDatabase.SDatabase;
import crypt.MD5;
import java.io.PrintStream;
import java.sql.ResultSet;

public class regcheck
{
  public int day = 0;
  public int fg = 0;
  public int state = 1;
  public String alertmess = "";
  public String userregno = "";

  public String reginfo()
  {
    this.alertmess = "";

    this.alertmess += "<center>";
    this.alertmess += " <p align='center'><font size=3 class=FontColor><b>填写注册资料</b></font></p>";
    this.alertmess += "<form name=frm method='post'  action='alert.jsp'> ";

    this.alertmess += "<table BORDER=0 width='100%' CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor='#000000' class='tablefill'>";

    this.alertmess += "<tr ALIGN=left >";
    this.alertmess += " <td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;公司名称</td>  ";
    this.alertmess += " <td width='35%'  class=roomright>&nbsp;<input type=text name=companyname  readonly value='青岛富瑞置业顾问有限公司' size=25  onkeydown='key(document.frm.companytel)'  ><font color=red>*</font></td>";
    this.alertmess += " </tr>";
    this.alertmess += "<tr ALIGN=left>";
    this.alertmess += "  <td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;公司电话</td>  ";
    this.alertmess += "  <td width='35%' class=roomright >&nbsp;<input type=text name=companytel value='' size=25 onkeydown='key(document.frm.companyfax)'><font color=red>*</font></td>";
    this.alertmess += "</tr>";
    this.alertmess += "<tr ALIGN=left>";
    this.alertmess += " <td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;公司传真</td>  ";
    this.alertmess += "<td width='35%' class=roomright >&nbsp;<input type=text name=companyfax value='' size=25 onkeydown='key(document.frm.companyaddr)'><font color=red>*</font></td>";
    this.alertmess += " </tr>";

    this.alertmess += " <tr ALIGN=left>";
    this.alertmess += "  <td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;公司地址</td>  ";
    this.alertmess += "  <td width='35%' class=roomright  >&nbsp;<input type=text name=companyaddr value=''  size=25 onkeydown='key(document.frm.companyman)'><font color=red>*</font></td>";
    this.alertmess += "</tr>";

    this.alertmess += " <tr ALIGN=left>";
    this.alertmess += " <td width='15%' class=roomleft  >&nbsp;&nbsp;&nbsp;&nbsp;公司法人</td>";
    this.alertmess += " <td width='35%'  class=roomright  >&nbsp;<input type=text name=companyman  value='' size=25 onkeydown='key(document.frm.post)'><font color=red>*</font></td>";
    this.alertmess += "</tr>";
    this.alertmess += " <tr ALIGN=left>";
    this.alertmess += "<td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;邮&nbsp;&nbsp;&nbsp;编</td>  ";
    this.alertmess += " <td width='35%' class=roomright  >&nbsp;<input type=text name=post value='' size=25 ><font color=red>*</font></td>";
    this.alertmess += " </tr>";
    this.alertmess += " <tr ALIGN=left>";
    this.alertmess += " <td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;软件版本</td>  ";
    this.alertmess += "<td width='35%' class=roomright  >&nbsp;<input type=text name=softver value='V7.4' readonly  size=25 readonly><font color=red>*</font></td>";
    this.alertmess += "</tr>";
    this.alertmess += "  <tr ALIGN=left>";
    this.alertmess += " <td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;软件编码</td>  ";
    this.alertmess += " <td width='35%' class=roomright  >&nbsp;<input type=text name=code value='ZLTC2007HCRM072195'  readonly  size=25 ><font color=red>*</font></td>";
    this.alertmess += " </tr>";
    this.alertmess += " <tr ALIGN=left>";
    this.alertmess += " <td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;使用项目</td>  ";
    this.alertmess += "  <td width='35%' class=roomright  >&nbsp;<select name='project' style='width : 80'>";
    this.alertmess += "<option value=1>1个</option>";

    this.alertmess += "</select></td>";
    this.alertmess += "</tr>";
    this.alertmess += "<tr ALIGN=left>";
    this.alertmess += " <td width='15%' class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;使用用户数</td>  ";
    this.alertmess += " <td width='35%' class=roomright  >&nbsp;<select name='usernum' style='width : 80'>";

    this.alertmess += "<option value=0>无限用户</option>";

    this.alertmess += "</select>";
    this.alertmess += "</td>";
    this.alertmess += "</tr>";
    this.alertmess += " <tr ALIGN=left>";
    this.alertmess += " <td width='15%' class=roomleft  >&nbsp;&nbsp;&nbsp;&nbsp;软件提供商</td>";
    this.alertmess += " <td width='35%'  class=roomright  >&nbsp;<input type=text name=saleperson readonly  value='U客软件' size=25 onkeydown='key(document.frm.phone)'></td>";
    this.alertmess += "  </tr>";
    this.alertmess += "    <tr ALIGN=left>";
    this.alertmess += "   <td width='15%' class=roomleft  >&nbsp;&nbsp;&nbsp;&nbsp;开发商网站</td>";
    this.alertmess += "   <td width='35%'  class=roomright  >&nbsp;<input type=text name=saleurl  readonly value='www.zltc.net' size=25 onkeydown='key(document.frm.phone)'></td>";
    this.alertmess += " </tr>";
    this.alertmess += "   <tr ALIGN=left>";
    this.alertmess += " <td width='15%' class=roomleft  >&nbsp;&nbsp;&nbsp;&nbsp;技术支持</td>";
    this.alertmess += "  <td width='35%'  class=roomright  >&nbsp;<input type=text name=person  value='' size=25 onkeydown='key(document.frm.phone)'><font color=red>*</font></td>";
    this.alertmess += "</tr>";
    this.alertmess += "   <tr ALIGN=left>";
    this.alertmess += "   <td width='15%' class=roomleft  >&nbsp;&nbsp;&nbsp;&nbsp;服务电话</td>";
    this.alertmess += "    <td width='35%'  class=roomright  >&nbsp;<input type=text name=phone  value='' size=25 ><font color=red>*</font></td>";
    this.alertmess += "  </tr>";
    this.alertmess += "  </table>";

    this.alertmess += " <p align='center'> ";
    this.alertmess += "        &nbsp;&nbsp; <input type=button name=save value='激 活' onclick='save1();'>&nbsp;&nbsp;<input type=button name=winclose value='退 出' onclick='window.close();'>";

    this.alertmess += "       </P>";
    this.alertmess += "  <input type=hidden name=save value='确定'>";
    this.alertmess += " <table BORDER=0 width='90%' CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor='#000000' class='tablefill'>";
    this.alertmess += "   <tr><td>咨询电话:0755-86105570 86237272 </td></tr>";

    this.alertmess += "  <tr><td>地址：深圳市科技园科二中路软件园1栋502  </td></tr>";
    this.alertmess += "   <tr><td>E-MAIL:service@zlcrm.com 网址：www.zltc.net</td></tr>";
    this.alertmess += " </table>";

    this.alertmess += "</center>";

    return this.alertmess;
  }

  public String checkREG() {
    Object localObject = null;
    String str1 = "";
    SDatabase localSDatabase = new SDatabase();
    writereadregedit localwritereadregedit = new writereadregedit();
    String str2 = localwritereadregedit.readRegDate();
    String str3 = localwritereadregedit.readRegsDate();
    if (str2.equals("")) str2 = "2000-01-01";
    String str4 = localwritereadregedit.readRegState();
    if (str4.equals("0"))
    {
      String str5 = "select  datediff(d,getdate(),'" + str2 + "') as day from  user_reg  where  convert(char(10),DATEADD(day, -6, '" + str2 + "'),120)<convert(char(10),getdate(),120) and  convert(char(10),'" + str2 + "',120)>convert(char(10),getdate(),120) and convert(char(10),'" + str3 + "',120)<=convert(char(10),getdate(),120) and userregno='' and state=" + str4;
      try
      {
        ResultSet localResultSet = localSDatabase.executeQuery(str5);
        if (localResultSet.next()) {
          this.day = localResultSet.getInt("day");
          if (this.day <= 0)
            str1 = "系统已过期，请及时联系U客软件,QQ:357657132 ";
          else if ((this.day < 7) && (this.day > 0))
            str1 = "系统还可以正常使用" + this.day + "天,请尽快注册系统，以勉影响系统运行!U客软件,QQ:357657132 ";
          else str1 = "";
          System.out.println(str1 + "test");
        }
        localResultSet.close();
      } catch (Exception localException) {
      }
    }
    return str1;
  }

  public String checkREGYear() {
    Object localObject1 = null;
    String localObject2 = "";
    writereadregedit localwritereadregedit = new writereadregedit();
    if (!localwritereadregedit.writeinfo().trim().equals("")) {
      SDatabase localSDatabase = new SDatabase();
      String str1 = localwritereadregedit.readRegState();
      String str2 = localwritereadregedit.readRegDate();
      String str3 = "select  datediff(d,getdate(),'" + str2 + "') as day,state from  user_reg  where   state=" + str1;
      try
      {
        ResultSet localResultSet = localSDatabase.executeQuery(str3);

        if (localResultSet.next())
        {
          this.day = localResultSet.getInt("day");
          if (localResultSet.getInt("state") == 1)
            if (this.day <= 0) {
              this.day = this.day;
              localObject2 = "系统已过维护期" + this.day + "天,避免影响系统运行,请及时联系U客软件,QQ:357657132 ";
            } else if ((this.day < 15) && (this.day > 0)) {
              localObject2 = "系统还差" + this.day + "天就过维护期,避免影响系统运行,请及时联系U客软件,QQ:357657132 "; } else {
              localObject2 = "";
            }
        }
        localResultSet.close();
      }
      catch (Exception localException)
      {
        System.out.print(localException);
      }if (!((String)localObject2).equals("")) {
        str3 = "  <script language=javascript>";
        str3 = str3 + " alert(\"" + (String)localObject2 + "\"); ";
        str3 = str3 + "</script>";
        localObject2 = str3;
      }
    }

    return localObject2;
  }

  public void checkREGIN() {
    SDatabase localSDatabase = new SDatabase();
    String str = "select datediff(d,getdate(),end_date) as day,state,userregno  from user_reg ";
    try
    {
      ResultSet localResultSet = localSDatabase.executeQuery(str);
      if (localResultSet.next()) {
        this.day = localResultSet.getInt("day");
        this.state = localResultSet.getInt("state");
        this.userregno = localResultSet.getString("userregno");
        this.fg = 1;
      }
      localResultSet.close();
    }
    catch (Exception localException) {
    }
    if (this.fg == 0) { this.alertmess = "<font color=red>系统未激活，请及时联系U客软件,QQ:357657132</font>"; System.out.close(); }
  }

  public String checkIn(String paramString)
  {
    String str = "";
    if (paramString == null) { str = "Error！";

      str = "<script>";
      str = str + "window.open('../index.jsp');";
      str = str + " window.close();";
      str = str + " </script>";
    }

    return str;
  }

  public String GetRegInfo(String paramString1, String paramString2, String paramString3, String paramString4, String paramString5, String paramString6, String paramString7, String paramString8, String paramString9) {
    Object localObject = null;
    String str1 = "";
    SDatabase localSDatabase = new SDatabase();
    String str2 = "";
    try {
      str2 = "insert into company(companyname,companytel,companyaddr,";
      str2 = str2 + "companyman,zip_code,companyfax,usernum,project) values('" + paramString1 + "','";
      str2 = str2 + paramString2 + "','" + paramString3 + "','" + paramString4 + "','" + paramString5 + "','" + paramString6 + "','" + paramString8 + "','" + paramString9 + "')";
      localSDatabase.executeUpdate("delete company");
      localSDatabase.executeUpdate("delete user_reg");
      localSDatabase.executeUpdate(str2);

      localSDatabase.sendtomaill("customer：" + paramString1 + ",phone:" + paramString2 + ",address:" + paramString3 + ",版本:" + paramString8 + "," + paramString9);
      localSDatabase.executeUpdate("insert into  user_reg(reg_date,end_date,state,column_b)   select getdate(),dateadd(dd,7,getdate()),0,1");

      str2 = " insert into logrecord  (dengluren , jinrushijian , jinrumokuai , dongzuomiaoxu )  values (  '" + paramString7 + "' , " + " getDate() , " + " 'system regster' , " + " 'ok' " + " ) ";

      writereadregedit localwritereadregedit = new writereadregedit();
      ResultSet localResultSet = localSDatabase.executeQuery("select dateadd(d,15,getdate()) cc,getdate() sd ");
      if (localResultSet.next()) localwritereadregedit.readinfo(localResultSet.getString("cc"), "0", paramString8, paramString9, localResultSet.getString("sd"));
      localResultSet.close();
      str2 = "<script>";
      str2 = str2 + "alert('系统已激活，请在7天后再次进行注册。');";
      str2 = str2 + "window.close();";
      str2 = str2 + "opener.window.close();";
      str2 = str2 + "</script>";
    } catch (Exception localException) {
      str2 = localException.getMessage();
    }return str2;
  }

  public String checkREGMess() {
    Object localObject = null;
    String str1 = "";
    SDatabase localSDatabase = new SDatabase();
    String str2 = "select * from user_reg where state=1";
    try
    {
      ResultSet localResultSet = localSDatabase.executeQuery(str2);
      if (localResultSet.next()) {
        str1 = "<br><br><br>&nbsp;&nbsp;<br>";
        str1 = str1 + "&nbsp;&nbsp;注册日期：" + localResultSet.getString("column_b");
        str1 = str1 + "<br>&nbsp;&nbsp;产品号：" + localResultSet.getString("code");
        str1 = str1 + "<br>&nbsp;&nbsp;版本号：" + localResultSet.getString("softver");
        str1 = str1 + "<br>&nbsp;&nbsp;U客软件版权所有";
      }
      localResultSet.close();
    } catch (Exception localException) {
    }
    return str1;
  }

  public String checkREGInfo(String paramString1, String paramString2, String paramString3) {
    Object localObject = null;

    String str1 = "";
    String str2 = "";
    String str3 = "";
    int i = 0;
    String str4 = "0";
    String str5 = "0";
    SDatabase localSDatabase = new SDatabase();
    HardWareID localHardWareID = new HardWareID();
    MD5 localMD5 = new MD5();
    String str6 = "select  top 1 CompanyName,project,usernum,regnum from company";
    try
    {
      ResultSet localResultSet = localSDatabase.executeQuery(str6);
      if (localResultSet.next()) {
        i = localResultSet.getInt("regnum");
        str4 = localResultSet.getString("usernum").trim();
        str5 = localResultSet.getString("project").trim();
        str1 = localResultSet.getString("regnum").trim() + localResultSet.getString("project").trim() + localResultSet.getString("usernum").trim() + paramString3 + localResultSet.getString("CompanyName").trim() + HardWareID.getMacAddress();

        str3 = localMD5.getMD5ofStr(str1);
      }

      localResultSet.close();
      String str7 = "";
      if (paramString3.equals("0")) str7 = "dd,7"; else {
        str7 = "mm,1";
      }
      if (str3.equals(paramString1)) {
        int j = 0;
        j = localSDatabase.executeUpdate("update  company set regnum=regnum+1");

        if ((i == 4) && (!paramString3.equals("0")))
          j = localSDatabase.executeUpdate("update  user_reg set column_b=convert(char(10),getdate(),120),end_date=DATEADD(mm, 11, '" + paramString2 + "'),state=1,userregno='" + localMD5.getMD5ofStr(paramString1) + "'");
        else if (i == 3)
          j = localSDatabase.executeUpdate("update  user_reg set column_b=convert(char(10),getdate(),120),end_date=DATEADD(" + str7 + ", '" + paramString2 + "'),regnum=regnum+1");
        else if (i == 2)
          j = localSDatabase.executeUpdate("update  user_reg set column_b=convert(char(10),getdate(),120),end_date=DATEADD(" + str7 + ", '" + paramString2 + "'),regnum=regnum+1");
        else if (i == 1) {
          j = localSDatabase.executeUpdate("update  user_reg set column_b=convert(char(10),getdate(),120),end_date=DATEADD(" + str7 + ", '" + paramString2 + "'),regnum=regnum+1");
        }
        writereadregedit localwritereadregedit = new writereadregedit();
        String str8 = localwritereadregedit.readRegsDate();
        localResultSet = localSDatabase.executeQuery("select convert(char(10),end_date,120),end_date,state,convert(char(10),getdate(),120) sd from user_reg ");
        if (localResultSet.next()) {
          localwritereadregedit.readinfo(localResultSet.getString("end_date"), localResultSet.getString("state"), str5, str4, str8);
        }
        localResultSet.close();
        str1 = "欢迎选择U客软件开发的售楼管理软件<br>如果您是过期后才进行注册，注册后必须重新登录系统。";
      }
      else {
        str1 = "注册失败!请确认你的注册码是否正确";
      }
    } catch (Exception localException) { System.err.println(localException.getMessage()); }
    return str1;
  }
}