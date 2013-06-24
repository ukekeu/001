package sale;

import ConnDatabase.SDatabase;
import FormatData.FormatData;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.util.LinkedList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import setProperty.setpopedom;

public class saleRoomState
{
	private static Logger logger = LoggerFactory.getLogger(saleRoomState.class);

  public int day = 0;
  public int fg = 0;

  public String alertmess = "";
  public String userregno = "";
  public String Upp = "";
  public String Loft = "";
  public String SecName = "";
  public String strSection = "";
  public String strBuilding = "";
  public String condi = "";
  public String sec = "";
  public String no = "";
  public String sql = "";
  public String state = "";

  public saleRoomState() {
    setpopedom localsetpopedom = new setpopedom();
  }

  public String projectCode() {
    return this.Loft;
  }

  public String projectName() {
    return this.SecName;
  }
  public String getbyte(String paramString) throws Exception {
    String str = paramString;
    str = new String(str.getBytes("iso-8859-1"));
    return str;
  }
  public String getbyte1(String paramString) throws Exception {
    String str = paramString;

    if (str == null) str = "";

    return str;
  }

  public String BeanshowLoft(String paramString1, String[] paramArrayOfString, String paramString2) {
    try {
      this.alertmess += "<table width=\"98%\" >";

      this.alertmess += "<tr> ";
      this.strSection = paramString1;
      int i = 0;

      SDatabase localSDatabase = new SDatabase();

      this.sql = ("select SerialNo,Name from CRM_Project where SerialNo in(" + paramString2 + ")");

      ResultSet localResultSet1 = localSDatabase.executeQuery(this.sql);

      this.alertmess += "<td  colspan=\"2\"> ";
      this.alertmess += "&nbsp;<select name=\"section_select\" style=\"width:117\" onchange=\"frm.submit();\"> ";
      this.alertmess += "<option value=\"\">请选择楼盘名称</option>";

      while (localResultSet1.next()) {
        this.no = localResultSet1.getString("SerialNo");
        this.sec = localResultSet1.getString("Name");
        if (this.strSection.equals(this.no)) this.SecName = this.sec;
        this.alertmess = (this.alertmess + "<option value='" + this.no + "'>" + this.sec + "</option>");
      }

      localResultSet1.close();

      this.alertmess += " </select> </td>";
      String[] arrayOfString = paramArrayOfString;
      if (!this.strSection.equals(""))
        this.alertmess = (this.alertmess + "  <td align=\"right\"><a href='#' onclick=\"openwin2('../basic/ViewPic.jsp?menusel=1&SecNo=" + this.no + "',550,500,100,100);\"  title=\"项目图片\"><img src=\"../images/t4.gif\" border=\"0\"></a></td>");
      this.alertmess += " </tr><tr>";
      this.alertmess += " <td   > ";

      if (arrayOfString != null) {
        for (int j = 0; j < arrayOfString.length; j++) {
          if (this.Loft.equals("")) this.Loft = ("'" + getbyte(arrayOfString[j]) + "'"); else
            this.Loft = (this.Loft + ",'" + getbyte(arrayOfString[j]) + "'");
        }
      }
      String str1 = "select  loft from Sectiontree where  SerialNo='" + this.strSection + "' group by loft";
      String str2 = "";
      ResultSet localResultSet2 = localSDatabase.executeQuery(str1);
      while (localResultSet2.next()) {
        str2 = "ok";
        String str3 = localResultSet2.getString("loft");
        this.alertmess += " <input name=\"showLoft\"  onclick=\"searcherdata();\" type=\"checkbox\"";
        if (this.Loft.indexOf(str3) >= 0) this.alertmess += " checked ";
        this.alertmess = (this.alertmess + "  value='" + str3 + "'>" + str3);
      }
      localResultSet2.close();

      this.alertmess += "   </td>";
      this.alertmess += "  </tr>";
      if (!str2.equals("")) {
        this.alertmess += "  <tr><td > &nbsp;&nbsp;<select name=pxshow   onchange=\"searcherdata();\">";
        this.alertmess += " <option value=\"1\">楼层降序</option>";
        this.alertmess += " <option value=\"0\">楼层升序</option>";
        this.alertmess += " </select> &nbsp;<select name=condi onchange=\"submitC();\">";
        this.alertmess += " <option value=\"color\">按色块</option>";
        this.alertmess += " <option value=\"wen\">按文字</option>";
        this.alertmess += " <option value=\"pic\">按图标</option>";
        this.alertmess += " </select>&nbsp;";
        if (!this.Loft.equals("")) {
          this.alertmess += " <input type=button name=\"EXCELTO\" value=\"导出到EXCEL\" onclick=\"document.frm.action='ExcelTomanRoomCodeShowS.jsp';document.frm.submit();\">&nbsp; <input type=\"button\" name=\"Button\" value=\"打印预览\" onClick=\"document.frm.action='printmanRoomCodeShowS.jsp';document.frm.submit();\">";
          this.alertmess += " </td>";
          this.alertmess += "  </tr>  ";
        }
        this.alertmess += " </table>";
      }

    }
    catch (Exception localException)
    {
    }

    return this.alertmess;
  }

  public String BeanCodeShow(String paramString1, String paramString2)
  {
    try
    {
      this.condi = paramString2;
      this.alertmess = "";
      int i = 0;
      asicc localasicc = new asicc();
      FormatData localFormatData = new FormatData();
      this.alertmess += "<table border=\"0\"  width=\"100%\"><tr>";
      String str1 = "select Loft FROM sectiontree where SerialNo='" + this.strSection + "'";

      if (!this.Loft.equals("")) str1 = str1 + " and Loft in (" + this.Loft + ") ";
      str1 = str1 + "group by Loft";
      ResultSet localResultSet1 = null;
      SDatabase localSDatabase1 = new SDatabase();
      SDatabase localSDatabase2 = new SDatabase();
      localResultSet1 = localSDatabase1.executeQuery(str1);
      if (!this.Loft.equals("")) {
        while (localResultSet1.next()) {
          i++;
          this.alertmess += "<td valign='top'>";
          this.Loft = localResultSet1.getString("Loft");
          String str2 = "";
          if (!this.Loft.equals("")) str2 = " and loft='" + this.Loft + "'";

          String str3 = "select lockroom from lockroom where section ='" + this.strSection + "' and ";
          str3 = str3 + " loft='" + this.Loft + "'";
          ResultSet localResultSet2 = null;
          Object localObject1 = "";
          Object localObject2 = "";
          LinkedList localLinkedList1 = new LinkedList();
          try {
            localResultSet2 = localSDatabase2.executeQuery(str3);
            while (localResultSet2.next()) {
              String str4 = localResultSet2.getString("LockRoom");
              if (((String)localObject1).equals("")) localObject1 = str4; else
                localObject1 = (String)localObject1 + "," + str4;
              char c1 = str4.charAt(0);
              if (!Character.isDigit(c1)) {
                str4 = String.valueOf(Character.getNumericValue(c1) - 9);
              }
              localLinkedList1.add(str4);
              if (((String)localObject2).equals(""))
                localObject2 = str4;
              else
                localObject2 = (String)localObject2 + "," + str4;
            }
            localResultSet2.close(); } catch (Exception localException2) {
          }
          this.sql = "select floor from";
          this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
          this.sql = (this.sql + "  and Region='" + this.Loft + "' and floor=0");
          ResultSet localResultSet3 = localSDatabase2.executeQuery(this.sql);
          char c1 = '\001';
          int j = 0;
          if (localResultSet3.next()) { 
        	  j = localResultSet3.getInt("floor"); 
          }
          
          localResultSet3.close();
          this.sql = "select min(Floor) as BeginF,max(Floor) as EndF,";
          this.sql += "min(Room) as BeginR,max(Room) as EndR,max(cell) as Ecell ,min(cell) as Scell from";
          this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
          this.sql = (this.sql + "  and Region='" + this.Loft + "'");
          localResultSet3 = localSDatabase2.executeQuery(this.sql);
          int k = 0;
          int m = 0;
          int str5 = 0;
          int str6 = 0;
          int n = 0;
          String str7 = "";
          String str8 = "";
          String str9 = "";
          if (localResultSet3.next()) {
            k = localResultSet3.getInt("BeginF");

            m = localResultSet3.getInt("EndF");
            str5 = localResultSet3.getInt("BeginR");
            str6 = localResultSet3.getInt("EndR");
            str7 = getbyte(localResultSet3.getString("Ecell"));
            str8 = getbyte(localResultSet3.getString("Scell"));
            if ((str8.equals("")) && (str7.equals(""))) { str7 = " "; str8 = " "; }
          }
          localResultSet3.close();
          int i1 = 0; int i2 = 0;
          char c2 = str8.charAt(0);
          char c3 = str7.charAt(0);
          if ((!str8.equals("")) && (!str7.equals(""))) {
            c2 = str8.charAt(0);
            c3 = str7.charAt(0);
            if (Character.isDigit(c2)) {
              i1 = Integer.parseInt(str8);
              i2 = Integer.parseInt(str7);
            } else {
              i1 = Character.getNumericValue(c2) - 9;
              i2 = Character.getNumericValue(c3) - 9;
            }
          }
          if (i1 < 0) i1 = 0;
          if (i2 < 0) i2 = 0;
          String str10 = "";
          localResultSet3 = localSDatabase2.executeQuery("select roomtype from LoftBuildCode where SecNo='" + this.strSection + "' and Loft='" + this.Loft + "' and roomtype=1");
          if (localResultSet3.next()) {
            str10 = "1";
          }
          localResultSet3.close();

          this.alertmess = (this.alertmess + " <input type=hidden name=SecNo value=\"" + this.strSection + "\">");
          this.alertmess = (this.alertmess + "<input type=hidden name=SecName value=\"" + this.SecName + "\">");
          this.alertmess = (this.alertmess + "<input type=hidden name=Loft value=\"" + this.Loft + "\">");
          this.alertmess += "<input type=hidden name=Build value=\"\">";
          this.alertmess += "<input type=hidden name=cusname value=\"\">";
          this.alertmess += "<input type=hidden name=secname value=\"\">";
          String str11 = "#00CCFF";
          String str12 = "#E5C862";
          String str13 = "#8DE4A6";
          String str14 = "#AACC6F";
          String str15 = "#FF00FF";
          String str16 = "#DDE8E8";
          if (!this.strSection.equals("")) {
            String str17 = "select  *  from SaleStateColor WHERE secno='" + this.strSection + "'";

            ResultSet localResultSet4 = localSDatabase2.executeQuery(str17);
            if (localResultSet4.next()) {
              str11 = localResultSet4.getString("RG");
              str12 = localResultSet4.getString("QY");
              str15 = localResultSet4.getString("ld");
              str14 = localResultSet4.getString("CZ");
              str13 = localResultSet4.getString("YL");
              str16 = localResultSet4.getString("ws");
            }

            localResultSet4.close();
          }
          if (str11.equals("")) {
            this.alertmess += "<script>";
            this.alertmess += "alert(\"还没有设置为销控表设置状态色块,请在系统管理中设置\");";

            this.alertmess += "</script>";
          }

          String str17 = paramString1;
          if (str17 == null) str17 = "";

          this.alertmess += " <p CLASS=FontColor align=\"center\"><b><font size=\"3\" >";

          if (!this.SecName.equals(this.Loft)) this.alertmess += this.SecName; this.alertmess = (this.alertmess + this.Loft + " 销控表</font></b></p>");
          this.alertmess += " <table width=\"98%\" border=\"0\"  align=\"center\" CELLSPACING=1 CELLPADDING=3>";

          this.alertmess = (this.alertmess + "<td bgcolor='" + str16 + "'  align=\"center\">未售</td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str11 + "'  align=\"center\">认购<img src='../images/mypw.gif' border='0' ></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str12 + "'  align=\"center\">签约<img src='../images/maIcon.gif' border='0' ></td>");
          this.alertmess = (this.alertmess + "\t<td bgcolor='" + str13 + "'  align=\"center\">");
          if (str17.indexOf("Y") >= 0) this.alertmess = (this.alertmess + "<a href=\"#\" onclick=\"ylroom(1,'','" + this.Loft + "');return false;\" title=\"选择预留房间后点击[预留]\" >预留</a>"); else
            this.alertmess += "预留";
          this.alertmess += "<img src='../images/day2.gif' border='0' ></td>";
          this.alertmess = (this.alertmess + "<td bgcolor='" + str15 + "'  align=\"center\">临定<img src='../images/face39.gif' border='0' ></td>");
          this.alertmess += "<td   align=\"center\">";
          this.alertmess += " </td>";
          this.alertmess += "</tr>";
          this.alertmess = (this.alertmess + " <tr><td bgcolor='" + str16 + "' align=\"center\"><div id=wy" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str11 + "'  align=\"center\"><div id=ry" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str12 + "'  align=\"center\"><div id=sy" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str13 + "'  align=\"center\"><div id=yy" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str15 + "' align=\"center\"><div id=ly" + i + "></div></td>");

          this.alertmess = (this.alertmess + "  <td   align=\"center\"><div id=sum" + i + "> </div>");
          this.alertmess += " </td>";
          this.alertmess += " \t</tr>";
          this.alertmess = (this.alertmess + "  <tr><td bgcolor='" + str16 + "' align=\"center\"><div id=w1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str11 + "'  align=\"center\"><div id=r1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str12 + "'  align=\"center\"><div id=s1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str13 + "'  align=\"center\"><div id=y1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str15 + "'  align=\"center\"><div id=l1" + i + "></div></td>");

          this.alertmess += " </td>";
          this.alertmess += " <td   align=\"center\"> ";
          this.alertmess += " </td>";
          this.alertmess += " </tr>";
          this.alertmess += " </table>";

          int i3 = 0;
          int i4 = 0;
          int i5 = 0;
          int i6 = 0;
          int i7 = 0;
          int i8 = 0;

          String str18 = "";
          if (str18 == null) str18 = "";

          String str19 = "ABCDEFGHIJKLOPQRST";
          str19 = str19.trim();
          int i9 = 0;
          String str20 = "";
          String str21 = "select top 1 Room_code from Room where seccode=";
          str21 = str21 + "'" + this.strSection + "' and Building='";
          str21 = str21 + this.strBuilding + "' and loft='" + this.Loft + "'  ";
          ResultSet localResultSet5 = localSDatabase2.executeQuery(str21);
          if (localResultSet5.next()) str20 = localResultSet5.getString("Room_code");
          localResultSet5.close();

          if (str20.equals(""))
          {
            this.alertmess += " <script>";

            this.alertmess += " </script>";
          }
          else {
            this.alertmess += " <script>";
            this.alertmess += " function px(para){";
            this.alertmess += " if (para==\"asc\")document.frm.action=\"RoomCodeShowS.jsp\";";
            this.alertmess += " else document.frm.action=\"RoomCodeShowDS.jsp\";";
            this.alertmess += "  document.frm.submit();";
            this.alertmess += "  }";

            this.alertmess += " </script>";
            this.alertmess += " <table width=\"100%\" align=\"center\" border=\"0\" CELLSPACING=0 CELLPADDING=0>";
            this.alertmess += " <tr valign=\"top\">";
            for (int i10 = i1; i10 <= i2; i10++) {
              if (i1 > 0) {
                str9 = localasicc.AsiicZH(i10, c2);
              }

              LinkedList localLinkedList2 = new LinkedList();
              LinkedList localLinkedList3 = new LinkedList();
              LinkedList localLinkedList4 = new LinkedList();
              LinkedList localLinkedList5 = new LinkedList();
              LinkedList localLinkedList6 = new LinkedList();
              LinkedList localLinkedList7 = new LinkedList();
              LinkedList localLinkedList8 = new LinkedList();
              LinkedList localLinkedList9 = new LinkedList();
              LinkedList localLinkedList10 = new LinkedList();
              LinkedList localLinkedList11 = new LinkedList();
              LinkedList localLinkedList12 = new LinkedList();
              LinkedList localLinkedList13 = new LinkedList();
              String str22 = ""; String str23 = "";
              String str24 = "";
              String str25 = "";
              String str26 = "";
              String str27 = "";
              String str28 = "ABCDEFGHIJKLOPQRST";
              String str29 = "";
              String str30 = "select   a.room_type,a.dis, a.tddate,a.Room_code,a.saleState,a.Floor,a.Room,a.area,a.code,a.sumprice,a.floorshow,a.floortype,a.floormess,b.showfloors from roomstateview a,roomno b where a.seccode+a.loft+a.room_code= b.SectionNo+b.region+b.roomno and a.seccode=";
              str30 = str30 + "'" + this.strSection + "'";
              str30 = str30 + str2 + " and  a.cell='" + str9 + "' and a.floortype=0   order by a.Floor";
              ResultSet localResultSet6 = localSDatabase2.executeQuery(str30);

              int i11 = 0;
              while (localResultSet6.next()) {
                str29 = localResultSet6.getString("room_type");
                localLinkedList8.add(localResultSet6.getString("Room_code"));
                localLinkedList3.add(localResultSet6.getString("SaleState"));
                String str31 = localResultSet6.getString("Floor");
                String str32 = localResultSet6.getString("Room");
                str22 = localResultSet6.getString("floorshow");
                str24 = localResultSet6.getString("floortype");
                localLinkedList4.add(str31);
                localLinkedList5.add(str32);
                if (Integer.parseInt(str32) >= 10)
                  localLinkedList2.add(str9 + str31 + str32);
                else {
                  localLinkedList2.add(str9 + str31 + "0" + str32);
                }
                localLinkedList6.add(getbyte1(localResultSet6.getString("area")));
                localLinkedList7.add(localResultSet6.getString("code"));
                localLinkedList9.add(getbyte1(localResultSet6.getString("floormess")));
                localLinkedList10.add(getbyte1(localResultSet6.getString("showfloors")));
                localLinkedList11.add(localResultSet6.getString("dis"));
                localLinkedList12.add(getbyte1(localResultSet6.getString("tddate")));
                localLinkedList13.add(getbyte1(localResultSet6.getString("sumprice")));
              }
              localResultSet6.close();
              int i12 = 0;
              System.out.println("ok");
              this.alertmess += " <td align=\"center\" valign=\"top\">";
              if (!str9.equals("")) this.alertmess = (this.alertmess + str9 + "单元");
              this.alertmess += " <table border=\"0\" width=\"100%\" CELLSPACING=1 CELLPADDING=0>";
              String str33ZH;
              if (str29.indexOf("墅") < 0) {
                this.alertmess += "  <tr>";
                this.alertmess += "   <td  width=\"1%\" bgcolor=\"#800000\" align=\"center\"><img src=\"../images/1.gif\" border=\"0\"></td>";

                char i13 = str20.charAt(0);
                str20 = str20.substring(str20.length() - 1);

                char c4 = str20.charAt(0);
                for (int i14 = str5; i14 <= str6; i14++) {
                	str33ZH = "";
                	str33ZH = localasicc.AsiicZH(i14, c4);

                  if ((((String)localObject2).indexOf(String.valueOf(i14)) >= 0) || (str19.indexOf((String)localObject2) >= 0)) {
                    if (str19.indexOf((String)localObject2) >= 0)
                    {
                      if (((String)localObject2).indexOf(String.valueOf(i14)) < 0)
                      {
                        this.alertmess += "<td align=\"center\" class=listtitle ";
                        if (str17.indexOf("Y") >= 0) this.alertmess += "   colspan=\"2\"";
                        this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33ZH + "</font></td>");
                      }
                    } else if (!localLinkedList1.contains(String.valueOf(i14)))
                    {
                      this.alertmess += "  <td align=\"center\" class=listtitle ";
                      if (str17.indexOf("Y") >= 0) this.alertmess += "   colspan='2'";
                      this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33ZH + "</font></td>");
                    }
                  }
                  else
                  {
                    this.alertmess += "  <td align=\"center\" class=listtitle ";
                    if (str17.indexOf("Y") >= 0) this.alertmess += "  colspan='2'";
                    this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33ZH + "</font></td>");
                  }

                }

                this.alertmess += "  </tr>";
              }
              this.alertmess += "  <tr>";
              float f1;
              float f2;
              String str34;
              String str37;
              for (int i13 = k; i13 <= m; i13++) {
                if (str29.indexOf("墅") < 0)
                  this.alertmess = (this.alertmess + "  <td align=\"center\" class=FloorC width=\"1%\"><font color=\"#ffffff\"><div id=A" + String.valueOf(Math.abs(i13)) + 1 + "w1>" + i13 + "</div></font></td>");
                else {
                  this.alertmess = (this.alertmess + " <div style='display:none' id=A" + String.valueOf(Math.abs(i13)) + 1 + "w1>" + i13 + "</div>");
                }
                f1 = 0.0F;
                f2 = 0.0F;
                for (int str33 = str5; str33 <= str6; str33++) {
                  if (!localLinkedList1.contains(String.valueOf(str33))) {
                    this.no = "";
                    str34 = "";
                    this.no = "";
                    String str35 = "0"; str37 = "";
                    if (str33 >= 10)
                      str34 = str9 + String.valueOf(i13) + String.valueOf(str33);
                    else
                      str34 = str9 + String.valueOf(i13) + "0" + String.valueOf(str33);
                    i12++;

                    if (localLinkedList2.contains(str34)) {
                      int i16 = localLinkedList2.indexOf(str34);
                      this.state = getbyte((String)localLinkedList3.get(i16));

                      str34 = (String)localLinkedList8.get(i16);
                      str25 = (String)localLinkedList9.get(i16);
                      str23 = (String)localLinkedList10.get(i16);
                      if (!this.state.equals("1"))
                        try {
                          str26 = (String)localLinkedList7.get(i16);
                          str27 = (String)localLinkedList6.get(i16);
                          String str39 = (String)localLinkedList13.get(i16);
                          if ((str26.equals("")) || (str26 == null)) str26 = "0";
                          if ((str27.equals("")) || (str27 == null)) str27 = "0";
                          if ((str39.equals("")) || (str39 == null)) str39 = "0";
                          f1 += Float.parseFloat(str39);
                          f2 += Float.parseFloat(str27); } catch (Exception localException4) {
                        }
                    } else {
                      this.state = "";
                    }String str38 = "";
                    if (((i13 != 3) || (str33 != 4)) || 
                      (this.state.equals("1"))) str38 = "BGCOLOR='" + str16 + "'";
                    else if (this.state.equals("2")) str38 = "bgcolor='" + str11 + "'";
                    else if (this.state.equals("3")) str38 = "bgcolor='" + str12 + "'";
                    else if (this.state.equals("4")) str38 = "bgcolor='" + str13 + "'";
                    else if (this.state.equals("5")) str38 = "bgcolor='" + str15 + "'";

                    this.no = str34;

                    if (this.condi.equals("wen")) {
                      str38 = "BGCOLOR='" + str16 + "'";
                      if (this.state.equals("3")) str34 = "已售" + this.no;
                      else if (this.state.equals("2")) str34 = "已认购" + this.no;
                      else if (this.state.equals("4")) str34 = "已预留" + this.no;
                      else if (this.state.equals("1")) str34 = "未售" + this.no;
                      else if (this.state.equals("5")) str34 = "临定" + this.no;
                      else if (this.state.equals("7")) str34 = "出租" + this.no; 
                    }
                    else if (this.condi.equals("pic")) {
                      str38 = "BGCOLOR='" + str16 + "'";
                      if (this.state.equals("2")) str34 = this.no + "<img src='../images/mypw.gif' border='0' >";
                      else if (this.state.equals("3")) str34 = this.no + "<img src='../images/maIcon.gif' border='0'  >";
                      else if (this.state.equals("1")) str34 = this.no + "&nbsp;&nbsp;";
                      else if (this.state.equals("5")) str34 = this.no + "<img src='../images/day2.gif' border='0' >";
                      else if (this.state.equals("2")) str34 = this.no;
                      else if (this.state.equals("4")) str34 = this.no + "<img src='../images/face39.gif' border='0' >";
                      else if (this.state.equals("6")) str34 = this.no;
                      else if (this.state.equals("7")) str34 = this.no;
                    }
                    else if (this.state.equals("2")) { str34 = this.no;
                    } else if (this.state.equals("3")) { str34 = this.no;
                    } else if (this.state.equals("1")) { str34 = this.no;
                    } else if (this.state.equals("5")) { str34 = this.no;
                    } else if (this.state.equals("2")) { str34 = this.no;
                    } else if (this.state.equals("4")) { str34 = this.no;
                    } else if (this.state.equals("6")) { str34 = this.no; }


                    if (!str37.equals("")) str37 = str37.substring(0, 10);

                    if (str17.indexOf("Y") >= 0) {
                      this.alertmess += "  <td align=\"center\" width=\"1%\">";
                      if ((str17.indexOf("Y") >= 0) && (!this.state.equals("2")) && (!this.state.equals("3")) && (!this.state.equals(""))) {
                        this.alertmess = (this.alertmess + "   <input type=checkbox name=yl ylloft='" + this.Loft + "' value='" + this.no + "'>");
                      }
                      this.alertmess += "  </td>";
                    }
                    this.alertmess = (this.alertmess + "  <td align=\"center\" width=\"5%\"  " + str38);
                    if (str35.equals("1")) this.alertmess = (this.alertmess + "  title='锁定日期:" + str37 + "'");

                    this.alertmess += "  >";
                    if (str10.equals("")) {
                      if ((this.state.equals("1")) && (str35.equals("0"))) { i3++;
                        if (str17.indexOf("A") >= 0) {
                          this.alertmess = (this.alertmess + " <a href='#" + this.no + "' onclick=\"opennewwin('roomdata.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=1',720,530,120,5)\">");
                        }
                        this.alertmess += str34;
                        if (str17.indexOf("A") >= 0)
                          this.alertmess += "</a>";
                      }
                      else if ((this.state.equals("1")) && (str35.equals("1"))) {
                        this.alertmess = (this.alertmess + " <a href=\"#\"> " + this.no + "[锁定] </a>");
                      } else if (this.state.equals("3")) { i5++;
                        this.alertmess = (this.alertmess + "<a href='#" + this.no + "'");
                        if (str17.indexOf("E") >= 0) {
                          this.alertmess = (this.alertmess + " onclick=\"opennewwin('ContractInput.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',750,530,120,2)\"");
                        }
                        this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                      }
                      else if (this.state.equals("2")) { i4++;
                        this.alertmess = (this.alertmess + "<a href='#" + this.no + "'");
                        if (str17.indexOf("E") >= 0) {
                          this.alertmess = (this.alertmess + " onclick=\"opennewwin('modiContractInput.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',750,530,120,2)\"");
                        }
                        this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                      } else if (this.state.equals("4")) { i7++;
                        if (str17.indexOf("Y") >= 0) {
                          this.alertmess = (this.alertmess + "<a href='#" + this.no + "' onclick=\"choose('" + str34 + "','" + this.Loft + "');ylroom(2,'" + str34 + "','" + this.Loft + "');\">");
                        }
                        this.alertmess += str34;
                        if (str17.indexOf("A") >= 0)
                          this.alertmess += "</a>";
                      }
                      else if (this.state.equals("6")) {
                        this.alertmess = (this.alertmess + " <a href='#" + this.no + "' ");
                        if (str17.indexOf("E") >= 0) {
                          this.alertmess = (this.alertmess + " onclick=\"opennewwin('ContractList.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=false',480,500,150,10)\"");
                        }
                        this.alertmess = (this.alertmess + ">" + str34 + "</a>");
                      } else if (this.state.equals("5")) { i8++;
                        this.alertmess = (this.alertmess + "<a href='#" + this.no + "' ");
                        if (str17.indexOf("A") >= 0) {
                          this.alertmess = (this.alertmess + " onclick=\"opennewwin('roomdata1.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=5',720,530,120,5)\"");
                        }
                        this.alertmess = (this.alertmess + ">" + str34 + "</a>");
                      } else if (this.state.equals("7")) {
                        this.alertmess = (this.alertmess + "<a href='#" + this.no + "' onclick=\"opennewwin('show_rent_contract.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=5',720,530,120,5)\">" + str34 + "</a>"); } else {
                        this.alertmess += "&nbsp;";
                      } } else if ((this.state.equals("1")) && (!str35.equals("1"))) { i3++;
                      if (str17.indexOf("A") >= 0) {
                        this.alertmess = (this.alertmess + " <a href='#" + this.no + "' onclick=\"opennewwin('roomdata.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=1',720,530,120,5)\">");
                      }
                      this.alertmess += str34;
                      if (str17.indexOf("A") >= 0)
                        this.alertmess += " </a>";
                    } else if (this.state.equals("2")) { i4++;
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "'");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + "  onclick=\"opennewwin('ContractInput2.jsp','?roomcode=" + str26 + "&secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',750,530,120,2);\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a> ");
                    }
                    else if (this.state.equals("3")) { i5++;
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "'  ");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + "  onclick=\"opennewwin('ContractInput2.jsp','?roomcode=" + str26 + "&secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',750,530,120,2);\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                    }
                    this.alertmess += " </td> ";
                  }

                }

                this.alertmess = (this.alertmess + "  <script>A" + String.valueOf(Math.abs(i13)) + 1 + "w1.innerHTML=\"");
                if (!str25.equals("")) this.alertmess = (this.alertmess + String.valueOf(i13) + str25); else
                  this.alertmess += i13;
                this.alertmess += "\" ;</script>";

                this.alertmess += " </tr>";
              }

              for (int i13 = n; i13 <= -1; i13++)
              {
                this.alertmess += " <tr> ";
                f1 = 0.0F;
                f2 = 0.0F;
                for (int str33 = str5; str33 <= str6; str33++) {
                  if (!localLinkedList1.contains(String.valueOf(str33))) {
                    this.no = "";
                    str34 = "";
                    this.no = "";
                    if (str33 >= 10)
                      str34 = str9 + String.valueOf(i13) + String.valueOf(str33);
                    else
                      str34 = str9 + String.valueOf(i13) + "0" + String.valueOf(str33);
                    i12++;

                    if (localLinkedList2.contains(str34)) {
                      int i15 = localLinkedList2.indexOf(str34);
                      this.state = ((String)localLinkedList3.get(i15));
                      str34 = (String)localLinkedList8.get(i15);
                      str25 = (String)localLinkedList9.get(i15);
                      str23 = (String)localLinkedList10.get(i15);
                      if (!this.state.equals("1"))
                        try {
                          str26 = (String)localLinkedList7.get(i15);
                          str27 = (String)localLinkedList6.get(i15);
                          str37 = (String)localLinkedList13.get(i15);
                          if ((str26.equals("")) || (str26 == null)) str26 = "0";
                          if ((str27.equals("")) || (str27 == null)) str27 = "0";
                          if ((str37.equals("")) || (str37 == null)) str37 = "0";

                          f1 += Float.parseFloat(str37);
                          f2 += Float.parseFloat(str27); } catch (Exception localException3) {
                        }
                    } else {
                      this.state = "";
                    }String str36 = "";
                    if (((i13 != 3) || (str33 != 4)) || 
                      (this.state.equals("1"))) str36 = "BGCOLOR='#DDE8E8'";
                    if (this.state.equals("2")) str36 = "bgcolor='#00CCFF'";
                    if (this.state.equals("3")) str36 = "bgcolor='#E5C862'";
                    if (this.state.equals("4")) str36 = "bgcolor='#8DE4A6'";
                    if (this.state.equals("5")) str36 = "bgcolor='#FF00FF'";
                    if (this.state.equals("6")) str36 = "bgcolor='#AACC6F'";
                    if (this.state.equals("7")) { str36 = "bgcolor='#AACC6F'"; i6++; }
                    this.no = str34;

                    if (this.condi.equals("wen")) {
                      str36 = "bgcolor='#c0c0c0'";
                      if (this.state.equals("3")) str34 = "已售" + this.no;
                      else if (this.state.equals("2")) str34 = "已认购" + this.no;
                      else if (this.state.equals("4")) str34 = "已预留" + this.no;
                      else if (this.state.equals("1")) str34 = "未售" + this.no;
                      else if (this.state.equals("5")) str34 = "临定" + this.no;
                      else if (this.state.equals("7")) str34 = "出租" + this.no; 
                    }
                    else if (this.condi.equals("pic")) {
                      str36 = "bgcolor='#c0c0c0'";
                      if (this.state.equals("2")) str34 = this.no + "<img src='../images/mypw.gif' border='0' >";
                      else if (this.state.equals("3")) str34 = this.no + "<img src='../images/maIcon.gif' border='0' >";
                      else if (this.state.equals("1")) str34 = this.no + "&nbsp;&nbsp;";
                      else if (this.state.equals("5")) str34 = this.no + "<img src='../images/day2.gif' border='0' >";
                      else if (this.state.equals("2")) str34 = this.no;
                      else if (this.state.equals("4")) str34 = this.no + "<img src='../images/face39.gif'  border='0' >";
                      else if (this.state.equals("6")) str34 = this.no;
                      else if (this.state.equals("7")) str34 = this.no;
                    }
                    else if (this.state.equals("2")) { str34 = this.no;
                    } else if (this.state.equals("3")) { str34 = this.no;
                    } else if (this.state.equals("1")) { str34 = this.no;
                    } else if (this.state.equals("5")) { str34 = this.no;
                    } else if (this.state.equals("2")) { str34 = this.no;
                    } else if (this.state.equals("4")) { str34 = this.no;
                    } else if (this.state.equals("6")) { str34 = this.no; }


                    if (str17.indexOf("Y") >= 0) {
                      this.alertmess += " <td align=\"center\" width=\"1%\">";
                      if ((str17.indexOf("Y") >= 0) && (!this.state.equals("2")) && (!this.state.equals("3")) && (!this.state.equals(""))) {
                        this.alertmess = (this.alertmess + "  <input type=checkbox name=yl ylloft=" + this.Loft + " value=" + this.no + ">");
                      }
                      this.alertmess += " </td>";
                    }
                    this.alertmess = (this.alertmess + " <td align=\"center\" width=\"5%\"  " + str36 + ">");
                    if (this.state.equals("1")) { i3++;
                      if (str17.indexOf("A") >= 0) {
                        this.alertmess = (this.alertmess + " <a href='#" + this.no + "' onclick=\"opennewwin('roomdata.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=1',720,530,120,5)\">");
                      }
                      this.alertmess += str34;
                      if (str17.indexOf("A") >= 0) this.alertmess += " </a>"; 
                    }
                    else if (this.state.equals("2")) { i4++;
                      this.alertmess = (this.alertmess + "  <a href='#" + this.no + "'");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + "   onclick=\"opennewwin('modiContractInput.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',720,530,120,2)\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a> ");
                    } else if (this.state.equals("3")) { i5++;
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "' ");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + "   onclick=\"opennewwin('modiContractInput.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',720,530,120,2)\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a> ");
                    } else if (this.state.equals("4")) { i7++;
                      if (str17.indexOf("Y") >= 0) {
                        this.alertmess = (this.alertmess + "   <a href='#" + this.no + "' onclick=\"choose('" + str34 + "','" + this.Loft + "');ylroom(2,'" + str34 + "','" + this.Loft + "');\">");
                      }
                      this.alertmess += str34;
                      if (str17.indexOf("Y") >= 0) this.alertmess += " </a>"; 
                    }
                    else if (this.state.equals("6")) {
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "'");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + " onclick=\"opennewwin('ContractList.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=false',480,500,150,10)\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                    }
                    else if (this.state.equals("5")) { i8++;
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "'");
                      if (str17.indexOf("A") >= 0) {
                        this.alertmess = (this.alertmess + "  onclick=\"opennewwin('roomdata1.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=5',720,530,120,5)\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                    } else if (this.state.equals("7")) {
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "' onclick=\"opennewwin('show_rent_contract.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=5',680,530,120,5)\">" + str34 + "</a>");
                    } else {
                      this.alertmess += " &nbsp;";
                    }this.alertmess += "  </td>";
                  }
                }
                this.alertmess += " </tr>";
              }
              this.alertmess += " </td></tr></table>";
            }
          }
          this.alertmess += " </td></tr>";
          this.alertmess += " </table>";

          this.alertmess += " <script>";

          this.alertmess += "  function printT(){";
          this.alertmess += " pri.innerHTML=\"\";";
          this.alertmess += " print();";

          this.alertmess += "  }";
          this.alertmess += "  function opennewwin1(para,wh,hg,lf,tp) {";
          this.alertmess += " var newwin=window.open(\"rgList.jsp?\"+para,\"newwin1\",\"toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,width=480,height=500,left=150,top=10\");";
          this.alertmess += "  }";

          this.alertmess = (this.alertmess + "  wy" + i + ".innerHTML = \"" + i3 + "\";");
          this.alertmess = (this.alertmess + " w1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i3)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + " ry" + i + ".innerHTML = \"" + i4 + "\";");
          this.alertmess = (this.alertmess + " r1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i4)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + "sy" + i + ".innerHTML = \"" + i5 + "\";");
          this.alertmess = (this.alertmess + "s1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i5)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + "yy" + i + ".innerHTML = \"" + i7 + "\";");
          this.alertmess = (this.alertmess + "y1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i7)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + "ly" + i + ".innerHTML = \"" + i8 + "\";");
          this.alertmess = (this.alertmess + " l1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i8)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");

          int i10 = i8 + i3 + i7 + i5 + i4 + i6;
          this.alertmess = (this.alertmess + " sum" + i + ".innerHTML = '合计：" + i10 + "';");
          this.alertmess += "</script>";
          this.alertmess += "  </td>";
        }
      }
      this.alertmess += "</tr></table>";
    } catch (Exception localException1) {
      System.out.println(localException1);
    }return this.alertmess;
  }

  public String BeanCodeShow1(String paramString1, String paramString2)
  {
    try
    {
      this.condi = paramString2;
      this.alertmess = "";
      int i = 0;
      asicc localasicc = new asicc();
      FormatData localFormatData = new FormatData();
      this.alertmess += "<table border=\"0\"  width=\"100%\"><tr>";
      String str1 = "select Loft FROM sectiontree where SerialNo='" + this.strSection + "'";

      if (!this.Loft.equals("")) str1 = str1 + " and Loft in (" + this.Loft + ") ";
      str1 = str1 + "group by Loft";
      ResultSet localResultSet1 = null;
      SDatabase localSDatabase1 = new SDatabase();
      SDatabase localSDatabase2 = new SDatabase();
      localResultSet1 = localSDatabase1.executeQuery(str1);
      if (!this.Loft.equals("")) {
        while (localResultSet1.next()) {
          i++;
          this.alertmess += "<td valign='top'>";
          this.Loft = localResultSet1.getString("Loft");
          String str2 = "";
          if (!this.Loft.equals("")) str2 = " and loft='" + this.Loft + "'";

          String str3 = "select lockroom from lockroom where section ='" + this.strSection + "' and ";
          str3 = str3 + " loft='" + this.Loft + "'";
          ResultSet localResultSet2 = null;
          Object localObject1 = "";
          Object localObject2 = "";
          LinkedList localLinkedList1 = new LinkedList();
          try {
            localResultSet2 = localSDatabase2.executeQuery(str3);
            while (localResultSet2.next()) {
              String str4 = localResultSet2.getString("LockRoom");
              if (((String)localObject1).equals("")) localObject1 = str4; else
                localObject1 = (String)localObject1 + "," + str4;
              char c1 = str4.charAt(0);
              if (!Character.isDigit(c1)) {
                str4 = String.valueOf(Character.getNumericValue(c1) - 9);
              }
              localLinkedList1.add(str4);
              if (((String)localObject2).equals(""))
                localObject2 = str4;
              else
                localObject2 = (String)localObject2 + "," + str4;
            }
            localResultSet2.close(); } catch (Exception localException2) {
          }
          this.sql = "select floor from";
          this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
          this.sql = (this.sql + "  and Region='" + this.Loft + "' and floor=0");
          ResultSet localResultSet3 = localSDatabase2.executeQuery(this.sql);
          char c1 = '\001';
          int j= 1;
          if (localResultSet3.next()) {
        	  j = localResultSet3.getInt("floor"); 
          }
          localResultSet3.close();
          this.sql = "select min(Floor) as BeginF,max(Floor) as EndF,";
          this.sql += "min(Room) as BeginR,max(Room) as EndR,max(cell) as Ecell ,min(cell) as Scell from";
          this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
          this.sql = (this.sql + "  and Region='" + this.Loft + "'");
          localResultSet3 = localSDatabase2.executeQuery(this.sql);
          int k = 0;
          int m = 0;
          int str5 = 0;
          int str6 = 0;
          int n = 0;
          String str7 = "";
          String str8 = "";
          String str9 = "";
          if (localResultSet3.next()) {
            k = localResultSet3.getInt("BeginF");

            m = localResultSet3.getInt("EndF");
            str5 = localResultSet3.getInt("BeginR");
            str6 = localResultSet3.getInt("EndR");
            str7 = getbyte(localResultSet3.getString("Ecell"));
            str8 = getbyte(localResultSet3.getString("Scell"));
            if ((str8.equals("")) && (str7.equals(""))) { str7 = " "; str8 = " "; }
          }
          localResultSet3.close();
          int i1 = 0; int i2 = 0;
          char c2 = str8.charAt(0);
          char c3 = str7.charAt(0);
          if ((!str8.equals("")) && (!str7.equals(""))) {
            c2 = str8.charAt(0);
            c3 = str7.charAt(0);
            if (Character.isDigit(c2)) {
              i1 = Integer.parseInt(str8);
              i2 = Integer.parseInt(str7);
            } else {
              i1 = Character.getNumericValue(c2) - 9;
              i2 = Character.getNumericValue(c3) - 9;
            }
          }
          if (i1 < 0) i1 = 0;
          if (i2 < 0) i2 = 0;
          String str10 = "";
          localResultSet3 = localSDatabase2.executeQuery("select roomtype from LoftBuildCode where SecNo='" + this.strSection + "' and Loft='" + this.Loft + "' and roomtype=1");
          if (localResultSet3.next()) {
            str10 = "1";
          }
          localResultSet3.close();

          this.alertmess = (this.alertmess + " <input type=hidden name=SecNo value=\"" + this.strSection + "\">");
          this.alertmess = (this.alertmess + "<input type=hidden name=SecName value=\"" + this.SecName + "\">");
          this.alertmess = (this.alertmess + "<input type=hidden name=Loft value=\"" + this.Loft + "\">");
          this.alertmess += "<input type=hidden name=Build value=\"\">";
          this.alertmess += "<input type=hidden name=cusname value=\"\">";
          this.alertmess += "<input type=hidden name=secname value=\"\">";
          String str11 = "#00CCFF";
          String str12 = "#E5C862";
          String str13 = "#8DE4A6";
          String str14 = "#AACC6F";
          String str15 = "#FF00FF";
          String str16 = "#DDE8E8";
          if (!this.strSection.equals("")) {
            String str17 = "select  *  from SaleStateColor WHERE secno='" + this.strSection + "'";

            ResultSet localResultSet4 = localSDatabase2.executeQuery(str17);
            if (localResultSet4.next()) {
              str11 = localResultSet4.getString("RG");
              str12 = localResultSet4.getString("QY");
              str15 = localResultSet4.getString("ld");
              str14 = localResultSet4.getString("CZ");
              str13 = localResultSet4.getString("YL");
              str16 = localResultSet4.getString("ws");
            }

            localResultSet4.close();
          }
          if (str11.equals("")) {
            this.alertmess += "<script>";
            this.alertmess += "alert(\"还没有设置为销控表设置状态色块,请在系统管理中设置\");";

            this.alertmess += "</script>";
          }

          String str17 = paramString1;
          if (str17 == null) str17 = "";

          this.alertmess += " <p CLASS=FontColor align=\"center\"><b><font size=\"3\" >";

          if (!this.SecName.equals(this.Loft)) this.alertmess += this.SecName; this.alertmess = (this.alertmess + this.Loft + " 销控表</font></b></p>");
          this.alertmess += " <table width=\"98%\" border=\"0\"  align=\"center\" CELLSPACING=1 CELLPADDING=3>";

          this.alertmess = (this.alertmess + "<td bgcolor='" + str16 + "'  align=\"center\">未售</td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str11 + "'  align=\"center\">认购<img src='../images/mypw.gif' border='0' ></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str12 + "'  align=\"center\">签约<img src='../images/maIcon.gif' border='0' ></td>");
          this.alertmess = (this.alertmess + "\t<td bgcolor='" + str13 + "'  align=\"center\">");
          if (str17.indexOf("Y") >= 0) this.alertmess = (this.alertmess + "<a href=\"#\" onclick=\"ylroom(1,'','" + this.Loft + "');return false;\" title=\"选择预留房间后点击[预留]\" >预留</a>"); else
            this.alertmess += "预留";
          this.alertmess += "<img src='../images/day2.gif' border='0' ></td>";
          this.alertmess = (this.alertmess + "<td bgcolor='" + str15 + "'  align=\"center\">临定<img src='../images/face39.gif' border='0' ></td>");
          this.alertmess += "<td   align=\"center\">";
          this.alertmess += " </td>";
          this.alertmess += "</tr>";
          this.alertmess = (this.alertmess + " <tr><td bgcolor='" + str16 + "' align=\"center\"><div id=wy" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str11 + "'  align=\"center\"><div id=ry" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str12 + "'  align=\"center\"><div id=sy" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str13 + "'  align=\"center\"><div id=yy" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str15 + "' align=\"center\"><div id=ly" + i + "></div></td>");

          this.alertmess = (this.alertmess + "  <td   align=\"center\"><div id=sum" + i + "> </div>");
          this.alertmess += " </td>";
          this.alertmess += " \t</tr>";
          this.alertmess = (this.alertmess + "  <tr><td bgcolor='" + str16 + "' align=\"center\"><div id=w1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str11 + "'  align=\"center\"><div id=r1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str12 + "'  align=\"center\"><div id=s1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str13 + "'  align=\"center\"><div id=y1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str15 + "'  align=\"center\"><div id=l1" + i + "></div></td>");

          this.alertmess += " </td>";
          this.alertmess += " <td   align=\"center\"> ";
          this.alertmess += " </td>";
          this.alertmess += " </tr>";
          this.alertmess += " </table>";

          int i3 = 0;
          int i4 = 0;
          int i5 = 0;
          int i6 = 0;
          int i7 = 0;
          int i8 = 0;

          String str18 = "";
          if (str18 == null) str18 = "";

          String str19 = "ABCDEFGHIJKLOPQRST";
          str19 = str19.trim();
          int i9 = 0;
          String str20 = "";
          String str21 = "select top 1 Room_code from Room where seccode=";
          str21 = str21 + "'" + this.strSection + "' and Building='";
          str21 = str21 + this.strBuilding + "' and loft='" + this.Loft + "'  ";
          ResultSet localResultSet5 = localSDatabase2.executeQuery(str21);
          if (localResultSet5.next()) str20 = localResultSet5.getString("Room_code");
          localResultSet5.close();

          if (str20.equals(""))
          {
            this.alertmess += " <script>";

            this.alertmess += " </script>";
          }
          else {
            this.alertmess += " <script>";
            this.alertmess += " function px(para){";
            this.alertmess += " if (para==\"asc\")document.frm.action=\"RoomCodeShowS.jsp\";";
            this.alertmess += " else document.frm.action=\"RoomCodeShowDS.jsp\";";
            this.alertmess += "  document.frm.submit();";
            this.alertmess += "  }";

            this.alertmess += " </script>";
            this.alertmess += " <table width=\"100%\" align=\"center\" border=\"0\" CELLSPACING=0 CELLPADDING=0>";
            this.alertmess += " <tr valign=\"top\">";
            for (int i10 = i1; i10 <= i2; i10++) {
              if (i1 > 0) {
                str9 = localasicc.AsiicZH(i10, c2);
              }

              LinkedList localLinkedList2 = new LinkedList();
              LinkedList localLinkedList3 = new LinkedList();
              LinkedList localLinkedList4 = new LinkedList();
              LinkedList localLinkedList5 = new LinkedList();
              LinkedList localLinkedList6 = new LinkedList();
              LinkedList localLinkedList7 = new LinkedList();
              LinkedList localLinkedList8 = new LinkedList();
              LinkedList localLinkedList9 = new LinkedList();
              LinkedList localLinkedList10 = new LinkedList();
              LinkedList localLinkedList11 = new LinkedList();
              LinkedList localLinkedList12 = new LinkedList();
              LinkedList localLinkedList13 = new LinkedList();
              String str22 = ""; String str23 = "";
              String str24 = "";
              String str25 = "";
              String str26 = "";
              String str27 = "";
              String str28 = "ABCDEFGHIJKLOPQRST";
              String str29 = "";
              String str30 = "select   a.room_type,a.dis, a.tddate,a.Room_code,a.saleState,a.Floor,a.Room,a.area,a.code,a.sumprice,a.floorshow,a.floortype,a.floormess,b.showfloors from roomstateview a,roomno b where a.seccode+a.loft+a.room_code= b.SectionNo+b.region+b.roomno and a.seccode=";
              str30 = str30 + "'" + this.strSection + "'";
              str30 = str30 + str2 + " and  a.cell='" + str9 + "' and a.floortype=0   order by a.Floor";
              ResultSet localResultSet6 = localSDatabase2.executeQuery(str30);

              int i11 = 0;
              while (localResultSet6.next()) {
                str29 = localResultSet6.getString("room_type");
                localLinkedList8.add(localResultSet6.getString("Room_code"));
                localLinkedList3.add(localResultSet6.getString("SaleState"));
                String str31 = localResultSet6.getString("Floor");
                String str32 = localResultSet6.getString("Room");
                str22 = localResultSet6.getString("floorshow");
                str24 = localResultSet6.getString("floortype");
                localLinkedList4.add(str31);
                localLinkedList5.add(str32);
                if (Integer.parseInt(str32) >= 10)
                  localLinkedList2.add(str9 + str31 + str32);
                else {
                  localLinkedList2.add(str9 + str31 + "0" + str32);
                }
                localLinkedList6.add(getbyte1(localResultSet6.getString("area")));
                localLinkedList7.add(localResultSet6.getString("code"));
                localLinkedList9.add(getbyte1(localResultSet6.getString("floormess")));
                localLinkedList10.add(getbyte1(localResultSet6.getString("showfloors")));
                localLinkedList11.add(localResultSet6.getString("dis"));
                localLinkedList12.add(getbyte1(localResultSet6.getString("tddate")));
                localLinkedList13.add(getbyte1(localResultSet6.getString("sumprice")));
              }
              localResultSet6.close();
              int i12 = 0;
              System.out.println("ok");
              this.alertmess += " <td align=\"center\" valign=\"top\">";
              if (!str9.equals("")) this.alertmess = (this.alertmess + str9 + "单元");
              this.alertmess += " <table border=\"0\" width=\"100%\" CELLSPACING=1 CELLPADDING=0>";
              String str33ZH;
              if (str29.indexOf("墅") < 0) {
                this.alertmess += "  <tr>";
                this.alertmess += "   <td  width=\"1%\" bgcolor=\"#800000\" align=\"center\"><img src=\"../images/1.gif\" border=\"0\"></td>";

                char i13 = str20.charAt(0);
                str20 = str20.substring(str20.length() - 1);

                char c4 = str20.charAt(0);
                for (int i14 = str5; i14 <= str6; i14++) {
                	str33ZH = "";
                	str33ZH = localasicc.AsiicZH(i14, c4);

                  if ((((String)localObject2).indexOf(String.valueOf(i14)) >= 0) || (str19.indexOf((String)localObject2) >= 0)) {
                    if (str19.indexOf((String)localObject2) >= 0)
                    {
                      if (((String)localObject2).indexOf(String.valueOf(i14)) < 0)
                      {
                        this.alertmess += "<td align=\"center\" class=listtitle ";
                        if (str17.indexOf("Y") >= 0) this.alertmess += "   colspan=\"2\"";
                        this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33ZH + "</font></td>");
                      }
                    } else if (!localLinkedList1.contains(String.valueOf(i14)))
                    {
                      this.alertmess += "  <td align=\"center\" class=listtitle ";
                      if (str17.indexOf("Y") >= 0) this.alertmess += "   colspan='2'";
                      this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33ZH + "</font></td>");
                    }
                  }
                  else
                  {
                    this.alertmess += "  <td align=\"center\" class=listtitle ";
                    if (str17.indexOf("Y") >= 0) this.alertmess += "  colspan='2'";
                    this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33ZH + "</font></td>");
                  }

                }

                this.alertmess += "  </tr>";
              }
              this.alertmess += "  <tr>";
              float f1;
              float f2;
              String str34;
              String str37;
              for (int i13 = m; i13 >= k; i13--) {
                if (str29.indexOf("墅") < 0)
                  this.alertmess = (this.alertmess + "  <td align=\"center\" class=FloorC width=\"1%\"><font color=\"#ffffff\"><div id=A" + String.valueOf(Math.abs(i13)) + 1 + "w1>" + i13 + "</div></font></td>");
                else {
                  this.alertmess = (this.alertmess + " <div style='display:none' id=A" + String.valueOf(Math.abs(i13)) + 1 + "w1>" + i13 + "</div>");
                }
                f1 = 0.0F;
                f2 = 0.0F;
                for (int str33 = str5; str33 <= str6; str33++) {
                  if (!localLinkedList1.contains(String.valueOf(str33))) {
                    this.no = "";
                    str34 = "";
                    this.no = "";
                    String str35 = "0"; str37 = "";
                    if (str33 >= 10)
                      str34 = str9 + String.valueOf(i13) + String.valueOf(str33);
                    else
                      str34 = str9 + String.valueOf(i13) + "0" + String.valueOf(str33);
                    i12++;

                    if (localLinkedList2.contains(str34)) {
                      int i16 = localLinkedList2.indexOf(str34);
                      this.state = getbyte((String)localLinkedList3.get(i16));

                      str34 = (String)localLinkedList8.get(i16);
                      str25 = (String)localLinkedList9.get(i16);
                      str23 = (String)localLinkedList10.get(i16);
                      if (!this.state.equals("1"))
                        try {
                          str26 = (String)localLinkedList7.get(i16);
                          str27 = (String)localLinkedList6.get(i16);
                          String str39 = (String)localLinkedList13.get(i16);
                          if ((str26.equals("")) || (str26 == null)) str26 = "0";
                          if ((str27.equals("")) || (str27 == null)) str27 = "0";
                          if ((str39.equals("")) || (str39 == null)) str39 = "0";
                          f1 += Float.parseFloat(str39);
                          f2 += Float.parseFloat(str27); } catch (Exception localException4) {
                        }
                    } else {
                      this.state = "";
                    }String str38 = "";
                    if (((i13 != 3) || (str33 != 4)) || 
                      (this.state.equals("1"))) str38 = "BGCOLOR='" + str16 + "'";
                    else if (this.state.equals("2")) str38 = "bgcolor='" + str11 + "'";
                    else if (this.state.equals("3")) str38 = "bgcolor='" + str12 + "'";
                    else if (this.state.equals("4")) str38 = "bgcolor='" + str13 + "'";
                    else if (this.state.equals("5")) str38 = "bgcolor='" + str15 + "'";

                    this.no = str34;

                    if (this.condi.equals("wen")) {
                      str38 = "BGCOLOR='" + str16 + "'";
                      if (this.state.equals("3")) str34 = "已售" + this.no;
                      else if (this.state.equals("2")) str34 = "已认购" + this.no;
                      else if (this.state.equals("4")) str34 = "已预留" + this.no;
                      else if (this.state.equals("1")) str34 = "未售" + this.no;
                      else if (this.state.equals("5")) str34 = "临定" + this.no;
                      else if (this.state.equals("7")) str34 = "出租" + this.no; 
                    }
                    else if (this.condi.equals("pic")) {
                      str38 = "BGCOLOR='" + str16 + "'";
                      if (this.state.equals("2")) str34 = this.no + "<img src='../images/mypw.gif' border='0' >";
                      else if (this.state.equals("3")) str34 = this.no + "<img src='../images/maIcon.gif' border='0'>";
                      else if (this.state.equals("1")) str34 = this.no + "&nbsp;&nbsp;";
                      else if (this.state.equals("5")) str34 = this.no + "<img src='../images/day2.gif' border='0'>";
                      else if (this.state.equals("2")) str34 = this.no;
                      else if (this.state.equals("4")) str34 = this.no + "<img src='../images/face39.gif' border='0'>";
                      else if (this.state.equals("6")) str34 = this.no;
                      else if (this.state.equals("7")) str34 = this.no;
                    }
                    else if (this.state.equals("2")) { str34 = this.no;
                    } else if (this.state.equals("3")) { str34 = this.no;
                    } else if (this.state.equals("1")) { str34 = this.no;
                    } else if (this.state.equals("5")) { str34 = this.no;
                    } else if (this.state.equals("2")) { str34 = this.no;
                    } else if (this.state.equals("4")) { str34 = this.no;
                    } else if (this.state.equals("6")) { str34 = this.no; }


                    if (!str37.equals("")) str37 = str37.substring(0, 10);

                    if (str17.indexOf("Y") >= 0) {
                      this.alertmess += "  <td align=\"center\" width=\"1%\">";
                      if ((str17.indexOf("Y") >= 0) && (!this.state.equals("2")) && (!this.state.equals("3")) && (!this.state.equals(""))) {
                        this.alertmess = (this.alertmess + "   <input type=checkbox name=yl ylloft='" + this.Loft + "' value='" + this.no + "'>");
                      }
                      this.alertmess += "  </td>";
                    }
                    this.alertmess = (this.alertmess + "  <td align=\"center\" width=\"5%\"  " + str38);
                    if (str35.equals("1")) this.alertmess = (this.alertmess + "  title='锁定日期:" + str37 + "'");

                    this.alertmess += "  >";
                    if (str10.equals("")) {
                      if ((this.state.equals("1")) && (str35.equals("0"))) { i3++;
                        if (str17.indexOf("A") >= 0) {
                          this.alertmess = (this.alertmess + " <a href='#" + this.no + "' onclick=\"opennewwin('roomdata.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=1',720,530,120,5)\">");
                        }
                        this.alertmess += str34;
                        if (str17.indexOf("A") >= 0)
                          this.alertmess += "</a>";
                      }
                      else if ((this.state.equals("1")) && (str35.equals("1"))) {
                        this.alertmess = (this.alertmess + " <a href=\"#\"> " + str34 + "[锁定] </a>");
                      } else if (this.state.equals("3")) { i5++;
                        this.alertmess = (this.alertmess + "<a href='#" + this.no + "'");
                        if (str17.indexOf("E") >= 0) {
                          this.alertmess = (this.alertmess + " onclick=\"opennewwin('ContractInput.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',750,530,120,2)\"");
                        }
                        this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                      }
                      else if (this.state.equals("2")) { i4++;
                        this.alertmess = (this.alertmess + "<a href='#" + this.no + "'");
                        if (str17.indexOf("E") >= 0) {
                          this.alertmess = (this.alertmess + " onclick=\"opennewwin('modiContractInput.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',750,530,120,2)\"");
                        }
                        this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                      } else if (this.state.equals("4")) { i7++;
                        if (str17.indexOf("Y") >= 0) {
                          this.alertmess = (this.alertmess + "<a href='#" + this.no + "' onclick=\"choose('" + str34 + "','" + this.Loft + "');ylroom(2,'" + str34 + "','" + this.Loft + "');\">");
                        }
                        this.alertmess += str34;
                        if (str17.indexOf("A") >= 0)
                          this.alertmess += "</a>";
                      }
                      else if (this.state.equals("6")) {
                        this.alertmess = (this.alertmess + " <a href='#" + this.no + "' ");
                        if (str17.indexOf("E") >= 0) {
                          this.alertmess = (this.alertmess + " onclick=\"opennewwin('ContractList.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=false',480,500,150,10)\"");
                        }
                        this.alertmess = (this.alertmess + ">" + str34 + "</a>");
                      } else if (this.state.equals("5")) { i8++;
                        this.alertmess = (this.alertmess + "<a href='#" + this.no + "' ");
                        if (str17.indexOf("A") >= 0) {
                          this.alertmess = (this.alertmess + " onclick=\"opennewwin('roomdata1.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=5',720,530,120,5)\"");
                        }
                        this.alertmess = (this.alertmess + ">" + str34 + "</a>");
                      } else if (this.state.equals("7")) {
                        this.alertmess = (this.alertmess + "<a href='#" + this.no + "' onclick=\"opennewwin('show_rent_contract.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=5',720,530,120,5)\">" + str34 + "</a>"); } else {
                        this.alertmess += "&nbsp;";
                      } } else if ((this.state.equals("1")) && (!str35.equals("1"))) { i3++;
                      if (str17.indexOf("A") >= 0) {
                        this.alertmess = (this.alertmess + " <a href='#" + this.no + "' onclick=\"opennewwin('roomdata.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=1',720,530,120,5)\">");
                      }
                      this.alertmess += str34;
                      if (str17.indexOf("A") >= 0)
                        this.alertmess += " </a>";
                    } else if (this.state.equals("2")) { i4++;
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "'");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + "  onclick=\"opennewwin('ContractInput2.jsp','?roomcode=" + str26 + "&secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',750,530,120,2);\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a> ");
                    }
                    else if (this.state.equals("3")) { i5++;
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "'  ");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + "  onclick=\"opennewwin('ContractInput2.jsp','?roomcode=" + str26 + "&secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',750,530,120,2);\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                    }
                    this.alertmess += " </td> ";
                  }

                }

                this.alertmess = (this.alertmess + "  <script>A" + String.valueOf(Math.abs(i13)) + 1 + "w1.innerHTML=\"");
                if (!str25.equals("")) this.alertmess = (this.alertmess + String.valueOf(i13) + str25); else
                  this.alertmess += i13;
                this.alertmess += "\" ;</script>";

                this.alertmess += " </tr>";
              }

              for (int i13 = n; i13 <= -1; i13++)
              {
                this.alertmess += " <tr> ";
                f1 = 0.0F;
                f2 = 0.0F;
                for (int str33 = str5; str33 <= str6; str33++) {
                  if (!localLinkedList1.contains(String.valueOf(str33))) {
                    this.no = "";
                    str34 = "";
                    this.no = "";
                    if (str33 >= 10)
                      str34 = str9 + String.valueOf(i13) + String.valueOf(str33);
                    else
                      str34 = str9 + String.valueOf(i13) + "0" + String.valueOf(str33);
                    i12++;

                    if (localLinkedList2.contains(str34)) {
                      int i15 = localLinkedList2.indexOf(str34);
                      this.state = ((String)localLinkedList3.get(i15));
                      str34 = (String)localLinkedList8.get(i15);
                      str25 = (String)localLinkedList9.get(i15);
                      str23 = (String)localLinkedList10.get(i15);
                      if (!this.state.equals("1"))
                        try {
                          str26 = (String)localLinkedList7.get(i15);
                          str27 = (String)localLinkedList6.get(i15);
                          str37 = (String)localLinkedList13.get(i15);
                          if ((str26.equals("")) || (str26 == null)) str26 = "0";
                          if ((str27.equals("")) || (str27 == null)) str27 = "0";
                          if ((str37.equals("")) || (str37 == null)) str37 = "0";

                          f1 += Float.parseFloat(str37);
                          f2 += Float.parseFloat(str27); } catch (Exception localException3) {
                        }
                    } else {
                      this.state = "";
                    }String str36 = "";
                    if (((i13 != 3) || (str33 != 4)) || 
                      (this.state.equals("1"))) str36 = "BGCOLOR='#DDE8E8'";
                    if (this.state.equals("2")) str36 = "bgcolor='#00CCFF'";
                    if (this.state.equals("3")) str36 = "bgcolor='#E5C862'";
                    if (this.state.equals("4")) str36 = "bgcolor='#8DE4A6'";
                    if (this.state.equals("5")) str36 = "bgcolor='#FF00FF'";
                    if (this.state.equals("6")) str36 = "bgcolor='#AACC6F'";
                    if (this.state.equals("7")) { str36 = "bgcolor='#AACC6F'"; i6++; }
                    this.no = str34;

                    if (this.condi.equals("wen")) {
                      str36 = "bgcolor='#c0c0c0'";
                      if (this.state.equals("3")) str34 = "已售" + this.no;
                      else if (this.state.equals("2")) str34 = "已认购" + this.no;
                      else if (this.state.equals("4")) str34 = "已预留" + this.no;
                      else if (this.state.equals("1")) str34 = "未售" + this.no;
                      else if (this.state.equals("5")) str34 = "临定" + this.no;
                      else if (this.state.equals("7")) str34 = "出租" + this.no; 
                    }
                    else if (this.condi.equals("pic")) {
                      str36 = "bgcolor='#c0c0c0'";
                      if (this.state.equals("2")) str34 = this.no + "<img src='../images/mypw.gif' border='0' >";
                      else if (this.state.equals("3")) str34 = this.no + "<img src='../images/maIcon.gif' border='0' >";
                      else if (this.state.equals("1")) str34 = this.no + "&nbsp;&nbsp;";
                      else if (this.state.equals("5")) str34 = this.no + "<img src='../images/day2.gif' border='0' >";
                      else if (this.state.equals("2")) str34 = this.no;
                      else if (this.state.equals("4")) str34 = this.no + "<img src='../images/face39.gif'  border='0' >";
                      else if (this.state.equals("6")) str34 = this.no;
                      else if (this.state.equals("7")) str34 = this.no;
                    }
                    else if (this.state.equals("2")) { str34 = this.no;
                    } else if (this.state.equals("3")) { str34 = this.no;
                    } else if (this.state.equals("1")) { str34 = this.no;
                    } else if (this.state.equals("5")) { str34 = this.no;
                    } else if (this.state.equals("2")) { str34 = this.no;
                    } else if (this.state.equals("4")) { str34 = this.no;
                    } else if (this.state.equals("6")) { str34 = this.no; }


                    if (str17.indexOf("Y") >= 0) {
                      this.alertmess += " <td align=\"center\" width=\"1%\">";
                      if ((str17.indexOf("Y") >= 0) && (!this.state.equals("2")) && (!this.state.equals("3")) && (!this.state.equals(""))) {
                        this.alertmess = (this.alertmess + "  <input type=checkbox name=yl ylloft=" + this.Loft + " value=" + this.no + ">");
                      }
                      this.alertmess += " </td>";
                    }
                    this.alertmess = (this.alertmess + " <td align=\"center\" width=\"5%\"  " + str36 + ">");
                    if (this.state.equals("1")) { i3++;
                      if (str17.indexOf("A") >= 0) {
                        this.alertmess = (this.alertmess + " <a href='#" + this.no + "' onclick=\"opennewwin('roomdata.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=1',720,530,120,5)\">");
                      }
                      this.alertmess += str34;
                      if (str17.indexOf("A") >= 0) this.alertmess += " </a>"; 
                    }
                    else if (this.state.equals("2")) { i4++;
                      this.alertmess = (this.alertmess + "  <a href='#" + this.no + "'");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + "   onclick=\"opennewwin('modiContractInput.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',720,530,120,2)\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a> ");
                    } else if (this.state.equals("3")) { i5++;
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "' ");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + "   onclick=\"opennewwin('modiContractInput.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',720,530,120,2)\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a> ");
                    } else if (this.state.equals("4")) { i7++;
                      if (str17.indexOf("Y") >= 0) {
                        this.alertmess = (this.alertmess + "   <a href='#" + this.no + "' onclick=\"choose('" + str34 + "','" + this.Loft + "');ylroom(2,'" + str34 + "','" + this.Loft + "');\">");
                      }
                      this.alertmess += str34;
                      if (str17.indexOf("Y") >= 0) this.alertmess += " </a>"; 
                    }
                    else if (this.state.equals("6")) {
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "'");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + " onclick=\"opennewwin('ContractList.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=false',480,500,150,10)\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                    }
                    else if (this.state.equals("5")) { i8++;
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "'");
                      if (str17.indexOf("A") >= 0) {
                        this.alertmess = (this.alertmess + "  onclick=\"opennewwin('roomdata1.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=5',720,530,120,5)\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                    } else if (this.state.equals("7")) {
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "' onclick=\"opennewwin('show_rent_contract.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=5',680,530,120,5)\">" + str34 + "</a>");
                    } else {
                      this.alertmess += " &nbsp;";
                    }this.alertmess += "  </td>";
                  }
                }
                this.alertmess += " </tr>";
              }
              this.alertmess += " </td></tr></table>";
            }
          }
          this.alertmess += " </td></tr>";
          this.alertmess += " </table>";

          this.alertmess += " <script>";

          this.alertmess += "  function printT(){";
          this.alertmess += " pri.innerHTML=\"\";";
          this.alertmess += " print();";

          this.alertmess += "  }";
          this.alertmess += "  function opennewwin1(para,wh,hg,lf,tp) {";
          this.alertmess += " var newwin=window.open(\"rgList.jsp?\"+para,\"newwin1\",\"toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,width=480,height=500,left=150,top=10\");";
          this.alertmess += "  }";

          this.alertmess = (this.alertmess + "  wy" + i + ".innerHTML = \"" + i3 + "\";");
          this.alertmess = (this.alertmess + " w1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i3)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + " ry" + i + ".innerHTML = \"" + i4 + "\";");
          this.alertmess = (this.alertmess + " r1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i4)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + "sy" + i + ".innerHTML = \"" + i5 + "\";");
          this.alertmess = (this.alertmess + "s1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i5)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + "yy" + i + ".innerHTML = \"" + i7 + "\";");
          this.alertmess = (this.alertmess + "y1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i7)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + "ly" + i + ".innerHTML = \"" + i8 + "\";");
          this.alertmess = (this.alertmess + " l1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i8)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");

          int i10 = i8 + i3 + i7 + i5 + i4 + i6;
          this.alertmess = (this.alertmess + " sum" + i + ".innerHTML = '合计：" + i10 + "';");
          this.alertmess += "</script>";
          this.alertmess += "  </td>";
        }
      }
      this.alertmess += "</tr></table>";
    } catch (Exception localException1) {
      System.out.println(localException1);
    }return this.alertmess;
  }

  public String BeanCodeShow2(String paramString1, String paramString2)
  {
    try
    {
      this.alertmess = "";
      this.condi = paramString2;
      int i = 0;
      asicc localasicc = new asicc();
      FormatData localFormatData = new FormatData();
      this.alertmess += "<table border=\"0\"  width=\"100%\"><tr>";
      String str1 = "select Loft FROM sectiontree where SerialNo='" + this.strSection + "'";

      if (!this.Loft.equals("")) str1 = str1 + " and Loft in (" + this.Loft + ") ";
      str1 = str1 + "group by Loft";
      ResultSet localResultSet1 = null;
      SDatabase localSDatabase1 = new SDatabase();
      SDatabase localSDatabase2 = new SDatabase();
      localResultSet1 = localSDatabase1.executeQuery(str1);
      if (!this.Loft.equals("")) {
        while (localResultSet1.next()) {
          i++;
          this.alertmess += "<td valign='top'>";
          this.Loft = localResultSet1.getString("Loft");
          String str2 = "";
          if (!this.Loft.equals("")) str2 = " and loft='" + this.Loft + "'";

          String str3 = "select lockroom from lockroom where section ='" + this.strSection + "' and ";
          str3 = str3 + " loft='" + this.Loft + "'";
          ResultSet localResultSet2 = null;
          Object localObject1 = "";
          Object localObject2 = "";
          LinkedList localLinkedList1 = new LinkedList();
          try {
            localResultSet2 = localSDatabase2.executeQuery(str3);
            while (localResultSet2.next()) {
              String str4 = localResultSet2.getString("LockRoom");
              if (((String)localObject1).equals("")) localObject1 = str4; else
                localObject1 = (String)localObject1 + "," + str4;
              char c1 = str4.charAt(0);
              if (!Character.isDigit(c1)) {
                str4 = String.valueOf(Character.getNumericValue(c1) - 9);
              }
              localLinkedList1.add(str4);
              if (((String)localObject2).equals(""))
                localObject2 = str4;
              else
                localObject2 = (String)localObject2 + "," + str4;
            }
            localResultSet2.close(); } catch (Exception localException2) {
          }
          this.sql = "select floor from";
          this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
          this.sql = (this.sql + "  and Region='" + this.Loft + "' and floor=0");
          ResultSet localResultSet3 = localSDatabase2.executeQuery(this.sql);
          char c1 = '\001';
          int j = 1;
          if (localResultSet3.next()) {
        	  j = localResultSet3.getInt("floor");
          }
          localResultSet3.close();
          this.sql = "select min(Floor) as BeginF,max(Floor) as EndF,";
          this.sql += "min(Room) as BeginR,max(Room) as EndR,max(cell) as Ecell ,min(cell) as Scell from";
          this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
          this.sql = (this.sql + "  and Region='" + this.Loft + "'");
          localResultSet3 = localSDatabase2.executeQuery(this.sql);
          int k = 0;
          int m = 0;
          int str5 = 0;
          int str6 = 0;
          int n = 0;
          String str7 = "";
          String str8 = "";
          String str9 = "";
          if (localResultSet3.next()) {
            k = localResultSet3.getInt("BeginF");

            m = localResultSet3.getInt("EndF");
            str5 = localResultSet3.getInt("BeginR");
            str6 = localResultSet3.getInt("EndR");
            str7 = getbyte(localResultSet3.getString("Ecell"));
            str8 = getbyte(localResultSet3.getString("Scell"));
            if ((str8.equals("")) && (str7.equals(""))) { str7 = " "; str8 = " "; }
          }
          localResultSet3.close();
          int i1 = 0; int i2 = 0;
          char c2 = str8.charAt(0);
          char c3 = str7.charAt(0);
          if ((!str8.equals("")) && (!str7.equals(""))) {
            c2 = str8.charAt(0);
            c3 = str7.charAt(0);
            if (Character.isDigit(c2)) {
              i1 = Integer.parseInt(str8);
              i2 = Integer.parseInt(str7);
            } else {
              i1 = Character.getNumericValue(c2) - 9;
              i2 = Character.getNumericValue(c3) - 9;
            }
          }
          if (i1 < 0) i1 = 0;
          if (i2 < 0) i2 = 0;
          String str10 = "";
          localResultSet3 = localSDatabase2.executeQuery("select roomtype from LoftBuildCode where SecNo='" + this.strSection + "' and Loft='" + this.Loft + "' and roomtype=1");
          if (localResultSet3.next()) {
            str10 = "1";
          }
          localResultSet3.close();

          this.alertmess = (this.alertmess + " <input type=hidden name=SecNo value=\"" + this.strSection + "\">");
          this.alertmess = (this.alertmess + "<input type=hidden name=SecName value=\"" + this.SecName + "\">");
          this.alertmess = (this.alertmess + "<input type=hidden name=Loft value=\"" + this.Loft + "\">");
          this.alertmess += "<input type=hidden name=Build value=\"\">";
          this.alertmess += "<input type=hidden name=cusname value=\"\">";
          this.alertmess += "<input type=hidden name=secname value=\"\">";
          String str11 = "#00CCFF";
          String str12 = "#E5C862";
          String str13 = "#8DE4A6";
          String str14 = "#AACC6F";
          String str15 = "#FF00FF";
          String str16 = "#DDE8E8";
          if (!this.strSection.equals("")) {
            String str17 = "select  *  from SaleStateColor WHERE secno='" + this.strSection + "'";

            ResultSet localResultSet4 = localSDatabase2.executeQuery(str17);
            if (localResultSet4.next()) {
              str11 = localResultSet4.getString("RG");
              str12 = localResultSet4.getString("QY");
              str15 = localResultSet4.getString("ld");
              str14 = localResultSet4.getString("CZ");
              str13 = localResultSet4.getString("YL");
              str16 = localResultSet4.getString("ws");
            }

            localResultSet4.close();
          }
          if (str11.equals("")) {
            this.alertmess += "<script>";
            this.alertmess += "alert(\"还没有设置为销控表设置状态色块,请在系统管理中设置\");";

            this.alertmess += "</script>";
          }

          String str17 = paramString1;
          if (str17 == null) str17 = "";

          this.alertmess += " <p CLASS=FontColor align=\"center\"><b><font size=\"3\" >";

          if (!this.SecName.equals(this.Loft)) this.alertmess += this.SecName; this.alertmess = (this.alertmess + this.Loft + " 销控表</font></b></p>");
          this.alertmess += " <table width=\"98%\" border=\"0\"  align=\"center\" CELLSPACING=1 CELLPADDING=3>";

          this.alertmess = (this.alertmess + "<td bgcolor='" + str16 + "'  align=\"center\">未售</td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str11 + "'  align=\"center\">认购<img src='../images/mypw.gif' border='0' ></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str12 + "'  align=\"center\">签约<img src='../images/maIcon.gif' border='0' ></td>");
          this.alertmess = (this.alertmess + "\t<td bgcolor='" + str13 + "'  align=\"center\">");
          if (str17.indexOf("Y") >= 0) this.alertmess = (this.alertmess + "<a href=\"#\" onclick=\"ylroom(1,'','" + this.Loft + "');return false;\" title=\"选择预留房间后点击[预留]\" >预留</a>"); else
            this.alertmess += "预留";
          this.alertmess += "<img src='../images/day2.gif' border='0' ></td>";
          this.alertmess = (this.alertmess + "<td bgcolor='" + str15 + "'  align=\"center\">临定<img src='../images/face39.gif' border='0' ></td>");
          this.alertmess += "<td   align=\"center\">";
          this.alertmess += " </td>";
          this.alertmess += "</tr>";
          this.alertmess = (this.alertmess + " <tr><td bgcolor='" + str16 + "' align=\"center\"><div id=wy" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str11 + "'  align=\"center\"><div id=ry" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str12 + "'  align=\"center\"><div id=sy" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str13 + "'  align=\"center\"><div id=yy" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str15 + "' align=\"center\"><div id=ly" + i + "></div></td>");

          this.alertmess = (this.alertmess + "  <td   align=\"center\"><div id=sum" + i + "> </div>");
          this.alertmess += " </td>";
          this.alertmess += " \t</tr>";
          this.alertmess = (this.alertmess + "  <tr><td bgcolor='" + str16 + "' align=\"center\"><div id=w1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str11 + "'  align=\"center\"><div id=r1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str12 + "'  align=\"center\"><div id=s1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str13 + "'  align=\"center\"><div id=y1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str15 + "'  align=\"center\"><div id=l1" + i + "></div></td>");

          this.alertmess += " </td>";
          this.alertmess += " <td   align=\"center\"> ";
          this.alertmess += " </td>";
          this.alertmess += " </tr>";
          this.alertmess += " </table>";

          int i3 = 0;
          int i4 = 0;
          int i5 = 0;
          int i6 = 0;
          int i7 = 0;
          int i8 = 0;

          String str18 = "";
          if (str18 == null) str18 = "";

          String str19 = "ABCDEFGHIJKLOPQRST";
          str19 = str19.trim();
          int i9 = 0;
          String str20 = "";
          String str21 = "select top 1 Room_code from Room where seccode=";
          str21 = str21 + "'" + this.strSection + "' and Building='";
          str21 = str21 + this.strBuilding + "' and loft='" + this.Loft + "'  ";
          ResultSet localResultSet5 = localSDatabase2.executeQuery(str21);
          if (localResultSet5.next()) str20 = localResultSet5.getString("Room_code");
          localResultSet5.close();

          if (str20.equals(""))
          {
            this.alertmess += " <script>";

            this.alertmess += " </script>";
          }
          else {
            this.alertmess += " <script>";
            this.alertmess += " function px(para){";
            this.alertmess += " if (para==\"asc\")document.frm.action=\"RoomCodeShowS.jsp\";";
            this.alertmess += " else document.frm.action=\"RoomCodeShowDS.jsp\";";
            this.alertmess += "  document.frm.submit();";
            this.alertmess += "  }";

            this.alertmess += " </script>";
            this.alertmess += " <table width=\"100%\" align=\"center\" border=\"0\" CELLSPACING=0 CELLPADDING=0>";
            this.alertmess += " <tr valign=\"top\">";
            for (int i10 = i1; i10 <= i2; i10++) {
              if (i1 > 0) {
                str9 = localasicc.AsiicZH(i10, c2);
              }

              LinkedList localLinkedList2 = new LinkedList();
              LinkedList localLinkedList3 = new LinkedList();
              LinkedList localLinkedList4 = new LinkedList();
              LinkedList localLinkedList5 = new LinkedList();
              LinkedList localLinkedList6 = new LinkedList();
              LinkedList localLinkedList7 = new LinkedList();
              LinkedList localLinkedList8 = new LinkedList();
              LinkedList localLinkedList9 = new LinkedList();
              LinkedList localLinkedList10 = new LinkedList();
              LinkedList localLinkedList11 = new LinkedList();
              LinkedList localLinkedList12 = new LinkedList();
              LinkedList localLinkedList13 = new LinkedList();
              String str22 = ""; String str23 = "";
              String str24 = "";
              String str25 = "";
              String str26 = "";
              String str27 = "";
              String str28 = "ABCDEFGHIJKLOPQRST";

              String str29 = "";
              String str30 = "select   a.room_type,a.dis, a.tddate,a.Room_code,a.saleState,a.Floor,a.Room,a.area,a.code,a.sumprice,a.floorshow,a.floortype,a.floormess,b.showfloors from roomstateview a,roomno b where a.seccode+a.loft+a.room_code= b.SectionNo+b.region+b.roomno and a.seccode=";
              str30 = str30 + "'" + this.strSection + "'";
              str30 = str30 + str2 + " and  a.cell='" + str9 + "' and a.floortype=0   order by a.Floor";
              ResultSet localResultSet6 = localSDatabase2.executeQuery(str30);

              int i11 = 0;
              while (localResultSet6.next()) {
                str29 = localResultSet6.getString("room_type");
                localLinkedList8.add(localResultSet6.getString("Room_code"));
                localLinkedList3.add(localResultSet6.getString("SaleState"));
                String str31 = localResultSet6.getString("Floor");
                String str32 = localResultSet6.getString("Room");
                str22 = localResultSet6.getString("floorshow");
                str24 = localResultSet6.getString("floortype");
                localLinkedList4.add(str31);
                localLinkedList5.add(str32);
                if (Integer.parseInt(str32) >= 10)
                  localLinkedList2.add(str9 + str31 + str32);
                else {
                  localLinkedList2.add(str9 + str31 + "0" + str32);
                }
                localLinkedList6.add(getbyte1(localResultSet6.getString("area")));
                localLinkedList7.add(localResultSet6.getString("code"));
                localLinkedList9.add(getbyte1(localResultSet6.getString("floormess")));
                localLinkedList10.add(getbyte1(localResultSet6.getString("showfloors")));
                localLinkedList11.add(localResultSet6.getString("dis"));
                localLinkedList12.add(getbyte1(localResultSet6.getString("tddate")));
                localLinkedList13.add(getbyte1(localResultSet6.getString("sumprice")));
              }
              localResultSet6.close();
              int i12 = 0;
              System.out.println("ok");
              this.alertmess += " <td align=\"center\" valign=\"top\">";
              if (!str9.equals("")) this.alertmess = (this.alertmess + str9 + "单元");
              this.alertmess += " <table border=\"0\" width=\"100%\" CELLSPACING=1 CELLPADDING=0>";
              String str33ZH ;
              if (str29.indexOf("墅") < 0) {
                this.alertmess += "  <tr>";
                this.alertmess += "   <td  width=\"1%\" bgcolor=\"#800000\" align=\"center\"><img src=\"../images/1.gif\" border=\"0\"></td>";

                char i13 = str20.charAt(0);
                str20 = str20.substring(str20.length() - 1);

                char c4 = str20.charAt(0);
                for (int i14 = str5; i14 <= str6; i14++) {
                	str33ZH = "";
                	str33ZH = localasicc.AsiicZH(i14, c4);

                  if ((((String)localObject2).indexOf(String.valueOf(i14)) >= 0) || (str19.indexOf((String)localObject2) >= 0)) {
                    if (str19.indexOf((String)localObject2) >= 0)
                    {
                      if (((String)localObject2).indexOf(String.valueOf(i14)) < 0)
                      {
                        this.alertmess += "<td align=\"center\" class=listtitle ";
                        if (str17.indexOf("Y") >= 0) this.alertmess += "   colspan=\"2\"";
                        this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33ZH + "</font></td>");
                      }
                    } else if (!localLinkedList1.contains(String.valueOf(i14)))
                    {
                      this.alertmess += "  <td align=\"center\" class=listtitle ";
                      if (str17.indexOf("Y") >= 0) this.alertmess += "   colspan='2'";
                      this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33ZH + "</font></td>");
                    }
                  }
                  else
                  {
                    this.alertmess += "  <td align=\"center\" class=listtitle ";
                    if (str17.indexOf("Y") >= 0) this.alertmess += "  colspan='2'";
                    this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33ZH + "</font></td>");
                  }

                }

                this.alertmess += "  </tr>";
              }
              this.alertmess += "  <tr>";
              float f1;
              float f2;
              String str34;
              String str37;
              for (int i13 = k; i13 <= m; i13++) {
                if (str29.indexOf("墅") < 0)
                  this.alertmess = (this.alertmess + "  <td align=\"center\" class=FloorC width=\"1%\"><font color=\"#ffffff\"><div id=A" + String.valueOf(Math.abs(i13)) + 1 + "w1>" + i13 + "</div></font></td>");
                else {
                  this.alertmess = (this.alertmess + " <div style='display:none' id=A" + String.valueOf(Math.abs(i13)) + 1 + "w1>" + i13 + "</div>");
                }
                f1 = 0.0F;
                f2 = 0.0F;
                for (int str33 = str5; str33 <= str6; str33++) {
                  if (!localLinkedList1.contains(String.valueOf(str33))) {
                    this.no = "";
                    str34 = "";
                    this.no = "";
                    String str35 = "0"; str37 = "";
                    if (str33 >= 10)
                      str34 = str9 + String.valueOf(i13) + String.valueOf(str33);
                    else
                      str34 = str9 + String.valueOf(i13) + "0" + String.valueOf(str33);
                    i12++;

                    if (localLinkedList2.contains(str34)) {
                      int i16 = localLinkedList2.indexOf(str34);
                      this.state = getbyte((String)localLinkedList3.get(i16));

                      str34 = (String)localLinkedList8.get(i16);
                      str25 = (String)localLinkedList9.get(i16);
                      str23 = (String)localLinkedList10.get(i16);
                      if (!this.state.equals("1"))
                        try {
                          str26 = (String)localLinkedList7.get(i16);
                          str27 = (String)localLinkedList6.get(i16);
                          String str39 = (String)localLinkedList13.get(i16);
                          if ((str26.equals("")) || (str26 == null)) str26 = "0";
                          if ((str27.equals("")) || (str27 == null)) str27 = "0";
                          if ((str39.equals("")) || (str39 == null)) str39 = "0";
                          f1 += Float.parseFloat(str39);
                          f2 += Float.parseFloat(str27); } catch (Exception localException4) {
                        }
                    } else {
                      this.state = "";
                    }String str38 = "";
                    if (((i13 != 3) || (str33 != 4)) || 
                      (this.state.equals("1"))) str38 = "BGCOLOR='" + str16 + "'";
                    else if (this.state.equals("2")) str38 = "bgcolor='" + str11 + "'";
                    else if (this.state.equals("3")) str38 = "bgcolor='" + str12 + "'";
                    else if (this.state.equals("4")) str38 = "bgcolor='" + str13 + "'";
                    else if (this.state.equals("5")) str38 = "bgcolor='" + str15 + "'";

                    this.no = str34;

                    if (this.condi.equals("wen")) {
                      str38 = "BGCOLOR='" + str16 + "'";
                      if (this.state.equals("3")) str34 = "已售" + this.no;
                      else if (this.state.equals("2")) str34 = "已认购" + this.no;
                      else if (this.state.equals("4")) str34 = "已预留" + this.no;
                      else if (this.state.equals("1")) str34 = "未售" + this.no;
                      else if (this.state.equals("5")) str34 = "临定" + this.no;
                      else if (this.state.equals("7")) str34 = "出租" + this.no; 
                    }
                    else if (this.condi.equals("pic")) {
                      str38 = "BGCOLOR='" + str16 + "'";
                      if (this.state.equals("2")) str34 = this.no + "<img src='../images/mypw.gif' border='0' >";
                      else if (this.state.equals("3")) str34 = this.no + "<img src='../images/maIcon.gif' border='0' >";
                      else if (this.state.equals("1")) str34 = this.no + "&nbsp;&nbsp;";
                      else if (this.state.equals("5")) str34 = this.no + "<img src='../images/day2.gif' border='0' >";
                      else if (this.state.equals("2")) str34 = this.no;
                      else if (this.state.equals("4")) str34 = this.no + "<img src='../images/face39.gif' border='0' >";
                      else if (this.state.equals("6")) str34 = this.no;
                      else if (this.state.equals("7")) str34 = this.no;
                    }
                    else if (this.state.equals("2")) { str34 = this.no;
                    } else if (this.state.equals("3")) { str34 = this.no;
                    } else if (this.state.equals("1")) { str34 = this.no;
                    } else if (this.state.equals("5")) { str34 = this.no;
                    } else if (this.state.equals("2")) { str34 = this.no;
                    } else if (this.state.equals("4")) { str34 = this.no;
                    } else if (this.state.equals("6")) { str34 = this.no; }


                    if (!str37.equals("")) str37 = str37.substring(0, 10);

                    if (str17.indexOf("Y") >= 0) {
                      this.alertmess += "  <td align=\"center\" width=\"1%\">";
                      if ((str17.indexOf("Y") >= 0) && (!this.state.equals("2")) && (!this.state.equals("3")) && (!this.state.equals(""))) {
                        this.alertmess = (this.alertmess + "   <input type=checkbox name=yl ylloft='" + this.Loft + "' value='" + this.no + "'>");
                      }
                      this.alertmess += "  </td>";
                    }
                    this.alertmess = (this.alertmess + "  <td align=\"center\" width=\"5%\"  " + str38);
                    if (str35.equals("1")) this.alertmess = (this.alertmess + "  title='锁定日期:" + str37 + "'");

                    this.alertmess += "  >";
                    if (str10.equals("")) {
                      if ((this.state.equals("1")) && (str35.equals("0"))) { i3++;
                        if (str17.indexOf("A") >= 0) {
                          this.alertmess = (this.alertmess + " <a href='#" + this.no + "' onclick=\"opennewwin('roomdata.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=1',720,530,120,5)\">");
                        }
                        this.alertmess += str34;
                        if (str17.indexOf("A") >= 0)
                          this.alertmess += "</a>";
                      }
                      else if ((this.state.equals("1")) && (str35.equals("1"))) {
                        this.alertmess = (this.alertmess + " <a href=\"#\"> " + str34 + "[锁定] </a>");
                      } else if (this.state.equals("3")) { i5++;

                        this.alertmess = (this.alertmess + " " + str34 + "</a>");
                      }
                      else if (this.state.equals("2")) { i4++;
                        this.alertmess = (this.alertmess + "<a href='#" + this.no + "'");
                        if (str17.indexOf("E") >= 0) {
                          this.alertmess = (this.alertmess + " onclick=\"opennewwin('modiorder.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',750,530,120,2)\"");
                        }
                        this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                      } else if (this.state.equals("4")) { i7++;
                        if (str17.indexOf("Y") >= 0) {
                          this.alertmess = (this.alertmess + "<a href='#" + this.no + "' onclick=\"choose('" + str34 + "','" + this.Loft + "');ylroom(2,'" + str34 + "','" + this.Loft + "');\">");
                        }
                        this.alertmess += str34;
                        if (str17.indexOf("A") >= 0)
                          this.alertmess += "</a>";
                      }
                      else if (this.state.equals("6")) {
                        this.alertmess = (this.alertmess + " <a href='#" + this.no + "' ");
                        if (str17.indexOf("E") >= 0) {
                          this.alertmess = (this.alertmess + " onclick=\"opennewwin('ContractList.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=false',480,500,150,10)\"");
                        }
                        this.alertmess = (this.alertmess + ">" + str34 + "</a>");
                      } else if (this.state.equals("5")) { i8++;
                        this.alertmess = (this.alertmess + "<a href='#" + this.no + "' ");
                        if (str17.indexOf("A") >= 0) {
                          this.alertmess = (this.alertmess + " onclick=\"opennewwin('roomdata1.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=5',720,530,120,5)\"");
                        }
                        this.alertmess = (this.alertmess + ">" + str34 + "</a>");
                      } else if (this.state.equals("7")) {
                        this.alertmess = (this.alertmess + "<a href='#" + this.no + "' onclick=\"opennewwin('show_rent_contract.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=5',720,530,120,5)\">" + str34 + "</a>"); } else {
                        this.alertmess += "&nbsp;";
                      } } else if ((this.state.equals("1")) && (!str35.equals("1"))) { i3++;
                      if (str17.indexOf("A") >= 0) {
                        this.alertmess = (this.alertmess + " <a href='#" + this.no + "' onclick=\"opennewwin('roomdata.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=1',720,530,120,5)\">");
                      }
                      this.alertmess += str34;
                      if (str17.indexOf("A") >= 0)
                        this.alertmess += " </a>";
                    } else if (this.state.equals("2")) { i4++;
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "'");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + "  onclick=\"opennewwin('ContractInput2.jsp','?roomcode=" + str26 + "&secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',750,530,120,2);\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a> ");
                    }
                    else if (this.state.equals("3")) { i5++;
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "'  ");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + "  onclick=\"opennewwin('ContractInput2.jsp','?roomcode=" + str26 + "&secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',750,530,120,2);\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                    }
                    this.alertmess += " </td> ";
                  }

                }

                this.alertmess = (this.alertmess + "  <script>A" + String.valueOf(Math.abs(i13)) + 1 + "w1.innerHTML=\"");
                if (!str25.equals("")) this.alertmess = (this.alertmess + String.valueOf(i13) + str25); else
                  this.alertmess += i13;
                this.alertmess += "\" ;</script>";

                this.alertmess += " </tr>";
              }

              for (int i13 = n; i13 <= -1; i13++)
              {

                this.alertmess += " <tr> ";
                f1 = 0.0F;
                f2 = 0.0F;
                for (int str33 = str5; str33 <= str6; str33++) {
                  if (!localLinkedList1.contains(String.valueOf(str33))) {
                    this.no = "";
                    str34 = "";
                    this.no = "";
                    if (str33 >= 10)
                      str34 = str9 + String.valueOf(i13) + String.valueOf(str33);
                    else
                      str34 = str9 + String.valueOf(i13) + "0" + String.valueOf(str33);
                    i12++;

                    if (localLinkedList2.contains(str34)) {
                      int i15 = localLinkedList2.indexOf(str34);
                      this.state = ((String)localLinkedList3.get(i15));
                      str34 = (String)localLinkedList8.get(i15);
                      str25 = (String)localLinkedList9.get(i15);
                      str23 = (String)localLinkedList10.get(i15);
                      if (!this.state.equals("1"))
                        try {
                          str26 = (String)localLinkedList7.get(i15);
                          str27 = (String)localLinkedList6.get(i15);
                          str37 = (String)localLinkedList13.get(i15);
                          if ((str26.equals("")) || (str26 == null)) str26 = "0";
                          if ((str27.equals("")) || (str27 == null)) str27 = "0";
                          if ((str37.equals("")) || (str37 == null)) str37 = "0";

                          f1 += Float.parseFloat(str37);
                          f2 += Float.parseFloat(str27); } catch (Exception localException3) {
                        }
                    } else {
                      this.state = "";
                    }String str36 = "";
                    if (((i13 != 3) || (str33 != 4)) || 
                      (this.state.equals("1"))) str36 = "BGCOLOR='#DDE8E8'";
                    if (this.state.equals("2")) str36 = "bgcolor='#00CCFF'";
                    if (this.state.equals("3")) str36 = "bgcolor='#E5C862'";
                    if (this.state.equals("4")) str36 = "bgcolor='#8DE4A6'";
                    if (this.state.equals("5")) str36 = "bgcolor='#FF00FF'";
                    if (this.state.equals("6")) str36 = "bgcolor='#AACC6F'";
                    if (this.state.equals("7")) { str36 = "bgcolor='#AACC6F'"; i6++; }
                    this.no = str34;

                    if (this.condi.equals("wen")) {
                      str36 = "bgcolor='#c0c0c0'";
                      if (this.state.equals("3")) str34 = "已售" + this.no;
                      else if (this.state.equals("2")) str34 = "已认购" + this.no;
                      else if (this.state.equals("4")) str34 = "已预留" + this.no;
                      else if (this.state.equals("1")) str34 = "未售" + this.no;
                      else if (this.state.equals("5")) str34 = "临定" + this.no;
                      else if (this.state.equals("7")) str34 = "出租" + this.no; 
                    }
                    else if (this.condi.equals("pic")) {
                      str36 = "bgcolor='#c0c0c0'";
                      if (this.state.equals("2")) str34 = this.no + "<img src='../images/mypw.gif' border='0'>";
                      else if (this.state.equals("3")) str34 = this.no + "<img src='../images/maIcon.gif' border='0'>";
                      else if (this.state.equals("1")) str34 = this.no + "&nbsp;&nbsp;";
                      else if (this.state.equals("5")) str34 = this.no + "<img src='../images/day2.gif' border='0'>";
                      else if (this.state.equals("2")) str34 = this.no;
                      else if (this.state.equals("4")) str34 = this.no + "<img src='../images/face39.gif'  border='0'>";
                      else if (this.state.equals("6")) str34 = this.no;
                      else if (this.state.equals("7")) str34 = this.no;
                    }
                    else if (this.state.equals("2")) { str34 = this.no;
                    } else if (this.state.equals("3")) { str34 = this.no;
                    } else if (this.state.equals("1")) { str34 = this.no;
                    } else if (this.state.equals("5")) { str34 = this.no;
                    } else if (this.state.equals("2")) { str34 = this.no;
                    } else if (this.state.equals("4")) { str34 = this.no;
                    } else if (this.state.equals("6")) { str34 = this.no; }


                    if (str17.indexOf("Y") >= 0) {
                      this.alertmess += " <td align=\"center\" width=\"1%\">";
                      if ((str17.indexOf("Y") >= 0) && (!this.state.equals("2")) && (!this.state.equals("3")) && (!this.state.equals(""))) {
                        this.alertmess = (this.alertmess + "  <input type=checkbox name=yl ylloft=" + this.Loft + " value=" + this.no + ">");
                      }
                      this.alertmess += " </td>";
                    }
                    this.alertmess = (this.alertmess + " <td align=\"center\" width=\"5%\"  " + str36 + ">");
                    if (this.state.equals("1")) { i3++;
                      if (str17.indexOf("A") >= 0) {
                        this.alertmess = (this.alertmess + " <a href='#" + this.no + "' onclick=\"opennewwin('roomdata.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=1',720,530,120,5)\">");
                      }
                      this.alertmess += str34;
                      if (str17.indexOf("A") >= 0) this.alertmess += " </a>"; 
                    }
                    else if (this.state.equals("2")) { i4++;
                      this.alertmess = (this.alertmess + "  <a href='#" + this.no + "'");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + "   onclick=\"opennewwin('modiContractInput.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',720,530,120,2)\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a> ");
                    } else if (this.state.equals("3")) { i5++;

                      this.alertmess = (this.alertmess + " " + str34 + "</a> ");
                    } else if (this.state.equals("4")) { i7++;
                      if (str17.indexOf("Y") >= 0) {
                        this.alertmess = (this.alertmess + "   <a href='#" + this.no + "' onclick=\"choose('" + str34 + "','" + this.Loft + "');ylroom(2,'" + str34 + "','" + this.Loft + "');\">");
                      }
                      this.alertmess += str34;
                      if (str17.indexOf("Y") >= 0) this.alertmess += " </a>"; 
                    }
                    else if (this.state.equals("6")) {
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "'");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + " onclick=\"opennewwin('ContractList.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=false',480,500,150,10)\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                    }
                    else if (this.state.equals("5")) { i8++;
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "'");
                      if (str17.indexOf("A") >= 0) {
                        this.alertmess = (this.alertmess + "  onclick=\"opennewwin('roomdata1.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=5',720,530,120,5)\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                    } else if (this.state.equals("7")) {
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "' onclick=\"opennewwin('show_rent_contract.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=5',680,530,120,5)\">" + str34 + "</a>");
                    } else {
                      this.alertmess += " &nbsp;";
                    }this.alertmess += "  </td>";
                  }
                }
                this.alertmess += " </tr>";
              }
              this.alertmess += " </td></tr></table>";
            }
          }
          this.alertmess += " </td></tr>";
          this.alertmess += " </table>";

          this.alertmess += " <script>";

          this.alertmess += "  function printT(){";
          this.alertmess += " pri.innerHTML=\"\";";
          this.alertmess += " print();";

          this.alertmess += "  }";
          this.alertmess += "  function opennewwin1(para,wh,hg,lf,tp) {";
          this.alertmess += " var newwin=window.open(\"rgList.jsp?\"+para,\"newwin1\",\"toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,width=480,height=500,left=150,top=10\");";
          this.alertmess += "  }";

          this.alertmess = (this.alertmess + "  wy" + i + ".innerHTML = \"" + i3 + "\";");
          this.alertmess = (this.alertmess + " w1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i3)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + " ry" + i + ".innerHTML = \"" + i4 + "\";");
          this.alertmess = (this.alertmess + " r1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i4)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + "sy" + i + ".innerHTML = \"" + i5 + "\";");
          this.alertmess = (this.alertmess + "s1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i5)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + "yy" + i + ".innerHTML = \"" + i7 + "\";");
          this.alertmess = (this.alertmess + "y1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i7)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + "ly" + i + ".innerHTML = \"" + i8 + "\";");
          this.alertmess = (this.alertmess + " l1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i8)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");

          int i10 = i8 + i3 + i7 + i5 + i4 + i6;
          this.alertmess = (this.alertmess + " sum" + i + ".innerHTML = '合计：" + i10 + "';");
          this.alertmess += "</script>";
          this.alertmess += "  </td>";
        }
      }
      this.alertmess += "</tr></table>";
    } catch (Exception localException1) {
    	logger.error(localException1.getLocalizedMessage(),localException1);
    }return this.alertmess;
  }

  public String BeanCodeShow3(String paramString1, String paramString2)
  {
    try
    {
      this.alertmess = "";
      this.condi = paramString2;
      int i = 0;
      asicc localasicc = new asicc();
      FormatData localFormatData = new FormatData();
      this.alertmess += "<table border=\"0\"  width=\"100%\"><tr>";
      String str1 = "select Loft FROM sectiontree where SerialNo='" + this.strSection + "'";

      if (!this.Loft.equals("")) str1 = str1 + " and Loft in (" + this.Loft + ") ";
      str1 = str1 + "group by Loft";
      ResultSet localResultSet1 = null;
      SDatabase localSDatabase1 = new SDatabase();
      SDatabase localSDatabase2 = new SDatabase();
      localResultSet1 = localSDatabase1.executeQuery(str1);
      if (!this.Loft.equals("")) {
        while (localResultSet1.next()) {
          i++;
          this.alertmess += "<td valign='top'>";
          this.Loft = localResultSet1.getString("Loft");
          String str2 = "";
          if (!this.Loft.equals("")) str2 = " and loft='" + this.Loft + "'";

          String str3 = "select lockroom from lockroom where section ='" + this.strSection + "' and ";
          str3 = str3 + " loft='" + this.Loft + "'";
          ResultSet localResultSet2 = null;
          Object localObject1 = "";
          Object localObject2 = "";
          LinkedList localLinkedList1 = new LinkedList();
          try {
            localResultSet2 = localSDatabase2.executeQuery(str3);
            while (localResultSet2.next()) {
              String str4 = localResultSet2.getString("LockRoom");
              if (((String)localObject1).equals("")) localObject1 = str4; else
                localObject1 = (String)localObject1 + "," + str4;
              char c1 = str4.charAt(0);
              if (!Character.isDigit(c1)) {
                str4 = String.valueOf(Character.getNumericValue(c1) - 9);
              }
              localLinkedList1.add(str4);
              if (((String)localObject2).equals(""))
                localObject2 = str4;
              else
                localObject2 = (String)localObject2 + "," + str4;
            }
            localResultSet2.close(); } catch (Exception localException2) {
          }
          this.sql = "select floor from";
          this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
          this.sql = (this.sql + "  and Region='" + this.Loft + "' and floor=0");
          ResultSet localResultSet3 = localSDatabase2.executeQuery(this.sql);
          char c1 = '\001';
          if (localResultSet3.next()) { int j = localResultSet3.getInt("floor"); localResultSet3.close();}
          this.sql = "select min(Floor) as BeginF,max(Floor) as EndF,";
          this.sql += "min(Room) as BeginR,max(Room) as EndR,max(cell) as Ecell ,min(cell) as Scell from";
          this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
          this.sql = (this.sql + "  and Region='" + this.Loft + "'");
          localResultSet3 = localSDatabase2.executeQuery(this.sql);
          int k = 0;
          int m = 0;
          int str5 = 0;
          int str6 = 0;
          int n = 0;
          String str7 = "";
          String str8 = "";
          String str9 = "";
          if (localResultSet3.next()) {
            k = localResultSet3.getInt("BeginF");

            m = localResultSet3.getInt("EndF");
            str5 = localResultSet3.getInt("BeginR");
            str6 = localResultSet3.getInt("EndR");
            str7 = getbyte(localResultSet3.getString("Ecell"));
            str8 = getbyte(localResultSet3.getString("Scell"));
            if ((str8.equals("")) && (str7.equals(""))) { str7 = " "; str8 = " "; }
          }
          localResultSet3.close();
          int i1 = 0; int i2 = 0;
          char c2 = str8.charAt(0);
          char c3 = str7.charAt(0);
          if ((!str8.equals("")) && (!str7.equals(""))) {
            c2 = str8.charAt(0);
            c3 = str7.charAt(0);
            if (Character.isDigit(c2)) {
              i1 = Integer.parseInt(str8);
              i2 = Integer.parseInt(str7);
            } else {
              i1 = Character.getNumericValue(c2) - 9;
              i2 = Character.getNumericValue(c3) - 9;
            }
          }
          if (i1 < 0) i1 = 0;
          if (i2 < 0) i2 = 0;
          String str10 = "";
          localResultSet3 = localSDatabase2.executeQuery("select roomtype from LoftBuildCode where SecNo='" + this.strSection + "' and Loft='" + this.Loft + "' and roomtype=1");
          if (localResultSet3.next()) {
            str10 = "1";
          }
          localResultSet3.close();

          this.alertmess = (this.alertmess + " <input type=hidden name=SecNo value=\"" + this.strSection + "\">");
          this.alertmess = (this.alertmess + "<input type=hidden name=SecName value=\"" + this.SecName + "\">");
          this.alertmess = (this.alertmess + "<input type=hidden name=Loft value=\"" + this.Loft + "\">");
          this.alertmess += "<input type=hidden name=Build value=\"\">";
          this.alertmess += "<input type=hidden name=cusname value=\"\">";
          this.alertmess += "<input type=hidden name=secname value=\"\">";
          String str11 = "#00CCFF";
          String str12 = "#E5C862";
          String str13 = "#8DE4A6";
          String str14 = "#AACC6F";
          String str15 = "#FF00FF";
          String str16 = "#DDE8E8";
          if (!this.strSection.equals("")) {
            String str17 = "select  *  from SaleStateColor WHERE secno='" + this.strSection + "'";

            ResultSet localResultSet4 = localSDatabase2.executeQuery(str17);
            if (localResultSet4.next()) {
              str11 = localResultSet4.getString("RG");
              str12 = localResultSet4.getString("QY");
              str15 = localResultSet4.getString("ld");
              str14 = localResultSet4.getString("CZ");
              str13 = localResultSet4.getString("YL");
              str16 = localResultSet4.getString("ws");
            }

            localResultSet4.close();
          }
          if (str11.equals("")) {
            this.alertmess += "<script>";
            this.alertmess += "alert(\"还没有设置为销控表设置状态色块,请在系统管理中设置\");";

            this.alertmess += "</script>";
          }

          String str17 = paramString1;
          if (str17 == null) str17 = "";

          this.alertmess += " <p CLASS=FontColor align=\"center\"><b><font size=\"3\" >";

          if (!this.SecName.equals(this.Loft)) this.alertmess += this.SecName; this.alertmess = (this.alertmess + this.Loft + " 销控表</font></b></p>");
          this.alertmess += " <table width=\"98%\" border=\"0\"  align=\"center\" CELLSPACING=1 CELLPADDING=3>";

          this.alertmess = (this.alertmess + "<td bgcolor='" + str16 + "'  align=\"center\">未售</td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str11 + "'  align=\"center\">认购<img src='../images/mypw.gif' border='0' ></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str12 + "'  align=\"center\">签约<img src='../images/maIcon.gif' border='0' ></td>");
          this.alertmess = (this.alertmess + "\t<td bgcolor='" + str13 + "'  align=\"center\">");
          if (str17.indexOf("Y") >= 0) this.alertmess = (this.alertmess + "<a href=\"#\" onclick=\"ylroom(1,'','" + this.Loft + "');return false;\" title=\"选择预留房间后点击[预留]\" >预留</a>"); else
            this.alertmess += "预留";
          this.alertmess += "<img src='../images/day2.gif' border='0' ></td>";
          this.alertmess = (this.alertmess + "<td bgcolor='" + str15 + "'  align=\"center\">临定<img src='../images/face39.gif' border='0' ></td>");
          this.alertmess += "<td   align=\"center\">";
          this.alertmess += " </td>";
          this.alertmess += "</tr>";
          this.alertmess = (this.alertmess + " <tr><td bgcolor='" + str16 + "' align=\"center\"><div id=wy" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str11 + "'  align=\"center\"><div id=ry" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str12 + "'  align=\"center\"><div id=sy" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str13 + "'  align=\"center\"><div id=yy" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str15 + "' align=\"center\"><div id=ly" + i + "></div></td>");

          this.alertmess = (this.alertmess + "  <td   align=\"center\"><div id=sum" + i + "> </div>");
          this.alertmess += " </td>";
          this.alertmess += " \t</tr>";
          this.alertmess = (this.alertmess + "  <tr><td bgcolor='" + str16 + "' align=\"center\"><div id=w1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str11 + "'  align=\"center\"><div id=r1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str12 + "'  align=\"center\"><div id=s1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str13 + "'  align=\"center\"><div id=y1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str15 + "'  align=\"center\"><div id=l1" + i + "></div></td>");

          this.alertmess += " </td>";
          this.alertmess += " <td   align=\"center\"> ";
          this.alertmess += " </td>";
          this.alertmess += " </tr>";
          this.alertmess += " </table>";

          int i3 = 0;
          int i4 = 0;
          int i5 = 0;
          int i6 = 0;
          int i7 = 0;
          int i8 = 0;

          String str18 = "";
          if (str18 == null) str18 = "";

          String str19 = "ABCDEFGHIJKLOPQRST";
          str19 = str19.trim();
          int i9 = 0;
          String str20 = "";
          String str21 = "select top 1 Room_code from Room where seccode=";
          str21 = str21 + "'" + this.strSection + "' and Building='";
          str21 = str21 + this.strBuilding + "' and loft='" + this.Loft + "'  ";
          ResultSet localResultSet5 = localSDatabase2.executeQuery(str21);
          if (localResultSet5.next()) str20 = localResultSet5.getString("Room_code");
          localResultSet5.close();

          if (str20.equals(""))
          {
            this.alertmess += " <script>";

            this.alertmess += " </script>";
          }
          else {
            this.alertmess += " <script>";
            this.alertmess += " function px(para){";
            this.alertmess += " if (para==\"asc\")document.frm.action=\"RoomCodeShowS.jsp\";";
            this.alertmess += " else document.frm.action=\"RoomCodeShowDS.jsp\";";
            this.alertmess += "  document.frm.submit();";
            this.alertmess += "  }";

            this.alertmess += " </script>";
            this.alertmess += " <table width=\"100%\" align=\"center\" border=\"0\" CELLSPACING=0 CELLPADDING=0>";
            this.alertmess += " <tr valign=\"top\">";
            for (int i10 = i1; i10 <= i2; i10++) {
              if (i1 > 0) {
                str9 = localasicc.AsiicZH(i10, c2);
              }

              LinkedList localLinkedList2 = new LinkedList();
              LinkedList localLinkedList3 = new LinkedList();
              LinkedList localLinkedList4 = new LinkedList();
              LinkedList localLinkedList5 = new LinkedList();
              LinkedList localLinkedList6 = new LinkedList();
              LinkedList localLinkedList7 = new LinkedList();
              LinkedList localLinkedList8 = new LinkedList();
              LinkedList localLinkedList9 = new LinkedList();
              LinkedList localLinkedList10 = new LinkedList();
              LinkedList localLinkedList11 = new LinkedList();
              LinkedList localLinkedList12 = new LinkedList();
              LinkedList localLinkedList13 = new LinkedList();
              String str22 = ""; String str23 = "";
              String str24 = "";
              String str25 = "";
              String str26 = "";
              String str27 = "";
              String str28 = "ABCDEFGHIJKLOPQRST";

              String str29 = "";
              String str30 = "select   a.room_type,a.dis, a.tddate,a.Room_code,a.saleState,a.Floor,a.Room,a.area,a.code,a.sumprice,a.floorshow,a.floortype,a.floormess,b.showfloors from roomstateview a,roomno b where a.seccode+a.loft+a.room_code= b.SectionNo+b.region+b.roomno and a.seccode=";
              str30 = str30 + "'" + this.strSection + "'";
              str30 = str30 + str2 + " and  a.cell='" + str9 + "' and a.floortype=0   order by a.Floor";
              ResultSet localResultSet6 = localSDatabase2.executeQuery(str30);

              int i11 = 0;
              while (localResultSet6.next()) {
                str29 = localResultSet6.getString("room_type");
                localLinkedList8.add(localResultSet6.getString("Room_code"));
                localLinkedList3.add(localResultSet6.getString("SaleState"));
                String str31 = localResultSet6.getString("Floor");
                String str32 = localResultSet6.getString("Room");
                str22 = localResultSet6.getString("floorshow");
                str24 = localResultSet6.getString("floortype");
                localLinkedList4.add(str31);
                localLinkedList5.add(str32);
                if (Integer.parseInt(str32) >= 10)
                  localLinkedList2.add(str9 + str31 + str32);
                else {
                  localLinkedList2.add(str9 + str31 + "0" + str32);
                }
                localLinkedList6.add(getbyte1(localResultSet6.getString("area")));
                localLinkedList7.add(localResultSet6.getString("code"));
                localLinkedList9.add(getbyte1(localResultSet6.getString("floormess")));
                localLinkedList10.add(getbyte1(localResultSet6.getString("showfloors")));
                localLinkedList11.add(localResultSet6.getString("dis"));
                localLinkedList12.add(getbyte1(localResultSet6.getString("tddate")));
                localLinkedList13.add(getbyte1(localResultSet6.getString("sumprice")));
              }
              localResultSet6.close();
              int i12 = 0;
              System.out.println("ok");
              this.alertmess += " <td align=\"center\" valign=\"top\">";
              if (!str9.equals("")) this.alertmess = (this.alertmess + str9 + "单元");
              this.alertmess += " <table border=\"0\" width=\"100%\" CELLSPACING=1 CELLPADDING=0>";
              String str33ZH;
              if (str29.indexOf("墅") < 0) {
                this.alertmess += "  <tr>";
                this.alertmess += "   <td  width=\"1%\" bgcolor=\"#800000\" align=\"center\"><img src=\"../images/1.gif\" border=\"0\"></td>";

                char i13 = str20.charAt(0);
                str20 = str20.substring(str20.length() - 1);

                char c4 = str20.charAt(0);
                for (int i14 = str5; i14 <= str6; i14++) {
                	str33ZH = "";
                	str33ZH = localasicc.AsiicZH(i14, c4);

                  if ((((String)localObject2).indexOf(String.valueOf(i14)) >= 0) || (str19.indexOf((String)localObject2) >= 0)) {
                    if (str19.indexOf((String)localObject2) >= 0)
                    {
                      if (((String)localObject2).indexOf(String.valueOf(i14)) < 0)
                      {
                        this.alertmess += "<td align=\"center\" class=listtitle ";
                        if (str17.indexOf("Y") >= 0) this.alertmess += "   colspan=\"2\"";
                        this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33ZH + "</font></td>");
                      }
                    } else if (!localLinkedList1.contains(String.valueOf(i14)))
                    {
                      this.alertmess += "  <td align=\"center\" class=listtitle ";
                      if (str17.indexOf("Y") >= 0) this.alertmess += "   colspan='2'";
                      this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33ZH + "</font></td>");
                    }
                  }
                  else
                  {
                    this.alertmess += "  <td align=\"center\" class=listtitle ";
                    if (str17.indexOf("Y") >= 0) this.alertmess += "  colspan='2'";
                    this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33ZH + "</font></td>");
                  }

                }

                this.alertmess += "  </tr>";
              }
              this.alertmess += "  <tr>";
              float f1;
              float f2;
              String str34;
              String str37;
              for (int i13 = m; i13 >= k; i13--) {
                if (str29.indexOf("墅") < 0)
                  this.alertmess = (this.alertmess + "  <td align=\"center\" class=FloorC width=\"1%\"><font color=\"#ffffff\"><div id=A" + String.valueOf(Math.abs(i13)) + 1 + "w1>" + i13 + "</div></font></td>");
                else {
                  this.alertmess = (this.alertmess + " <div style='display:none' id=A" + String.valueOf(Math.abs(i13)) + 1 + "w1>" + i13 + "</div>");
                }
                f1 = 0.0F;
                f2 = 0.0F;
    
                for (int dddd = str5; dddd <= str6; dddd++) {
                  if (!localLinkedList1.contains(String.valueOf(dddd))) {
                    this.no = "";
                    str34 = "";
                    this.no = "";
                    String str35 = "0"; str37 = "";
                    if (dddd >= 10)
                      str34 = str9 + String.valueOf(i13) + String.valueOf(dddd);
                    else
                      str34 = str9 + String.valueOf(i13) + "0" + String.valueOf(dddd);
                    i12++;

                    if (localLinkedList2.contains(str34)) {
                      int i16 = localLinkedList2.indexOf(str34);
                      this.state = getbyte((String)localLinkedList3.get(i16));

                      str34 = (String)localLinkedList8.get(i16);
                      str25 = (String)localLinkedList9.get(i16);
                      str23 = (String)localLinkedList10.get(i16);
                      if (!this.state.equals("1"))
                        try {
                          str26 = (String)localLinkedList7.get(i16);
                          str27 = (String)localLinkedList6.get(i16);
                          String str39 = (String)localLinkedList13.get(i16);
                          if ((str26.equals("")) || (str26 == null)) str26 = "0";
                          if ((str27.equals("")) || (str27 == null)) str27 = "0";
                          if ((str39.equals("")) || (str39 == null)) str39 = "0";
                          f1 += Float.parseFloat(str39);
                          f2 += Float.parseFloat(str27); } catch (Exception localException4) {
                        }
                    } else {
                      this.state = "";
                    }String str38 = "";
                    if (((i13 != 3) || (dddd != 4)) || 
                      (this.state.equals("1"))) str38 = "BGCOLOR='" + str16 + "'";
                    else if (this.state.equals("2")) str38 = "bgcolor='" + str11 + "'";
                    else if (this.state.equals("3")) str38 = "bgcolor='" + str12 + "'";
                    else if (this.state.equals("4")) str38 = "bgcolor='" + str13 + "'";
                    else if (this.state.equals("5")) str38 = "bgcolor='" + str15 + "'";

                    this.no = str34;

                    if (this.condi.equals("wen")) {
                      str38 = "BGCOLOR='" + str16 + "'";
                      if (this.state.equals("3")) str34 = "已售" + this.no;
                      else if (this.state.equals("2")) str34 = "已认购" + this.no;
                      else if (this.state.equals("4")) str34 = "已预留" + this.no;
                      else if (this.state.equals("1")) str34 = "未售" + this.no;
                      else if (this.state.equals("5")) str34 = "临定" + this.no;
                      else if (this.state.equals("7")) str34 = "出租" + this.no; 
                    }
                    else if (this.condi.equals("pic")) {
                      str38 = "BGCOLOR='" + str16 + "'";
                      if (this.state.equals("2")) str34 = this.no + "<img src='../images/mypw.gif' border='0' >";
                      else if (this.state.equals("3")) str34 = this.no + "<img src='../images/maIcon.gif' border='0'  >";
                      else if (this.state.equals("1")) str34 = this.no + "&nbsp;&nbsp;";
                      else if (this.state.equals("5")) str34 = this.no + "<img src='../images/day2.gif' border='0' >";
                      else if (this.state.equals("2")) str34 = this.no;
                      else if (this.state.equals("4")) str34 = this.no + "<img src='../images/face39.gif' border='0' >";
                      else if (this.state.equals("6")) str34 = this.no;
                      else if (this.state.equals("7")) str34 = this.no;
                    }
                    else if (this.state.equals("2")) { str34 = this.no;
                    } else if (this.state.equals("3")) { str34 = this.no;
                    } else if (this.state.equals("1")) { str34 = this.no;
                    } else if (this.state.equals("5")) { str34 = this.no;
                    } else if (this.state.equals("2")) { str34 = this.no;
                    } else if (this.state.equals("4")) { str34 = this.no;
                    } else if (this.state.equals("6")) { str34 = this.no; }


                    if (!str37.equals("")) str37 = str37.substring(0, 10);

                    if (str17.indexOf("Y") >= 0) {
                      this.alertmess += "  <td align=\"center\" width=\"1%\">";
                      if ((str17.indexOf("Y") >= 0) && (!this.state.equals("2")) && (!this.state.equals("3")) && (!this.state.equals(""))) {
                        this.alertmess = (this.alertmess + "   <input type=checkbox name=yl ylloft='" + this.Loft + "' value='" + this.no + "'>");
                      }
                      this.alertmess += "  </td>";
                    }
                    this.alertmess = (this.alertmess + "  <td align=\"center\" width=\"5%\"  " + str38);
                    if (str35.equals("1")) this.alertmess = (this.alertmess + "  title='锁定日期:" + str37 + "'");

                    this.alertmess += "  >";
                    if (str10.equals("")) {
                      if ((this.state.equals("1")) && (str35.equals("0"))) { i3++;
                        if (str17.indexOf("A") >= 0) {
                          this.alertmess = (this.alertmess + " <a href='#" + this.no + "' onclick=\"opennewwin('roomdata.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=1',720,530,120,5)\">");
                        }
                        this.alertmess += str34;
                        if (str17.indexOf("A") >= 0)
                          this.alertmess += "</a>";
                      }
                      else if ((this.state.equals("1")) && (str35.equals("1"))) {
                        this.alertmess = (this.alertmess + " <a href=\"#\"> " + str34 + "[锁定] </a>");
                      } else if (this.state.equals("3")) { i5++;

                        this.alertmess = (this.alertmess + " " + str34 + "</a>");
                      }
                      else if (this.state.equals("2")) { i4++;
                        this.alertmess = (this.alertmess + "<a href='#" + this.no + "'");
                        if (str17.indexOf("E") >= 0) {
                          this.alertmess = (this.alertmess + " onclick=\"opennewwin('modiorder.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',750,530,120,2)\"");
                        }
                        this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                      } else if (this.state.equals("4")) { i7++;
                        if (str17.indexOf("Y") >= 0) {
                          this.alertmess = (this.alertmess + "<a href='#" + this.no + "' onclick=\"choose('" + str34 + "','" + this.Loft + "');ylroom(2,'" + str34 + "','" + this.Loft + "');\">");
                        }
                        this.alertmess += str34;
                        if (str17.indexOf("A") >= 0)
                          this.alertmess += "</a>";
                      }
                      else if (this.state.equals("6")) {
                        this.alertmess = (this.alertmess + " <a href='#" + this.no + "' ");
                        if (str17.indexOf("E") >= 0) {
                          this.alertmess = (this.alertmess + " onclick=\"opennewwin('ContractList.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=false',480,500,150,10)\"");
                        }
                        this.alertmess = (this.alertmess + ">" + str34 + "</a>");
                      } else if (this.state.equals("5")) { i8++;
                        this.alertmess = (this.alertmess + "<a href='#" + this.no + "' ");
                        if (str17.indexOf("A") >= 0) {
                          this.alertmess = (this.alertmess + " onclick=\"opennewwin('roomdata1.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=5',720,530,120,5)\"");
                        }
                        this.alertmess = (this.alertmess + ">" + str34 + "</a>");
                      } else if (this.state.equals("7")) {
                        this.alertmess = (this.alertmess + "<a href='#" + this.no + "' onclick=\"opennewwin('show_rent_contract.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=5',720,530,120,5)\">" + str34 + "</a>"); } else {
                        this.alertmess += "&nbsp;";
                      } } else if ((this.state.equals("1")) && (!str35.equals("1"))) { i3++;
                      if (str17.indexOf("A") >= 0) {
                        this.alertmess = (this.alertmess + " <a href='#" + this.no + "' onclick=\"opennewwin('roomdata.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=1',720,530,120,5)\">");
                      }
                      this.alertmess += str34;
                      if (str17.indexOf("A") >= 0)
                        this.alertmess += " </a>";
                    } else if (this.state.equals("2")) { i4++;
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "'");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + "  onclick=\"opennewwin('ContractInput2.jsp','?roomcode=" + str26 + "&secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',750,530,120,2);\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a> ");
                    }
                    else if (this.state.equals("3")) { i5++;
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "'  ");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + "  onclick=\"opennewwin('ContractInput2.jsp','?roomcode=" + str26 + "&secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',750,530,120,2);\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                    }
                    this.alertmess += " </td> ";
                  }

                }

                this.alertmess = (this.alertmess + "  <script>A" + String.valueOf(Math.abs(i13)) + 1 + "w1.innerHTML=\"");
                if (!str25.equals("")) this.alertmess = (this.alertmess + String.valueOf(i13) + str25); else
                  this.alertmess += i13;
                this.alertmess += "\" ;</script>";

                this.alertmess += " </tr>";
              }

              for (int i13 = n; i13 <= -1; i13++)
              {
                this.alertmess += " <tr> ";
                f1 = 0.0F;
                f2 = 0.0F;
                for (int str33 = str5; str33 <= str6; str33++) {
                  if (!localLinkedList1.contains(String.valueOf(str33))) {
                    this.no = "";
                    str34 = "";
                    this.no = "";
                    if (str33 >= 10)
                      str34 = str9 + String.valueOf(i13) + String.valueOf(str33);
                    else
                      str34 = str9 + String.valueOf(i13) + "0" + String.valueOf(str33);
                    i12++;

                    if (localLinkedList2.contains(str34)) {
                      int i15 = localLinkedList2.indexOf(str34);
                      this.state = ((String)localLinkedList3.get(i15));
                      str34 = (String)localLinkedList8.get(i15);
                      str25 = (String)localLinkedList9.get(i15);
                      str23 = (String)localLinkedList10.get(i15);
                      if (!this.state.equals("1"))
                        try {
                          str26 = (String)localLinkedList7.get(i15);
                          str27 = (String)localLinkedList6.get(i15);
                          str37 = (String)localLinkedList13.get(i15);
                          if ((str26.equals("")) || (str26 == null)) str26 = "0";
                          if ((str27.equals("")) || (str27 == null)) str27 = "0";
                          if ((str37.equals("")) || (str37 == null)) str37 = "0";

                          f1 += Float.parseFloat(str37);
                          f2 += Float.parseFloat(str27); } catch (Exception localException3) {
                        }
                    } else {
                      this.state = "";
                    }String str36 = "";
                    if (((i13 != 3) || (str33 != 4)) || 
                      (this.state.equals("1"))) str36 = "BGCOLOR='#DDE8E8'";
                    if (this.state.equals("2")) str36 = "bgcolor='#00CCFF'";
                    if (this.state.equals("3")) str36 = "bgcolor='#E5C862'";
                    if (this.state.equals("4")) str36 = "bgcolor='#8DE4A6'";
                    if (this.state.equals("5")) str36 = "bgcolor='#FF00FF'";
                    if (this.state.equals("6")) str36 = "bgcolor='#AACC6F'";
                    if (this.state.equals("7")) { str36 = "bgcolor='#AACC6F'"; i6++; }
                    this.no = str34;

                    if (this.condi.equals("wen")) {
                      str36 = "bgcolor='#c0c0c0'";
                      if (this.state.equals("3")) str34 = "已售" + this.no;
                      else if (this.state.equals("2")) str34 = "已认购" + this.no;
                      else if (this.state.equals("4")) str34 = "已预留" + this.no;
                      else if (this.state.equals("1")) str34 = "未售" + this.no;
                      else if (this.state.equals("5")) str34 = "临定" + this.no;
                      else if (this.state.equals("7")) str34 = "出租" + this.no; 
                    }
                    else if (this.condi.equals("pic")) {
                      str36 = "bgcolor='#c0c0c0'";
                      if (this.state.equals("2")) str34 = this.no + "<img src='../images/mypw.gif' border='0' >";
                      else if (this.state.equals("3")) str34 = this.no + "<img src='../images/maIcon.gif' border='0'  >";
                      else if (this.state.equals("1")) str34 = this.no + "&nbsp;&nbsp;";
                      else if (this.state.equals("5")) str34 = this.no + "<img src='../images/day2.gif' border='0' >";
                      else if (this.state.equals("2")) str34 = this.no;
                      else if (this.state.equals("4")) str34 = this.no + "<img src='../images/face39.gif'  border='0'>";
                      else if (this.state.equals("6")) str34 = this.no;
                      else if (this.state.equals("7")) str34 = this.no;
                    }
                    else if (this.state.equals("2")) { str34 = this.no;
                    } else if (this.state.equals("3")) { str34 = this.no;
                    } else if (this.state.equals("1")) { str34 = this.no;
                    } else if (this.state.equals("5")) { str34 = this.no;
                    } else if (this.state.equals("2")) { str34 = this.no;
                    } else if (this.state.equals("4")) { str34 = this.no;
                    } else if (this.state.equals("6")) { str34 = this.no; }


                    if (str17.indexOf("Y") >= 0) {
                      this.alertmess += " <td align=\"center\" width=\"1%\">";
                      if ((str17.indexOf("Y") >= 0) && (!this.state.equals("2")) && (!this.state.equals("3")) && (!this.state.equals(""))) {
                        this.alertmess = (this.alertmess + "  <input type=checkbox name=yl ylloft=" + this.Loft + " value=" + this.no + ">");
                      }
                      this.alertmess += " </td>";
                    }
                    this.alertmess = (this.alertmess + " <td align=\"center\" width=\"5%\"  " + str36 + ">");
                    if (this.state.equals("1")) { i3++;
                      if (str17.indexOf("A") >= 0) {
                        this.alertmess = (this.alertmess + " <a href='#" + this.no + "' onclick=\"opennewwin('roomdata.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=1',720,530,120,5)\">");
                      }
                      this.alertmess += str34;
                      if (str17.indexOf("A") >= 0) this.alertmess += " </a>"; 
                    }
                    else if (this.state.equals("2")) { i4++;
                      this.alertmess = (this.alertmess + "  <a href='#" + this.no + "'");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + "   onclick=\"opennewwin('modiContractInput.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=true',720,530,120,2)\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a> ");
                    } else if (this.state.equals("3")) { i5++;

                      this.alertmess = (this.alertmess + " " + str34 + "</a> ");
                    } else if (this.state.equals("4")) { i7++;
                      if (str17.indexOf("Y") >= 0) {
                        this.alertmess = (this.alertmess + "   <a href='#" + this.no + "' onclick=\"choose('" + str34 + "','" + this.Loft + "');ylroom(2,'" + str34 + "','" + this.Loft + "');\">");
                      }
                      this.alertmess += str34;
                      if (str17.indexOf("Y") >= 0) this.alertmess += " </a>"; 
                    }
                    else if (this.state.equals("6")) {
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "'");
                      if (str17.indexOf("E") >= 0) {
                        this.alertmess = (this.alertmess + " onclick=\"opennewwin('ContractList.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&show=false',480,500,150,10)\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                    }
                    else if (this.state.equals("5")) { i8++;
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "'");
                      if (str17.indexOf("A") >= 0) {
                        this.alertmess = (this.alertmess + "  onclick=\"opennewwin('roomdata1.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=5',720,530,120,5)\"");
                      }
                      this.alertmess = (this.alertmess + " >" + str34 + "</a>");
                    } else if (this.state.equals("7")) {
                      this.alertmess = (this.alertmess + " <a href='#" + this.no + "' onclick=\"opennewwin('show_rent_contract.jsp','?secname=" + this.SecName + "&secno=" + this.strSection + "&roomno=" + this.no + "&build=" + this.strBuilding + "&loft=" + this.Loft + "&Floor=" + i13 + "&state=5',680,530,120,5)\">" + str34 + "</a>");
                    } else {
                      this.alertmess += " &nbsp;";
                    }this.alertmess += "  </td>";
                  }
                }
                this.alertmess += " </tr>";
              }
              this.alertmess += " </td></tr></table>";
            }
          }
          this.alertmess += " </td></tr>";
          this.alertmess += " </table>";

          this.alertmess += " <script>";

          this.alertmess += "  function printT(){";
          this.alertmess += " pri.innerHTML=\"\";";
          this.alertmess += " print();";

          this.alertmess += "  }";
          this.alertmess += "  function opennewwin1(para,wh,hg,lf,tp) {";
          this.alertmess += " var newwin=window.open(\"rgList.jsp?\"+para,\"newwin1\",\"toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,width=480,height=500,left=150,top=10\");";
          this.alertmess += "  }";

          this.alertmess = (this.alertmess + "  wy" + i + ".innerHTML = \"" + i3 + "\";");
          this.alertmess = (this.alertmess + " w1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i3)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + " ry" + i + ".innerHTML = \"" + i4 + "\";");
          this.alertmess = (this.alertmess + " r1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i4)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + "sy" + i + ".innerHTML = \"" + i5 + "\";");
          this.alertmess = (this.alertmess + "s1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i5)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + "yy" + i + ".innerHTML = \"" + i7 + "\";");
          this.alertmess = (this.alertmess + "y1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i7)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + "ly" + i + ".innerHTML = \"" + i8 + "\";");
          this.alertmess = (this.alertmess + " l1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i8)) / (i8 + i3 + i7 + i5 + i4) * 100.0F, 2) + "%\";");

          int i10 = i8 + i3 + i7 + i5 + i4 + i6;
          this.alertmess = (this.alertmess + " sum" + i + ".innerHTML = '合计：" + i10 + "';");
          this.alertmess += "</script>";
          this.alertmess += "  </td>";
        }
      }
      this.alertmess += "</tr></table>";
    } catch (Exception localException1) {
      System.out.println(localException1);
    }return this.alertmess;
  }
}