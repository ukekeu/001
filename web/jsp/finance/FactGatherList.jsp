<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>

<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "�տ�ͳ��" , 
                  "���"
                ) ;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>�տ���ϸ��</title>
</head> 
<script language="javascript" src="../public_js/basal.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>
 
<body>

<%
String SecNo=request.getParameter("SecNo");
String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");

String sel=(String)request.getParameter("sel");
if(sel==null) sel="1";				
 

String SQL="SELECT  id,signatory,loft+room_no room ,factmoney,CurrName,CurrRate,Gather_Date1,PayType,Receiver,Bill_Num FROM View_FactMoney WHERE SECTION='"+SecNo+"' AND GATHER_DATE1 BETWEEN '"+Date1+"' and  '"+Date2+"' and vo="+sel+" order by GATHER_DATE desc, customer";
ResultSet rs = ViewBean.executeQuery(SQL) ;
 out.print(SQL);
 %>
 <form name=frm>
 <input type=hidden name=sel value="<%=sel%>">
 <input type=hidden name=SecNo value="<%=SecNo%>">
 <input type=hidden name=Date1 value="<%=Date1%>">
 <input type=hidden name=Date2 value="<%=Date2%>">
 <table width="95%" border=0 cellspacing='0'  cellpadding='0'>
  <tr align="center"> 
   <td class="titlesize"><%if(sel.equals("1")){%> δ����ƾ֤��ϸ��<%}else{ %>������ƾ֤��ϸ��<%} %></td>
  </tr>
  </table>
  <br>
    <table width="270" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;document.frm.action='FactGatherList.jsp';document.frm.submit();"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>δ����ϸ��</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;document.frm.action='FactGatherList1.jsp';document.frm.submit();"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>ƾ֤��ϸ</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=3;document.frm.action='FactGatherList.jsp';document.frm.submit();"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��������ϸ</font></a>
	</td>
	</tr>
	</table>
 <table width="95%" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr> 
   <td>&nbsp;</td><td>�ͻ�����</td><td>�������</td><td>������</td>
   <td>�ұ�</td><td>����</td>
   <td>��������</td><td>���ʽ</td><td>�տ���</td><td>Ʊ�ݱ��</td>
  </tr>
  <%
   while (rs.next()){
   %> 
   <tr> 
   <td>&nbsp;<input type="checkbox" value="<%=getbyte(rs.getString("id")) %>" name=vo></td><td><%=getbyte(rs.getString("signatory")) %></td><td><%=getbyte(rs.getString("room")) %></td><td><%=rs.getString("factmoney") %></td>
<%
String FactCurry=getbyte(rs.getString("CurrName"));
String curryDX="";
if (FactCurry.equals("��"))curryDX="�����";
		if (FactCurry.equals("HKD"))curryDX="�۱�";
		if (FactCurry.equals("USD"))curryDX="��Ԫ"; %>
<td><%=curryDX %></td><td><%=getbyte(rs.getString("CurrRate")) %></td>
   <td><%=rs.getString("Gather_Date1") %>&nbsp;</td><td><%=getbyte(rs.getString("PayType")) %>&nbsp;</td><td><%=getbyte(rs.getString("Receiver")) %>&nbsp;</td><td><%=getbyte(rs.getString("Bill_Num")) %>&nbsp;</td>
  </tr>
  <%}
  rs.close(); %>
  </table>
  <%if(!sel.equals("3")){%>
  <table align="center"><tr>
  <td>��������ȡ����:</td><td><input type=text size=8 name=rate value=0>(��) </td><td><input type=button  name=writevoucher value="����ƾ֤" onclick=" aa();"></td></tr>
</table>
<%} %>
<script>
function choosAll()
  {
   if (document.frm.vo.length){
  for (var i=0;i<document.frm.vo.length;i++){
    if (document.frm.vo[i].checked) return true;
  }
  }else{
   if (document.frm.vo.checked) return true;
  }
  alert("��ѡ����Ҫ����ƾ֤���տ��¼!");
  return false;
    }
function aa(){
if (choosAll()){
document.frm.action="WriteVoucher.jsp";
document.frm.submit();
}
}
</script>
</body>
</form>
</html>