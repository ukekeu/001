<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

	<title>Ƿ����ϸ��</title>
</head>
<%
   try{
String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String SecNo=getbyte1(request.getParameter("SecNo"));
String Loft=getbyte1(request.getParameter("Loft"));

String roomno=getbyte1(request.getParameter("room"));
String SecNo1="";
if (!SecNo.equals("")){
  SecNo1=SecNo.substring(0,SecNo.indexOf("-"));
SecNo=SecNo.substring(SecNo.indexOf("-")+1);
}
 
 %>
<body>
		 	<DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="������EXCEL" onClick="window.open('rep_qk_Excel.jsp?Date1=<%=Date1 %>&Date2=<%=Date2 %>&SecNo=<%=China.getParameter(request,"SecNo") %>&Loft=<%=Loft %>&room=<%=roomno %>');">

 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<p align="center">����ĿǷ����ϸ��</p>
 
<table   width="100%"  align="center" ><tr ><td>&nbsp;</td><td align="right"><%=Date1+"--"+Date2 %></td></tr></table>
<table width="100%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

<table width="110%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center">
    <td width="3%" rowspan="2">�ص�</td>
    <td width="3%" rowspan="2">ҵ��</td>
    <td width="3%" rowspan="2">��ϵ�绰</td>
	
    <td width="27%" colspan="3">Ӧ�տ���</td>
    <td width="27%" colspan="3">���տ���</td>
    <td width="27%" colspan="3">��Ƿ����</td>
    <td width="10%" rowspan="2">��ע</td>
  </tr>
  <tr align="center">
    <td width="9%">����</td>
    <td width="9%">���տ�</td>
    <td width="9%">�ϼ�</td>
     <td width="9%">����</td>
    <td width="9%">���տ�</td>
    <td width="9%">�ϼ�</td>
    <td width="9%">����</td>
    <td width="9%">���տ�</td>
    <td width="9%">�ϼ�</td>
  </tr>
  <%
    if (!SecNo.equals(""))SecNo=" and o.section='"+SecNo1+"'";
	if (!Loft.equals(""))SecNo+=" and o.Loft='"+Loft+"'";
	if (!roomno.equals(""))SecNo+=" and o.room_No='"+roomno+"'";
  String sql="select  o.code,o.section,o.sectionname,o.loft+o.building+o.room_no room,c.Cus_Name,c.phone,c.sj ,o.rmbprice+o.lu_tai_area*o.lu_tai_area_price fk,ajmoney  from order_contract o ,customer c,GatheringRecord d where  o.customer=c.serialno and  o.date >='"+Date1+"' and o.state<>3 and  o.date <='"+Date2+"' "+SecNo+"  and o.code=d. ContactNo   and d.cusno=o.customer and  d.state<>2    order by  o.section,o.sectionname, o.loft +o.building+o.Room_no";// group by o.code,o.section,o.sectionname, o.loft +o.building+o.Room_no, c.Cus_Name, c.Phone , c.sj";
  ResultSet rs=null;
   ResultSet rs1=null;

  rs=ViewBean.executeQuery(sql); 
 double y_price=0;
 double s_price=0;
 double y_price1=0;
 double s_price1=0;
 double fk=0;
 double dsk=0;
  double ffk=0;
 double fdsk=0;
  int ajmoney=0;
  while (rs.next()){
    String section=getbyte(rs.getString("section")); 
    String name=rs.getString("room"); 
	String cusname=getbyte(rs.getString("cus_name")); 
	String phone=getbyte(rs.getString("phone")); 
	if (!phone.equals(""))
	phone+="/"+getbyte(rs.getString("sj")); 
	else 
	phone+=getbyte(rs.getString("sj")); 
	fk+=rs.getDouble("fk"); 
	ajmoney=rs.getInt("ajmoney");
   %>
  <tr  align="center">
    <td width="3%"><%=name%></td>
	
    <td width="3%"><%=cusname%></td>
    <td width="9%"><%=phone%>��</td>
	<%
	sql="select  sum(shouldMoney*rate) price  from GatheringRecord where    ContactNo ="+rs.getString("code");
  
	rs1=ViewBean1.executeQuery(sql);
	double f_price=ajmoney; 
	double t_price=0; 
	double f_sumprice=0;//Ӧ��
	double f_sum=0;//Ӧ�պϼ�(����+����)
	
	double f_sumprice1=0;//ʵ�շ���
	
	double t_sumprice=0;//Ӧ��
	double t_sum1=0;//ʵ�պϼ�(����+����)
	
	double t_sumprice1=0;//ʵ�մ���
	
    double sumprice=0;
	double price=0;
	if (rs1.next())f_price+=rs1.getDouble("price");
	f_sumprice=f_price;
	
	 %>
    <td width="9%"><%=FormatD.getFloat2(f_price,2) %></td>
	<%
	rs1.close();
	sql="select  sum(TaxMoney) price  from GatheringTaxRecord where  cancel=0  and ContactNo   ="+rs.getString("code");
	rs1=ViewBean1.executeQuery(sql);
	 price=0;
	 
	if (rs1.next())t_price=rs1.getDouble("price");
	t_sumprice=t_price;
	 %>
    <td width="9%"><%=FormatD.getFloat2(t_price,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(t_price+f_price,2) %></td>
	<%
	rs1.close();
	
	sumprice=0;
	sql="select  sum(factmoney*CurrRate) price  from FactGatheringRecord where ContractNo    ="+rs.getString("code");
	rs1=ViewBean1.executeQuery(sql);
	 price=0;
	if (rs1.next())f_sumprice1=rs1.getDouble("price");
	
	rs1.close();
	//�ſ�
	sql="select  sum(FactMonye) price  from FactAjCharges where contractno   ="+rs.getString("code");
	rs1=ViewBean1.executeQuery(sql);
	  
	if (rs1.next())f_sumprice1+=rs1.getDouble("price");
	 %>
    <td width="9%"><%=FormatD.getFloat2(f_sumprice1,2) %></td>
	<%
	rs1.close();
	 
	sql="select  sum(money) price  from FactGatheringTaxRecord where ContractNo    ="+rs.getString("code");
	rs1=ViewBean1.executeQuery(sql);
	 price=0;
	if (rs1.next())t_sumprice1=rs1.getDouble("price");
	fdsk+=price;
	sumprice+=price;
	s_price1+=price;
	t_sum1=t_sumprice1+f_sumprice1;
	 %>
    <td width="9%"><%=FormatD.getFloat2(t_sumprice1,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(t_sumprice1+f_sumprice1,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(f_sumprice-f_sumprice1,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(t_sumprice-t_sumprice1,2) %></td>
        <td width="9%"><%=FormatD.getFloat2((f_sumprice-f_sumprice1)+(t_sumprice-t_sumprice1),2) %></td>
    <td width="10%">��</td>
  </tr>
  
 <%} %>
 <%
 sql="select  sum(shouldMoney*rate) price  from GatheringRecord where ContactNo in (select code   from order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' ";
  if (!SecNo.equals(""))sql+=" and section='"+SecNo1+"'";
  if (!Loft.equals(""))sql+=" and Loft='"+Loft+"'";
  if (!roomno.equals(""))sql+=" and  room_no='"+roomno+"'";
  sql+=")";
	 
	rs1=ViewBean1.executeQuery(sql);
	double a1=0,a2=0,a3=0,a4=0;
   if (rs1.next())a1=rs1.getDouble("price");
   rs1.close();
    sql="select  sum(ajmoney) ajmoney   from order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' ";
  if (!SecNo.equals(""))sql+=" and section='"+SecNo1+"'";
  if (!Loft.equals(""))sql+=" and  Loft='"+Loft+"'";
  if (!roomno.equals(""))sql+=" and  room_no='"+roomno+"'";
 rs1=ViewBean1.executeQuery(sql);
     if (rs1.next())a1+=rs1.getDouble("ajmoney");
	 
	 
   sql="select  sum(TaxMoney) price  from GatheringTaxRecord where  cancel=0  and  ContactNo in (select code from   order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' ";
   if (!SecNo.equals(""))sql+=" and section='"+SecNo1+"'";
   if (!Loft.equals(""))sql+=" and  Loft='"+Loft+"'";
   if (!roomno.equals(""))sql+=" and  room_no='"+roomno+"'";
   sql+=")";
	rs1=ViewBean1.executeQuery(sql);
	 
	if (rs1.next())a2=rs1.getDouble("price");
	rs1.close();
	//ʵ��
	sql="select  sum(factmoney*CurrRate) price  from FactGatheringRecord where ContractNo in (select code from   order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' ";
	 if (!SecNo.equals(""))sql+=" and section='"+SecNo1+"'";
   if (!Loft.equals(""))sql+=" and  Loft='"+Loft+"'";
       if (!roomno.equals(""))sql+=" and  room_no='"+roomno+"'";
   sql+=")";

	rs1=ViewBean1.executeQuery(sql);
 
	if (rs1.next())a3=rs1.getDouble("price");
	rs1.close();
	//�ſ�
	sql="select  sum(FactMonye) price  from FactAjCharges where contractno in (select code from   order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' ";
	 if (!SecNo.equals(""))sql+=" and section='"+SecNo1+"'";
   if (!Loft.equals(""))sql+=" and  Loft='"+Loft+"'";
       if (!roomno.equals(""))sql+=" and  room_no='"+roomno+"'";
   sql+=")";
   
	rs1=ViewBean1.executeQuery(sql);
	  
	if (rs1.next())a3+=rs1.getDouble("price");
	rs1.close();
	 
	sql="select  sum(money) price  from FactGatheringTaxRecord where  ContractNo in (select code from   order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' ";
	 if (!SecNo.equals(""))sql+=" and section='"+SecNo1+"'";
   if (!Loft.equals(""))sql+=" and  Loft='"+Loft+"'";
      if (!roomno.equals(""))sql+=" and  room_no='"+roomno+"'";
   sql+=")";
	rs1=ViewBean1.executeQuery(sql);
 
	if (rs1.next())a4=rs1.getDouble("price");
  %>
  <tr  align="center">
    <td width="9%">�ϼ�</td>
	<td width="9%"> &nbsp;</td>
	<td width="9%"> &nbsp;</td>
    <td width="9%"><%=FormatD.getFloat2(a1,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(a2,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(a1+a2,2) %></td>
	
    <td width="9%"><%=FormatD.getFloat2(a3,2) %></td>
      <td width="9%"><%=FormatD.getFloat2(a4,2) %></td>
     <td width="9%"><%=FormatD.getFloat2(a3+a4,2) %></td>
     <td width="9%"><%=FormatD.getFloat2(a1-a3,2) %></td>
   <td width="9%"><%=FormatD.getFloat2(a2-a4,2) %></td>
     <td width="9%"><%=FormatD.getFloat2((a1-a3)+(a2-a4),2) %></td>
    <td width="10%">��</td> 
  </tr>
    
</table>
  <br>
 
<%  }catch(Exception s){out.print("ϵͳ�����쳣���󣬴���ԭ��"+s);} %>

</body>
</html>
