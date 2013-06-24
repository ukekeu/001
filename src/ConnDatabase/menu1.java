package ConnDatabase;

import FormatData.FormatData;
import crypt.MD4;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import regcheck.HardWareID;
import regcheck.regcheck1;
import regcheck.writereadregedit;

public class menu1
{
  ResultSet sectionRS = null;
  HashMap hm = null;
  String outStr;

  public String showregCompay()
  {
    SDatabase conndata = new SDatabase();
    String CompanyName = "";
    try {
      ResultSet rs = null;
      rs = conndata.executeQuery("select CompanyName from company");

      while (rs.next()) {
        CompanyName = rs.getString("CompanyName");
      }
      rs.close();
      this.outStr = "";
      this.outStr += " function windowstate(){";
      this.outStr = (this.outStr + " window.status=\"本产品是U客软件授权给" + CompanyName + "合法使用" + "\";");
      this.outStr += "}";
    } catch (Exception s) {
      System.out.print(s.getMessage());
    }return this.outStr;
  }

  public String showProduect() {
    SDatabase conndata = new SDatabase();
    SDatabase conndata1 = new SDatabase();
    String SqlStr = "select * from user_reg where state=1 ";
    ResultSet rs = null;
    try { rs = conndata.executeQuery(SqlStr);

      if (rs.next()) {
        this.outStr = "<table border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%' id='AutoNumber1'>";

        this.outStr += " <tr>";
        this.outStr += "<td valign='middle' height='97' valign='middle' background='../../images/top_banner.gif'>";
        this.outStr += "       <object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0' width='210' height='80'>";
        this.outStr += "       <param name='movie' value='logo.swf'>";
        this.outStr += "      <param name='quality' value='high'><param name='BGCOLOR' value='#000000'><param name='wmode' value='transparent'>";
        this.outStr += "       <embed src='images/logo.swf' width='210' height='80' quality='high' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' bgcolor='#000000'></embed></object>  </td>";
        this.outStr += "   </tr>  ";
        this.outStr += "  <tr>";
        this.outStr = (this.outStr + "   <td width='100%'>正式注册日期：" + rs.getString("column_b") + "</td>");
        this.outStr += " </tr>";
        this.outStr += " <tr>";
        this.outStr = (this.outStr + "  <td width='100%'>正式注册号码：" + rs.getString("userregno") + "</td>");
        this.outStr += " </tr>";
        this.outStr += "<tr>";
        this.outStr = (this.outStr + "   <td width='100%'>软件版本号码：" + rs.getString("softver") + "</td>");
        this.outStr += " </tr>";
        this.outStr += "<tr>";
        this.outStr = (this.outStr + "   <td width='100%'>软件版本条码：" + rs.getString("code") + "</td>");
        this.outStr += " </tr>";
        this.outStr += "   <tr>";
        this.outStr = (this.outStr + "    <td width='100%'>软件版权属于：" + rs.getString("saleperson") + "</td>");
        this.outStr += "  </tr>";
        this.outStr += "</table>";
      }rs.close(); } catch (Exception localException) {
    }
    return this.outStr;
  }

  public String newLeftMenu(String userid, String paraIp)
  {
    SDatabase conndata = new SDatabase();
    SDatabase conndata1 = new SDatabase();
    regcheck1 reg = new regcheck1();

    reg.checkREGIN();
    this.outStr = "";
    try {
      this.outStr += " \t<table border=\"0\" width=\"95%\" cellspacing=\"0\" cellpadding=\"0\" background='../images/new/F_r1_c6.jpg'>";

      String SqlStr = "select Url,MModuleNo,CModuleNo,MModuleName,picpath,nexus,title  from ModuleCortrol where  nexus='P' and   MModuleNo<>'desktop' and  MModuleNo in(select manModule from  ManModuleCortrol where SellerId='" + userid + "') ORDER BY orderby  ";
      ResultSet rs = null;
      rs = conndata.executeQuery(SqlStr);
      int menu = 0;
      while (rs.next()) {
        menu++;

        this.outStr += " <tr valign=\"top\"  align=\"center\"  onmouseover=\"mout(this) ;\">";
        this.outStr = (this.outStr + "  <td  height=\"30\" valign=\"middle\" id=upto" + String.valueOf(menu) + " background=\"../images/new/Over.jpg\" onclick=\"open_close(" + menu + " );open_close1(" + menu + " );window.parent.main.location='../" + rs.getString("Url") + "';window.parent.banner.showwz.innerHTML='<font color=#FFFFFF>当前位置:" + rs.getString("MModuleName") + "</font>';\"  >");
        this.outStr = (this.outStr + "<font color=\"#FFFFFF\">" + rs.getString("MModuleName") + " </font>");
        this.outStr += " </td>";
        this.outStr += "</tr><tr>";
        this.outStr += "<td  valign=\"top\" background=\"../images/new/line.jpg\">";
        this.outStr = (this.outStr + "<div id=\"detail" + menu + "\" style=\"display:none\">");
        this.outStr += "<table border=0 cellspacing=\"0\" cellpadding=\"0\" width=100%>";
        SqlStr = "select Url,MModuleNo,MModuleName,CModuleNo,CModuleName,small,nexus,title  from ModuleCortrol where   nexus='C' and  MModuleNo ='" + rs.getString("MModuleNo") + "' and CModuleNo in(select ModuleNo from  PopedomConrtrol where SellerId='" + userid + "') ORDER BY nexus DESC, orderby";
        ResultSet rs1 = null;
        rs1 = conndata1.executeQuery(SqlStr);
        while (rs1.next()) {
          this.outStr = (this.outStr + "  <tr   height='30'    align=center> <td background=''  valign='middle' ><img  src='" + rs1.getString("small") + "' border='0' width='16' height='16'>&nbsp;<a href='#' onclick=\"window.parent.main.location='../" + rs1.getString("Url") + "';window.parent.banner.showwz.innerHTML='<font color=#FFFFFF>当前位置:" + rs.getString("MModuleName") + "-->" + rs1.getString("CModuleName") + "</font>';\" ><font color='#FFFFFF'>" + rs1.getString("CModuleName") + "</font></a></td></tr>");
        }
        rs1.close();

        this.outStr += " </table>";
        this.outStr += "</div> ";
      }rs.close();

      this.outStr += "  </td>";
      this.outStr += "</tr>\t";

      this.outStr += " </table> ";
    }
    catch (Exception localException) {
    }
    return this.outStr;
  }

  public String newTopMenu(String userid, String paraIp)
  {
    SDatabase conndata = new SDatabase();
    SDatabase conndata1 = new SDatabase();
    String servicephone = "";
    String serviceperson = "";
    String saleurl = "";
    String saleperson = "";
    try {
      ResultSet rs1 = conndata.executeQuery("select servicephone,serviceperson,saleurl,saleperson from  user_reg");
      if (rs1.next()) {
        servicephone = rs1.getString("servicephone");
        serviceperson = rs1.getString("serviceperson");
        saleperson = rs1.getString("saleperson");
        saleurl = rs1.getString("saleurl");
      }
      rs1.close(); } catch (Exception s) {
      System.out.print(s.getMessage());
    }

    regcheck1 reg = new regcheck1();
    reg.checkREGIN();
    this.outStr = "<TABLE cellSpacing=0 cellPadding=0 width=\"100%\" border=0  ";
    if (reg.state == 1)
      this.outStr = (this.outStr + "title='软件提供商：U客软件　          　正式注册编码：hcrm-" + reg.userregno + "'");
    this.outStr += ">";
    this.outStr += " <TBODY>";
    this.outStr += " <TR background=\"../images/new/D_r1_c5.jpg\" width=\"100%\">";
    this.outStr += " <TD vAlign=top height=107>";
    this.outStr += " <TABLE height=102 cellSpacing=0 cellPadding=0 width=\"100%\" align=left   background=../images/new/D_r1_c5.jpg border=0> ";
    this.outStr += "  <TBODY>";
    this.outStr += "    <TR vAlign=top align=left>";
    this.outStr += "     <TD width=467 background=../images/new/D_r1_c1.jpg height=107>";
    this.outStr += "        ";
    this.outStr += "        <PARAM NAME=\"movie\" VALUE=\"../images/new/SHU.SWF\"><PARAM NAME=\"quality\" VALUE=\"high\"><PARAM NAME=\"wmode\" VALUE=\"transparent\">";
    this.outStr += "              <embed src=\"../images/new/SHU.SWF\"";
    this.outStr += "           width=\"467\" height=\"107\" hspace=\"0\" vspace=\"0\" quality=\"high\" ";

    this.outStr += "                 type=\"application/x-shockwave-flash\" wmode=\"transparent\"></embed></TD>";
    this.outStr += "  <td valign='middle' width='40'>&nbsp;</td>";
    this.outStr += "  <td valign='middle' width='100%' align='right'></td>";

    this.outStr += "    <TD width=100% align=right vAlign=top><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"524\">";
    this.outStr += "     <tr>";
    this.outStr += "     <td><table align='left' border='0' cellpadding='0' cellspacing='0' width='513'>";
    this.outStr += "        <tr>";
    this.outStr += "        <td><img src='../images/new/F_r1_c6.jpg' width='513' height='23'></td>";
    this.outStr += "     </tr>";
    this.outStr += "     <tr>";
    this.outStr += "      <td><table align='left' border='0' cellpadding='0' cellspacing='0' width='513'>";
    this.outStr += "      <tr>";
    this.outStr += "               <td   onMouseOut=\"MM_swapImgRestore();\" onMouseOver=\"mout(this);MM_swapImage('Image10','','../images/new/F2_r1_c1.jpg',1);\" onclick=\"openwin1('../sys/chane_set.jsp',300,500,100,100);\"  title='设置我的快捷菜单' ><img src=\"../images/new/F_r2_c6.jpg\" name=\"Image10\" width=\"80\" height=\"43\" border=\"0\"></td>";
    this.outStr += "               <td   onMouseOut=\"MM_swapImgRestore();\" onMouseOver=\"mout(this);MM_swapImage('Image11','','../images/new/F2_r1_c2.jpg',1);\" onclick=\"openwin1('../sys/chane_reg.jsp',300,200,100,100);\"  title='修改登录用户' ><img src=\"../images/new/F_r2_c7.jpg\" name=\"Image11\" width=\"89\" height=\"43\" border=\"0\"></td>";
    this.outStr = (this.outStr + "               <td   onMouseOut=\"MM_swapImgRestore();\" onMouseOver=\"mout(this);MM_swapImage('Image12','','../images/new/F2_r1_c4.jpg',1);\" title='技术支持联系人:" + serviceperson + ",电话:" + servicephone + "'><img src=\"../images/new/F_r2_c9.jpg\" name=\"Image12\" width=\"72\" height=\"43\" border=\"0\"></td>");
    this.outStr = (this.outStr + "               <td   onMouseOut=\"MM_swapImgRestore();\" onMouseOver=\"mout(this);MM_swapImage('Image13','','../images/new/F2_r1_c5.jpg',1);\" title='" + saleperson + "' onclick=\"window.open('http://" + saleurl + "');return false;\" ><img src=\"../images/new/F_r2_c10.jpg\" name=\"Image13\" width=\"69\" height=\"43\" border=\"0\"></td>");
    this.outStr += "               <td   onMouseOut=\"MM_swapImgRestore();\" onMouseOver=\"mout(this);MM_swapImage('Image14','','../images/new/F2_r1_c6.jpg',1);\" onclick=\"openwin1('../sys/ChangePassword.jsp',300,200,100,100);\"  title='修改登录密码'><img src=\"../images/new/F_r2_c11.jpg\" name=\"Image14\" width=\"67\" height=\"43\" border=\"0\"></td>";
    if (reg.state == 0)
      this.outStr += "               <td   onMouseOut=\"MM_swapImgRestore();\" onMouseOver=\"mout(this);MM_swapImage('Image15','','../images/new/F2_r1_c8.jpg',1);\" onClick=\"reg();return false;\"   title='注册时请连接internet网络'  target=rightp><img src=\"../images/new/F_r2_c13.jpg\" name=\"Image15\" width=\"67\" height=\"43\" border=\"0\"></td>";
    else {
      this.outStr += "               <td   onMouseOut=\"MM_swapImgRestore();\" onMouseOver=\"mout(this);MM_swapImage('Image15','','../images/new/F2_r1_c10.jpg',1);\" onClick=\"ver();return false;\"   title='注册时请连接internet网络'  target=rightp><img src=\"../images/new/F_r2_c15.jpg\" name=\"Image15\" width=\"67\" height=\"43\" border=\"0\"></td>";
    }
    this.outStr += "               <td   onMouseOut=\"MM_swapImgRestore();\" onMouseOver=\"mout(this);MM_swapImage('Image16','','../images/new/F2_r1_c9.jpg',1);\" onClick=\"out();return false;\"   title='退出系统'  target=rightp><img src=\"../images/new/F_r2_c14.jpg\" name=\"Image16\" width=\"63\" height=\"43\" border=\"0\"></td>";
    this.outStr += "       </tr>";
    this.outStr += "         </table></td>";
    this.outStr += "      </tr>";
    this.outStr += "      <tr>";
    this.outStr += "                       <td background=\"../images/new/F_r3_c6.jpg\" width=\"100%\" height=\"41\" align='center'><table width=\"100%\" border='0'><tr><td align='left'><img src='../images/home.gif'><div id='showwz' ><font color='#FFFFFF'>当前位置：我的桌面</font></div></td><td align='right' ><img src='../images/new/p1.gif' border='0' title='我的桌面' onMouseOver=\"mout(this);\" onClick=\"window.parent.main.location='../manager/rigthmenu.jsp?MModuleNo=DESKTOP';\">&nbsp;<img onclick=\"openwin1('../top/message.jsp',600,400,100,100);\"  onMouseOver=\"mout(this);\" src='../images/new/p3.gif' border='0' title='及时消息'>&nbsp;<img onclick=\"openwin1('../top/online.jsp',500,200,100,100);\" onMouseOver=\"mout(this);\" src='../images/new/p2.gif' border='0' title='在线用户'>&nbsp;<img onMouseOver=\"mout(this);\" src='../images/new/p4.gif' border='0' onclick=\"openwin1('../help/help.jsp',500,300,100,100);\"  title='在线帮助'></td></tr></table>";

    this.outStr += "                     </tr>";
    this.outStr += "                 </table></td>";
    this.outStr += "                 <td><img src=\"../images/new/F_r1_c15.jpg\" width=\"11\" height=\"107\"></td>";
    this.outStr += "               </tr>";
    this.outStr += "             </table></TD>";
    this.outStr += "           </TR>";
    this.outStr += "           </TBODY></TABLE>";
    this.outStr += "         </TD></TR>";
    this.outStr += "     </TBODY></TABLE> ";
    if (reg.fg == 0) this.outStr = reg.alertmess; else
      checkREG();
    return this.outStr;
  }

  public String doleftmenuStart(String userid, String paraIp)
  {
    SDatabase conndata = new SDatabase();
    SDatabase conndata1 = new SDatabase();
    regcheck1 reg = new regcheck1();
    reg.checkREGIN();
    this.outStr = "<table width='50%'   border='0' cellpadding='0' cellspacing='0' title='";
    if (reg.state == 1)
      this.outStr = (this.outStr + "软件提供商：U客软件　          　正式注册编码：hcrm-" + reg.userregno);
    this.outStr += "'>";

    String SqlStr = "select Url,MModuleNo,CModuleNo,MModuleName,picpath,nexus,title  from ModuleCortrol where  nexus='P' and  MModuleNo in(select manModule from  ManModuleCortrol where SellerId='" + userid + "') ORDER BY orderby  ";
    ResultSet rs = null;
    int ii = 1;
    String manurl = "welcome.jsp";
    try {
      rs = conndata.executeQuery(SqlStr);
      while (rs.next()) {
        String Url = getbyte(rs.getString("Url"));
        String CModuleName = getbyte(rs.getString("MModuleName"));
        String picpath = "../../../images/d1.gif";
        String Model_ID = getbyte(rs.getString("MModuleNo"));
        if (getbyte(rs.getString("CModuleNo")).trim().equals("desktop")) manurl = "rigthmenu.jsp?MModuleNo=DESKTOP"; else {
          manurl = "welcome.jsp";
        }
        this.outStr = (this.outStr + "  <tr   height='30'   align=center> <td background='' onclick=\"window.parent.main.location='rigthmenu.jsp?MModuleNo=" + Model_ID + "';menupic(this);windowstate('" + CModuleName + "');changeclass(this,'L3','L2');\"  ><a href  onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style=\"cursor:hand;\"    border=0 >" + CModuleName + "</a></td></tr>");
      }

      rs.close();
    } catch (Exception s) {
      System.out.print(s.getMessage());
    }

    this.outStr += "</table> ";

    if (reg.fg == 0) this.outStr = reg.alertmess; else
      checkREG();
    return this.outStr;
  }

  public String doleftmenuPStart(String userid, String paraIp) {
    SDatabase conndata = new SDatabase();
    SDatabase conndata1 = new SDatabase();
    regcheck1 reg = new regcheck1();
    reg.checkREGIN();
    String SqlStr = "select Url,MModuleNo,CModuleNo,MModuleName,picpath,nexus,title  from ModuleCortrol where  nexus='P' and  MModuleNo in(select manModule from  ManModuleCortrol where SellerId='" + userid + "') ORDER BY orderby  ";
    ResultSet rs = null;
    int ii = 1;
    this.outStr = "";
    String manurl = "welcome.jsp";
    try {
      rs = conndata.executeQuery(SqlStr);
      while (rs.next()) {
        if (this.outStr.equals("")) this.outStr = getbyte(rs.getString("MModuleNo")); else
          this.outStr = (this.outStr + "," + getbyte(rs.getString("MModuleNo")));
      }
      rs.close();
    } catch (Exception s) {
      System.out.print(s.getMessage());
    }

    if (reg.fg == 0) this.outStr = reg.alertmess; else
      checkREG();
    return this.outStr;
  }
  public String doleftmenuOutLookStart(String para, String ii, String titlename, String serverport, String manurl, String userid) {
    SDatabase ViewBean = new SDatabase();
    SDatabase conndata1 = new SDatabase();
    regcheck1 reg = new regcheck1();
    reg.checkREGIN();
    String ss = "";
    String menu_name = "";
    String cno = "";
    String SqlStr = "";
    SqlStr = "select Url,MModuleNo,CModuleNo,CModuleName,picpath,nexus,title  from ModuleCortrol where    MModuleNo='" + para + "' and CModuleNo in(select ModuleNo from  PopedomConrtrol where SellerId='" + userid + "') ORDER BY orderby";
    if (para.equals("DESKTOP")) {
      SqlStr = "select Url,MModuleNo,CModuleNo,CModuleName,picpath,nexus,title  from ModuleCortrol where     MModuleNo='" + para + "' or  ( CModuleNo in(select ModuleNo from  PopedomConrtrol where SellerId='" + userid + "'  and choose=1)) ORDER BY orderby";
    }
    ResultSet rs = null;
    try {
      rs = ViewBean.executeQuery(SqlStr);
      while (rs.next()) {
        String Url = getbyte(rs.getString("Url"));
        String MModuleNo = getbyte(rs.getString("MModuleNo"));
        String CModuleNo = getbyte(rs.getString("CModuleNo"));
        String CModuleName = getbyte(rs.getString("CModuleName")).trim();
        String picpath = getbyte(rs.getString("picpath"));
        String nexus = getbyte(rs.getString("nexus"));
        String title = getbyte(rs.getString("title"));

        cno = MModuleNo;
        if (nexus.equals("P")) { menu_name = CModuleName;
        } else {
          ss = ss + "\"" + picpath + "\",";

          ss = ss + "\"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + CModuleName + "\",";
          ss = ss + "\"../" + Url + "\",";

          ss = ss + "\"parent.main\",";
        }
      }
      if (!ss.equals("")) {
        ss = ss.substring(0, ss.lastIndexOf(","));
        ss = " OutBarFolder" + ii + "=new Array(\"" + titlename + "," + manurl + "&MModuleNo=" + cno + "\"," + ss + ");";
      }
      rs.close();
    }
    catch (Exception s) {
      ss = s.getMessage();
    }if (reg.fg == 0) this.outStr = reg.alertmess; else
      checkREG();
    return ss;
  }

  public String DoTopMenu(String userid, String paraIp) {
    SDatabase conndata = new SDatabase();
    String servicephone = "";
    String serviceperson = "";

    String saleurl = "";
    String saleperson = "";
    try {
      ResultSet rs1 = conndata.executeQuery("select servicephone,serviceperson,saleurl,saleperson from  user_reg");
      if (rs1.next())
      {
        servicephone = rs1.getString("servicephone");
        serviceperson = rs1.getString("serviceperson");
        saleperson = rs1.getString("saleperson");
        saleurl = rs1.getString("saleurl");
      }
      rs1.close(); } catch (Exception s) {
      System.out.print(s.getMessage());
    }
    regcheck1 reg = new regcheck1();
    reg.checkREGIN();
    this.outStr = "<table width='100%'  border='0'  background='../images/green_topM.jpg' cellpadding='0' cellspacing='0' title='";
    if (reg.state == 1) this.outStr = (this.outStr + "软件提供商：U客软件　          　正式注册编码：hcrm-" + reg.userregno);
    this.outStr += "'>";

    this.outStr += "  <tr >";

    this.outStr += " <td width='442'  height='230' valign='top' align='right'><SPAN id=lblFlash>";
    this.outStr += "  <object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0' width='442' height='245'>";
    this.outStr += "   <param name='movie' value='../images/7.swf'>";
    this.outStr += "   <param name='quality' value='high'>";
    this.outStr += "  <embed src='../images/7.swf' quality='high' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' width='442' height='245'></embed>";
    this.outStr += "  </object>";
    this.outStr += "  </SPAN></td>";
    this.outStr += " <td valign='top'><table width='100%'  border='0' cellpadding='0' cellspacing='0'>";

    this.outStr += " <tr>";
    this.outStr += " <td height='60' ><table width='100%'  border='0' cellpadding='0' cellspacing='0'>";
    this.outStr += " <tr>";
    this.outStr += " <td width='20'></td>";
    this.outStr += "  <td></td><td align='right'>";

    this.outStr = (this.outStr + " <img src='../images/set.gif' width='15' height='15' hspace='8' align='absmiddle'><span class='style3' onclick=\"openwin1('../sys/chane_set.jsp',300,500,100,100);\"  title='设置我的快捷菜单' onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'><font color=#000000>快捷菜单</font></span><img src='../images/phone.gif' width='23' height='16' hspace='8' align='absmiddle'><span class='style4'  onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'  title='技术支持联系人:" + serviceperson + ",电话:" + servicephone + "'><font color=#000000>服务</font></span><img src='../images/home.gif' width='15' height='15' hspace='5' align='absmiddle'><span class='style2' onMouseOver='OverArrow(this)'  title='" + saleperson + "' onclick=\"window.open('http://" + saleurl + "');return false;\" onMouseOut='OutArrow(this)' style='cursor:hand;'      target=rightp><font color=#000000>主页</font></span><img src='images/user.gif' width='15' height='15' hspace='8' align='absmiddle'><span class='style4' onclick=\"openwin1('../sys/chane_reg.jsp',300,200,100,100);\" onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;' title='修改登录用户'><font color=#000000>帐号</font></span><img src='../images/icon_edit_topic.gif' width='15' height=15 hspace=8 align='absmiddle' ><span class='style3' onclick=\"openwin1('../sys/ChangePassword.jsp',300,200,100,100);\" onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'  title='修改登录密码'><font color=#000000>密码</font></span><img src='../images/standard_basic.gif' width='15' height='15' hspace='5' align='absmiddle'>");
    this.outStr += " <span class='style2' onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'  onClick=\"reg();return false;\"   title='注册时请连接internet网络'  target=rightp>";
    if (reg.state == 0) this.outStr += " <font color=#000000>注册</font>"; else this.outStr += " <font color=#000000>关于</font>";
    this.outStr += " </span><img src='../images/exit.gif' width='15' height='15' hspace='5' align='absmiddle'><span class='style2' onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'  onClick=\"out();return false;\"   title='退出系统'  target=rightp><font color=#000000>退出</font></span></td>";
    this.outStr += "  <td width='80' align='right'><MARQUEE id='PLACARD' direction='left'  width='100%'  scrollDelay='30' trueSpeed='true' scrollAmount='1' ><font color='#FFFFFF'><!--尊敬的客户，您好！欢迎您选择U客售楼管理系统!--></font></MARQUEE> </td>";
    this.outStr += " </tr>   </table> </td>";
    this.outStr += "</tr>";
    this.outStr += "<tr>";
    this.outStr += "  <td height='65' >";
    this.outStr += "<table width='100%' height='65'  border='0' cellpadding='0' cellspacing='0'>";
    this.outStr += "  <tr align='center' valign='top'><td><img src='../images//word.gif' width='230' height='30'></td>";
    this.outStr += "</tr>  ";
    this.outStr += "</table></td>";
    this.outStr += "</tr>";
    this.outStr += "</table></td>";
    this.outStr += " <td width='17' valign='top'></td>";
    this.outStr += "</tr>";
    this.outStr += "</table>";
    if (reg.fg == 0) this.outStr = reg.alertmess; else
      checkREG();
    return this.outStr;
  }

  public String doStartTag(String userid)
  {
    SDatabase conndata = new SDatabase();
    String servicephone = "";
    String serviceperson = "";

    String saleurl = "";
    String saleperson = "";
    try {
      ResultSet rs1 = conndata.executeQuery("select servicephone,serviceperson,saleurl,saleperson from  user_reg");
      if (rs1.next())
      {
        servicephone = rs1.getString("servicephone");
        serviceperson = rs1.getString("serviceperson");
        saleperson = rs1.getString("saleperson");
        saleurl = rs1.getString("saleurl");
      }
      rs1.close(); } catch (Exception s) {
      System.out.print(s.getMessage());
    }regcheck1 reg = new regcheck1();
    reg.checkREGIN();
    this.outStr = "<table width='100%'  border='0' cellpadding='0' cellspacing='0' title='";
    if (reg.state == 1) this.outStr = (this.outStr + "软件提供商：U客软件　          　正式注册编码：hcrm-" + reg.userregno);
    this.outStr += "'>";

    this.outStr += "  <tr >";
    this.outStr += " <td width='18'><img src='images/tab_bg_left.gif' width='18' height='125'></td>";
    this.outStr += " <td width='284' background='images/tab_bg_left2.gif' valign='top' align='right'></td>";
    this.outStr += " <td valign='top'><table width='100%'  border='0' cellpadding='0' cellspacing='0'>";

    this.outStr += " <tr>";
    this.outStr += " <td height='60' background='images/tab_bg_left3bg.gif'><table width='100%'  border='0' cellpadding='0' cellspacing='0'>";
    this.outStr += " <tr>";
    this.outStr += " <td width='20'><img src='images/tab_bg_left3.gif' width='20' height='60'></td>";
    this.outStr += " <td><embed src='logo.swf' width='100' height='60' quality='high' wmode='transparent'></td><td align='right'>";
    this.outStr = (this.outStr + " <img src='images/set.gif' width='15' height='15' hspace='8' align='absmiddle'><span class='style4' onclick=\"openwin1('../sys/chane_set.jsp',500,500,100,100);\" onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;' title='修改我的桌面内容'>桌面设置</span><img src='images/user.gif' width='15' height='15' hspace='8' align='absmiddle'><span class='style4' onclick=\"openwin1('../sys/chane_reg.jsp',300,200,100,100);\"  title='修改登录用户' onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'>修改帐号</span><img src='images/set.gif' width='15' height='15' hspace='8' align='absmiddle'><span class='style4' onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;' onclick=\"window.parent.contents.location='../manager/menu.jsp?MModuleNo=M';window.parent.main.location='../manager/log.jsp';\" title='进入系统管理模块'>系统设置</span><img src='../images/phone.gif' width='23' height='16' hspace='8' align='absmiddle'><span class='style4'  onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'  title='技术支持联系人:" + serviceperson + ",电话:" + servicephone + "'>服务</span><img src='images/home.gif' width='15' height='15' hspace='5' align='absmiddle'><span class='style2' onMouseOver='OverArrow(this)' title='" + saleperson + "' onclick=\"window.open('http://" + saleurl + "');return false;\"  onMouseOut='OutArrow(this)' style='cursor:hand;'      target=rightp>主页</span><img src='../images/icon_edit_topic.gif' width='15' height=15 hspace=8 align='absmiddle' ><span class='style3' onclick=\"openwin1('../sys/ChangePassword.jsp',300,200,100,100);\"  title='修改登录密码' onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;' >密码</span><img src='../images/standard_basic.gif' width='15' height='15' hspace='5' align='absmiddle'>");
    this.outStr += " <span class='style2' onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'  onClick=\"reg();return false;\"   title='注册时请连接internet网络'  target=rightp>";
    if (reg.state == 0) this.outStr += " 注册"; else this.outStr += " 关于";
    this.outStr += " </span><img src='images/exit.gif' width='15' height='15' hspace='5' align='absmiddle'><span class='style2' onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'  onClick=\"out();return false;\"   title='退出系统'  target=rightp>退出</span> </td>";

    this.outStr += " </tr>   </table> </td>";
    this.outStr += "</tr>";
    this.outStr += "<tr>";
    this.outStr += "  <td height='65' background='images/tab_bg_left3bg2.gif' valign='top'  >";
    this.outStr += "<table width='100%'   border='0' cellpadding='0' cellspacing='0'>";
    this.outStr += "  <tr align='center' valign='top'>";
    String SqlStr = "select Url,MModuleNo,CModuleNo,MModuleName,picpath,nexus,title  from ModuleCortrol where (MModuleNo<>'M' ) and nexus='P' and  MModuleNo in(select manModule from  ManModuleCortrol where SellerId='" + userid + "') ORDER BY orderby  ";
    try {
      ResultSet rs = conndata.executeQuery(SqlStr);
      while (rs.next()) {
        String Url = rs.getString("Url");
        String MModuleNo = rs.getString("MModuleNo");
        String CModuleNo = rs.getString("CModuleNo");
        String MModuleName = rs.getString("MModuleName").trim();
        String picpath = rs.getString("picpath");
        String nexus = rs.getString("nexus");
        String title = rs.getString("title");
        String mm = "";

        mm = "../" + Url;
        this.outStr = (this.outStr + "  <td valign='top' onclick=\"\"><img title=" + title + " onclick=\"window.parent.contents.location='../manager/menu.jsp?MModuleNo=" + MModuleNo + "';window.parent.main.location='" + mm + "';menupic(this);windowstate('" + MModuleName + "')\" onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'  src=" + picpath + " width='32' height='32'  border=0 ><br>" + MModuleName + "</td>");
      }
      rs.close(); } catch (Exception s) {
      System.out.print(s.getMessage());
    }this.outStr += " <td></td>";
    this.outStr += "</tr>  ";
    this.outStr += "</table></td>";
    this.outStr += "</tr>";
    this.outStr += "</table></td>";
    this.outStr += " <td width='17' valign='top'><img src='images/tab_bg_right.gif' width='17' height='125'></td>";
    this.outStr += "</tr>";
    this.outStr += "</table>";
    if (reg.fg == 0) this.outStr = reg.alertmess; else
      checkREG();
    return this.outStr;
  }
  public String getbyte(String para) throws Exception {
    String temp = para;
    if (temp == null) temp = "";
    return temp;
  }
  public String doReadProject(String Cortrol) {
    this.outStr = "<p align='center'><b><font size='3' class=FontColor>楼盘资料一览表</font></b></p>";
    this.outStr += " <table width=100%><tr height='16' bgcolor='#EAEAEA'><td align='right'>";
    if (Cortrol.indexOf("A") >= 0) this.outStr += "<input type=button name=add value='增 加' title='添加楼盘资料'  onclick=\"openwin2('crm_Project_add.jsp',650,580,100,10);\">";
    if (Cortrol.indexOf("E") >= 0) this.outStr += "<input type=button name=modi value=\"修 改\" title=\"修改选中的楼盘资料\" onclick=\"EditInto();\" >";
    if (Cortrol.indexOf("D") >= 0) this.outStr += "<input type=button name=del value=\"删　除\" title=\"删除选中的楼盘资料\"  onclick=\"Dele();\">";
    if (Cortrol.indexOf("F") >= 0) this.outStr += "<input type=button name=del value=\"房间明细表\"   onclick=\"openwin2('../sale/auto_select.jsp?PARA_SQL=ViewSectionData&url=22&reporttype=sale&tablename=',700,400,50,50);\">";

    this.outStr += " <input type=button name=\"xq\" value=\"销售统计\" title=\"查找选中楼盘的详细楼栋资料\" onclick=\"setSubmit1();\">";
    this.outStr += " <input type=hidden name=SetNo>\t<input type=hidden name=CancelNo>";
    this.outStr += " </td></tr></table>";
    this.outStr += " <table width=100%><tr height=\"3\"><td></td></tr></table> ";
    this.outStr += "<table BORDER=0 width=\"100%\"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>";
    this.outStr += "<tr class=listtitle>";
    this.outStr += "<td  align=\"center\"  ><font color=white>楼盘名称</font></td>";
    this.outStr += "<td  align=\"center\"  ><font color=white>位置</font></td>";
    this.outStr += "<td  align=\"center\"  ><font color=white>预售许可证</font></td>";
    this.outStr += "<td  align=\"center\"  ><font color=white>规划许可证</font></td>";
    this.outStr += " <td  align=\"center\"  ><font color=white>施工许可证</font></td>";
    this.outStr += "<td width=\"8%\" align=\"center\"  >&nbsp;</td>";
    this.outStr += " </tr>";
    SDatabase conndata = new SDatabase();
    FormatData FormtD = new FormatData();
    ResultSet rs = null;
    int project = 0;
    String infoProject = "0";
    try
    {
      writereadregedit regdate = new writereadregedit();
      infoProject = regdate.readRegProject();
    } catch (Exception s) {
      System.out.print(s.getMessage());
    }String sql = "select ";
    if (infoProject.equals("0"))
      sql = sql + " * from CRM_Project order by code asc";
    else
      sql = sql + " top " + infoProject + " * from CRM_Project order by code asc";
    String secno = "";
    String secname = "";
    String areano = "";

    String Active = "";
    String code = "";
    String yushou_no = "";
    String guihua_no = "";
    String shigong_no = "";
    int i = 0;
    try {
      rs = conndata.executeQuery(sql);
      while (rs.next()) {
        i++;
        code = getbyte(rs.getString("code"));
        secname = getbyte(rs.getString("Name"));
        areano = getbyte(rs.getString("AreaNo"));
        secno = rs.getString("SerialNo");
        String totalarea = FormtD.getFloat(rs.getFloat("TotalArea"), 4);
        String groundarea = FormtD.getFloat(rs.getFloat("GroundArea"), 2);
        String greenrate = FormtD.getFloat(rs.getFloat("GreenRate"), 3);
        yushou_no = getbyte(rs.getString("yushou_no"));
        guihua_no = getbyte(rs.getString("guihua_no"));
        shigong_no = getbyte(rs.getString("shigong_no"));

        String offerdate = getbyte(rs.getString("Offerdate"));
        SimpleDateFormat date = null;
        if (!offerdate.equals("")) {
          date = new SimpleDateFormat("yyyy-MM-dd");

          offerdate = date.format(date.parse(offerdate));
        }
        int familycount = rs.getInt("FamilyCount");
        String realrate = FormtD.getFloat(rs.getFloat("RealRate"), 3);
        this.outStr = (this.outStr + "  <tr id=TR" + i + " align=\"center\"  ondblclick=\"openwin2('SectionShow.jsp?ID=" + code + "',480,420,100,10);\" class=listcontent onmouseover=\"mout(this);\"  onclick=\"savepara('" + code + "','" + secno + "','" + secname + "');changeclass1(this,'clickbg','listcontent');\"  title=\"双击可查看楼盘资料\" >");
        this.outStr = (this.outStr + " <td   > " + secname + "</td>");
        this.outStr = (this.outStr + "  <td   > " + areano + "</td>");
        this.outStr = (this.outStr + " <td   > " + yushou_no + "</td>");
        this.outStr = (this.outStr + " <td   > " + guihua_no + "</td>");
        this.outStr = (this.outStr + " <td   > " + shigong_no + "</td>");
        this.outStr = (this.outStr + " <td><input type=button value=\"楼 栋\" title=\"增加楼栋资料\" onclick=\"openwin2('indexTree.jsp?SecNo=" + secno + "',450,300,100,100);\">&nbsp;<input type=button value=\"图片\" title=\"增加地图\" onclick=\"openwin2('AddPic.jsp?SecNo=" + secno + "',450,300,100,100);\"></td>");
        this.outStr += "</tr>";
      }

      rs.close(); } catch (Exception s) {
      System.out.print(s.getMessage());
    }
    return this.outStr;
  }
  public String doStartReg(String endd, String regno, String aa) {
    SDatabase conndata = new SDatabase();
    MD4 md5 = new MD4();
    HardWareID HID = new HardWareID();
    String userCompayname = ""; String regnum = ""; String project = ""; String usernum = "";
    SimpleDateFormat date = null;
    date = new SimpleDateFormat("yyyy-MM-dd");
    String TodayDate = new Date().toString();
    ResultSet msgrs = null;
    try {
      msgrs = conndata.executeQuery("select  top 1 CompanyName,regnum,usernum,project from company");
      if (msgrs.next()) {
        userCompayname = msgrs.getString("CompanyName");
        regnum = msgrs.getString("regnum");
        usernum = msgrs.getString("usernum");
        project = msgrs.getString("project");
        if (usernum.equals("0")) usernum = "无限";
        if (project.equals("0")) project = "无限";
      }
      msgrs.close(); } catch (Exception s) {
      System.out.print(s.getMessage());
    }this.outStr = "<table width='100%'  border='0' cellpadding='0' cellspacing='0'>";
    this.outStr += " <tr>";
    this.outStr += " <td width='25%' height='16'>使用企业名称</td>";
    this.outStr = (this.outStr + " <td width='38%' height='16'>" + userCompayname + "</td>");

    this.outStr += " </tr>";
    this.outStr += " <tr>";
    this.outStr += " <td width='25%' height='16'>使用客户类型</td>";
    this.outStr += " <td width='38%' height='16'><select name=custype><option value=0>试用客户</option><option value=1>U客代理商</option><option value=2>购买客户</option></select></td>";

    this.outStr += " </tr>";
    this.outStr += " <tr>";
    this.outStr += " <td width='25%' height='16'>授&nbsp;权&nbsp;许&nbsp;可</td>";
    this.outStr = (this.outStr + " <td width='38%' height='16'>并发用户数：" + usernum + "&nbsp;许可楼盘数：" + project + "</td>");

    this.outStr += " </tr>";
    this.outStr += " <tr>";
    this.outStr += " <td width='25%' height='16'>已注册次数</td>";
    this.outStr = (this.outStr + " <td width='38%' height='16'>" + regnum + "</td>");

    this.outStr += " </tr>";
    this.outStr += "<tr>";
    this.outStr += " <td width='25%' height='16'>系统随机序号</td>";
    this.outStr = (this.outStr + "<td width='38%' height='16'>" + HardWareID.getMacAddress() + "</td>");
    this.outStr += " <tr>";
    this.outStr += " <td width='25%' height='14'>系统注册日期</td>";
    this.outStr = (this.outStr + "<td width='38%' height='14'><input type=text name=endd size='42' value='" + date.format(new Date()).toString() + "'></td>");
    this.outStr += " </tr>";
    this.outStr += "<tr>";
    this.outStr += " <td width='25%' height='16'>请填写注册号</td>";
    this.outStr += "<td width='38%' height='16'><input type=text name=regno size='42' value=''></td>";
    this.outStr += " </tr>";
    this.outStr += "</table>";

    this.outStr += " <p align='center'> <input type=button name=reg value='确认注册' ONCLICK=\"if (confirm('确认注册吗?'))regfrm.submit();\"> </p>";
    regcheck1 reg = new regcheck1();
    String mess = reg.checkREGMess();
    int aaa = 0;
    if (!mess.equals("")) { this.outStr = mess;
    } else if (!regno.equals("")) {
      String messinfo = reg.checkREGInfo(regno, endd, aa);
      if (!messinfo.equals("")) this.outStr = messinfo;
    }

    return this.outStr;
  }

  public String checkREG()
  {
    Object obj = null;
    String s = "系统已过期，请及时联系U客软件,QQ:357657132 ";
    String okmess = "";
    SDatabase sdatabase = new SDatabase();
    writereadregedit regdate = new writereadregedit();
    String infodate = regdate.readRegDate();
    String infoState = regdate.readRegState();
    String infosdate = regdate.readRegsDate();
    if (infoState.equals("0")) {
      String s1 = "select  * from  user_reg  where  convert(char(10),'" + infodate + "',120) <convert(char(10),getdate(),120)  and convert(char(10),'" + infosdate + "',120)<=convert(char(10),getdate(),120)  and state=0";
      try
      {
        ResultSet resultset = sdatabase.executeQuery(s1);
        if (resultset.next())
        {
          s = "系统已过期，请及时联系U客软件,QQ:357657132 ";

          resultset.close();
        } else {
          resultset.close();
          String s2 = "select  * from  user_reg where convert(char(10),'" + infosdate + "',120)<=convert(char(10),getdate(),120) and state=" + infoState;
          resultset = sdatabase.executeQuery(s2);
          if (resultset.next()) {
            okmess = "|ok";
            s = "jsp/manager/index.jsp";
          }resultset.close();
        }
      } catch (Exception localException) {
      }
    } else { okmess = "|ok";
      s = "jsp/manager/index.jsp";
    }
    return s + okmess;
  }
  public String checkLoginUser(int num) {
    SDatabase sdatabase = new SDatabase();
    String yy = "true";

    writereadregedit regdate = new writereadregedit();

    String infoOnline = regdate.readRegOnline();
    if (infoOnline.equals("")) infoOnline = "0";
    String s1 = "select  *," + infoOnline + " as online from  company ";
    try
    {
      ResultSet resultset = sdatabase.executeQuery(s1);
      if (resultset.next()) {
        int usernum = resultset.getInt("online");

        if (usernum == 0) yy = "true";
        else if (usernum < num) yy = "false";
      }

      resultset.close(); } catch (Exception exception) {
      return "false";
    }return yy;
  }
  public String doStart(String dd, int num) {
    String yyy = "";
    if (!dd.equals("")) {
      String ok = checkREG();
      writereadregedit writedate = new writereadregedit();
      if (writedate.writeinfo().equals("")) ok = "";

      if (ok.indexOf("过期") >= 0) {
        this.outStr = "  <script language=javascript>";
        this.outStr += " alert(\"已过期，请重新注册,U客软件,QQ:357657132 \"); ";
        this.outStr += "window.showModalDialog(\"../jsp/manager/testerror.jsp\",\"\",\"dialogWidth400px; dialogHeight:200px; dialogLeft:150px; dialogTop:100px; status:no; directories:yes;scrollbars:no;Resizable=no; \");";
        this.outStr += "parent.window.close();";
        this.outStr += "</script>";
      } else {
        regcheck1 reg = new regcheck1();
        String reginfomess = reg.checkREG();
        if (writedate.writeinfo().equals("")) reginfomess = "你可能第一次安装U客软件，请重新激活系统后才能正常使用";
        this.outStr = reg.checkREGYear();
        this.outStr += "<script>";
        this.outStr += "function alertmess(){";
        if (!reginfomess.equals("")) {
          this.outStr = (this.outStr + " alert(\"" + reginfomess + "\"); ");
        }
        this.outStr = (this.outStr + "var aa=\"" + ok + "\";");
        this.outStr += " if (aa.indexOf(\"|\")==-1){";
        this.outStr += "  showx = screen.availWidth;  ";
        this.outStr += "showy = screen.availHeight; ";
        this.outStr += " retval = window.showModalDialog('alert.jsp','','dialogWidth400px; dialogHeight:550px; dialogLeft:150px; dialogTop:100px; status:no; directories:yes;scrollbars:no;Resizable=no; '  );";
        this.outStr += "}";
        this.outStr += " if (aa.indexOf('|')>=0) ";
        this.outStr += " window.location=aa.substring(0,aa.indexOf('|'));";
        this.outStr += "  else";
        this.outStr += " window.location=aa; ";
        this.outStr += " }";

        this.outStr += "</script>";
        yyy = checkLoginUser(num);

        yyy = yyy.trim();
        if (yyy.equals("false")) {
          this.outStr = "  <script language=javascript>";
          this.outStr += " alert(\"当前用户数已满!请稍后再登录\"); ";
          this.outStr += "window.open(\"index.jsp\");";
          this.outStr += "parent.window.close();";
          this.outStr += "</script>";
        }
      }
    }
    else {
      this.outStr = "  <script language=javascript>";
      this.outStr += " alert(\"登录失败\"); ";
      this.outStr += "window.open(\"index.jsp\");";
      this.outStr += "parent.window.close();";
      this.outStr += "</script>";
    }

    return this.outStr;
  }
}