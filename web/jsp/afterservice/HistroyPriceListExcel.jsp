
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<title>ʵ�����¼��</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script src="js/mad.js"> </script>
</head>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id = "changePriceListBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id = "FormatD" scope = "page" class = "FormatData.FormatData" />

<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
 <%
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"A005");


 %>
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
 

    String SectionS="";
    String SecName=getbyte(request.getParameter("SecName"));
    SectionS=request.getParameter("section");
    Loft=getbyte1(request.getParameter("Loft"));	 
	building=request.getParameter("Build");
	Floor= request.getParameter("Floor");
	RoomNo=request.getParameter("Room");
	state=request.getParameter("state");					
	int hasRecord = 0;
   
%>
<script>
  function findSub(para){
    document.frm.action=para;
 
   document.frm.submit();
}

</script>
	 
<body >
 <form name="frm" method=post action="MapUpdate.jsp">
 
 
  <p align=center><font size=3 class=FontColor><b><%=SecName+Loft %>������</b></font></p>
 <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >
 <table width="99%" border="0" cellpadding="1" cellspacing="1">
  <tr align="center"  class=listtitle> 
 
    
    <td  > 
      <font color=white>����</font>
    </td>
	 
	  <td  > 
    <font color=white>��潨��<br>���(M<sup>2</sup>)</font>
    </td>
	<td  > 
    <font color=white>�������<br>���(M<sup>2</sup>)</font>
    </td>
	 <td  > 
    <font color=white>ʵ��¶̨<br>���M<sup>2</sup></font>
    </td>
	<td  > 
    <font color=white>ʵ�⻨԰<br>���M<sup>2</sup></font>
    </td>
	<td  > 
    <font color=white>ʵ����̨<br>���M<sup>2</sup></font>
    </td>
	 <td  > 
    <font color=white>�������<br>���M<sup>2</sup></font>
    </td>
	 <td  > 
    <font color=white>������<br>���M<sup>2</sup></font>
    </td>
	
	<td  > 
    <font color=white>������ȫ��<br>���M<sup>2</sup></font>
    </td>
	
  
   
	
	
	<td  > 
    <font color=white>���¶̨<br>����</font>
    </td>
	<td  > 
    <font color=white>��԰<br>����</font>
    </td>
	<td  > 
    <font color=white>�������<br>����</font>
    </td>
	<td  > 
    <font color=white>������<br>����</font>
    </td>
	<td  > 
    <font color=white>������ȫ��<br>����</font>
    </td>
	<td  > 
    <font color=white>������������</font>
    </td>
	<td  > 
    <font color=white>��԰/¶̨��������</font>
    </td>
  </tr>

      <%
		int floor=0;	
		String code="";
		String room="";
		String SaleArea="";
		int salestate=0;
		String  unitprice="";
		String usedarea="";
		String af_unitprice="";
		String af_sumprice="";
		String contractno="",yang_tai_area="";
		String Sql="",yang_tai_zhao_yarea="";
		String customer="",lu_tai_area="";
	%> 
  <%	
	
	String strDisabled="";
	String strWhere="";
	int i=0;

	change2Str="select * from MapArea where Section='"+SectionS+"'";

	if (!Loft.equals(""))
	change2Str+=" and loft='"+Loft+"'";
	 
		change2RS = changePriceListBean.executeQuery(change2Str);
		
try{
    String vv="";
		while (change2RS.next()) {
		i=i+1;
			hasRecord = 1;
			
			Loft = getbyte(change2RS.getString("loft"));
			building = getbyte(change2RS.getString("building"));
			room = getbyte(change2RS.getString("Room"));
		    SaleArea = getbyte(change2RS.getString("area"));
			 boolean checked=change2RS.getBoolean("checked");
			String chk="";
			if (checked)chk="disabled";
		
 %>
  
  <tr align="center"  class=listcontent> 
 
 
   <td > <%=Loft+room.trim() %></td> 
   <td > <%=getbyte(change2RS.getString("Y_Area")) %></td> 
   <td > <%=getbyte(change2RS.getString("y_UserArea"))%></td> 
   <td > <%=getbyte(change2RS.getString("y_lutai_area")) %></td> 
   <td > <%=getbyte(change2RS.getString("y_ty_area")) %></td> 
   <td> <%=getbyte(change2RS.getString("y_yangtai_area")) %></td>
   <td > <%=getbyte(change2RS.getString("y_yangtai_zhao_area")) %></td> 
   <td > <%=getbyte(change2RS.getString("dt_area"))  %></td> 
   <td> <%=getbyte(change2RS.getString("yxz_area")) %></td>
   <td >  <%=getbyte(change2RS.getString("lutai_price")) %></td> 
   <td >  <%=getbyte(change2RS.getString("ty_price")) %></td> 
   <td > <%=getbyte(change2RS.getString("y_yangtai_zao_price"))%></td> 
   <td > <%=getbyte(change2RS.getString("dt_price"))%></td> 
   <td> <%=getbyte(change2RS.getString("yxz_price")) %></td>
   <td> <%=getbyte(change2RS.getString("area_rate")) %></td>
   <td> <%=getbyte(change2RS.getString("area_rate1")) %></td>
      
  </tr>
  
  <%
   }
   }catch(Exception s){out.print(s.getMessage());}
 
  // change2RS.close();
   %>
 
</table>
</div>
</form>
 
<script>
  function bringToExcel(){


   // get all the text
   var pasteText = document.all.report1.innerHTML;

   // copy all the text to clipboard
   window.clipboardData.setData ("Text", pasteText);

     // Start Excel and get Application object.     
     var oXL = new ActiveXObject("Excel.Application");     
     oXL.Visible = true;   
     // Get a new workbook.     
     var oWB = oXL.Workbooks.Add();     
     var oSheet = oWB.ActiveSheet;     
         var selectArea=document.body.createTextRange(); //�����ı����� 
        selectArea.moveToElementText(report1);//���ı�����۽���printData 
        selectArea.select();//ѡ��printData 
        selectArea.execCommand("Copy");//��printData���Ƶ����а��� 
         oSheet.Paste();//�����а��е����ݸ��Ƶ�Excel��   
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
 bringToExcel();
 window.close();
</script>
    
</form>
 
</center>

</body>
 
</html>
