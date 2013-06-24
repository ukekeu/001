<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
 <title>打印契税纳税申报表</title>
<script language=javascript src="js/mad.js"> </script>
<script language=javascript src="../public_js/basal.js"> </script>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
</head>
<%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
  <%
	
 
String code=request.getParameter("code"); 
String  sql="select  o.code,c.signatory,o.ContractNo,o.sectionname+o.loft+o.building+";
		sql+="o.Room_no room,o.payment1,o.jzarea,o.visadate,o.yong_tu,o.room_sumprice,o.q_tax,o.yh_tax";
		sql+=" from order_contract o,customer c where c.serialno=o.customer and o.ContractNo<>''";
		sql+=" and o.state<>3 and  o.code in("+code+")";
		
		ResultSet rs1=ViewBean.executeQuery("select developcom FROM crm_project where SerialNo in (select section from order_contract where code in("+code+"))");
		String developcom="";
		if (rs1.next())developcom=getbyte(rs1.getString("developcom"));
		rs1.close();
%>
<body >
<form action="rh_view.jsp" method="post" name="frm">
 <DIV align=center id="printdiv">
 <!--<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">&nbsp;<input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">

 </div>

  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  	 <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

 <center>
 <p align="center"><font size=4><b>交易确认、契税纳税申报表</b></font></p>
 <table width="99%"  border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr > 
<td width="50%">
公司名称：
</td>
<td width="50%" align="right">单位：元、平方米
</td>
</table>
 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr > 
<td  align="right">序号</td>
<td  align="center">客户姓名</td>
<td  align="center">房间代码</td>
<td  align="center">建筑面积</td>
<td w align="center">合同金额</td>
<td  align="center">合同编号</td>
　
<td  align="center">应征税额(元)</td>
<td  align="center">签约日期</td>
<td  align="center">房屋性质</td>
<td w align="center">备注</td>
<td w align="center">印花税</td>


	<%
	int i=0;
	ResultSet rs=null;
	try{
		
	rs=ViewBean.executeQuery(sql);
	 
	//保存输入值的变量
     
 

   while (rs.next()){
	 
     i=i+1;
        code=rs.getString("Code");
     String Customer=getbyte(rs.getString("signatory"));
 
	 String ContractNo=getbyte(rs.getString("ContractNo"));
	 String room=getbyte(rs.getString("room"));
     String payment=getbyte(rs.getString("payment1"));
     String jzarea=fa.getFloat(rs.getFloat("jzarea"),2);
	 String visidate=rs.getDate("visadate").toString();
	 String yongtu=getbyte(rs.getString("yong_tu"));
	 String room_sumprice=fa.getFloat(rs.getFloat("room_sumprice"),2);
	 String q_tax=fa.getFloat( rs.getFloat("q_tax"),3);
 
	 String yh_tax=fa.getFloat( rs.getFloat("yh_tax"),0);
  %>
 <tr id=TR<%=i %> align="center" > 
<td   align="center"><%=i %></td>
<td   align="left">&nbsp; <%=Customer%> </td>
<td  align="left">&nbsp; <%=room%></td>
<td  align="left">&nbsp; <%=jzarea%></td>
<td  align="left">&nbsp; <%=room_sumprice%></td>

<td  align="left">&nbsp; <%=ContractNo%></td>
<td  align="left">&nbsp; <%=q_tax%></td>
<td  align="left">&nbsp; <%=visidate%></td>
<td  align="left">&nbsp; <%=yongtu%></td>
<td  align="left">&nbsp; <%=payment%></td>
 <td  align="left">&nbsp; <%=yh_tax%></td>
 
</tr> 
 <%
 }
rs.close();
 sql="select   sum(o.jzarea) jzarea, sum(o.room_sumprice) rmbprice,sum(o.q_tax) q_tax ,sum(o.yh_tax) yh_tax";
		sql+=" from order_contract o,customer c where  o.state<>3 and  c.serialno=o.customer and o.ContractNo<>''";
		sql+=" and  o.code in("+code+")";
	rs=ViewBean.executeQuery(sql);
	if (rs.next()){
%>
<tr>
<td>合计:</td><td>&nbsp;</td><td>&nbsp;</td> 
<td>&nbsp;<%=fa.getFloat(rs.getFloat("jzarea"),2) %></td>
<td>&nbsp;<%=fa.getFloat(rs.getFloat("rmbprice"),2) %></td>
<td>&nbsp;</td> 
<td>&nbsp;<%=fa.getFloat(rs.getFloat("q_tax"),2) %></td>
<td>&nbsp;</td> 
<td>&nbsp;</td> 
<td>&nbsp;</td> 
<td>&nbsp;<%=fa.getFloat(rs.getFloat("yh_tax"),0) %></td>
</tr>

<%}
rs.close();
  out.print("</table>");

}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
 
 %> </table>
 <br><br>
  <table width="99%"  border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr > <td>填表人：</td><td>&nbsp;</td>
<td>收件人：</td><td>&nbsp;</td><td>&nbsp;</td>
<td>交易股签收人：</td><td>&nbsp;</td>
<td>签收日期:     年　　　月　　　日</td>
</tr>
</table>
  </center> 
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
 
  </script>
</body>
 
</html>

