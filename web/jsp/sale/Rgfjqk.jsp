<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/news.css" rel=stylesheet>
<script src="js/mad.js"> </script>
</head>
<%@ page contentType="text/html;charset=GBK" %>
  <%@ page import="java.sql.*,common.*,java.util.*" %>

  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
  <%@ include file="../public_js/getByteOut.jsp"%>
  <%@ include file="../public_js/checktime.jsp"%>
  <%
  	String section2 = China.getParameter(request,"Section");
	String building2 = China.getParameter(request,"Building") ;
	String layer2 = China.getParameter(request,"Layer") ;
	String room2 = China.getParameter(request,"Room") ;
	String roomType2 = China.getParameter(request,"RoomType") ;
	String area2 = China.getParameter(request,"Area") ;
	String direction2 = China.getParameter(request,"Direction") ;
	String sectionName2 = "" ;
	if (!section2.equals("")) {
		SelectList sl = new SelectList() ;
		sl.getList("select serialno,name from section","serialno","name") ;
		sectionName2 = sl.getValue(section2) ;
	}
	
	//section = new String(section.getBytes("ISO8859_1"),"GBK");
	//String secVal = request.getParameter("SecVal");
	//secVal = new String(secVal.getBytes("ISO8859_1"),"GBK");
	
	//String year = request.getParameter("Year");
	//String month = request.getParameter("Month");
	//out.print(section);
	Timestamp ts = new Timestamp(System.currentTimeMillis());
	String rq = ts.toString().substring(0,10);
	//out.print(rq);
	String SectionS=(String)session.getAttribute("Section");
%>
<script>
	function loadbody() {
		setSelectMad(document.dform.Section,"<%= section2 %>") ;
		document.dform.Building.value = "<%= building2 %>" ;
		document.dform.Layer.value = "<%= layer2 %>" ;
		document.dform.Room.value = "<%= room2 %>" ;
		setSelectMad(document.dform.RoomType,"<%= roomType2 %>") ;
		setSelectMad(document.dform.Area,"<%= area2 %>") ;
		setSelectMad(document.dform.Direction,"<%= direction2 %>") ;
	}	
	
		  	function printall() {
				printdiv.innerText = "" ;
			}

</script>	
<body bgcolor="#FFFFFF" text="#000000" onload="loadbody()">
<div id=printdiv>
<form name="dform" method="post" action="">
  <table width="104%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
    <td> 
      
        <div align="left">楼盘: 
          <SELECT NAME="Section" ONCHANGE="">
		  <option value="">
            <%
			out.println(getbyte(commonListBean.getList(aBean,"serialno","name"," FROM crm_project where  SerialNo in("+SectionS+")")));
		%>
          </SELECT>
          栋号: 
          <input type="text" name="Building" size="4">
          楼层: 
          <input type="text" name="Layer" size="4">
          房号: 
          <input type="text" name="Room" size="4">
          户型: 
          <select name="RoomType">
            <option value=""> 
            <option value="一房一厅">一房一厅 
            <option value="两房一厅">两房一厅 
            <option value="两房两厅">两房两厅 
            <option value="三房两厅">三房两厅 
            <option value="四房两厅">四房两厅 
          </select><br>
          面积: 
          <select name="Area">
            <option value=""> 
            <option value="50-">小于50 
            <option value="50+100-">50~100 
            <option value="100+150-">100~150 
            <option value="150+">大于150 
          </select>          朝向: 
          <select name="Direction">
            <option value=""> 
            <option value="东">东 
            <option value="南">南 
            <option value="西">西 
            <option value="北">北 
            <option value="东南">东南 
            <option value="东北">东北 
            <option value="西南">西南 
            <option value="西北">西北 
          </select>
        </div>
    
    </td>
  </tr>
  <tr> 
    <td> 
      <div align="center">
        <input type="submit" name="Submit" value="查找">
          <input type="checkbox" name="ForPrint" value="checkbox" onclick="printall()">
		  
        打印 </div>
    </td>
  </tr>
</table>
  </form>
  </div>
<%!
	public String getFloat(float temp,int lens) {
		java.text.DecimalFormat df = null;
		if (lens == 4)
			df = new java.text.DecimalFormat("##0.0000");
		if (lens == 2)
			df = new java.text.DecimalFormat("###,###,###,##0");
		if (lens == 1)
			df = new java.text.DecimalFormat("##,###,##0.0");	
		return df.format(temp).toString();
	}
%>

<table width="104%" border="0"> <tr> <td colspan="2"> 
<div align="center">认购房间情况表</div></td></tr> 
<tr> <td width="73%"> <div align="right">制表日期：</div></td>
<td width="27%"><%= rq %></td></tr> 
<tr> <td width="73%"> <div align="right">楼盘名称：</div></td>
<td width="27%"><%= sectionName2 %></td></tr> 
<tr> <td width="73%">&nbsp;</td><td width="27%">&nbsp;</td>
</tr> 
</table>
  
<table BORDER=0 width="110%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >

<tr bgcolor="#CFE6EB">

<td  BGCOLOR="#cfe6eb" HEIGHT="18"> 
<div align="center">栋号</div></td><td  BGCOLOR="#cfe6eb" HEIGHT="18"> 
<div align="center">房号</div></td><td  BGCOLOR="#cfe6eb" HEIGHT="18"> 
<div align="center">客户姓名</div></td><td BGCOLOR="#cfe6eb" HEIGHT="18"> 
<div align="center">认购日期</div></td><td  BGCOLOR="#cfe6eb" HEIGHT="18"> 
<div align="center">付款方式</div></td><td  BGCOLOR="#cfe6eb" HEIGHT="18"> 
<div align="center">成交金额</div></td><td  BGCOLOR="#cfe6eb" HEIGHT="18"> 
<div align="center">建筑面积</div></td><TD BGCOLOR="#cfe6eb" HEIGHT="18"> 
<DIV ALIGN="center">套内面积</DIV></TD><td  BGCOLOR="#cfe6eb" HEIGHT="18"> 
<div align="center">户型</div></td><td  BGCOLOR="#cfe6eb" HEIGHT="18"> 
<div align="center">朝向</div></td><td  BGCOLOR="#cfe6eb" HEIGHT="18"> 
<div align="center">装修标准</div></td><td BGCOLOR="#cfe6eb" HEIGHT="18"> 
<div align="center">销售员</div></td></tr>

 <%	
 
 	String sectionStr2 = "" ;
	String buildingStr2 = "" ;
	String layerStr2 = "" ;
	String roomStr2 = "" ;
	String areaStr2 = "" ;
	String roomTypeStr2 = "" ;
	String directionStr2 = "" ;
	
	if (!section2.equals(""))
			sectionStr2 = " and secno='" + section2 + "' ";
	if (!building2.equals(""))
			buildingStr2 = " and building like '%" + building2 + "%' " ;
	if (!layer2.equals("")) 
			layerStr2 = " and substring(room_no,1,len(room_no)-2)='" + layer2 + "' " ;
	if (!room2.equals(""))
			roomStr2 = " and room_no='" + room2 + "' " ;
	if (!area2.equals("")) {
		if (area2.equals("50-"))
			areaStr2 = " and jzarea<50 " ;
		else if (area2.equals("50+100-"))
			areaStr2 = " and jzarea<100 and jzarea>50 " ;
		else if (area2.equals("100+150-"))
			areaStr2 = " and jzarea<150 and jzarea>100 " ;
		else if (area2.equals("150+"))
			areaStr2 = " and jzarea>150 " ;			
	}
	if (!roomType2.equals(""))
		roomTypeStr2 = " and roomType='" + roomType2 + "' " ;
	if (!direction2.equals(""))
		directionStr2 = " and direction='" + direction2 + "' " ;
	String xsStr = "select * from  rghjqkv2 where secno in ("+SectionS+")";//where section='" + section + "' where id>0 "; 
	xsStr = xsStr + sectionStr2 + buildingStr2 + layerStr2 ;
	xsStr = xsStr + roomStr2 + roomTypeStr2 + areaStr2 + directionStr2 ;
	//xsStr = xsStr + 
	//xsStr = xsStr + 
	//out.print(xsStr);
	//out.close();
	String building;
	String room;
	String cus_name;
	String rgno;
	String date;
	String paymentType;
	float formerPrice;
	float discont;
	float salerPrice;
	float area;
	float jzArea;
	String roomType;
	String direction;
	String fitment;
	String name;
	String discontStr = "";
	String salerPriceStr = "";
	String areaStr = "";
	String areaJzStr = "";
	ResultSet aRS = aBean.executeQuery(xsStr);
	int i = 0;
	while(aRS.next())  {
		i ++;
		
		building = getbyte(aRS.getString("building"));
		room = aRS.getString("room_no");
		cus_name = getbyte(aRS.getString("cus_name"));
		rgno = aRS.getString("rgno");
		date = aRS.getString("date");
		date = date.substring(0,4) + "-" + date.substring(5,7) + "-" + date.substring(8,10);
		paymentType = getbyte(aRS.getString("payment"));
		//formerPrice = aRS.getFloat("formerPrice");
		//discont= aRS.getFloat("discont");
		//discontStr = getFloat(discont,2);
		salerPrice  = aRS.getFloat("salerprice");
		salerPriceStr = getFloat(salerPrice,2);
		area = aRS.getFloat("area");
		areaStr = getFloat(area,1);
		jzArea = aRS.getFloat("jzarea");
		areaJzStr = getFloat(jzArea,1);
		roomType = getbyte(aRS.getString("roomtype"));
		direction = getbyte(aRS.getString("direction"));
		fitment = getbyte(aRS.getString("fitment"));
		name = aRS.getString("seller");
  %> <tr BGCOLOR="#e6f9ff"> <td > 
<div align="center"><%= building.trim() %></div></td><td > <div align="center"><%= room %></div></td>
<td >
<div align="center"><%= cus_name %></div></td><td > <div align="center"><%= date %></div></td>
<td > 
<div align="center"><%= paymentType %></div></td>
<td>
<div align="center"><%= salerPriceStr %></div></td>
<td > <div align="center"><%= areaJzStr %></div></td><TD WIDTH="7%"> 
<DIV ALIGN="center"><%= areaStr %></DIV></TD>
<td > <div align="center"><%= roomType %></div></td><td width="6%"> 
<div align="center"><%= direction %></div></td>
<td > <div align="center"><%= fitment %></div></td><td width="6%"> 
<div align="center"><%
StringTokenizer st22 = new StringTokenizer(name,",") ;
		int count22 = st22.countTokens() ;
	
		String[] sellers22 = new String[count22] ;
		int j22 = 0 ;
		
		while (st22.hasMoreElements()) {
			sellers22[j22] = (String)st22.nextElement() ;
			j22 ++ ;
		}
		
		String sellerStr2 = "" ;
		String	sellerStr3 = "" ;
			if (sellers22.length > 1)  {
				for (int i2 = 0 ; i2 < sellers22.length ; i2 ++ ) {
					if (i2 == 0) {
						sellerStr2 += "'" + sellers22[i2].trim() + "" ;
						sellerStr3 += "'" + sellers22[i2].trim() + "'" ;
					}	
					else {
						sellerStr2 += "," + sellers22[i2].trim() + "" ;
						sellerStr3 += ",'" + sellers22[i2].trim() + "'" ;
					}		
				}
				sellerStr2 += "'" ;
			} else {
				sellerStr2 = "'" + name + "'" ;
				sellerStr3 = sellerStr2 ;
			}
			name="";
		String nameStr = "select name from CortrolMan where SerialNo" + 
							" in (" + sellerStr3 + ")" ; 
	//	out.print(nameStr) ;
		//out.close() ;
									
		ResultSet nameRS1 =aBean1.executeQuery(nameStr) ;
		
	//	String name = "" ;
		while (nameRS1.next())
			name += nameRS1.getString("name") + " " ;
		
              nameRS1.close();
out.print(name);
%></div></td></tr> <%
  	}
	aRS.close();
  %> </table><table width="100%" border="0"> <tr> <td width="28%">&nbsp;</td><td width="25%">&nbsp;</td><td width="17%">&nbsp;</td><td width="30%">&nbsp;</td></tr> 
<tr> <td width="28%"> <div align="right">总套数：<%=i%></div></td><td width="25%">&nbsp;</td><td width="17%"> 
<div align="right">制表人：</div></td><td width="30%">&nbsp;</td></tr> </table><p>&nbsp;</p>
</body>
</html>
