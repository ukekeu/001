package ConnDatabase;

import FormatData.FormatData;
import crypt.MD5;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import regcheck.HardWareID;
import regcheck.regcheck;
import regcheck.writereadregedit;

public class menu {
	ResultSet sectionRS = null;
	HashMap hm = null;
	String outStr;
	private static Logger logger = LoggerFactory.getLogger(menu.class);

	public String showregCompay() {
		SDatabase localSDatabase = null;
		String str = "";
		ResultSet localResultSet = null;
		try {
			localSDatabase = new SDatabase();

			localResultSet = localSDatabase
					.executeQuery("select CompanyName from company");

			while (localResultSet.next()) {
				str = localResultSet.getString("CompanyName");
			}
			localResultSet.close();
			this.outStr = "";
			this.outStr += " function windowstate(){";
			this.outStr = (this.outStr + " window.status=\"本产品是U客软件授权给" + str
					+ "合法使用" + "\";");
			this.outStr += "}";
		} catch (Exception localException) {
			logger.error(localException.getMessage(), localException);
		} finally {
			if (localResultSet != null) {
				try {
					localResultSet.close();
				} catch (SQLException e) {

				}
			}
			if (localSDatabase != null) {
				localSDatabase.closeConn();
			}
		}
		return this.outStr;
	}

	public String showProduect() {
		SDatabase localSDatabase1 = null;
		String str = "select * from user_reg where state=1 ";
		ResultSet localResultSet = null;
		try {
			localSDatabase1 = new SDatabase();
			localResultSet = localSDatabase1.executeQuery(str);

			if (localResultSet.next()) {
				this.outStr = "<table border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%' id='AutoNumber1'>";

				this.outStr += " <tr>";
				this.outStr += "<td valign='middle' height='97' valign='middle' background='../../images/top_banner.gif'>";
				this.outStr += "       <object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0' width='210' height='80'>";
				this.outStr += "       <param name='movie' value='logo.swf'>";
				this.outStr += "      <param name='quality' value='high'><param name='BGCOLOR' value='#000000'><param name='wmode' value='transparent'>";
				this.outStr += "       <embed src='images/logo.swf' width='210' height='80' quality='high' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' bgcolor='#000000'></embed></object>  </td>";
				this.outStr += "   </tr>  ";
				this.outStr += "  <tr>";
				this.outStr = (this.outStr + "   <td width='100%'>正式注册日期："
						+ localResultSet.getString("column_b") + "</td>");
				this.outStr += " </tr>";
				this.outStr += " <tr>";
				this.outStr = (this.outStr + "  <td width='100%'>正式注册号码："
						+ localResultSet.getString("userregno") + "</td>");
				this.outStr += " </tr>";
				this.outStr += "<tr>";
				this.outStr = (this.outStr + "   <td width='100%'>软件版本号码："
						+ localResultSet.getString("softver") + "</td>");
				this.outStr += " </tr>";
				this.outStr += "<tr>";
				this.outStr = (this.outStr + "   <td width='100%'>软件版本条码："
						+ localResultSet.getString("code") + "</td>");
				this.outStr += " </tr>";
				this.outStr += "   <tr>";
				this.outStr = (this.outStr + "    <td width='100%'>软件版权属于："
						+ localResultSet.getString("saleperson") + "</td>");
				this.outStr += "  </tr>";
				this.outStr += "</table>";
			}
			localResultSet.close();
		} catch (Exception localException) {
			logger.error(localException.getLocalizedMessage(), localException);
		} finally {
			if (localResultSet != null) {
				try {
					localResultSet.close();
				} catch (SQLException e) {
				}
			}
			if (localSDatabase1 != null) {
				localSDatabase1.closeConn();
			}
		}
		return this.outStr;
	}

	public String newLeftMenu(String paramString1, String paramString2) {
		SDatabase localSDatabase1 = null;
		SDatabase localSDatabase2 = null;
		regcheck localregcheck = new regcheck();
		ResultSet localResultSet1 = null;
		localregcheck.checkREGIN();
		this.outStr = "";
		try {
			localSDatabase1 = new SDatabase();
			localSDatabase2 = new SDatabase();
			this.outStr += " \t<table border=\"0\" width=\"95%\" cellspacing=\"0\" cellpadding=\"0\" background='../images/new/F_r1_c6.jpg'>";

			String str = "select Url,MModuleNo,CModuleNo,MModuleName,picpath,nexus,title  from ModuleCortrol where  nexus='P' and   MModuleNo<>'desktop' and  MModuleNo in(select manModule from  ManModuleCortrol where SellerId='"
					+ paramString1 + "') ORDER BY orderby  ";

			localResultSet1 = localSDatabase1.executeQuery(str);
			int i = 0;
			while (localResultSet1.next()) {
				i++;

				this.outStr += " <tr valign=\"top\"  align=\"center\"  onmouseover=\"mout(this) ;\">";
				this.outStr = (this.outStr
						+ "  <td  height=\"30\" valign=\"middle\" id=upto"
						+ String.valueOf(i)
						+ " background=\"../images/new/Over.jpg\" onclick=\"open_close("
						+ i
						+ " );open_close1("
						+ i
						+ " );window.parent.main.location='../"
						+ localResultSet1.getString("Url")
						+ "';window.parent.banner.showwz.innerHTML='<font color=#FFFFFF>当前位置:"
						+ localResultSet1.getString("MModuleName") + "</font>';\"  >");
				this.outStr = (this.outStr + "<font color=\"#FFFFFF\">"
						+ localResultSet1.getString("MModuleName") + " </font>");
				this.outStr += " </td>";
				this.outStr += "</tr><tr>";
				this.outStr += "<td  valign=\"top\" background=\"../images/new/line.jpg\">";
				this.outStr = (this.outStr + "<div id=\"detail" + i + "\" style=\"display:none\">");
				this.outStr += "<table border=0 cellspacing=\"0\" cellpadding=\"0\" width=100%>";
				str = "select Url,MModuleNo,MModuleName,CModuleNo,CModuleName,small,nexus,title  from ModuleCortrol where   nexus='C' and  MModuleNo ='"
						+ localResultSet1.getString("MModuleNo")
						+ "' and CModuleNo in(select ModuleNo from  PopedomConrtrol where SellerId='"
						+ paramString1 + "') ORDER BY nexus DESC, orderby";
				ResultSet localResultSet2 = null;
				localResultSet2 = localSDatabase2.executeQuery(str);
				while (localResultSet2.next()) {
					this.outStr = (this.outStr
							+ "  <tr   height='30'    align=center> <td background=''  valign='middle' ><img  src='"
							+ localResultSet2.getString("small")
							+ "' border='0' width='16' height='16'>&nbsp;<a href='#' onclick=\"window.parent.main.location='../"
							+ localResultSet2.getString("Url")
							+ "';window.parent.banner.showwz.innerHTML='<font color=#FFFFFF>当前位置:"
							+ localResultSet1.getString("MModuleName") + "-->"
							+ localResultSet2.getString("CModuleName")
							+ "</font>';\" ><font color='#FFFFFF'>"
							+ localResultSet2.getString("CModuleName") + "</font></a></td></tr>");
				}
				localResultSet2.close();

				this.outStr += " </table>";
				this.outStr += "</div> ";
			}
			localResultSet1.close();

			this.outStr += "  </td>";
			this.outStr += "</tr>\t";

			this.outStr += " </table> ";
		} catch (Exception localException) {
			logger.error(localException.getLocalizedMessage(), localException);
		} finally {
			if (localResultSet1 != null) {
				try {
					localResultSet1.close();
				} catch (SQLException e) {

				}
			}
			if (localSDatabase1 != null) {
				localSDatabase1.closeConn();
			}
			if (localSDatabase2 != null) {
				localSDatabase2.closeConn();
			}

		}
		return this.outStr;
	}

	public String newTopMenu(String paramString1, String paramString2) {
		SDatabase localSDatabase1 = null;

		String str1 = "";
		String str2 = "";
		String str3 = "";
		String str4 = "";
		ResultSet localResultSet = null;
		try {
			localSDatabase1 = new SDatabase();
			localResultSet = localSDatabase1
					.executeQuery("select servicephone,serviceperson,saleurl,saleperson from  user_reg");
			if (localResultSet.next()) {
				str1 = localResultSet.getString("servicephone");
				str2 = localResultSet.getString("serviceperson");
				str4 = localResultSet.getString("saleperson");
				str3 = localResultSet.getString("saleurl");
			}

		} catch (Exception localException) {
			System.out.print(localException.getMessage());
		} finally {
			try {
				if (localResultSet != null) {
					localResultSet.close();
				}

			} catch (SQLException e) {

			}

			if (localSDatabase1 != null) {
				localSDatabase1.closeConn();
			}
		}

		regcheck localregcheck = new regcheck();
		localregcheck.checkREGIN();
		this.outStr = "<TABLE cellSpacing=0 cellPadding=0 width=\"100%\" border=0  ";
		if (localregcheck.state == 1)
			this.outStr = (this.outStr
					+ "title='软件提供商：U客软件　          　正式注册编码：hcrm-"
					+ localregcheck.userregno + "'");
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
		this.outStr += "  <td valign='bottom' width='100%' align='left' style=\"padding:0 0 10px 5px;\"><img src='../images/home.gif' style=\"float: left;\"><div id='showwz' ><font color='#FFFFFF'>当前位置：我的桌面</font></div></td>";

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
		this.outStr = (this.outStr
				+ "               <td   onMouseOut=\"MM_swapImgRestore();\" onMouseOver=\"mout(this);MM_swapImage('Image12','','../images/new/F2_r1_c4.jpg',1);\" title='技术支持联系人:"
				+ str2 + ",电话:" + str1 + "'><img src=\"../images/new/F_r2_c9.jpg\" name=\"Image12\" width=\"72\" height=\"43\" border=\"0\"></td>");
		this.outStr = (this.outStr
				+ "               <td   onMouseOut=\"MM_swapImgRestore();\" onMouseOver=\"mout(this);MM_swapImage('Image13','','../images/new/F2_r1_c5.jpg',1);\" title='"
				+ str4 + "' onclick=\"window.open('http://" + str3 + "');return false;\" ><img src=\"../images/new/F_r2_c10.jpg\" name=\"Image13\" width=\"69\" height=\"43\" border=\"0\"></td>");
		this.outStr += "               <td   onMouseOut=\"MM_swapImgRestore();\" onMouseOver=\"mout(this);MM_swapImage('Image14','','../images/new/F2_r1_c6.jpg',1);\" onclick=\"openwin1('../sys/ChangePassword.jsp',300,200,100,100);\"  title='修改登录密码'><img src=\"../images/new/F_r2_c11.jpg\" name=\"Image14\" width=\"67\" height=\"43\" border=\"0\"></td>";
		if (localregcheck.state == 0)
			this.outStr += "               <td   onMouseOut=\"MM_swapImgRestore();\" onMouseOver=\"mout(this);MM_swapImage('Image15','','../images/new/F2_r1_c8.jpg',1);\" onClick=\"reg();return false;\"   title='注册时请连接internet网络'  target=rightp><img src=\"../images/new/F_r2_c13.jpg\" name=\"Image15\" width=\"67\" height=\"43\" border=\"0\"></td>";
		else {
			this.outStr += "               <td   onMouseOut=\"MM_swapImgRestore();\" onMouseOver=\"mout(this);MM_swapImage('Image15','','../images/new/F2_r1_c10.jpg',1);\" onClick=\"ver();return false;\"   title='注册时请连接internet网络'  target=rightp><img src=\"../images/new/F_r2_c15.jpg\" name=\"Image15\" width=\"67\" height=\"43\" border=\"0\"></td>";
		}
		this.outStr += "               <td   onMouseOut=\"MM_swapImgRestore();\" onMouseOver=\"mout(this);MM_swapImage('Image16','','../images/new/F2_r1_c9.jpg',1);\" onClick=\"out();return false;\"   title='退出系统'  target=rightp><img src=\"../images/new/F_r2_c14.jpg\" name=\"Image16\" width=\"63\" height=\"43\" border=\"0\"></td>";
		this.outStr += "       </tr>";
		this.outStr += "         </table></td>";
		this.outStr += "      </tr>";
		this.outStr += "      <tr>";
		this.outStr += "                       <td background=\"../images/new/F_r3_c6.jpg\" width=\"100%\" height=\"41\" align='center'><table width=\"100%\" border='0'><tr><td align='left'></td><td align='right' ><img src='../images/new/p1.gif' border='0' title='我的桌面' onMouseOver=\"mout(this);\" onClick=\"window.parent.main.location='../manager/rigthmenu.jsp?MModuleNo=DESKTOP';\">&nbsp;<img onclick=\"openwin1('../top/message.jsp',600,400,100,100);\"  onMouseOver=\"mout(this);\" src='../images/new/p3.gif' border='0' title='及时消息'>&nbsp;<img onclick=\"openwin1('../top/online.jsp',500,200,100,100);\" onMouseOver=\"mout(this);\" src='../images/new/p2.gif' border='0' title='在线用户'>&nbsp;<img onMouseOver=\"mout(this);\" src='../images/new/p4.gif' border='0' onclick=\"openwin1('../help/help.jsp',500,300,100,100);\"  title='在线帮助'></td></tr></table>";

		this.outStr += "                     </tr>";
		this.outStr += "                 </table></td>";
		this.outStr += "                 <td><img src=\"../images/new/F_r1_c15.jpg\" width=\"11\" height=\"107\"></td>";
		this.outStr += "               </tr>";
		this.outStr += "             </table></TD>";
		this.outStr += "           </TR>";
		this.outStr += "           </TBODY></TABLE>";
		this.outStr += "         </TD></TR>";
		this.outStr += "     </TBODY></TABLE> ";
		if (localregcheck.fg == 0)
			this.outStr = localregcheck.alertmess;
		else
			checkREG();
		return this.outStr;
	}

	public String doleftmenuStart(String paramString1, String paramString2) {
		SDatabase localSDatabase1 = null;
		regcheck localregcheck = new regcheck();
		localregcheck.checkREGIN();
		this.outStr = "<table width='50%'   border='0' cellpadding='0' cellspacing='0' title='";
		if (localregcheck.state == 1)
			this.outStr = (this.outStr + "软件提供商：U客软件　          　正式注册编码：hcrm-" + localregcheck.userregno);
		this.outStr += "'>";

		String str1 = "select Url,MModuleNo,CModuleNo,MModuleName,picpath,nexus,title  from ModuleCortrol where  nexus='P' and  MModuleNo in(select manModule from  ManModuleCortrol where SellerId='"
				+ paramString1 + "') ORDER BY orderby  ";
		ResultSet localResultSet = null;
		int i = 1;
		String str2 = "welcome.jsp";
		try {
			localSDatabase1 = new SDatabase();
			localResultSet = localSDatabase1.executeQuery(str1);
			while (localResultSet.next()) {
				String str3 = getbyte(localResultSet.getString("Url"));
				String str4 = getbyte(localResultSet.getString("MModuleName"));
				String str5 = "../../../images/d1.gif";
				String str6 = getbyte(localResultSet.getString("MModuleNo"));
				if (getbyte(localResultSet.getString("CModuleNo")).trim()
						.equals("desktop"))
					str2 = "rigthmenu.jsp?MModuleNo=DESKTOP";
				else {
					str2 = "welcome.jsp";
				}
				this.outStr = (this.outStr
						+ "  <tr   height='30'   align=center> <td background='' onclick=\"window.parent.main.location='rigthmenu.jsp?MModuleNo="
						+ str6
						+ "';menupic(this);windowstate('"
						+ str4
						+ "');changeclass(this,'L3','L2');\"  ><a href  onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style=\"cursor:hand;\"    border=0 >"
						+ str4 + "</a></td></tr>");
			}

			localResultSet.close();
		} catch (Exception localException) {
			System.out.print(localException.getMessage());
		} finally {
			SDatabase.closeConn(localResultSet, null, localSDatabase1.conn);
		}

		this.outStr += "</table> ";

		if (localregcheck.fg == 0)
			this.outStr = localregcheck.alertmess;
		else
			checkREG();
		return this.outStr;
	}

	public String doleftmenuPStart(String paramString1, String paramString2) {
		SDatabase localSDatabase1 = new SDatabase();
		regcheck localregcheck = new regcheck();
		localregcheck.checkREGIN();
		String str1 = "select Url,MModuleNo,CModuleNo,MModuleName,picpath,nexus,title  from ModuleCortrol where  nexus='P' and  MModuleNo in(select manModule from  ManModuleCortrol where SellerId='"
				+ paramString1 + "') ORDER BY orderby  ";
		ResultSet localResultSet = null;
		int i = 1;
		this.outStr = "";
		String str2 = "welcome.jsp";
		try {
			localResultSet = localSDatabase1.executeQuery(str1);
			while (localResultSet.next()) {
				if (this.outStr.equals(""))
					this.outStr = getbyte(localResultSet.getString("MModuleNo"));
				else
					this.outStr = (this.outStr + "," + getbyte(localResultSet
							.getString("MModuleNo")));
			}
			localResultSet.close();
		} catch (Exception localException) {
			System.out.print(localException.getMessage());
		} finally {
			SDatabase.closeConn(localResultSet, null, localSDatabase1.conn);
		}

		if (localregcheck.fg == 0)
			this.outStr = localregcheck.alertmess;
		else
			checkREG();
		return this.outStr;
	}

	public String doleftmenuOutLookStart(String paramString1,
			String paramString2, String paramString3, String paramString4,
			String paramString5, String paramString6) {
		SDatabase localSDatabase1 = null;
		regcheck localregcheck = new regcheck();
		localregcheck.checkREGIN();
		String str1 = "";
		Object localObject1 = "";
		Object localObject2 = "";
		String str2 = "";
		str2 = "select Url,MModuleNo,CModuleNo,CModuleName,picpath,nexus,title  from ModuleCortrol where    MModuleNo='"
				+ paramString1
				+ "' and CModuleNo in(select ModuleNo from  PopedomConrtrol where SellerId='"
				+ paramString6 + "') ORDER BY orderby";
		if (paramString1.equals("DESKTOP")) {
			str2 = "select Url,MModuleNo,CModuleNo,CModuleName,picpath,nexus,title  from ModuleCortrol where     MModuleNo='"
					+ paramString1
					+ "' or  ( CModuleNo in(select ModuleNo from  PopedomConrtrol where SellerId='"
					+ paramString6 + "'  and choose=1)) ORDER BY orderby";
		}
		ResultSet localResultSet = null;
		try {
			localSDatabase1 = new SDatabase();
			localResultSet = localSDatabase1.executeQuery(str2);
			while (localResultSet.next()) {
				String str3 = getbyte(localResultSet.getString("Url"));
				String str4 = getbyte(localResultSet.getString("MModuleNo"));
				String str5 = getbyte(localResultSet.getString("CModuleNo"));
				String str6 = getbyte(localResultSet.getString("CModuleName"))
						.trim();
				String str7 = getbyte(localResultSet.getString("picpath"));
				String str8 = getbyte(localResultSet.getString("nexus"));
				String str9 = getbyte(localResultSet.getString("title"));

				localObject2 = str4;
				if (str8.equals("P")) {
					localObject1 = str6;
				} else {
					str1 = str1 + "\"" + str7 + "\",";

					str1 = str1 + "\"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
							+ str6 + "\",";
					str1 = str1 + "\"../" + str3 + "\",";

					str1 = str1 + "\"parent.main\",";
				}
			}
			if (!str1.equals("")) {
				str1 = str1.substring(0, str1.lastIndexOf(","));
				str1 = " OutBarFolder" + paramString2 + "=new Array(\""
						+ paramString3 + "," + paramString5 + "&MModuleNo="
						+ (String) localObject2 + "\"," + str1 + ");";
			}
			localResultSet.close();
		} catch (Exception localException) {
			str1 = localException.getMessage();
		} finally {
			SDatabase.closeConn(localResultSet, null, localSDatabase1.conn);
		}
		if (localregcheck.fg == 0)
			this.outStr = localregcheck.alertmess;
		else
			checkREG();
		return str1;
	}

	public String DoTopMenu(String paramString1, String paramString2) {
		SDatabase localSDatabase = null;
		String str1 = "";
		String str2 = "";

		String str3 = "";
		String str4 = "";
		ResultSet localResultSet = null;
		try {
			localSDatabase = new SDatabase();
			localResultSet = localSDatabase
					.executeQuery("select servicephone,serviceperson,saleurl,saleperson from  user_reg");
			if (localResultSet.next()) {
				str1 = localResultSet.getString("servicephone");
				str2 = localResultSet.getString("serviceperson");
				str4 = localResultSet.getString("saleperson");
				str3 = localResultSet.getString("saleurl");
			}
			localResultSet.close();
		} catch (Exception localException) {
			System.out.print(localException.getMessage());
		} finally {
			SDatabase.closeConn(localResultSet, null, localSDatabase.conn);
		}
		regcheck localregcheck = new regcheck();
		localregcheck.checkREGIN();
		this.outStr = "<table width='100%'  border='0'  background='../images/green_topM.jpg' cellpadding='0' cellspacing='0' title='";
		if (localregcheck.state == 1)
			this.outStr = (this.outStr + "软件提供商：U客软件　          　正式注册编码：hcrm-" + localregcheck.userregno);
		this.outStr += "'>";

		this.outStr += "  <tr >";

		this.outStr += " <td width='442'  height='230' valign='top' align='right'><SPAN id=lblFlash>";

		this.outStr += "  </SPAN></td>";
		this.outStr += " <td valign='top'><table width='100%'  border='0' cellpadding='0' cellspacing='0'>";

		this.outStr += " <tr>";
		this.outStr += " <td height='60' ><table width='100%'  border='0' cellpadding='0' cellspacing='0'>";
		this.outStr += " <tr>";
		this.outStr += " <td width='20'></td>";
		this.outStr += "  <td></td><td align='right'>";

		this.outStr = (this.outStr
				+ " <img src='../images/set.gif' width='15' height='15' hspace='8' align='absmiddle'><span class='style3' onclick=\"openwin1('../sys/chane_set.jsp',300,500,100,100);\"  title='设置我的快捷菜单' onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'><font color=#000000>快捷菜单</font></span><img src='../images/phone.gif' width='23' height='16' hspace='8' align='absmiddle'><span class='style4'  onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'  title='技术支持联系人:"
				+ str2
				+ ",电话:"
				+ str1
				+ "'><font color=#000000>服务</font></span><img src='../images/home.gif' width='15' height='15' hspace='5' align='absmiddle'><span class='style2' onMouseOver='OverArrow(this)'  title='"
				+ str4 + "' onclick=\"window.open('http://" + str3 + "');return false;\" onMouseOut='OutArrow(this)' style='cursor:hand;'      target=rightp><font color=#000000>主页</font></span><img src='images/user.gif' width='15' height='15' hspace='8' align='absmiddle'><span class='style4' onclick=\"openwin1('../sys/chane_reg.jsp',300,200,100,100);\" onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;' title='修改登录用户'><font color=#000000>帐号</font></span><img src='../images/icon_edit_topic.gif' width='15' height=15 hspace=8 align='absmiddle' ><span class='style3' onclick=\"openwin1('../sys/ChangePassword.jsp',300,200,100,100);\" onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'  title='修改登录密码'><font color=#000000>密码</font></span><img src='../images/standard_basic.gif' width='15' height='15' hspace='5' align='absmiddle'>");
		this.outStr += " <span class='style2' onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'  onClick=\"reg();return false;\"   title='注册时请连接internet网络'  target=rightp>";
		if (localregcheck.state == 0)
			this.outStr += " <font color=#000000>注册</font>";
		else
			this.outStr += " <font color=#000000>关于</font>";
		this.outStr += " </span><img src='../images/exit.gif' width='15' height='15' hspace='5' align='absmiddle'><span class='style2' onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'  onClick=\"out();return false;\"   title='退出系统'  target=rightp><font color=#000000>退出</font></span></td>";
		this.outStr += "  <td width='80' align='right'><MARQUEE id='PLACARD' direction='left'  width='100%'  scrollDelay='30' trueSpeed='true' scrollAmount='1' ><font color='#FFFFFF'><!--尊敬的客户，您好！欢迎您选择U客售楼管理系统!--></font></MARQUEE> </td>";
		this.outStr += " </tr>   </table> </td>";
		this.outStr += "</tr>";
		this.outStr += "<tr>";
		this.outStr += "  <td height='65' >";
		this.outStr += "<table width='100%' height='65'  border='0' cellpadding='0' cellspacing='0'>";
		this.outStr += "  <tr align='center' valign='top'><td></td>";
		this.outStr += "</tr>  ";
		this.outStr += "</table></td>";
		this.outStr += "</tr>";
		this.outStr += "</table></td>";
		this.outStr += " <td width='17' valign='top'></td>";
		this.outStr += "</tr>";
		this.outStr += "</table>";
		if (localregcheck.fg == 0)
			this.outStr = localregcheck.alertmess;
		else
			checkREG();
		return this.outStr;
	}

	public String doStartTag(String paramString) {
		SDatabase localSDatabase = new SDatabase();
		String str1 = "";
		String str2 = "";

		String str3 = "";
		String str4 = "";
		ResultSet localResultSet1 = null;
		try {
			localSDatabase = new SDatabase();
			localResultSet1 = localSDatabase
					.executeQuery("select servicephone,serviceperson,saleurl,saleperson from  user_reg");
			if (localResultSet1.next()) {
				str1 = localResultSet1.getString("servicephone");
				str2 = localResultSet1.getString("serviceperson");
				str4 = localResultSet1.getString("saleperson");
				str3 = localResultSet1.getString("saleurl");
			}
			localResultSet1.close();
		} catch (Exception localException1) {
			System.out.print(localException1.getMessage());
		}finally {
			SDatabase.closeConn(localResultSet1, null, localSDatabase.conn);
		}
		regcheck localregcheck = new regcheck();
		localregcheck.checkREGIN();
		this.outStr = "<table width='100%'  border='0' cellpadding='0' cellspacing='0' title='";
		if (localregcheck.state == 1)
			this.outStr = (this.outStr + "软件提供商：U客软件　          　正式注册编码：hcrm-" + localregcheck.userregno);
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
		this.outStr = (this.outStr
				+ " <img src='images/set.gif' width='15' height='15' hspace='8' align='absmiddle'><span class='style4' onclick=\"openwin1('../sys/chane_set.jsp',500,500,100,100);\" onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;' title='修改我的桌面内容'>桌面设置</span><img src='images/user.gif' width='15' height='15' hspace='8' align='absmiddle'><span class='style4' onclick=\"openwin1('../sys/chane_reg.jsp',300,200,100,100);\"  title='修改登录用户' onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'>修改帐号</span><img src='images/set.gif' width='15' height='15' hspace='8' align='absmiddle'><span class='style4' onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;' onclick=\"window.parent.contents.location='../manager/menu.jsp?MModuleNo=M';window.parent.main.location='../manager/log.jsp';\" title='进入系统管理模块'>系统设置</span><img src='../images/phone.gif' width='23' height='16' hspace='8' align='absmiddle'><span class='style4'  onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'  title='技术支持联系人:"
				+ str2
				+ ",电话:"
				+ str1
				+ "'>服务</span><img src='images/home.gif' width='15' height='15' hspace='5' align='absmiddle'><span class='style2' onMouseOver='OverArrow(this)' title='"
				+ str4 + "' onclick=\"window.open('http://" + str3 + "');return false;\"  onMouseOut='OutArrow(this)' style='cursor:hand;'      target=rightp>主页</span><img src='../images/icon_edit_topic.gif' width='15' height=15 hspace=8 align='absmiddle' ><span class='style3' onclick=\"openwin1('../sys/ChangePassword.jsp',300,200,100,100);\"  title='修改登录密码' onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;' >密码</span><img src='../images/standard_basic.gif' width='15' height='15' hspace='5' align='absmiddle'>");
		this.outStr += " <span class='style2' onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'  onClick=\"reg();return false;\"   title='注册时请连接internet网络'  target=rightp>";
		if (localregcheck.state == 0)
			this.outStr += " 注册";
		else
			this.outStr += " 关于";
		this.outStr += " </span><img src='images/exit.gif' width='15' height='15' hspace='5' align='absmiddle'><span class='style2' onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'  onClick=\"out();return false;\"   title='退出系统'  target=rightp>退出</span> </td>";

		this.outStr += " </tr>   </table> </td>";
		this.outStr += "</tr>";
		this.outStr += "<tr>";
		this.outStr += "  <td height='65' background='images/tab_bg_left3bg2.gif' valign='top'  >";
		this.outStr += "<table width='100%'   border='0' cellpadding='0' cellspacing='0'>";
		this.outStr += "  <tr align='center' valign='top'>";
		String str5 = "select Url,MModuleNo,CModuleNo,MModuleName,picpath,nexus,title  from ModuleCortrol where (MModuleNo<>'M' ) and nexus='P' and  MModuleNo in(select manModule from  ManModuleCortrol where SellerId='"
				+ paramString + "') ORDER BY orderby  ";
		try {
			ResultSet localResultSet2 = localSDatabase.executeQuery(str5);
			while (localResultSet2.next()) {
				String str6 = localResultSet2.getString("Url");
				String str7 = localResultSet2.getString("MModuleNo");
				String str8 = localResultSet2.getString("CModuleNo");
				String str9 = localResultSet2.getString("MModuleName").trim();
				String str10 = localResultSet2.getString("picpath");
				String str11 = localResultSet2.getString("nexus");
				String str12 = localResultSet2.getString("title");
				String str13 = "";

				str13 = "../" + str6;
				this.outStr = (this.outStr
						+ "  <td valign='top' onclick=\"\"><img title="
						+ str12
						+ " onclick=\"window.parent.contents.location='../manager/menu.jsp?MModuleNo="
						+ str7
						+ "';window.parent.main.location='"
						+ str13
						+ "';menupic(this);windowstate('"
						+ str9
						+ "')\" onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)' style='cursor:hand;'  src="
						+ str10 + " width='32' height='32'  border=0 ><br>"
						+ str9 + "</td>");
			}
			localResultSet2.close();
		} catch (Exception localException2) {
			System.out.print(localException2.getMessage());
		}
		this.outStr += " <td></td>";
		this.outStr += "</tr>  ";
		this.outStr += "</table></td>";
		this.outStr += "</tr>";
		this.outStr += "</table></td>";
		this.outStr += " <td width='17' valign='top'><img src='images/tab_bg_right.gif' width='17' height='125'></td>";
		this.outStr += "</tr>";
		this.outStr += "</table>";
		if (localregcheck.fg == 0)
			this.outStr = localregcheck.alertmess;
		else
			checkREG();
		return this.outStr;
	}

	public String getbyte(String paramString) throws Exception {
		String str = paramString;
		if (str == null)
			str = "";
		return str;
	}

	public String doReadProject(String paramString) {
		this.outStr = "<p align='center'><b><font size='3' class=FontColor>楼盘资料一览表</font></b></p>";
		this.outStr += " <table width=100%><tr height='16' bgcolor='#EAEAEA'><td align='right'>";
		if (paramString.indexOf("A") >= 0)
			this.outStr += "<input type=button name=add value='增 加' title='添加楼盘资料'  onclick=\"openwin2('crm_Project_add.jsp',650,580,100,10);\">";
		if (paramString.indexOf("E") >= 0)
			this.outStr += "<input type=button name=modi value=\"修 改\" title=\"修改选中的楼盘资料\" onclick=\"EditInto();\" >";
		if (paramString.indexOf("D") >= 0)
			this.outStr += "<input type=button name=del value=\"删　除\" title=\"删除选中的楼盘资料\"  onclick=\"Dele();\">";
		if (paramString.indexOf("F") >= 0)
			this.outStr += "<input type=button name=del value=\"房间明细表\"   onclick=\"openwin2('../sale/auto_select.jsp?PARA_SQL=ViewSectionData&url=22&reporttype=sale&tablename=',700,400,50,50);\">";

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
		SDatabase localSDatabase = null;
		FormatData localFormatData = new FormatData();
		ResultSet localResultSet = null;
		int i = 0;
		String str1 = "0";
		try {
			writereadregedit localwritereadregedit = new writereadregedit();
			str1 = localwritereadregedit.readRegProject();
		} catch (Exception localException1) {
			System.out.print(localException1.getMessage());
		}
		String str2 = "select ";
		if (str1.equals("0"))
			str2 = str2 + " * from CRM_Project order by code asc";
		else
			str2 = str2 + " top " + str1
					+ " * from CRM_Project order by code asc";
		String str3 = "";
		String str4 = "";
		String str5 = "";

		String str11 = "";
		String str12 = "";
		String str13 = "";
		String str14 = "";
		String str15 = "";
		int k = 0;
		try {
			localSDatabase = new SDatabase();
			localResultSet = localSDatabase.executeQuery(str2);
			while (localResultSet.next()) {
				k++;
				str12 = getbyte(localResultSet.getString("code"));
				str4 = getbyte(localResultSet.getString("Name"));
				str5 = getbyte(localResultSet.getString("AreaNo"));
				str3 = localResultSet.getString("SerialNo");
				String str6 = localFormatData.getFloat(
						localResultSet.getFloat("TotalArea"), 4);
				String str7 = localFormatData.getFloat(
						localResultSet.getFloat("GroundArea"), 2);
				String str8 = localFormatData.getFloat(
						localResultSet.getFloat("GreenRate"), 3);
				str13 = getbyte(localResultSet.getString("yushou_no"));
				str14 = getbyte(localResultSet.getString("guihua_no"));
				str15 = getbyte(localResultSet.getString("shigong_no"));

				String str10 = getbyte(localResultSet.getString("Offerdate"));
				SimpleDateFormat localSimpleDateFormat = null;
				if (!str10.equals("")) {
					localSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

					str10 = localSimpleDateFormat.format(localSimpleDateFormat
							.parse(str10));
				}
				int j = localResultSet.getInt("FamilyCount");
				String str9 = localFormatData.getFloat(
						localResultSet.getFloat("RealRate"), 3);
				this.outStr = (this.outStr
						+ "  <tr id=TR"
						+ k
						+ " align=\"center\"  ondblclick=\"openwin2('SectionShow.jsp?ID="
						+ str12
						+ "',480,420,100,10);\" class=listcontent onmouseover=\"mout(this);\"  onclick=\"savepara('"
						+ str12 + "','" + str3 + "','" + str4 + "');changeclass1(this,'clickbg','listcontent');\"  title=\"双击可查看楼盘资料\" >");
				this.outStr = (this.outStr + " <td   > " + str4 + "</td>");
				this.outStr = (this.outStr + "  <td   > " + str5 + "</td>");
				this.outStr = (this.outStr + " <td   > " + str13 + "</td>");
				this.outStr = (this.outStr + " <td   > " + str14 + "</td>");
				this.outStr = (this.outStr + " <td   > " + str15 + "</td>");
				this.outStr = (this.outStr
						+ " <td><input type=button value=\"楼 栋\" title=\"增加楼栋资料\" onclick=\"openwin2('indexTree.jsp?SecNo="
						+ str3
						+ "',450,300,100,100);\">&nbsp;<input type=button value=\"图片\" title=\"增加地图\" onclick=\"openwin2('AddPic.jsp?SecNo="
						+ str3 + "',450,300,100,100);\"></td>");
				this.outStr += "</tr>";
			}

			localResultSet.close();
		} catch (Exception localException2) {
			System.out.print(localException2.getMessage());
		} finally {
			SDatabase.closeConn(localResultSet, null, localSDatabase.conn);
		}
		return this.outStr;
	}

	public String doStartReg(String paramString1, String paramString2,
			String paramString3) {
		SDatabase localSDatabase = null;
		MD5 localMD5 = new MD5();
		HardWareID localHardWareID = new HardWareID();
		String str1 = "";
		String str2 = "";
		String str3 = "";
		String str4 = "";
		SimpleDateFormat localSimpleDateFormat = null;
		localSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String str5 = new Date().toString();
		ResultSet localResultSet = null;
		try {
			localSDatabase = new SDatabase();
			localResultSet = localSDatabase
					.executeQuery("select  top 1 CompanyName,regnum,usernum,project from company");
			if (localResultSet.next()) {
				str1 = localResultSet.getString("CompanyName");
				str2 = localResultSet.getString("regnum");
				str4 = localResultSet.getString("usernum");
				str3 = localResultSet.getString("project");
				if (str4.equals("0"))
					str4 = "无限";
				if (str3.equals("0"))
					str3 = "无限";
			}
			localResultSet.close();
		} catch (Exception localException) {
			System.out.print(localException.getMessage());
		}finally {
			SDatabase.closeConn(localResultSet, null, localSDatabase.conn);
		}
		this.outStr = "<table width='100%'  border='0' cellpadding='0' cellspacing='0'>";
		this.outStr += " <tr>";
		this.outStr += " <td width='25%' height='16'>使用企业名称</td>";
		this.outStr = (this.outStr + " <td width='38%' height='16'>" + str1 + "</td>");

		this.outStr += " </tr>";
		this.outStr += " <tr>";
		this.outStr += " <td width='25%' height='16'>使用客户类型</td>";
		this.outStr += " <td width='38%' height='16'><select name=custype><option value=0>试用客户</option><option value=1>U客代理商</option><option value=2>购买客户</option></select></td>";

		this.outStr += " </tr>";
		this.outStr += " <tr>";
		this.outStr += " <td width='25%' height='16'>授&nbsp;权&nbsp;许&nbsp;可</td>";
		this.outStr = (this.outStr + " <td width='38%' height='16'>并发用户数："
				+ str4 + "&nbsp;许可楼盘数：" + str3 + "</td>");

		this.outStr += " </tr>";
		this.outStr += " <tr>";
		this.outStr += " <td width='25%' height='16'>已注册次数</td>";
		this.outStr = (this.outStr + " <td width='38%' height='16'>" + str2 + "</td>");

		this.outStr += " </tr>";
		this.outStr += "<tr>";
		this.outStr += " <td width='25%' height='16'>系统随机序号</td>";
		this.outStr = (this.outStr + "<td width='38%' height='16'>"
				+ HardWareID.getMacAddress() + "</td>");
		this.outStr += " <tr>";
		this.outStr += " <td width='25%' height='14'>系统注册日期</td>";
		this.outStr = (this.outStr
				+ "<td width='38%' height='14'><input type=text name=endd size='42' value='"
				+ localSimpleDateFormat.format(new Date()).toString() + "'></td>");
		this.outStr += " </tr>";
		this.outStr += "<tr>";
		this.outStr += " <td width='25%' height='16'>请填写注册号</td>";
		this.outStr += "<td width='38%' height='16'><input type=text name=regno size='42' value=''></td>";
		this.outStr += " </tr>";
		this.outStr += "</table>";

		this.outStr += " <p align='center'> <input type=button name=reg value='确认注册' ONCLICK=\"if (confirm('确认注册吗?'))regfrm.submit();\"> </p>";
		regcheck localregcheck = new regcheck();
		String str6 = localregcheck.checkREGMess();
		int i = 0;
		if (!str6.equals("")) {
			this.outStr = str6;
		} else if (!paramString2.equals("")) {
			String str7 = localregcheck.checkREGInfo(paramString2,
					paramString1, paramString3);
			if (!str7.equals(""))
				this.outStr = str7;
		}

		return this.outStr;
	}

	public String checkREG() {
		Object localObject = null;
		String str1 = "系统已过期，请及时联系U客软件 QQ：357657132 ";
		String str2 = "";
		SDatabase localSDatabase = null;
		writereadregedit localwritereadregedit = new writereadregedit();
		String str3 = localwritereadregedit.readRegDate();
		String str4 = localwritereadregedit.readRegState();
		String str5 = localwritereadregedit.readRegsDate();
		ResultSet localResultSet = null;
		if (str4.equals("0")) {
			String str6 = "select  * from  user_reg  where  convert(char(10),'"
					+ str3
					+ "',120) <convert(char(10),getdate(),120)  and convert(char(10),'"
					+ str5
					+ "',120)<=convert(char(10),getdate(),120)  and state=0";
			try {
				localSDatabase = new SDatabase();
				localResultSet = localSDatabase.executeQuery(str6);
				if (localResultSet.next()) {
					str1 = "系统已过期，请及时联系U客软件，QQ：357657132 ";

					localResultSet.close();
				} else {
					localResultSet.close();
					String str7 = "select  * from  user_reg where convert(char(10),'"
							+ str5
							+ "',120)<=convert(char(10),getdate(),120) and state="
							+ str4;
					localResultSet = localSDatabase.executeQuery(str7);

					if (localResultSet.next()) {
						str2 = "|ok";
						str1 = "manager/index.jsp";
					}
					localResultSet.close();
				}
			} catch (Exception localException) {
				logger.error(localException.getLocalizedMessage(),
						localException);
			} finally {
				SDatabase.closeConn(localResultSet, null, localSDatabase.conn);
			}		} else {
			str2 = "|ok";
			str1 = "manager/index.jsp";
		}
		return str1 + str2;
	}

	public String checkLoginUser(int paramInt) {
		SDatabase localSDatabase = null;
		String str1 = "true";

		writereadregedit localwritereadregedit = new writereadregedit();

		String str2 = localwritereadregedit.readRegOnline();
		if (str2.equals(""))
			str2 = "0";
		String str3 = "select  *," + str2 + " as online from  company ";
		ResultSet localResultSet = null;
		try {
			localSDatabase = new SDatabase();
			localResultSet = localSDatabase.executeQuery(str3);
			if (localResultSet.next()) {
				int i = localResultSet.getInt("online");

				if (i == 0)
					str1 = "true";
				else if (i < paramInt)
					str1 = "false";
			}

			localResultSet.close();
		} catch (Exception localException) {
			return "false";
		}finally {
			SDatabase.closeConn(localResultSet, null, localSDatabase.conn);
		}
		return str1;
	}

	public String doStart(String paramString, int paramInt) {
		String str1 = "";
		if (!paramString.equals("")) {
			String str2 = checkREG();
			writereadregedit localwritereadregedit = new writereadregedit();
			if (localwritereadregedit.writeinfo().equals(""))
				str2 = "";

			if (str2.indexOf("过期") >= 0) {
				this.outStr = "  <script language=javascript>";
				this.outStr += " alert(\"已过期，请重新注册,U客软件,QQ:357657132 \"); ";

				this.outStr += "window.showModalDialog(\"../jsp/manager/testerror.jsp\",\"\",\"dialogWidth400px; dialogHeight:200px; dialogLeft:150px; dialogTop:100px; status:no; directories:yes;scrollbars:no;Resizable=no; \");";

				this.outStr += "parent.window.close();";
				this.outStr += "</script>";
			} else {
				regcheck localregcheck = new regcheck();
				String str3 = localregcheck.checkREG();
				if (localwritereadregedit.writeinfo().equals(""))
					str3 = "你可能第一次安装U客软件，请重新激活系统后才能正常使用";
				this.outStr = localregcheck.checkREGYear();
				this.outStr += "<script>";
				this.outStr += "function alertmess(){";
				if (!str3.equals("")) {
					this.outStr = (this.outStr + " alert(\"" + str3 + "\"); ");
				}
				this.outStr = (this.outStr + "var aa=\"" + str2 + "\";");
				this.outStr += " if (aa.indexOf(\"|\")==-1){";
				this.outStr += "  showx = screen.availWidth;  ";
				this.outStr += "showy = screen.availHeight; ";
				this.outStr += " retval = window.showModalDialog('../alert.jsp','','dialogWidth400px; dialogHeight:550px; dialogLeft:150px; dialogTop:100px; status:no; directories:yes;scrollbars:no;Resizable=no; '  );";
				this.outStr += "}";
				this.outStr += " if (aa.indexOf('|')>=0) ";
				this.outStr += " window.location=aa.substring(0,aa.indexOf('|'));";
				this.outStr += "  else";
				this.outStr += " window.location=aa; ";
				this.outStr += " }";

				this.outStr += "</script>";
				str1 = checkLoginUser(paramInt);

				str1 = str1.trim();
				if (str1.equals("false")) {
					this.outStr = "  <script language=javascript>";
					this.outStr += " alert(\"当前用户数已满!请稍后再登录\"); ";
					this.outStr += "window.open(\"../index.jsp\");";
					this.outStr += "parent.window.close();";
					this.outStr += "</script>";
				}
			}
		} else {
			this.outStr = "  <script language=javascript>";
			this.outStr += " alert(\"登录失败\"); ";
			this.outStr += "window.open(\"../index.jsp\");";
			this.outStr += "parent.window.close();";
			this.outStr += "</script>";
		}

		return this.outStr;
	}
}