 <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "价格管理" , 
                  "历史浏览"
                ) ;
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script src="js/mad.js"> </script>
</head>


<%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "java.sql.*,common.*" %>
<jsp:useBean id = "changePriceListBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />

<%@ include file="../public_js/getByteOut.jsp"%>

  <%
    String section = null;
	String building = null;
	String Floor="";
	String RoomNo="";
	String state="";
	String color="";
	String AreaStr="";
	String change2Str = "";
	ResultSet change2RS = null;
	String Loft="";
    String Date="";
	String Times="";
    
    String SectionS="";
    String SecName=China.getParameter(request,"SecName");
    SectionS=China.getParameter(request,"SecNo");
    Loft=China.getParameter(request,"Loft");	 
	building=China.getParameter(request,"Build");
	Floor= China.getParameter(request,"Floor");
	RoomNo=China.getParameter(request,"Room");
	state=China.getParameter(request,"state");		
	Date=China.getParameter(request,"Date");		
	Times=China.getParameter(request,"times");				
	int hasRecord = 0;
   
%>
	 <%
   
		String reportAddr=(String)session.getAttribute("reportAddr");
 %>
<script>
     function Validate(aForm)
   {
      if (aForm.SecNo.value.length<1)
	    	{
	    	alert("请楼盘！");
	        aForm.SecNo.fofrm();
	        return (false);
	    	}	
       if (aForm.build.value.length<1)
		{
	        alert("请输入栋号!");
	        aForm.build.fofrm();
	        return false;
		}
	}	


	var secValue = "<%= section %>";
	var buildValue = "<%= building %>";
	var Floor="<%=Floor%>";
	var Loft1="<%=Loft %>";
	var RoomNo="<%=RoomNo%>";
	var state="<%=state%>";

	function loadSelect() {
		setSelectMad(document.frm.SecNo,secValue);
		document.frm.build.options[document.frm.build.length]=new Option(buildValue,buildValue);
        document.frm.Loft.options[document.frm.Loft.length]=new Option(Loft1,Loft1);

		document.frm.Floor.value = Floor;
		document.frm.Room.value = RoomNo;
		
	}	
	
	
   function check(aa){
   var para=aa;
   alert(para);
   if (para == "查找") {
			document.frm.action = "ChangePriceList.jsp";
			document.frm.submit();
		}
	else{
	
	  document.frm.action = "UpdateRoomPrice.jsp";
	  document.frm.submit();
	}	
   }	
   
   
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<body bgcolor="#FFFFFF" text="#000000"  >
<form name="frm" method="post" action="HistroyPriceList.jsp" >
<input type=hidden name=SecNo value="<%=SectionS %>">
<input type=hidden name=Loft value="<%=Loft %>">
<input type=hidden name=SecName value="<%=SecName %>">
<input type=hidden name=Build value="<%=building %>">
<input type=hidden name=choose>

   <table width="104%" border="0">
      <tr > 
      <td width="90%" align=center class="FontColor"> <b><font size=3> 历史价格列表</font></b>
    </td><!--<td width="10%" align=right ><img src="../picture/helpgif.gif" alt="使用说明"></td>--></tr></table>
  <table width="100%" border="0">
   <tr class=roomright> 
   
      
	  <td>楼层<input type=text name=Floor size="4" ></td>
  	  <td>房号<input type=text name=Room size="4" ></td>
	  <td>调价日期<input type=text name=Date size="12" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date);return false;"></td>
	   <td>第<input type=text name=times size="4" >次调价</td>
	  <td> <input type=submit name=Find value="查找" ><input type=submit name=pic value="线图" onclick="window.open('<%=reportAddr %>/RoomPriceAvgPic.rpt');" ></td>
    </tr>
  </table>
</form>
 <form name="editprice" method=post action="UpdateRoomPrice.jsp?Section=<%=section%>&Building=<%=building%>">

<br>
  <table width="100%" border="1" cellspacing='0'  cellpadding='2' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000 >
    <tr align="center" class=TXTColor> 
      <td rowspan="2" > 楼层 </td>
      <td rowspan="2" > 房号 </td>
      <td colspan="2" >原 价</td>
      <td colspan="2"   >当前价</td>
      <td rowspan="2" > 调价日期 </td>
      <td rowspan="2" > 调价次数 </td>
    </tr>
    <tr align="center" class=TXTColor> 
      <td   > 建筑面积单价</td>
      <td > 原总价</td>
      <td bgcolor="#AA7B46" > 建筑面积单价</td>
      <td bgcolor="#AA7B46" > 现总价</td>
    </tr>
    <%
		int floor=0;	
		int code=0;
		String room="";
		float area=0;
		int salestate=0;
		String  unitprice="";
		String sumprice="";
		String af_unitprice="";
		String af_sumprice="";
		String ch_date="";
		String times="";
		String Sql="";
	%>
    <%	
	
	String strDisabled="";
	String strWhere="";
	int i=0;
	if (!Floor.equals("")){
	    strWhere=" and Floor="+Floor;
	}
	if (!RoomNo.equals("")){
	   if (!strWhere.equals("")){strWhere=strWhere+" and Room_code ='"+RoomNo+"'";}
	   else{strWhere=" and Room_code ='"+RoomNo+"'";}
	}
	if (!state.equals("")){

	   if (!strWhere.equals("")){strWhere=strWhere+" and SaleState="+state;}
	   else{strWhere=" and SaleState="+state;}
   }
   if (!Date.equals("")){

	   if (!strWhere.equals("")){strWhere=strWhere+" and substring(convert(char(24),CH_Date,121),1,10)='"+Date+"'";}
	   else{strWhere=" and  substring(convert(char(24),CH_Date,121),1,10)='"+Date+"'";}
   }
    if (!Times.equals("")){

	   if (!strWhere.equals("")){strWhere=strWhere+" and times="+Times;}
	   else{strWhere=" and  times="+Times;}
   }
	    change2Str = "select * from RoomPriceBackup where seccode ='"+SectionS+"' and Loft='"+Loft+"' and upper(building)='" + building.toUpperCase() + "'"+strWhere+" order by ch_date desc,floor";
		changePriceListBean.executeUpdate("update RoomPriceBackup set out='0'");
		changePriceListBean.executeUpdate("update RoomPriceBackup set out='1' where seccode ='"+SectionS+"' and Loft='"+Loft+"' and upper(building)='" + building.toUpperCase() + "'"+strWhere);
		change2RS = changePriceListBean.executeQuery(change2Str);

		while (change2RS.next()) {
		i=i+1;
			hasRecord = 1;
			code = change2RS.getInt("Code");
			room = change2RS.getString("room_code");
			floor = change2RS.getInt("floor");
			salestate=change2RS.getInt("SaleState");
			unitprice=change2RS.getString("Unitprice");
			sumprice = change2RS.getString("Sumprice");
			
			af_unitprice = change2RS.getString("AF_Unitprice");
		    af_sumprice = change2RS.getString("AF_Sumprice");
			ch_date=change2RS.getString("CH_Date");
			if (ch_date.indexOf(" ")>=0)ch_date=ch_date.substring(0,ch_date.indexOf(" "));
			times=change2RS.getString("times");
		
 %>
    <%switch (salestate)
    {
	  case 1:
	       color="blue";
		   strDisabled="";
		   break;
	  case 2:
	       color="red";
		   strDisabled="disabled"; 
		   break;
	  case 3:
	       color="black";
		   strDisabled="disabled";
		   break;
	  case 4:
	       color="yellow";
		   strDisabled="";
		   break;    
	}
  %>
    <tr align="center" class=listcontent> 
      <td > <%= floor %></td>
      <td ><%=room.trim() %></td>
      <td align="right" > <%=unitprice.trim() %></td>
      <td align="right" ><%=sumprice.trim() %></td>
      <td align="right"  bgcolor="#E8DEDE"><%= af_unitprice %></td>
      <td align="right" bgcolor="#E8DEDE"><%= af_sumprice %></td>
      <td> <%= ch_date %></td>
      <td> <%= times %></td>
    </tr>
    <%

  %>
    <%
   }
 
   change2RS.close();
   %>
    <input type=hidden name=MaxRoomNo value="<%=i%>">
  </table>
</form>
 
</body>
</html>
