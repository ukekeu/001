<%@ page contentType="text/html;charset=GBK" %>

<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 
 <jsp:useBean id="txt" scope="page" class="ConnDatabase.WriteToTxtBean"/>
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<title>�����ӡ��������</title>
<script language="JavaScript" src='../public_js/basal.js'></script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

</head>
<center>
<form name=frm method="post" action="rep_ajlist.jsp?codes=<%=request.getParameter("codes") %>">
  <br><input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" name="Button1" value="������EXCEL" onClick="bringToExcel();">

 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
 
  <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >
  <P align="center">��Ѻ���ƽ��嵥</p>
  <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
     <tr  > 
		<td  align="center">���</td>
		<td  align="center">����</td>
		<td  align="center">������ַ</td>
		<td  align="center">���</td>
		<td  align="center">����</td>
		<td  align="center">������ַ</td>
   </tr>
  <%
   int num=0;
   int num2=0;
   String code="";
   String codes=request.getParameter("codes");
   ViewBean.executeUpdate("update order_contract set dyyj=1 where code in ("+codes+")");
     String sql="SELECT count(*) num FROM order_contract o,customer c WHERE c.serialno=o.customer and o.state<>3 and o.code in ("+codes+")";
   ResultSet rs = ViewBean.executeQuery(sql);
   if (rs.next())num=rs.getInt("num");
   
   rs.close();
   num2=num/2;
   num2=num-num2;
   num=num-num2;
   sql="SELECT c.cus_name,o.sectionname+o.loft+o.room_no room    FROM order_contract o,customer c WHERE c.serialno=o.customer and o.state<>3 and o.code in ("+codes+")";
 rs = ViewBean.executeQuery(sql);
  int ii=1;
  int j=1;
 while (rs.next()){
    String cusname=getbyte(rs.getString("cus_name"));
	String room=getbyte(rs.getString("room"));
   
 
   if (j==1){ %>
     <tr  > 
   <%}
   // if (j==2){ out.print("<td  align='center'>&nbsp;</td>");}
    %>	 
	    <td  align="center"><%=ii %></td>
		<td  align="center"><%=cusname %></td>
		<td  align="center"><%=room %></td>
		 	<%
	  j++;
	 if (j==3){ %>
     </tr  > 
   <%}  if (j==3){j=1;}
  
   ii++;
   
 }
rs.close();
%> 
	  <tr><td colspan="6">���Ϲ�<%=ii %>�׵Ĺ�����ͬ��������Ʊ(���տ��վ�)����˰��˰֤(���տ��վ�)������Ȩ��֤����</td></tr>
	  <tr><td colspan="3">�ƽ���:</td><td colspan="3">�н���:</td></tr>
	  <tr><td colspan="3">�ꡡ���¡������ա�</td><td colspan="3">�ꡡ���¡������ա�</td></tr>
	  </table> 
	  
	   </div>
 
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
     oSheet.Paste();     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
  opener.window.location.reload();
</script>

</body>       
</html>       
