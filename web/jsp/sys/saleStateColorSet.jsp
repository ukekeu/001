<%@ page contentType="text/html;charset=GBK" %>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/CheckSection.jsp"%>
<html>
<head>
	<title>销售状态色设置</title>
</head>

 <OBJECT id=dlgHelper CLASSID="clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b" WIDTH="0px" HEIGHT="0px"></OBJECT>

<!-- Create the licensing object for the common dialog activex control -->
<OBJECT CLASSID="clsid:5220cb21-c88d-11cf-b347-00aa00a28331">
    <PARAM NAME="LPKPath" VALUE="comdlg.lpk">
</OBJECT>

<!--Create the Common Dialog Box activex control-->
<OBJECT ID="cDialog" WIDTH="0px" HEIGHT="0px"
    CLASSID="CLSID:F9043C85-F6F2-101A-A3C9-08002B2F49FB"
    CODEBASE="http://activex.microsoft.com/controls/vb5/comdlg32.cab">
</OBJECT>
<body  oncontextmenu="return false">

<table>
<script>
var sInitColor = null;
function callColorDlg(sColorType,obj,obj1){

if (sInitColor == null) 
	//display color dialog box
	var sColor = dlgHelper.ChooseColorDlg();
else
	var sColor = dlgHelper.ChooseColorDlg(sInitColor);
	//change decimal to hex
	sColor = sColor.toString(16);
	//add extra zeroes if hex number is less than 6 digits
if (sColor.length < 6) {
  	var sTempString = "000000".substring(0,6-sColor.length);
  	sColor = sTempString.concat(sColor);
}
	//change color of the selected text
	document.execCommand(sColorType, false, sColor);
	sInitColor = sColor;
	 if (sColor!="000000"){
	  obj.style.backgroundColor=sColor;
	  obj1.value="#"+sColor;
	  }
	//oDiv.focus();
}
</script>
<script language="javascript" src="../public_js/public.js">
</script>
<body  onload="setSelectMad(document.frm.section,'<%=request.getParameter("section") %>')">
<%
String SecNo1=getbyte1(request.getParameter("section"));
String rg1=getbyte1(request.getParameter("rg1"));
String qy1=getbyte1(request.getParameter("qy1"));
String ld1=getbyte1(request.getParameter("ld1"));
String cz1=getbyte1(request.getParameter("cz1"));
String yl1=getbyte1(request.getParameter("yl1"));
String ws1=getbyte1(request.getParameter("ws1"));
 
if (!SecNo1.equals("")&&!rg1.equals("")&&!qy1.equals("")&&!ld1.equals("")&&!cz1.equals("")&&!yl1.equals("")&&!ws1.equals("")){ 
 String SQL="select  RG from SaleStateColor WHERE secno='"+SecNo1+"'";

ResultSet rs=ViewBean1.executeQuery(SQL);	
if (rs.next()){
  SQL="update SaleStateColor set RG='"+rg1+"',QY='"+qy1+"'";
  SQL+=",LD='"+ld1+"',CZ='"+cz1+"',YL='"+yl1+"',WS='"+ws1+"' where secno='"+SecNo1+"'";
  ViewBean1.executeUpdate(SQL);	

}else{
  SQL="insert into SaleStateColor(SECNO,RG,QY,LD,CZ,YL,WS) VALUES('"+SecNo1+"','"+rg1+"','"+qy1+"'";
 SQL+=",'"+ld1+"','"+cz1+"','"+yl1+"','"+ws1+"')";

 ViewBean1.executeUpdate(SQL);	

}

rs.close();

}else{

out.print("请为每一种状态设置颜色");
}

if (!SecNo1.equals("")){
String SQL="select  *  from SaleStateColor WHERE secno='"+SecNo1+"'";
 
ResultSet rs=ViewBean1.executeQuery(SQL);	
if (rs.next()){
   rg1=rs.getString("RG");
   qy1=rs.getString("QY");
   ld1=rs.getString("ld");   
   cz1=rs.getString("CZ");
   yl1=rs.getString("YL");   
   ws1=rs.getString("ws");   
}
rs.close();
}
%>



 <form name=frm>
<center>
<table width="50%" align="center" >
<tr><td colspan="2"><font size=4>销控表销售状态色块设置</font></td></tr>
<tr><td colspan="2"></td></tr>
<tr><td colspan="2" >
楼盘名称：<select name="section" onchange="document.frm.submit();"> 
   <option></option>
<%  
  if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";	
      String sql1="select SerialNo,Name from Crm_Project  ";

	  ResultSet rs2=ViewBean1.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
 
	    rs2.close();
	
     %> </select></td></tr>
	 <tr>
<td>未售：</td><td> <input type=button name=ws value="未售" onclick="callColorDlg('BackColor',this,document.frm.ws1);">
 <input type=hidden name=ws1 value="<%=ws1%>">
 <%if (!ws1.equals("")){ %>
 <script>
 document.frm.ws.style.backgroundColor="<%=ws1 %>";
 </script>
  <%} %>
</td>
</tr>
<tr>
<td>认购：</td><td> <input type=button name=rg value="认购" onclick="callColorDlg('BackColor',this,document.frm.rg1);">
 <input type=hidden name=rg1 value="<%=rg1%>">
 <%if (!rg1.equals("")){ %>
 <script>
 document.frm.rg.style.backgroundColor="<%=rg1 %>";
 </script>
  <%} %>
</td>
</tr>
<tr>
<td>签约：</td><td> <input type=button name=qy value="签约" onclick="callColorDlg('BackColor',this,document.frm.qy1);">
 <input type=hidden name=qy1 value="<%=qy1%>">
  <%if (!qy1.equals("")){ %>
 <script>
 document.frm.qy.style.backgroundColor="<%=qy1 %>";
 </script>
  <%} %>
</td>
</tr>
<tr>
<td>临定：</td><td> <input type=button name=ld value="临定" onclick="callColorDlg('BackColor',this,document.frm.ld1);" >
<input type=hidden name=ld1 value="<%=ld1%>">
  <%if (!ld1.equals("")){ %>
 <script>
 document.frm.ld.style.backgroundColor="<%=ld1 %>";
 </script>
  <%} %>
</td>
</tr>
<tr>
<td>预留：</td><td> <input type=button name=yl value="预留" onclick="callColorDlg('BackColor',this,document.frm.yl1);">
<input type=hidden name=yl1 value="<%=yl1%>"> 
  <%if (!yl1.equals("")){ %>
 <script>
 document.frm.yl.style.backgroundColor="<%=yl1 %>";
 </script>
  <%} %>
</td>
</tr>
<tr>
<td>出租：</td><td> <input type=button name=cz value="出租" onclick="callColorDlg('BackColor',this,document.frm.cz1);">
<input type=hidden name=cz1 value="<%=cz1%>">
  <%if (!cz1.equals("")){ %>
 <script>
 document.frm.cz.style.backgroundColor="<%=cz1 %>";
 </script>
 <%} %>
</td>
</tr>

</table>
<table width="50%" border="0">
<tr><td  align="center"><input type=submit name=saveSet value=" 提 交 "></td></tr>

</table>
</center>
</form>
 

</body>
</html>
