package sale;

import ConnDatabase.SDatabase;
import FormatData.FormatData;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.util.LinkedList;
import java.util.List;
import setProperty.setpopedom;

public class ChooseRoomState {
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

	public ChooseRoomState() {
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

		if (str == null)
			str = "";

		return str;
	}

	public String BeanshowLoft(String paramString1,
			String[] paramArrayOfString, String paramString2) {
		try {
			this.alertmess += "<table width=\"98%\" >";

			this.alertmess += "<tr> ";
			this.strSection = paramString1;
			int i = 0;

			SDatabase localSDatabase = new SDatabase();

			this.sql = ("select SerialNo,Name from CRM_Project where SerialNo in("
					+ paramString2 + ")");

			ResultSet localResultSet1 = localSDatabase.executeQuery(this.sql);

			this.alertmess += "<td  colspan=\"2\"> ";
			this.alertmess += "&nbsp;<select name=\"section_select\" style=\"width:117\" onchange=\"frm.submit();\"> ";
			this.alertmess += "<option value=\"\">请选择楼盘名称</option>";

			while (localResultSet1.next()) {
				this.no = localResultSet1.getString("SerialNo");
				this.sec = localResultSet1.getString("Name");
				if (this.strSection.equals(this.no))
					this.SecName = this.sec;
				this.alertmess = (this.alertmess + "<option value='" + this.no
						+ "'>" + this.sec + "</option>");
			}

			localResultSet1.close();

			this.alertmess += " </select></td><td align=\"right\"><input type=button name='findroom' value='查询房间' onclick=\"openwinzy('auto_select.jsp?PARA_SQL=roomView',650,450,100,100);\"></td>";

			this.alertmess += " </tr><tr>";
			this.alertmess += " <td   > ";

			String[] arrayOfString = paramArrayOfString;

			if (arrayOfString != null) {
				for (int j = 0; j < arrayOfString.length; j++) {
					if (this.Loft.equals(""))
						this.Loft = ("'" + getbyte(arrayOfString[j]) + "'");
					else {
						this.Loft = (this.Loft + ",'"
								+ getbyte(arrayOfString[j]) + "'");
					}
				}
			}
			String str1 = "select  discNum1,discNum2 from ChooseRoomDiscSet where  sectionno='"
					+ this.strSection + "'";
			String str2 = "0";
			System.out.println(str1);
			String str3 = "0";
			ResultSet localResultSet2 = localSDatabase.executeQuery(str1);
			while (localResultSet2.next()) {
				str2 = localResultSet2.getString("discNum1");
				str3 = localResultSet2.getString("discNum2");
			}
			localResultSet2.close();
			str1 = "select  loft from Sectiontree where  SerialNo='"
					+ this.strSection + "' group by loft";
			String str4 = "";
			System.out.println(str1);
			localResultSet2 = localSDatabase.executeQuery(str1);
			while (localResultSet2.next()) {
				str4 = "ok";
				String str5 = localResultSet2.getString("loft");
				this.alertmess += " <input name=\"showLoft\"  onclick=\"searcherdata();\" type=\"checkbox\"";
				if (this.Loft.indexOf(str5) >= 0)
					this.alertmess += " checked ";
				this.alertmess = (this.alertmess + "  value='" + str5 + "'>" + str5);
			}
			localResultSet2.close();

			this.alertmess += "   </td>";
			this.alertmess += "  </tr>";
			if (!str4.equals("")) {
				this.alertmess += "  <tr><td > &nbsp;&nbsp;<select name=pxshow   onchange=\"searcherdata();\">";
				this.alertmess += " <option value=\"1\">楼层降序</option>";
				this.alertmess += " <option value=\"0\">楼层升序</option>";
				this.alertmess += " </select> &nbsp;<select name=condi onchange=\"searcherdata();\">";
				this.alertmess += " <option value=\"color\">按色块</option>";
				this.alertmess += " <option value=\"wen\">按文字</option>";
				this.alertmess += " <option value=\"pic\">按图标</option>";
				this.alertmess += " </select>&nbsp;";
				this.alertmess += " </td>";
				this.alertmess += "  </tr>  ";

				this.alertmess = (this.alertmess
						+ " <tr><td>   &nbsp;&nbsp;额外折扣数：<input type=text name=yh size=6 value='"
						+ str2
						+ "'> \"0\"表示没有额外的优惠.&nbsp;&nbsp;会员优惠折扣数：<input type=text name=hy size=6 value='"
						+ str3 + "'> \"0\"表示没有会员的优惠.&nbsp;&nbsp;\t<input type=button name=ss value=\"客户选房试算\" onclick=\"chhoseData1();\"></td></tr>");
			}

			this.alertmess += " </table>";
		} catch (Exception localException) {
		}

		return this.alertmess;
	}

	public String BeanshowLoft1(String paramString1,
			String[] paramArrayOfString, String paramString2) {
		try {
			this.alertmess += "<table width=\"98%\" >";

			this.alertmess += "<tr> ";
			this.strSection = paramString1;
			int i = 0;

			SDatabase localSDatabase = new SDatabase();

			this.sql = ("select SerialNo,Name from CRM_Project where SerialNo in("
					+ paramString2 + ")");

			ResultSet localResultSet1 = localSDatabase.executeQuery(this.sql);

			this.alertmess += "<td  colspan=\"2\"> ";
			this.alertmess += "&nbsp;<select name=\"section_select\" style=\"width:117\" onchange=\"frm.submit();\"> ";
			this.alertmess += "<option value=\"\">请选择楼盘名称</option>";

			while (localResultSet1.next()) {
				this.no = localResultSet1.getString("SerialNo");
				this.sec = localResultSet1.getString("Name");
				if (this.strSection.equals(this.no))
					this.SecName = this.sec;
				this.alertmess = (this.alertmess + "<option value='" + this.no
						+ "'>" + this.sec + "</option>");
			}

			localResultSet1.close();
			this.alertmess += " </select></td><td align=\"right\"><input type=button name='findroom' value='查询房间' onclick=\"openwinzy('auto_select.jsp?PARA_SQL=roomView',650,450,100,100);\"></td>";
			this.alertmess += " </tr><tr>";
			this.alertmess += " <td   > ";

			String[] arrayOfString = paramArrayOfString;

			if (arrayOfString != null) {
				for (int j = 0; j < arrayOfString.length; j++) {
					if (this.Loft.equals(""))
						this.Loft = ("'" + getbyte(arrayOfString[j]) + "'");
					else
						this.Loft = (this.Loft + ",'"
								+ getbyte(arrayOfString[j]) + "'");
				}
			}
			String str1 = "select  loft from Sectiontree where  SerialNo='"
					+ this.strSection + "' group by loft";
			String str2 = "";
			ResultSet localResultSet2 = localSDatabase.executeQuery(str1);
			while (localResultSet2.next()) {
				str2 = "ok";
				String str3 = localResultSet2.getString("loft");
				this.alertmess += " <input name=\"showLoft\"  onclick=\"searcherdata();\" type=\"checkbox\"";
				if (this.Loft.indexOf(str3) >= 0)
					this.alertmess += " checked ";
				this.alertmess = (this.alertmess + "  value='" + str3 + "'>" + str3);
			}
			localResultSet2.close();

			this.alertmess += "   </td>";
			this.alertmess += "  </tr>";
			if (!str2.equals("")) {
				this.alertmess += "  <tr><td > &nbsp;&nbsp;<select name=pxshow   onchange=\"searcherdata();\">";
				this.alertmess += " <option value=\"1\">楼层降序</option>";
				this.alertmess += " <option value=\"0\">楼层升序</option>";
				this.alertmess += " </select> &nbsp;<select name=condi onchange=\"searcherdata();\">";
				this.alertmess += " <option value=\"color\">按色块</option>";
				this.alertmess += " <option value=\"wen\">按文字</option>";
				this.alertmess += " <option value=\"pic\">按图标</option>";
				this.alertmess += " </select>&nbsp;";
				this.alertmess = (this.alertmess
						+ " </td><td><input type=button name=zy value='定义置业需要准备的资料'  onclick=\"openwinzy('add_zy_data.jsp?section="
						+ this.strSection + "',650,450,100,100);\"></td>");
				this.alertmess += "  </tr>  ";
			}

			this.alertmess += " </table>";
		} catch (Exception localException) {
		}

		return this.alertmess;
	}

	public String BeanCodeShow(String paramString1, String paramString2)
  {
    try {
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
          int j =1;
          if (localResultSet3.next()) {
        	  j = localResultSet3.getInt("floor");
          }
          localResultSet3.close();
          this.sql = "select max(len(cell)) cell from ";

          this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
          this.sql = (this.sql + "  and Region='" + this.Loft + "'");
          String str5 = "";
          localResultSet3 = localSDatabase2.executeQuery(this.sql);
          if (localResultSet3.next())
          {
            str5 = localResultSet3.getString("cell");
          }

          localResultSet3.close();

          if (str5.equals("2")) {
            this.sql = "select min(Floor) as BeginF,max(Floor) as EndF,";
            this.sql += "min(Room) as BeginR,max(Room) as EndR, max(convert(int,cell))  as Ecell ,min(cell) as Scell from";
            this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
            this.sql = (this.sql + " and Region='" + this.Loft + "'");
          }
          else
          {
            this.sql = "select min(Floor) as BeginF,max(Floor) as EndF,";
            this.sql += "min(Room) as BeginR,max(Room) as EndR, max(cell)  as Ecell ,min(cell) as Scell from";
            this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
            this.sql = (this.sql + "   and Region='" + this.Loft + "'");
          }

          localResultSet3 = localSDatabase2.executeQuery(this.sql);
          int k = 0;
          int m = 0;
          int n = 0;
          int i1 = 0;
          int i2 = 0;
          String str6 = "";
          String str7 = "";
          String str8 = "";
          if (localResultSet3.next()) {
            k = localResultSet3.getInt("BeginF");

            m = localResultSet3.getInt("EndF");
            n = localResultSet3.getInt("BeginR");
            i1 = localResultSet3.getInt("EndR");
            str6 = getbyte(localResultSet3.getString("Ecell"));
            str7 = getbyte(localResultSet3.getString("Scell"));
            if ((str7.equals("")) && (str6.equals(""))) { str6 = " "; str7 = " "; }
          }
          localResultSet3.close();
          int i3 = 0; int i4 = 0;
          char c2 = str7.charAt(0);
          char c3 = str6.charAt(0);
          if ((!str7.equals("")) && (!str6.equals(""))) {
            c2 = str7.charAt(0);
            c3 = str6.charAt(0);
            if (Character.isDigit(c2)) {
              i3 = Integer.parseInt(str7);
              i4 = Integer.parseInt(str6);
            } else {
              i3 = Character.getNumericValue(c2) - 9;
              i4 = Character.getNumericValue(c3) - 9;
            }
          }
          if (i3 < 0) i3 = 0;
          if (i4 < 0) i4 = 0;
          String str9 = "";
          int i5 = 20;
          String str10 = "select room_type,ts from LoftBuildCode where SECNO='" + this.strSection + "' and loft='" + this.Loft + "'";

          ResultSet localResultSet4 = localSDatabase2.executeQuery(str10);
          if (localResultSet4.next()) {
            str9 = localResultSet4.getString("room_type");
            i5 = localResultSet4.getInt("ts");
          }

          String str11 = "";
          localResultSet3 = localSDatabase2.executeQuery("select roomtype from LoftBuildCode where SecNo='" + this.strSection + "' and Loft='" + this.Loft + "' and roomtype=1");
          if (localResultSet3.next()) {
            str11 = "1";
          }
          localResultSet3.close();

          this.alertmess = (this.alertmess + " <input type=hidden name=SecNo value=\"" + this.strSection + "\">");
          this.alertmess = (this.alertmess + "<input type=hidden name=SecName value=\"" + this.SecName + "\">");
          this.alertmess = (this.alertmess + "<input type=hidden name=Loft value=\"" + this.Loft + "\">");
          this.alertmess += "<input type=hidden name=Build value=\"\">";
          this.alertmess += "<input type=hidden name=cusname value=\"\">";
          this.alertmess += "<input type=hidden name=secname value=\"\">";
          String str12 = "#00CCFF";
          String str13 = "#E5C862";
          String str14 = "#8DE4A6";
          String str15 = "#AACC6F";
          String str16 = "#FF00FF";
          String str17 = "#DDE8E8";
          if (!this.strSection.equals("")) {
            String str18 = "select  *  from SaleStateColor WHERE secno='" + this.strSection + "'";

            ResultSet localResultSet5 = localSDatabase2.executeQuery(str18);
            if (localResultSet5.next()) {
              str12 = localResultSet5.getString("RG");
              str13 = localResultSet5.getString("QY");
              str16 = localResultSet5.getString("ld");
              str15 = localResultSet5.getString("CZ");
              str14 = localResultSet5.getString("YL");
              str17 = localResultSet5.getString("ws");
            }

            localResultSet5.close();
          }
          if (str12.equals("")) {
            this.alertmess += "<script>";
            this.alertmess += "alert(\"还没有设置为销控表设置状态色块,请在系统管理中设置\");";

            this.alertmess += "</script>";
          }

          String str18 = paramString1;
          if (str18 == null) str18 = "";

          this.alertmess += " <p CLASS=FontColor align=\"center\"><b><font size=\"3\" >";

          if (!this.SecName.equals(this.Loft)) this.alertmess += this.SecName; this.alertmess = (this.alertmess + this.Loft + " 销控表</font></b></p>");
          this.alertmess += " <table width=\"98%\" border=\"0\"  align=\"center\" CELLSPACING=1 CELLPADDING=3>";

          this.alertmess = (this.alertmess + "<td bgcolor='" + str17 + "'  align=\"center\">未售</td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str12 + "'  align=\"center\">已售<img src='../images/mypw.gif' border='0' ></td>");
          this.alertmess += "<td   align=\"center\">";
          this.alertmess += " </td>";
          this.alertmess += "</tr>";
          this.alertmess = (this.alertmess + " <tr><td bgcolor='" + str17 + "' align=\"center\"><div id=wy" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str12 + "'  align=\"center\"><div id=ry" + i + "></div></td>");
          this.alertmess = (this.alertmess + "  <td   align=\"center\"><div id=sum" + i + "> </div>");
          this.alertmess += " </td>";
          this.alertmess += " \t</tr>";
          this.alertmess = (this.alertmess + "  <tr><td bgcolor='" + str17 + "' align=\"center\"><div id=w1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str12 + "'  align=\"center\"><div id=r1" + i + "></div></td>");
          this.alertmess += " </td>";
          this.alertmess += " <td   align=\"center\"> ";
          this.alertmess += " </td>";
          this.alertmess += " </tr>";
          this.alertmess += " </table>";

          int i6 = 0;
          int i7 = 0;
          int i8 = 0;
          int i9 = 0;
          int i10 = 0;
          int i11 = 0;

          String str19 = "";
          if (str19 == null) str19 = "";

          String str20 = "ABCDEFGHIJKLOPQRST";
          str20 = str20.trim();
          int i12 = 0;
          String str21 = "";
          String str22 = "select top 1 Room_code from Room where seccode=";
          str22 = str22 + "'" + this.strSection + "' and Building='";
          str22 = str22 + this.strBuilding + "' and loft='" + this.Loft + "'  ";
          ResultSet localResultSet6 = localSDatabase2.executeQuery(str22);
          if (localResultSet6.next()) str21 = localResultSet6.getString("Room_code");
          localResultSet6.close();

          if (str21.equals(""))
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
            for (int i13 = i3; i13 <= i4; i13++) {
              if (i3 > 0) {
                str8 = localasicc.AsiicZH(i13, c2);
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
              String str23 = ""; String str24 = "";
              String str25 = "";
              String str26 = "";
              String str27 = "";
              String str28 = "";
              String str29 = "ABCDEFGHIJKLOPQRST";

              String str30 = "select   a.dis, a.tddate,a.Room_code,case when a.type=1 and a.salestate=1  and a.ssstate=0 then 1 else 2 end SaleState,a.Floor,a.Room,a.area,a.code,a.sumprice,a.floorshow,a.floortype,a.floormess,b.showfloors from roomstateview a,roomno b where a.seccode+a.loft+a.room_code= b.SectionNo+b.region+b.roomno and a.seccode=";
              str30 = str30 + "'" + this.strSection + "'";
              str30 = str30 + str2 + " and  a.cell='" + str8 + "' and a.floortype=0    order by a.Floor";
              ResultSet localResultSet7 = localSDatabase2.executeQuery(str30);
              int i14 = 0;
              while (localResultSet7.next())
              {
                localLinkedList8.add(localResultSet7.getString("Room_code"));
                localLinkedList3.add(localResultSet7.getString("SaleState"));
                String str31 = localResultSet7.getString("Floor");
                String str32 = localResultSet7.getString("Room");
                str23 = localResultSet7.getString("floorshow");
                str25 = localResultSet7.getString("floortype");
                localLinkedList4.add(str31);
                localLinkedList5.add(str32);
                if (Integer.parseInt(str32) >= 10)
                  localLinkedList2.add(str8 + str31 + str32);
                else {
                  localLinkedList2.add(str8 + str31 + "0" + str32);
                }
                localLinkedList6.add(getbyte1(localResultSet7.getString("area")));
                localLinkedList7.add(localResultSet7.getString("code"));
                localLinkedList9.add(getbyte1(localResultSet7.getString("floormess")));
                localLinkedList10.add(getbyte1(localResultSet7.getString("showfloors")));
                localLinkedList11.add(localResultSet7.getString("dis"));
                localLinkedList12.add(getbyte1(localResultSet7.getString("tddate")));
                localLinkedList13.add(getbyte1(localResultSet7.getString("sumprice")));
              }
              localResultSet7.close();
              int i15 = 0;

              this.alertmess += " <td align=\"center\" valign=\"top\">";
              if (!str8.equals("")) this.alertmess = (this.alertmess + str8 + "单元");
              this.alertmess += " <table border=\"0\" width=\"100%\" CELLSPACING=1 CELLPADDING=0>";
              if ((str9.indexOf("墅") < 0) && (str9.indexOf("车") < 0)) {
                this.alertmess += "  <tr>";
                this.alertmess += "   <td  width=\"1%\" bgcolor=\"#800000\" align=\"center\"><img src=\"../images/1.gif\" border=\"0\"></td>";

                char i16 = str21.charAt(0);
                str21 = str21.substring(str21.length() - 1);

                char i17 = str21.charAt(0);
                for (int i18 = n; i18 <= i1; i18++) {
                  String str33 = "";
                  str33 = localasicc.AsiicZH(i18, i17);

                  if ((((String)localObject2).indexOf(String.valueOf(i18)) >= 0) || (str20.indexOf((String)localObject2) >= 0)) {
                    if (str20.indexOf((String)localObject2) >= 0)
                    {
                      if (!localLinkedList1.contains(String.valueOf(i18)))
                      {
                        this.alertmess += "<td align=\"center\" class=listtitle ";
                        this.alertmess += "   colspan=\"2\"";
                        this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33 + "</font></td>");
                      }
                    } else if (!localLinkedList1.contains(String.valueOf(i18)))
                    {
                      this.alertmess += "  <td align=\"center\" class=listtitle ";
                      this.alertmess += "   colspan='2'";
                      this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33 + "</font></td>");
                    }
                  }
                  else if (!localLinkedList1.contains(String.valueOf(i18)))
                  {
                    this.alertmess += "  <td align=\"center\" class=listtitle ";
                    this.alertmess += "  colspan='2'";
                    this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33 + "</font></td>");
                  }

                }

                this.alertmess += "  </tr>";
              }
              this.alertmess += "  <tr>";

              int i16 = 0;
              float f1;
              float f2;
              int i19;
              String str34;
              String str37;
              for (int i17 = k; i17 <= m; i17++) {
                i16 = 0;
                if (i16 == 0) this.alertmess += "<tr>";
                if ((str9.indexOf("墅") < 0) && (str9.indexOf("车") < 0))
                  this.alertmess = (this.alertmess + "  <td align=\"center\" class=FloorC width=\"1%\"><font color=\"#ffffff\"><div id=A" + String.valueOf(Math.abs(i17)) + 1 + "w1>" + i17 + "</div></font></td>");
                else {
                  this.alertmess = (this.alertmess + " <div style='display:none' id=A" + String.valueOf(Math.abs(i17)) + 1 + "w1>" + i17 + "</div>");
                }
                f1 = 0.0F;
                f2 = 0.0F;

                for (i19 = n; i19 <= i1; i19++) {
                  if (i16 == i5) { i16 = 0; this.alertmess += "</tr><tr>"; }
                  if (!localLinkedList1.contains(String.valueOf(i19))) {
                    i16++;
                    this.no = "";
                    str34 = "";
                    this.no = "";
                    String str35 = "0"; str37 = "";
                    if (i19 >= 10)
                      str34 = str8 + String.valueOf(i17) + String.valueOf(i19);
                    else
                      str34 = str8 + String.valueOf(i17) + "0" + String.valueOf(i19);
                    i15++;

                    if (localLinkedList2.contains(str34)) {
                      int i21 = localLinkedList2.indexOf(str34);
                      this.state = getbyte((String)localLinkedList3.get(i21));

                      str34 = (String)localLinkedList8.get(i21);
                      str26 = (String)localLinkedList9.get(i21);
                      str24 = (String)localLinkedList10.get(i21);
                      if (this.state.equals("1"))
                        try {
                          str27 = (String)localLinkedList7.get(i21);
                          str28 = (String)localLinkedList6.get(i21);
                          String str39 = (String)localLinkedList13.get(i21);
                          if ((str27.equals("")) || (str27 == null)) str27 = "0";
                          if ((str28.equals("")) || (str28 == null)) str28 = "0";
                          if ((str39.equals("")) || (str39 == null)) str39 = "0";
                          f1 += Float.parseFloat(str39);
                          f2 += Float.parseFloat(str28); } catch (Exception localException4) {
                        }
                    } else {
                      this.state = "";
                    }String str38 = "";
                    if (((i17 != 3) || (i19 != 4)) || 
                      (this.state.equals("1"))) str38 = "BGCOLOR='" + str17 + "'";
                    else if (this.state.equals("2")) str38 = "bgcolor='" + str12 + "'";
                    else if (this.state.equals("3")) str38 = "bgcolor='" + str13 + "'";
                    else if (this.state.equals("4")) str38 = "bgcolor='" + str14 + "'";
                    else if (this.state.equals("5")) str38 = "bgcolor='" + str16 + "'";

                    this.no = str34;

                    if (this.condi.equals("wen")) {
                      str38 = "BGCOLOR='" + str17 + "'";
                      if (this.state.equals("3")) str34 = "已售" + this.no;
                      else if (this.state.equals("2")) str34 = "已认购" + this.no;
                      else if (this.state.equals("4")) str34 = "已预留" + this.no;
                      else if (this.state.equals("1")) str34 = "未售" + this.no;
                      else if (this.state.equals("5")) str34 = "临定" + this.no;
                      else if (this.state.equals("7")) str34 = "出租" + this.no; 
                    }
                    else if (this.condi.equals("pic")) {
                      str38 = "BGCOLOR='" + str17 + "'";
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
                    if (this.state.equals("1")) str38 = "BGCOLOR='" + str17 + "'";
                    if (this.state.equals("2")) str38 = "bgcolor='" + str12 + "'";

                    this.alertmess += "  <td align=\"center\" width=\"1%\">";

                    if (this.state.equals("1")) {
                      this.alertmess = (this.alertmess + "  <input type=checkbox name=chooseroom ylloft='" + this.Loft + "' value='" + str27 + "'>");
                      i6++;
                    } else {
                      i7++;
                    }
                    this.alertmess += "  </td>";

                    this.alertmess = (this.alertmess + "  <td align=\"center\" width=\"5%\"  " + str38);

                    this.alertmess += "  >";
                    if (!this.state.equals("")) {
                      this.alertmess += str34;
                    }
                    this.alertmess += "</td> ";
                  }

                }

                this.alertmess = (this.alertmess + "  <script>A" + String.valueOf(Math.abs(i17)) + 1 + "w1.innerHTML=\"");
                if (!str26.equals("")) this.alertmess = (this.alertmess + String.valueOf(i17) + str26); else
                  this.alertmess += i17;
                this.alertmess += "\" ;</script>";

                this.alertmess += " </tr>";
              }

              for (int i17 = i2; i17 <= -1; i17++)
              {
                this.alertmess += " <tr> ";
                f1 = 0.0F;
                f2 = 0.0F;
                for (i19 = n; i19 <= i1; i19++) {
                  if (!localLinkedList1.contains(String.valueOf(i19))) {
                    this.no = "";
                    str34 = "";
                    this.no = "";
                    if (i19 >= 10)
                      str34 = str8 + String.valueOf(i17) + String.valueOf(i19);
                    else
                      str34 = str8 + String.valueOf(i17) + "0" + String.valueOf(i19);
                    i15++;

                    if (localLinkedList2.contains(str34)) {
                      int i20 = localLinkedList2.indexOf(str34);
                      this.state = ((String)localLinkedList3.get(i20));
                      str34 = (String)localLinkedList8.get(i20);
                      str26 = (String)localLinkedList9.get(i20);
                      str24 = (String)localLinkedList10.get(i20);
                      if (this.state.equals("1"))
                        try {
                          str27 = (String)localLinkedList7.get(i20);
                          str28 = (String)localLinkedList6.get(i20);
                          str37 = (String)localLinkedList13.get(i20);
                          if ((str27.equals("")) || (str27 == null)) str27 = "0";
                          if ((str28.equals("")) || (str28 == null)) str28 = "0";
                          if ((str37.equals("")) || (str37 == null)) str37 = "0";

                          f1 += Float.parseFloat(str37);
                          f2 += Float.parseFloat(str28); } catch (Exception localException3) {
                        }
                    } else {
                      this.state = "";
                    }String str36 = "";
                    if (((i17 != 3) || (i19 != 4)) || 
                      (this.state.equals("1"))) str36 = "BGCOLOR='#DDE8E8'";
                    if (this.state.equals("2")) str36 = "bgcolor='#00CCFF'";
                    if (this.state.equals("3")) str36 = "bgcolor='#E5C862'";
                    if (this.state.equals("4")) str36 = "bgcolor='#8DE4A6'";
                    if (this.state.equals("5")) str36 = "bgcolor='#FF00FF'";
                    if (this.state.equals("6")) str36 = "bgcolor='#AACC6F'";
                    if (this.state.equals("7")) { str36 = "bgcolor='#AACC6F'"; i9++; }
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


                    if (this.state.equals("1")) str36 = "BGCOLOR='#DDE8E8'";
                    if (this.state.equals("2")) str36 = "bgcolor='#00CCFF'";

                    this.alertmess += "  <td align=\"center\" width=\"1%\">";

                    if ((!this.state.equals("2")) && (!this.state.equals("3")) && (!this.state.equals(""))) {
                      this.alertmess = (this.alertmess + " <input type=checkbox name=chooseroom ylloft='" + this.Loft + "' value='" + str27 + "'>");
                      i6++;
                    } else {
                      i7++;
                    }
                    this.alertmess += "  </td>";

                    this.alertmess = (this.alertmess + "  <td align=\"center\" width=\"5%\"  " + str36);

                    this.alertmess += "  >";

                    if (!this.state.equals("")) {
                      this.alertmess += str34;
                    }
                    this.alertmess += "</td> ";
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

          this.alertmess = (this.alertmess + "  wy" + i + ".innerHTML = \"" + i6 + "\";");
          this.alertmess = (this.alertmess + " w1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i6)) / (i11 + i6 + i10 + i8 + i7) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + " ry" + i + ".innerHTML = \"" + i7 + "\";");
          int i13 = i11 + i6 + i10 + i8 + i7 + i9;
          this.alertmess = (this.alertmess + " sum" + i + ".innerHTML = '合计：" + i13 + "';");
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
              int c1 = str4.charAt(0);
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
          int j = 1 ;
          if (localResultSet3.next()) { j = localResultSet3.getInt("floor"); }
          localResultSet3.close();
          this.sql = "select max(len(cell)) cell from ";

          this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
          this.sql = (this.sql + "  and Region='" + this.Loft + "'");
          String str5 = "";
          localResultSet3 = localSDatabase2.executeQuery(this.sql);
          if (localResultSet3.next())
          {
            str5 = localResultSet3.getString("cell");
          }

          localResultSet3.close();

          if (str5.equals("2")) {
            this.sql = "select min(Floor) as BeginF,max(Floor) as EndF,";
            this.sql += "min(Room) as BeginR,max(Room) as EndR, max(convert(int,cell))  as Ecell ,min(cell) as Scell from";
            this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
            this.sql = (this.sql + " and Region='" + this.Loft + "'");
          }
          else
          {
            this.sql = "select min(Floor) as BeginF,max(Floor) as EndF,";
            this.sql += "min(Room) as BeginR,max(Room) as EndR, max(cell)  as Ecell ,min(cell) as Scell from";
            this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
            this.sql = (this.sql + "   and Region='" + this.Loft + "'");
          }

          localResultSet3 = localSDatabase2.executeQuery(this.sql);
          int k = 0;
          int m = 0;
          int n = 0;
          int i1 = 0;
          int i2 = 0;
          String str6 = "";
          String str7 = "";
          String str8 = "";
          if (localResultSet3.next()) {
            k = localResultSet3.getInt("BeginF");

            m = localResultSet3.getInt("EndF");
            n = localResultSet3.getInt("BeginR");
            i1 = localResultSet3.getInt("EndR");
            str6 = getbyte(localResultSet3.getString("Ecell"));
            str7 = getbyte(localResultSet3.getString("Scell"));
            if ((str7.equals("")) && (str6.equals(""))) { str6 = " "; str7 = " "; }
          }
          localResultSet3.close();
          int i3 = 0; int i4 = 0;
          char c2 = str7.charAt(0);
          char c3 = str6.charAt(0);
          if ((!str7.equals("")) && (!str6.equals(""))) {
            c2 = str7.charAt(0);
            c3 = str6.charAt(0);
            if (Character.isDigit(c2)) {
              i3 = Integer.parseInt(str7);
              i4 = Integer.parseInt(str6);
            } else {
              i3 = Character.getNumericValue(c2) - 9;
              i4 = Character.getNumericValue(c3) - 9;
            }
          }
          if (i3 < 0) i3 = 0;
          if (i4 < 0) i4 = 0;
          String str9 = "";
          String str10 = "";
          int i5 = 20;
          String str11 = "select room_type,ts from LoftBuildCode where SECNO='" + this.strSection + "' and loft='" + this.Loft + "'";

          ResultSet localResultSet4 = localSDatabase2.executeQuery(str11);
          if (localResultSet4.next()) {
            str10 = localResultSet4.getString("room_type");
            i5 = localResultSet4.getInt("ts");
          }
          localResultSet4.close();
          localResultSet3 = localSDatabase2.executeQuery("select roomtype from LoftBuildCode where SecNo='" + this.strSection + "' and Loft='" + this.Loft + "' and roomtype=1");
          if (localResultSet3.next()) {
            str9 = "1";
          }
          localResultSet3.close();

          this.alertmess = (this.alertmess + " <input type=hidden name=SecNo value=\"" + this.strSection + "\">");
          this.alertmess = (this.alertmess + "<input type=hidden name=SecName value=\"" + this.SecName + "\">");
          this.alertmess = (this.alertmess + "<input type=hidden name=Loft value=\"" + this.Loft + "\">");
          this.alertmess += "<input type=hidden name=Build value=\"\">";
          this.alertmess += "<input type=hidden name=cusname value=\"\">";
          this.alertmess += "<input type=hidden name=secname value=\"\">";
          String str12 = "#00CCFF";
          String str13 = "#E5C862";
          String str14 = "#8DE4A6";
          String str15 = "#AACC6F";
          String str16 = "#FF00FF";
          String str17 = "#DDE8E8";
          if (!this.strSection.equals("")) {
            String str18 = "select  *  from SaleStateColor WHERE secno='" + this.strSection + "'";

            ResultSet localResultSet5 = localSDatabase2.executeQuery(str18);
            if (localResultSet5.next()) {
              str12 = localResultSet5.getString("RG");
              str13 = localResultSet5.getString("QY");
              str16 = localResultSet5.getString("ld");
              str15 = localResultSet5.getString("CZ");
              str14 = localResultSet5.getString("YL");
              str17 = localResultSet5.getString("ws");
            }

            localResultSet5.close();
          }
          if (str12.equals("")) {
            this.alertmess += "<script>";
            this.alertmess += "alert(\"还没有设置为销控表设置状态色块,请在系统管理中设置\");";

            this.alertmess += "</script>";
          }

          String str18 = paramString1;
          if (str18 == null) str18 = "";

          this.alertmess += " <p CLASS=FontColor align=\"center\"><b><font size=\"3\" >";

          if (!this.SecName.equals(this.Loft)) this.alertmess += this.SecName; this.alertmess = (this.alertmess + this.Loft + " 销控表</font></b></p>");
          this.alertmess += " <table width=\"98%\" border=\"0\"  align=\"center\" CELLSPACING=1 CELLPADDING=3>";

          this.alertmess = (this.alertmess + "<td bgcolor='" + str17 + "'  align=\"center\">未售</td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str12 + "'  align=\"center\">已售<img src='../images/mypw.gif' border='0' ></td>");
          this.alertmess += "<td   align=\"center\">";
          this.alertmess += " </td>";
          this.alertmess += "</tr>";
          this.alertmess = (this.alertmess + " <tr><td bgcolor='" + str17 + "' align=\"center\"><div id=wy" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str12 + "'  align=\"center\"><div id=ry" + i + "></div></td>");
          this.alertmess = (this.alertmess + "  <td   align=\"center\"><div id=sum" + i + "> </div>");
          this.alertmess += " </td>";
          this.alertmess += " \t</tr>";
          this.alertmess = (this.alertmess + "  <tr><td bgcolor='" + str17 + "' align=\"center\"><div id=w1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str12 + "'  align=\"center\"><div id=r1" + i + "></div></td>");
          this.alertmess += " </td>";
          this.alertmess += " <td   align=\"center\"> ";
          this.alertmess += " </td>";
          this.alertmess += " </tr>";
          this.alertmess += " </table>";

          int i6 = 0;
          int i7 = 0;
          int i8 = 0;
          int i9 = 0;
          int i10 = 0;
          int i11 = 0;

          String str19 = "";
          if (str19 == null) str19 = "";

          String str20 = "ABCDEFGHIJKLOPQRST";
          str20 = str20.trim();
          int i12 = 0;
          String str21 = "";
          String str22 = "select top 1 Room_code from Room where seccode=";
          str22 = str22 + "'" + this.strSection + "' and Building='";
          str22 = str22 + this.strBuilding + "' and loft='" + this.Loft + "'  ";
          ResultSet localResultSet6 = localSDatabase2.executeQuery(str22);
          if (localResultSet6.next()) str21 = localResultSet6.getString("Room_code");
          localResultSet6.close();

          if (str21.equals(""))
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
            for (int i13 = i3; i13 <= i4; i13++) {
              if (i3 > 0) {
                str8 = localasicc.AsiicZH(i13, c2);
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
              String str23 = ""; String str24 = "";
              String str25 = "";
              String str26 = "";
              String str27 = "";
              String str28 = "";
              String str29 = "ABCDEFGHIJKLOPQRST";

              String str30 = "select    a.dis, a.tddate,a.Room_code,case when a.type=1 and a.salestate=1 and a.ssstate=0 then 1 else 2 end SaleState,a.Floor,a.Room,a.area,a.code,a.sumprice,a.floorshow,a.floortype,a.floormess,b.showfloors from roomstateview a,roomno b where a.seccode+a.loft+a.room_code= b.SectionNo+b.region+b.roomno and a.seccode=";
              str30 = str30 + "'" + this.strSection + "'";
              str30 = str30 + str2 + " and  a.cell='" + str8 + "' and a.floortype=0    order by a.Floor";
              ResultSet localResultSet7 = localSDatabase2.executeQuery(str30);
              int i14 = 0;
              while (localResultSet7.next())
              {
                localLinkedList8.add(localResultSet7.getString("Room_code"));
                localLinkedList3.add(localResultSet7.getString("SaleState"));
                String str31 = localResultSet7.getString("Floor");
                String str32 = localResultSet7.getString("Room");
                str23 = localResultSet7.getString("floorshow");
                str25 = localResultSet7.getString("floortype");
                localLinkedList4.add(str31);
                localLinkedList5.add(str32);
                if (Integer.parseInt(str32) >= 10)
                  localLinkedList2.add(str8 + str31 + str32);
                else {
                  localLinkedList2.add(str8 + str31 + "0" + str32);
                }
                localLinkedList6.add(getbyte1(localResultSet7.getString("area")));
                localLinkedList7.add(localResultSet7.getString("code"));
                localLinkedList9.add(getbyte1(localResultSet7.getString("floormess")));
                localLinkedList10.add(getbyte1(localResultSet7.getString("showfloors")));
                localLinkedList11.add(localResultSet7.getString("dis"));
                localLinkedList12.add(getbyte1(localResultSet7.getString("tddate")));
                localLinkedList13.add(getbyte1(localResultSet7.getString("sumprice")));
              }
              localResultSet7.close();
              int i15 = 0;
              System.out.println("ok");
              this.alertmess += " <td align=\"center\" valign=\"top\">";
              if (!str8.equals("")) this.alertmess = (this.alertmess + str8 + "单元");
              this.alertmess += " <table border=\"0\" width=\"100%\" CELLSPACING=1 CELLPADDING=0>";
              if ((str10.indexOf("墅") < 0) && (str10.indexOf("车") < 0)) {
                this.alertmess += "  <tr>";
                this.alertmess += "   <td  width=\"1%\" bgcolor=\"#800000\" align=\"center\"><img src=\"../images/1.gif\" border=\"0\"></td>";

                char i16 = str21.charAt(0);
                str21 = str21.substring(str21.length() - 1);

                char i17 = str21.charAt(0);
                for (int i18 = n; i18 <= i1; i18++) {
                  String str33 = "";
                  str33 = localasicc.AsiicZH(i18, i17);

                  if ((((String)localObject2).indexOf(String.valueOf(i18)) >= 0) || (str20.indexOf((String)localObject2) >= 0)) {
                    if (str20.indexOf((String)localObject2) >= 0)
                    {
                      if (!localLinkedList1.contains(String.valueOf(i18)))
                      {
                        this.alertmess += "<td align=\"center\" class=listtitle ";
                        this.alertmess += "   colspan=\"2\"";
                        this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33 + "</font></td>");
                      }
                    } else if (!localLinkedList1.contains(String.valueOf(i18)))
                    {
                      this.alertmess += "  <td align=\"center\" class=listtitle ";
                      this.alertmess += "   colspan='2'";
                      this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33 + "</font></td>");
                    }
                  }
                  else if (!localLinkedList1.contains(String.valueOf(i18)))
                  {
                    this.alertmess += "  <td align=\"center\" class=listtitle ";
                    this.alertmess += "  colspan='2'";
                    this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33 + "</font></td>");
                  }

                }

                this.alertmess += "  </tr>";
              }
              this.alertmess += "  <tr>";
              int i16 = 0;
              float f1;
              float f2;
              int i19;
              String str34;
              String str37;
              for (int i17 = m; i17 >= k; i17--) {
                i16 = 0;
                if (i16 == 0) this.alertmess += " <tr>";
                if ((str10.indexOf("墅") < 0) && (str10.indexOf("车") < 0))
                  this.alertmess = (this.alertmess + "  <td align=\"center\" class=FloorC width=\"1%\"><font color=\"#ffffff\"><div id=A" + String.valueOf(Math.abs(i17)) + 1 + "w1>" + i17 + "</div></font></td>");
                else {
                  this.alertmess = (this.alertmess + " <div style='display:none' id=A" + String.valueOf(Math.abs(i17)) + 1 + "w1>" + i17 + "</div>");
                }
                f1 = 0.0F;
                f2 = 0.0F;
                for (i19 = n; i19 <= i1; i19++) {
                  if (i16 == i5) { i16 = 0; this.alertmess += "</tr><tr>"; }
                  if (!localLinkedList1.contains(String.valueOf(i19))) {
                    i16++;
                    this.no = "";
                    str34 = "";
                    this.no = "";
                    String str35 = "0"; str37 = "";
                    if (i19 >= 10)
                      str34 = str8 + String.valueOf(i17) + String.valueOf(i19);
                    else
                      str34 = str8 + String.valueOf(i17) + "0" + String.valueOf(i19);
                    i15++;

                    if (localLinkedList2.contains(str34)) {
                      int i21 = localLinkedList2.indexOf(str34);
                      this.state = getbyte((String)localLinkedList3.get(i21));

                      str34 = (String)localLinkedList8.get(i21);
                      str26 = (String)localLinkedList9.get(i21);
                      str24 = (String)localLinkedList10.get(i21);
                      if (this.state.equals("1"))
                        try {
                          str27 = (String)localLinkedList7.get(i21);
                          str28 = (String)localLinkedList6.get(i21);
                          String str39 = (String)localLinkedList13.get(i21);
                          if ((str27.equals("")) || (str27 == null)) str27 = "0";
                          if ((str28.equals("")) || (str28 == null)) str28 = "0";
                          if ((str39.equals("")) || (str39 == null)) str39 = "0";
                          f1 += Float.parseFloat(str39);
                          f2 += Float.parseFloat(str28); } catch (Exception localException4) {
                        }
                    } else {
                      this.state = "";
                    }String str38 = "";
                    if (((i17 != 3) || (i19 != 4)) || 
                      (this.state.equals("1"))) str38 = "BGCOLOR='" + str17 + "'";
                    else if (this.state.equals("2")) str38 = "bgcolor='" + str12 + "'";
                    else if (this.state.equals("3")) str38 = "bgcolor='" + str13 + "'";
                    else if (this.state.equals("4")) str38 = "bgcolor='" + str14 + "'";
                    else if (this.state.equals("5")) str38 = "bgcolor='" + str16 + "'";

                    this.no = str34;

                    if (this.condi.equals("wen")) {
                      str38 = "BGCOLOR='" + str17 + "'";
                      if (this.state.equals("3")) str34 = "已售" + this.no;
                      else if (this.state.equals("2")) str34 = "已认购" + this.no;
                      else if (this.state.equals("4")) str34 = "已预留" + this.no;
                      else if (this.state.equals("1")) str34 = "未售" + this.no;
                      else if (this.state.equals("5")) str34 = "临定" + this.no;
                      else if (this.state.equals("7")) str34 = "出租" + this.no; 
                    }
                    else if (this.condi.equals("pic")) {
                      str38 = "BGCOLOR='" + str17 + "'";
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

                    if (this.state.equals("1")) str38 = "BGCOLOR='" + str17 + "'";
                    if (this.state.equals("2")) str38 = "bgcolor='" + str12 + "'";

                    this.alertmess += "  <td align=\"center\" width=\"1%\">";

                    if (this.state.equals("1")) {
                      this.alertmess = (this.alertmess + " <input type=checkbox name=chooseroom ylloft='" + this.Loft + "' value='" + str27 + "'>");
                      i6++;
                    } else {
                      i7++;
                    }
                    this.alertmess += "  </td>";

                    this.alertmess = (this.alertmess + "  <td align=\"center\" width=\"5%\"  " + str38);

                    this.alertmess += "  >";

                    if (!this.state.equals("")) {
                      this.alertmess += str34;
                    }
                    this.alertmess += "</td> ";
                  }

                }

                this.alertmess = (this.alertmess + "  <script>A" + String.valueOf(Math.abs(i17)) + 1 + "w1.innerHTML=\"");
                if (!str26.equals("")) this.alertmess = (this.alertmess + String.valueOf(i17) + str26); else
                  this.alertmess += i17;
                this.alertmess += "\" ;</script>";

                this.alertmess += " </tr>";
              }

              for (int i17 = i2; i17 <= -1; i17++)
              {
                this.alertmess += " <tr> ";
                f1 = 0.0F;
                f2 = 0.0F;
                for (i19 = n; i19 <= i1; i19++) {
                  if (!localLinkedList1.contains(String.valueOf(i19))) {
                    this.no = "";
                    str34 = "";
                    this.no = "";
                    if (i19 >= 10)
                      str34 = str8 + String.valueOf(i17) + String.valueOf(i19);
                    else
                      str34 = str8 + String.valueOf(i17) + "0" + String.valueOf(i19);
                    i15++;

                    if (localLinkedList2.contains(str34)) {
                      int i20 = localLinkedList2.indexOf(str34);
                      this.state = ((String)localLinkedList3.get(i20));
                      str34 = (String)localLinkedList8.get(i20);
                      str26 = (String)localLinkedList9.get(i20);
                      str24 = (String)localLinkedList10.get(i20);
                      if (this.state.equals("1"))
                        try {
                          str27 = (String)localLinkedList7.get(i20);
                          str28 = (String)localLinkedList6.get(i20);
                          str37 = (String)localLinkedList13.get(i20);
                          if ((str27.equals("")) || (str27 == null)) str27 = "0";
                          if ((str28.equals("")) || (str28 == null)) str28 = "0";
                          if ((str37.equals("")) || (str37 == null)) str37 = "0";

                          f1 += Float.parseFloat(str37);
                          f2 += Float.parseFloat(str28); } catch (Exception localException3) {
                        }
                    } else {
                      this.state = "";
                    }String str36 = "";
                    if (((i17 != 3) || (i19 != 4)) || 
                      (this.state.equals("1"))) str36 = "BGCOLOR='#DDE8E8'";
                    if (this.state.equals("2")) str36 = "bgcolor='#00CCFF'";
                    if (this.state.equals("3")) str36 = "bgcolor='#E5C862'";
                    if (this.state.equals("4")) str36 = "bgcolor='#8DE4A6'";
                    if (this.state.equals("5")) str36 = "bgcolor='#FF00FF'";
                    if (this.state.equals("6")) str36 = "bgcolor='#AACC6F'";
                    if (this.state.equals("7")) { str36 = "bgcolor='#AACC6F'"; i9++; }
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


                    if (this.state.equals("1")) str36 = "BGCOLOR='" + str17 + "'";
                    if (this.state.equals("2")) str36 = "bgcolor='" + str12 + "'";

                    this.alertmess += "  <td align=\"center\" width=\"1%\">";

                    if (this.state.equals("1")) {
                      this.alertmess = (this.alertmess + " <input type=checkbox name=chooseroom ylloft='" + this.Loft + "' value='" + str27 + "'>");
                      i6++;
                    } else {
                      i7++;
                    }
                    this.alertmess += "  </td>";

                    this.alertmess = (this.alertmess + "  <td align=\"center\" width=\"5%\"  " + str36);

                    this.alertmess += "  >";

                    if (!this.state.equals(""))
                      this.alertmess += str34;
                    else {
                      this.alertmess += "</td> ";
                    }
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

          this.alertmess = (this.alertmess + "  wy" + i + ".innerHTML = \"" + i6 + "\";");
          this.alertmess = (this.alertmess + " w1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i6)) / (i11 + i6 + i10 + i8 + i7) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + " ry" + i + ".innerHTML = \"" + i7 + "\";");
          int i13 = i11 + i6 + i10 + i8 + i7 + i9;
          this.alertmess = (this.alertmess + " sum" + i + ".innerHTML = '合计：" + i13 + "';");
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
          int j = 1;
          if (localResultSet3.next()) { 
        	  	j = localResultSet3.getInt("floor");
          }
          localResultSet3.close();
          this.sql = "select max(len(cell)) cell from ";

          this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
          this.sql = (this.sql + "  and Region='" + this.Loft + "'");
          String str5 = "";
          localResultSet3 = localSDatabase2.executeQuery(this.sql);
          if (localResultSet3.next())
          {
            str5 = localResultSet3.getString("cell");
          }

          localResultSet3.close();

          if (str5.equals("2")) {
            this.sql = "select min(Floor) as BeginF,max(Floor) as EndF,";
            this.sql += "min(Room) as BeginR,max(Room) as EndR, max(convert(int,cell))  as Ecell ,min(cell) as Scell from";
            this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
            this.sql = (this.sql + " and Region='" + this.Loft + "'");
          }
          else
          {
            this.sql = "select min(Floor) as BeginF,max(Floor) as EndF,";
            this.sql += "min(Room) as BeginR,max(Room) as EndR, max(cell)  as Ecell ,min(cell) as Scell from";
            this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
            this.sql = (this.sql + "   and Region='" + this.Loft + "'");
          }

          localResultSet3 = localSDatabase2.executeQuery(this.sql);
          int k = 0;
          int m = 0;
          int n = 0;
          int i1 = 0;
          int i2 = 0;
          String str6 = "";
          String str7 = "";
          String str8 = "";
          if (localResultSet3.next()) {
            k = localResultSet3.getInt("BeginF");

            m = localResultSet3.getInt("EndF");
            n = localResultSet3.getInt("BeginR");
            i1 = localResultSet3.getInt("EndR");
            str6 = getbyte(localResultSet3.getString("Ecell"));
            str7 = getbyte(localResultSet3.getString("Scell"));
            if ((str7.equals("")) && (str6.equals(""))) { str6 = " "; str7 = " "; }
          }
          localResultSet3.close();
          int i3 = 0; int i4 = 0;
          char c2 = str7.charAt(0);
          char c3 = str6.charAt(0);
          if ((!str7.equals("")) && (!str6.equals(""))) {
            c2 = str7.charAt(0);
            c3 = str6.charAt(0);
            if (Character.isDigit(c2)) {
              i3 = Integer.parseInt(str7);
              i4 = Integer.parseInt(str6);
            } else {
              i3 = Character.getNumericValue(c2) - 9;
              i4 = Character.getNumericValue(c3) - 9;
            }
          }
          if (i3 < 0) i3 = 0;
          if (i4 < 0) i4 = 0;
          String str9 = "";
          int i5 = 20;
          String str10 = "select room_type,ts from LoftBuildCode where SECNO='" + this.strSection + "' and loft='" + this.Loft + "'";

          ResultSet localResultSet4 = localSDatabase2.executeQuery(str10);
          if (localResultSet4.next()) {
            str9 = localResultSet4.getString("room_type");
            i5 = localResultSet4.getInt("ts");
          }
          String str11 = "";
          localResultSet3 = localSDatabase2.executeQuery("select roomtype from LoftBuildCode where SecNo='" + this.strSection + "' and Loft='" + this.Loft + "' and roomtype=1");
          if (localResultSet3.next()) {
            str11 = "1";
          }
          localResultSet3.close();

          this.alertmess = (this.alertmess + " <input type=hidden name=SecNo value=\"" + this.strSection + "\">");
          this.alertmess = (this.alertmess + "<input type=hidden name=SecName value=\"" + this.SecName + "\">");
          this.alertmess = (this.alertmess + "<input type=hidden name=Loft value=\"" + this.Loft + "\">");
          this.alertmess += "<input type=hidden name=Build value=\"\">";
          this.alertmess += "<input type=hidden name=cusname value=\"\">";
          this.alertmess += "<input type=hidden name=secname value=\"\">";
          String str12 = "#00CCFF";
          String str13 = "#E5C862";
          String str14 = "#8DE4A6";
          String str15 = "#AACC6F";
          String str16 = "#FF00FF";
          String str17 = "#DDE8E8";
          if (!this.strSection.equals("")) {
            String str18 = "select  *  from SaleStateColor WHERE secno='" + this.strSection + "'";

            ResultSet localResultSet5 = localSDatabase2.executeQuery(str18);
            if (localResultSet5.next()) {
              str12 = localResultSet5.getString("RG");
              str13 = localResultSet5.getString("QY");
              str16 = localResultSet5.getString("ld");
              str15 = localResultSet5.getString("CZ");
              str14 = localResultSet5.getString("YL");
              str17 = localResultSet5.getString("ws");
            }

            localResultSet5.close();
          }
          if (str12.equals("")) {
            this.alertmess += "<script>";
            this.alertmess += "alert(\"还没有设置为销控表设置状态色块,请在系统管理中设置\");";

            this.alertmess += "</script>";
          }

          String str18 = paramString1;
          if (str18 == null) str18 = "";

          this.alertmess += " <p CLASS=FontColor align=\"center\"><b><font size=\"3\" >";

          if (!this.SecName.equals(this.Loft)) this.alertmess += this.SecName; this.alertmess = (this.alertmess + this.Loft + " 销控表</font></b></p>");
          this.alertmess += " <table width=\"98%\" border=\"0\"  align=\"center\" CELLSPACING=1 CELLPADDING=3>";

          this.alertmess = (this.alertmess + "<td bgcolor='" + str17 + "'  align=\"center\">未售</td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str12 + "'  align=\"center\">已售<img src='../images/mypw.gif' border='0' ></td>");
          this.alertmess += "<td   align=\"center\">";
          this.alertmess += " </td>";
          this.alertmess += "</tr>";
          this.alertmess = (this.alertmess + " <tr><td bgcolor='" + str17 + "' align=\"center\"><div id=wy" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str12 + "'  align=\"center\"><div id=ry" + i + "></div></td>");

          this.alertmess = (this.alertmess + "  <td   align=\"center\"><div id=sum" + i + "> </div>");
          this.alertmess += " </td>";
          this.alertmess += " \t</tr>";
          this.alertmess = (this.alertmess + "  <tr><td bgcolor='" + str17 + "' align=\"center\"><div id=w1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str12 + "'  align=\"center\"><div id=r1" + i + "></div></td>");

          this.alertmess += " </td>";
          this.alertmess += " <td   align=\"center\"> ";
          this.alertmess += " </td>";
          this.alertmess += " </tr>";
          this.alertmess += " </table>";

          int i6 = 0;
          int i7 = 0;
          int i8 = 0;
          int i9 = 0;
          int i10 = 0;
          int i11 = 0;

          String str19 = "";
          if (str19 == null) str19 = "";

          String str20 = "ABCDEFGHIJKLOPQRST";
          str20 = str20.trim();
          int i12 = 0;
          String str21 = "";
          String str22 = "select top 1 Room_code from Room where seccode=";
          str22 = str22 + "'" + this.strSection + "' and Building='";
          str22 = str22 + this.strBuilding + "' and loft='" + this.Loft + "'  ";
          ResultSet localResultSet6 = localSDatabase2.executeQuery(str22);
          if (localResultSet6.next()) str21 = localResultSet6.getString("Room_code");
          localResultSet6.close();

          if (str21.equals(""))
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
            for (int i13 = i3; i13 <= i4; i13++) {
              if (i3 > 0) {
                str8 = localasicc.AsiicZH(i13, c2);
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
              String str23 = ""; String str24 = "";
              String str25 = "";
              String str26 = "";
              String str27 = "";
              String str28 = "";
              String str29 = "ABCDEFGHIJKLOPQRST";

              String str30 = "select    a.dis, a.tddate,a.Room_code,case when a.type=1 and a.salestate=1 and a.ssstate=0  then 1 else 2 end SaleState,a.Floor,a.Room,a.area,a.code,a.sumprice,a.floorshow,a.floortype,a.floormess,b.showfloors from roomstateview a,roomno b where a.seccode+a.loft+a.room_code= b.SectionNo+b.region+b.roomno and a.seccode=";
              str30 = str30 + "'" + this.strSection + "'";
              str30 = str30 + str2 + " and  a.cell='" + str8 + "' and a.floortype=0    order by a.Floor";
              ResultSet localResultSet7 = localSDatabase2.executeQuery(str30);
              int i14 = 0;
              while (localResultSet7.next())
              {
                localLinkedList8.add(localResultSet7.getString("Room_code"));
                localLinkedList3.add(localResultSet7.getString("SaleState"));
                String str31 = localResultSet7.getString("Floor");
                String str32 = localResultSet7.getString("Room");
                str23 = localResultSet7.getString("floorshow");
                str25 = localResultSet7.getString("floortype");
                localLinkedList4.add(str31);
                localLinkedList5.add(str32);
                if (Integer.parseInt(str32) >= 10)
                  localLinkedList2.add(str8 + str31 + str32);
                else {
                  localLinkedList2.add(str8 + str31 + "0" + str32);
                }
                localLinkedList6.add(getbyte1(localResultSet7.getString("area")));
                localLinkedList7.add(localResultSet7.getString("code"));
                localLinkedList9.add(getbyte1(localResultSet7.getString("floormess")));
                localLinkedList10.add(getbyte1(localResultSet7.getString("showfloors")));
                localLinkedList11.add(localResultSet7.getString("dis"));
                localLinkedList12.add(getbyte1(localResultSet7.getString("tddate")));
                localLinkedList13.add(getbyte1(localResultSet7.getString("sumprice")));
              }
              localResultSet7.close();
              int i15 = 0;

              this.alertmess += " <td align=\"center\" valign=\"top\">";
              if (!str8.equals("")) this.alertmess = (this.alertmess + str8 + "单元");
              this.alertmess += " <table border=\"0\" width=\"100%\" CELLSPACING=1 CELLPADDING=0>";
              if ((str9.indexOf("墅") < 0) && (str9.indexOf("车") < 0)) {
                this.alertmess += "  <tr>";
                this.alertmess += "   <td  width=\"1%\" bgcolor=\"#800000\" align=\"center\"><img src=\"../images/1.gif\" border=\"0\"></td>";

                char i16 = str21.charAt(0);
                str21 = str21.substring(str21.length() - 1);

                char i17 = str21.charAt(0);
                for (int i18 = n; i18 <= i1; i18++) {
                  String str33 = "";
                  str33 = localasicc.AsiicZH(i18, i17);

                  if ((((String)localObject2).indexOf(String.valueOf(i18)) >= 0) || (str20.indexOf((String)localObject2) >= 0)) {
                    if (str20.indexOf((String)localObject2) >= 0)
                    {
                      if (!localLinkedList1.contains(String.valueOf(i18)))
                      {
                        this.alertmess += "<td align=\"center\" class=listtitle ";
                        this.alertmess += "   colspan=\"2\"";
                        this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33 + "</font></td>");
                      }
                    } else if (!localLinkedList1.contains(String.valueOf(i18)))
                    {
                      this.alertmess += "  <td align=\"center\" class=listtitle ";
                      this.alertmess += "   colspan='2'";
                      this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33 + "</font></td>");
                    }
                  }
                  else if (!localLinkedList1.contains(String.valueOf(i18)))
                  {
                    this.alertmess += "  <td align=\"center\" class=listtitle ";
                    this.alertmess += "  colspan='2'";
                    this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33 + "</font></td>");
                  }

                }

                this.alertmess += "  </tr>";
              }
              this.alertmess += "  <tr>";
              int i16 = 0;
              float f1;
              float f2;
              int i19;
              String str34;
              String str37;
              for (int i17 = m; i17 >= k; i17--) {
                i16 = 0;
                if (i16 == 0) this.alertmess += "<tr>";
                if ((str9.indexOf("墅") < 0) && (str9.indexOf("车") < 0))
                  this.alertmess = (this.alertmess + "  <td align=\"center\" class=FloorC width=\"1%\"><font color=\"#ffffff\"><div id=A" + String.valueOf(Math.abs(i17)) + 1 + "w1>" + i17 + "</div></font></td>");
                else {
                  this.alertmess = (this.alertmess + " <div style='display:none' id=A" + String.valueOf(Math.abs(i17)) + 1 + "w1>" + i17 + "</div>");
                }
                f1 = 0.0F;
                f2 = 0.0F;
                for (i19 = n; i19 <= i1; i19++) {
                  if (i16 == i5) { i16 = 0; this.alertmess += "</tr><tr>"; }
                  if (!localLinkedList1.contains(String.valueOf(i19))) {
                    i16++;
                    this.no = "";
                    str34 = "";
                    this.no = "";
                    String str35 = "0"; str37 = "";
                    if (i19 >= 10)
                      str34 = str8 + String.valueOf(i17) + String.valueOf(i19);
                    else
                      str34 = str8 + String.valueOf(i17) + "0" + String.valueOf(i19);
                    i15++;

                    if (localLinkedList2.contains(str34)) {
                      int i21 = localLinkedList2.indexOf(str34);
                      this.state = getbyte((String)localLinkedList3.get(i21));

                      str34 = (String)localLinkedList8.get(i21);
                      str26 = (String)localLinkedList9.get(i21);
                      str24 = (String)localLinkedList10.get(i21);
                      if (this.state.equals("1"))
                        try {
                          str27 = (String)localLinkedList7.get(i21);
                          str28 = (String)localLinkedList6.get(i21);
                          String str39 = (String)localLinkedList13.get(i21);
                          if ((str27.equals("")) || (str27 == null)) str27 = "0";
                          if ((str28.equals("")) || (str28 == null)) str28 = "0";
                          if ((str39.equals("")) || (str39 == null)) str39 = "0";
                          f1 += Float.parseFloat(str39);
                          f2 += Float.parseFloat(str28); } catch (Exception localException4) {
                        }
                    } else {
                      this.state = "";
                    }String str38 = "";
                    if (((i17 != 3) || (i19 != 4)) || 
                      (this.state.equals("1"))) str38 = "BGCOLOR='" + str17 + "'";
                    else if (this.state.equals("2")) str38 = "bgcolor='" + str12 + "'";
                    else if (this.state.equals("3")) str38 = "bgcolor='" + str13 + "'";
                    else if (this.state.equals("4")) str38 = "bgcolor='" + str14 + "'";
                    else if (this.state.equals("5")) str38 = "bgcolor='" + str16 + "'";

                    this.no = str34;

                    if (this.condi.equals("wen")) {
                      str38 = "BGCOLOR='" + str17 + "'";
                      if (this.state.equals("3")) str34 = "已售" + this.no;
                      else if (this.state.equals("2")) str34 = "已认购" + this.no;
                      else if (this.state.equals("4")) str34 = "已预留" + this.no;
                      else if (this.state.equals("1")) str34 = "未售" + this.no;
                      else if (this.state.equals("5")) str34 = "临定" + this.no;
                      else if (this.state.equals("7")) str34 = "出租" + this.no; 
                    }
                    else if (this.condi.equals("pic")) {
                      str38 = "BGCOLOR='" + str17 + "'";
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
                    if (this.state.equals("1")) str38 = "BGCOLOR='" + str17 + "'";
                    if (this.state.equals("2")) str38 = "bgcolor='" + str12 + "'";

                    if ((!this.state.equals("2")) && (!this.state.equals("3")) && (!this.state.equals("")))
                    {
                      i6++;
                    }
                    else i7++;

                    this.alertmess = (this.alertmess + "  <td align=\"center\" width=\"5%\"  " + str38);

                    this.alertmess += "  >";
                    if (!this.state.equals(""))
                      this.alertmess += str34;
                    if ((!this.state.equals("2")) && (!this.state.equals("3")) && (!this.state.equals("")))
                      this.alertmess = (this.alertmess + " <a href='#aa' onclick=\"openwinzy('zy2.jsp?code=" + str27 + "',650,450,100,100);\">打印</a> ");
                    this.alertmess += "</td> ";
                  }

                }

                this.alertmess = (this.alertmess + "  <script>A" + String.valueOf(Math.abs(i17)) + 1 + "w1.innerHTML=\"");
                if (!str26.equals("")) this.alertmess = (this.alertmess + String.valueOf(i17) + str26); else
                  this.alertmess += i17;
                this.alertmess += "\" ;</script>";

                this.alertmess += " </tr>";
              }

              for (int i17 = i2; i17 <= -1; i17++)
              {
                this.alertmess += " <tr> ";
                f1 = 0.0F;
                f2 = 0.0F;
                for (i19 = n; i19 <= i1; i19++) {
                  if (!localLinkedList1.contains(String.valueOf(i19))) {
                    this.no = "";
                    str34 = "";
                    this.no = "";
                    if (i19 >= 10)
                      str34 = str8 + String.valueOf(i17) + String.valueOf(i19);
                    else
                      str34 = str8 + String.valueOf(i17) + "0" + String.valueOf(i19);
                    i15++;

                    if (localLinkedList2.contains(str34)) {
                      int i20 = localLinkedList2.indexOf(str34);
                      this.state = ((String)localLinkedList3.get(i20));
                      str34 = (String)localLinkedList8.get(i20);
                      str26 = (String)localLinkedList9.get(i20);
                      str24 = (String)localLinkedList10.get(i20);
                      if (this.state.equals("1"))
                        try {
                          str27 = (String)localLinkedList7.get(i20);
                          str28 = (String)localLinkedList6.get(i20);
                          str37 = (String)localLinkedList13.get(i20);
                          if ((str27.equals("")) || (str27 == null)) str27 = "0";
                          if ((str28.equals("")) || (str28 == null)) str28 = "0";
                          if ((str37.equals("")) || (str37 == null)) str37 = "0";

                          f1 += Float.parseFloat(str37);
                          f2 += Float.parseFloat(str28); } catch (Exception localException3) {
                        }
                    } else {
                      this.state = "";
                    }String str36 = "";
                    if (((i17 != 3) || (i19 != 4)) || 
                      (this.state.equals("1"))) str36 = "BGCOLOR='" + str17 + "'";
                    if (this.state.equals("2")) str36 = "bgcolor='" + str12 + "'";

                    if (this.state.equals("3")) str36 = "bgcolor='#E5C862'";
                    if (this.state.equals("4")) str36 = "bgcolor='#8DE4A6'";
                    if (this.state.equals("5")) str36 = "bgcolor='#FF00FF'";
                    if (this.state.equals("6")) str36 = "bgcolor='#AACC6F'";
                    if (this.state.equals("7")) { str36 = "bgcolor='#AACC6F'"; i9++; }
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

                    if ((!this.state.equals("2")) && (!this.state.equals("3")) && (!this.state.equals("")))
                      i6++;
                    else {
                      i7++;
                    }

                    this.alertmess = (this.alertmess + "  <td align=\"center\" width=\"5%\"  " + str36);

                    this.alertmess += "  >";
                    if (!this.state.equals(""))
                      this.alertmess += str34;
                    if ((!this.state.equals("2")) && (!this.state.equals("3")) && (!this.state.equals("")))
                      this.alertmess = (this.alertmess + " <a href='#aa' onclick=\"openwinzy('zy2.jsp?code=" + str27 + "',650,450,100,100);\">打印</a> ");
                    this.alertmess += "</td> ";
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

          this.alertmess = (this.alertmess + "  wy" + i + ".innerHTML = \"" + i6 + "\";");
          this.alertmess = (this.alertmess + " w1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i6)) / (i11 + i6 + i10 + i8 + i7) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + " ry" + i + ".innerHTML = \"" + i7 + "\";");
          int i13 = i11 + i6 + i10 + i8 + i7 + i9;
          this.alertmess = (this.alertmess + " sum" + i + ".innerHTML = '合计：" + i13 + "';");
          this.alertmess += "</script>";
          this.alertmess += "  </td>";
        }
      }
      this.alertmess += "</tr></table>";
    } catch (Exception localException1) {
      System.out.println(localException1);
    }return this.alertmess;
  }

	public String BeanCodeShow3(String paramString1, String paramString2)
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
          int j = 1;
          if (localResultSet3.next()) {
        	  j = localResultSet3.getInt("floor"); 
          }
          localResultSet3.close();
          this.sql = "select max(len(cell)) cell from ";

          this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
          this.sql = (this.sql + "  and Region='" + this.Loft + "'");
          String str5 = "";
          localResultSet3 = localSDatabase2.executeQuery(this.sql);
          if (localResultSet3.next())
          {
            str5 = localResultSet3.getString("cell");
          }

          localResultSet3.close();

          if (str5.equals("2")) {
            this.sql = "select min(Floor) as BeginF,max(Floor) as EndF,";
            this.sql += "min(Room) as BeginR,max(Room) as EndR, max(convert(int,cell))  as Ecell ,min(cell) as Scell from";
            this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
            this.sql = (this.sql + " and Region='" + this.Loft + "'");
          }
          else
          {
            this.sql = "select min(Floor) as BeginF,max(Floor) as EndF,";
            this.sql += "min(Room) as BeginR,max(Room) as EndR, max(cell)  as Ecell ,min(cell) as Scell from";
            this.sql = (this.sql + " RoomNo where SectionNo='" + this.strSection + "'");
            this.sql = (this.sql + "   and Region='" + this.Loft + "'");
          }

          localResultSet3 = localSDatabase2.executeQuery(this.sql);
          int k = 0;
          int m = 0;
          int n = 0;
          int i1 = 0;
          int i2 = 0;
          String str6 = "";
          String str7 = "";
          String str8 = "";
          if (localResultSet3.next()) {
            k = localResultSet3.getInt("BeginF");

            m = localResultSet3.getInt("EndF");
            n = localResultSet3.getInt("BeginR");
            i1 = localResultSet3.getInt("EndR");
            str6 = getbyte(localResultSet3.getString("Ecell"));
            str7 = getbyte(localResultSet3.getString("Scell"));
            if ((str7.equals("")) && (str6.equals(""))) { str6 = " "; str7 = " "; }
          }
          localResultSet3.close();
          int i3 = 0; int i4 = 0;
          char c2 = str7.charAt(0);
          char c3 = str6.charAt(0);
          if ((!str7.equals("")) && (!str6.equals(""))) {
            c2 = str7.charAt(0);
            c3 = str6.charAt(0);
            if (Character.isDigit(c2)) {
              i3 = Integer.parseInt(str7);
              i4 = Integer.parseInt(str6);
            } else {
              i3 = Character.getNumericValue(c2) - 9;
              i4 = Character.getNumericValue(c3) - 9;
            }
          }
          if (i3 < 0) i3 = 0;
          if (i4 < 0) i4 = 0;
          String str9 = "";
          String str10 = "";
          int i5 = 20;
          String str11 = "select room_type,ts from LoftBuildCode where SECNO='" + this.strSection + "' and loft='" + this.Loft + "'";

          ResultSet localResultSet4 = localSDatabase2.executeQuery(str11);
          if (localResultSet4.next()) {
            str10 = localResultSet4.getString("room_type");
            i5 = localResultSet4.getInt("ts");
          }
          localResultSet3 = localSDatabase2.executeQuery("select roomtype from LoftBuildCode where SecNo='" + this.strSection + "' and Loft='" + this.Loft + "' and roomtype=1");
          if (localResultSet3.next()) {
            str9 = "1";
          }
          localResultSet3.close();

          this.alertmess = (this.alertmess + " <input type=hidden name=SecNo value=\"" + this.strSection + "\">");
          this.alertmess = (this.alertmess + "<input type=hidden name=SecName value=\"" + this.SecName + "\">");
          this.alertmess = (this.alertmess + "<input type=hidden name=Loft value=\"" + this.Loft + "\">");
          this.alertmess += "<input type=hidden name=Build value=\"\">";
          this.alertmess += "<input type=hidden name=cusname value=\"\">";
          this.alertmess += "<input type=hidden name=secname value=\"\">";
          String str12 = "#00CCFF";
          String str13 = "#E5C862";
          String str14 = "#8DE4A6";
          String str15 = "#AACC6F";
          String str16 = "#FF00FF";
          String str17 = "#DDE8E8";
          if (!this.strSection.equals("")) {
            String str18 = "select  *  from SaleStateColor WHERE secno='" + this.strSection + "'";

            ResultSet localResultSet5 = localSDatabase2.executeQuery(str18);
            if (localResultSet5.next()) {
              str12 = localResultSet5.getString("RG");
              str13 = localResultSet5.getString("QY");
              str16 = localResultSet5.getString("ld");
              str15 = localResultSet5.getString("CZ");
              str14 = localResultSet5.getString("YL");
              str17 = localResultSet5.getString("ws");
            }

            localResultSet5.close();
          }
          if (str12.equals("")) {
            this.alertmess += "<script>";
            this.alertmess += "alert(\"还没有设置为销控表设置状态色块,请在系统管理中设置\");";

            this.alertmess += "</script>";
          }

          String str18 = paramString1;
          if (str18 == null) str18 = "";

          this.alertmess += " <p CLASS=FontColor align=\"center\"><b><font size=\"3\" >";

          if (!this.SecName.equals(this.Loft)) this.alertmess += this.SecName; this.alertmess = (this.alertmess + this.Loft + " 销控表</font></b></p>");
          this.alertmess += " <table width=\"98%\" border=\"0\"  align=\"center\" CELLSPACING=1 CELLPADDING=3>";

          this.alertmess = (this.alertmess + "<td bgcolor='" + str17 + "'  align=\"center\">未售</td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str12 + "'  align=\"center\">已售<img src='../images/mypw.gif' border='0' ></td>");
          this.alertmess += "<td   align=\"center\">";
          this.alertmess += " </td>";
          this.alertmess += "</tr>";
          this.alertmess = (this.alertmess + " <tr><td bgcolor='" + str17 + "' align=\"center\"><div id=wy" + i + "></div></td>");
          this.alertmess = (this.alertmess + "<td bgcolor='" + str12 + "'  align=\"center\"><div id=ry" + i + "></div></td>");
          this.alertmess = (this.alertmess + "  <td   align=\"center\"><div id=sum" + i + "> </div>");
          this.alertmess += " </td>";
          this.alertmess += " \t</tr>";
          this.alertmess = (this.alertmess + "  <tr><td bgcolor='" + str17 + "' align=\"center\"><div id=w1" + i + "></div></td>");
          this.alertmess = (this.alertmess + " <td bgcolor='" + str12 + "'  align=\"center\"><div id=r1" + i + "></div></td>");
          this.alertmess += " </td>";
          this.alertmess += " <td   align=\"center\"> ";
          this.alertmess += " </td>";
          this.alertmess += " </tr>";
          this.alertmess += " </table>";

          int i6 = 0;
          int i7 = 0;
          int i8 = 0;
          int i9 = 0;
          int i10 = 0;
          int i11 = 0;

          String str19 = "";
          if (str19 == null) str19 = "";

          String str20 = "ABCDEFGHIJKLOPQRST";
          str20 = str20.trim();
          int i12 = 0;
          String str21 = "";
          String str22 = "select top 1 Room_code from Room where seccode=";
          str22 = str22 + "'" + this.strSection + "' and Building='";
          str22 = str22 + this.strBuilding + "' and loft='" + this.Loft + "'  ";
          ResultSet localResultSet6 = localSDatabase2.executeQuery(str22);
          if (localResultSet6.next()) str21 = localResultSet6.getString("Room_code");
          localResultSet6.close();

          if (str21.equals(""))
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
            for (int i13 = i3; i13 <= i4; i13++) {
              if (i3 > 0) {
                str8 = localasicc.AsiicZH(i13, c2);
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
              String str23 = ""; String str24 = "";
              String str25 = "";
              String str26 = "";
              String str27 = "";
              String str28 = "";
              String str29 = "ABCDEFGHIJKLOPQRST";

              String str30 = "select  a.dis, a.tddate,a.Room_code,case when a.type=1 and a.salestate=1 and a.ssstate=0 then 1 else 2 end SaleState,a.Floor,a.Room,a.area,a.code,a.sumprice,a.floorshow,a.floortype,a.floormess,b.showfloors from roomstateview a,roomno b where a.seccode+a.loft+a.room_code= b.SectionNo+b.region+b.roomno and a.seccode=";
              str30 = str30 + "'" + this.strSection + "'";
              str30 = str30 + str2 + " and  a.cell='" + str8 + "' and a.floortype=0    order by a.Floor";
              ResultSet localResultSet7 = localSDatabase2.executeQuery(str30);
              int i14 = 0;
              while (localResultSet7.next())
              {
                localLinkedList8.add(localResultSet7.getString("Room_code"));
                localLinkedList3.add(localResultSet7.getString("SaleState"));
                String str31 = localResultSet7.getString("Floor");
                String str32 = localResultSet7.getString("Room");
                str23 = localResultSet7.getString("floorshow");
                str25 = localResultSet7.getString("floortype");
                localLinkedList4.add(str31);
                localLinkedList5.add(str32);
                if (Integer.parseInt(str32) >= 10)
                  localLinkedList2.add(str8 + str31 + str32);
                else {
                  localLinkedList2.add(str8 + str31 + "0" + str32);
                }
                localLinkedList6.add(getbyte1(localResultSet7.getString("area")));
                localLinkedList7.add(localResultSet7.getString("code"));
                localLinkedList9.add(getbyte1(localResultSet7.getString("floormess")));
                localLinkedList10.add(getbyte1(localResultSet7.getString("showfloors")));
                localLinkedList11.add(localResultSet7.getString("dis"));
                localLinkedList12.add(getbyte1(localResultSet7.getString("tddate")));
                localLinkedList13.add(getbyte1(localResultSet7.getString("sumprice")));
              }
              localResultSet7.close();
              int i15 = 0;

              this.alertmess += " <td align=\"center\" valign=\"top\">";
              if (!str8.equals("")) this.alertmess = (this.alertmess + str8 + "单元");
              this.alertmess += " <table border=\"0\" width=\"100%\" CELLSPACING=1 CELLPADDING=0>";
              if ((str10.indexOf("墅") < 0) && (str10.indexOf("车") < 0)) {
                this.alertmess += "  <tr>";
                this.alertmess += "   <td  width=\"1%\" bgcolor=\"#800000\" align=\"center\"><img src=\"../images/1.gif\" border=\"0\"></td>";

                char i16 = str21.charAt(0);
                str21 = str21.substring(str21.length() - 1);

                char i17 = str21.charAt(0);
                for (int i18 = n; i18 <= i1; i18++) {
                  String str33 = "";
                  str33 = localasicc.AsiicZH(i18, i17);

                  if ((((String)localObject2).indexOf(String.valueOf(i18)) >= 0) || (str20.indexOf((String)localObject2) >= 0)) {
                    if (str20.indexOf((String)localObject2) >= 0)
                    {
                      if (!localLinkedList1.contains(String.valueOf(i18)))
                      {
                        this.alertmess += "<td align=\"center\" class=listtitle ";
                        this.alertmess += "   colspan=\"2\"";
                        this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33 + "</font></td>");
                      }
                    } else if (!localLinkedList1.contains(String.valueOf(i18)))
                    {
                      this.alertmess += "  <td align=\"center\" class=listtitle ";
                      this.alertmess += "   colspan='2'";
                      this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33 + "</font></td>");
                    }
                  }
                  else if (!localLinkedList1.contains(String.valueOf(i18)))
                  {
                    this.alertmess += "  <td align=\"center\" class=listtitle ";
                    this.alertmess += "  colspan='2'";
                    this.alertmess = (this.alertmess + "   width=\"5%\"><font color=\"#ffffff\">" + str33 + "</font></td>");
                  }

                }

                this.alertmess += "  </tr>";
              }
              this.alertmess += "  <tr>";

              int i16 = 0;
              float f1;
              float f2;
              int i19;
              String str34;
              String str37;
              for (int i17 = k; i17 <= m; i17++) {
                i16 = 0;
                if (i16 == 0) this.alertmess += "<tr>";
                if ((str10.indexOf("墅") < 0) && (str10.indexOf("车") < 0))
                  this.alertmess = (this.alertmess + "  <td align=\"center\" class=FloorC width=\"1%\"><font color=\"#ffffff\"><div id=A" + String.valueOf(Math.abs(i17)) + 1 + "w1>" + i17 + "</div></font></td>");
                else {
                  this.alertmess = (this.alertmess + " <div style='display:none' id=A" + String.valueOf(Math.abs(i17)) + 1 + "w1>" + i17 + "</div>");
                }
                f1 = 0.0F;
                f2 = 0.0F;
                for (i19 = n; i19 <= i1; i19++) {
                  if (i16 == i5) { i16 = 0; this.alertmess += "</tr><tr>"; }
                  if (!localLinkedList1.contains(String.valueOf(i19)))
                  {
                    i16++;
                    this.no = "";
                    str34 = "";
                    this.no = "";
                    String str35 = "0"; str37 = "";
                    if (i19 >= 10)
                      str34 = str8 + String.valueOf(i17) + String.valueOf(i19);
                    else
                      str34 = str8 + String.valueOf(i17) + "0" + String.valueOf(i19);
                    i15++;

                    if (localLinkedList2.contains(str34)) {
                      int i21 = localLinkedList2.indexOf(str34);
                      this.state = getbyte((String)localLinkedList3.get(i21));

                      str34 = (String)localLinkedList8.get(i21);
                      str26 = (String)localLinkedList9.get(i21);
                      str24 = (String)localLinkedList10.get(i21);
                      if (this.state.equals("1"))
                        try {
                          str27 = (String)localLinkedList7.get(i21);
                          str28 = (String)localLinkedList6.get(i21);
                          String str39 = (String)localLinkedList13.get(i21);
                          if ((str27.equals("")) || (str27 == null)) str27 = "0";
                          if ((str28.equals("")) || (str28 == null)) str28 = "0";
                          if ((str39.equals("")) || (str39 == null)) str39 = "0";
                          f1 += Float.parseFloat(str39);
                          f2 += Float.parseFloat(str28); } catch (Exception localException4) {
                        }
                    } else {
                      this.state = "";
                    }String str38 = "";
                    if (((i17 != 3) || (i19 != 4)) || 
                      (this.state.equals("1"))) str38 = "BGCOLOR='" + str17 + "'";
                    else if (this.state.equals("2")) str38 = "bgcolor='" + str12 + "'";
                    else if (this.state.equals("3")) str38 = "bgcolor='" + str13 + "'";
                    else if (this.state.equals("4")) str38 = "bgcolor='" + str14 + "'";
                    else if (this.state.equals("5")) str38 = "bgcolor='" + str16 + "'";

                    this.no = str34;

                    if (this.condi.equals("wen")) {
                      str38 = "BGCOLOR='" + str17 + "'";
                      if (this.state.equals("3")) str34 = "已售" + this.no;
                      else if (this.state.equals("2")) str34 = "已认购" + this.no;
                      else if (this.state.equals("4")) str34 = "已预留" + this.no;
                      else if (this.state.equals("1")) str34 = "未售" + this.no;
                      else if (this.state.equals("5")) str34 = "临定" + this.no;
                      else if (this.state.equals("7")) str34 = "出租" + this.no; 
                    }
                    else if (this.condi.equals("pic")) {
                      str38 = "BGCOLOR='" + str17 + "'";
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


                    if ((!this.state.equals("2")) && (!this.state.equals("3")) && (!this.state.equals("")))
                    {
                      i6++;
                    }
                    else i7++;

                    this.alertmess = (this.alertmess + "  <td align=\"center\" width=\"5%\"  " + str38);

                    this.alertmess += "  >";
                    if (!this.state.equals(""))
                      this.alertmess += str34;
                    if ((!this.state.equals("2")) && (!this.state.equals("3")) && (!this.state.equals("")))
                      this.alertmess = (this.alertmess + " <a href='#aa' onclick=\"openwinzy('zy2.jsp?code=" + str27 + "',650,450,100,100);\">打印</a> ");
                    this.alertmess += "</td> ";
                  }

                }

                this.alertmess = (this.alertmess + "  <script>A" + String.valueOf(Math.abs(i17)) + 1 + "w1.innerHTML=\"");
                if (!str26.equals("")) this.alertmess = (this.alertmess + String.valueOf(i17) + str26); else
                  this.alertmess += i17;
                this.alertmess += "\" ;</script>";

                this.alertmess += " </tr>";
              }

              for (int i17 = i2; i17 <= -1; i17++)
              {
                this.alertmess += " <tr> ";
                f1 = 0.0F;
                f2 = 0.0F;
                for (i19 = n; i19 <= i1; i19++) {
                  if (!localLinkedList1.contains(String.valueOf(i19))) {
                    this.no = "";
                    str34 = "";
                    this.no = "";
                    if (i19 >= 10)
                      str34 = str8 + String.valueOf(i17) + String.valueOf(i19);
                    else
                      str34 = str8 + String.valueOf(i17) + "0" + String.valueOf(i19);
                    i15++;

                    if (localLinkedList2.contains(str34)) {
                      int i20 = localLinkedList2.indexOf(str34);
                      this.state = ((String)localLinkedList3.get(i20));
                      str34 = (String)localLinkedList8.get(i20);
                      str26 = (String)localLinkedList9.get(i20);
                      str24 = (String)localLinkedList10.get(i20);
                      if (this.state.equals("1"))
                        try {
                          str27 = (String)localLinkedList7.get(i20);
                          str28 = (String)localLinkedList6.get(i20);
                          str37 = (String)localLinkedList13.get(i20);
                          if ((str27.equals("")) || (str27 == null)) str27 = "0";
                          if ((str28.equals("")) || (str28 == null)) str28 = "0";
                          if ((str37.equals("")) || (str37 == null)) str37 = "0";

                          f1 += Float.parseFloat(str37);
                          f2 += Float.parseFloat(str28); } catch (Exception localException3) {
                        }
                    } else {
                      this.state = "";
                    }String str36 = "";
                    if (((i17 != 3) || (i19 != 4)) || 
                      (this.state.equals("1"))) str36 = "BGCOLOR='#DDE8E8'";
                    if (this.state.equals("2")) str36 = "bgcolor='#00CCFF'";
                    if (this.state.equals("3")) str36 = "bgcolor='#E5C862'";
                    if (this.state.equals("4")) str36 = "bgcolor='#8DE4A6'";
                    if (this.state.equals("5")) str36 = "bgcolor='#FF00FF'";
                    if (this.state.equals("6")) str36 = "bgcolor='#AACC6F'";
                    if (this.state.equals("7")) { str36 = "bgcolor='#AACC6F'"; i9++; }
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


                    if ((!this.state.equals("2")) && (!this.state.equals("3")) && (!this.state.equals("")))
                    {
                      i6++;
                    }
                    else i7++;

                    this.alertmess = (this.alertmess + "  <td align=\"center\" width=\"5%\"  " + str36);

                    this.alertmess += "  >";
                    if (!this.state.equals(""))
                      this.alertmess += str34;
                    if ((!this.state.equals("2")) && (!this.state.equals("3")) && (!this.state.equals("")))
                      this.alertmess = (this.alertmess + " <a href='#aa' onclick=\"openwinzy('zy2.jsp?code=" + str27 + "',650,450,100,100);\">打印</a> ");
                    this.alertmess += "</td> ";
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

          this.alertmess = (this.alertmess + "  wy" + i + ".innerHTML = \"" + i6 + "\";");
          this.alertmess = (this.alertmess + " w1" + i + ".innerHTML = \"" + localFormatData.getFloat(Float.parseFloat(String.valueOf(i6)) / (i11 + i6 + i10 + i8 + i7) * 100.0F, 2) + "%\";");
          this.alertmess = (this.alertmess + " ry" + i + ".innerHTML = \"" + i7 + "\";");
          int i13 = i11 + i6 + i10 + i8 + i7 + i9;
          this.alertmess = (this.alertmess + " sum" + i + ".innerHTML = '合计：" + i13 + "';");
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