<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<title>��ͬ����</title>

</head>
<script language="javascript" src="../public_js/public.js">
</script>


<%@ page language="java" import="java.sql.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%

  String  sql="";
  String name="";
  String secno=request.getParameter("SecNo");
  String build=request.getParameter("build");
  String room=getbyte1(request.getParameter("roomno"));
  String Loft=getbyte1(request.getParameter("Loft"));
  
   
  %>  <%
	  sql="select s.presell_bargain_no,s.secno,s.building,s.Room,s.roomtype,s.fiment,s.buildtype,s.area,s.jzarea,";
	  sql=sql+"s.tnunitprice,s.saleprice,s.formerprice,s.paymenttype,s.saler,convert(char(24),s.YJ_DATE,111) as YJ_DATE,convert(char(24),s.QD_date,111) as QD_date,s.text";
	  sql = sql + ",s.ajbk,s.ajyear,s.ajcs,s.dktype,convert(char(24),s.AjDate,111) as AjDate, convert(char(24),s.JzDate,111) as JzDate,c.signatory as cus_name,se.name,c.serialno as cusno,s.kikckbackrate";
	  sql=sql+" from saled_circs s,customer c,section se where se.serialno=s.secno and c.SerialNo=s.cusno and s.secno='"+secno+"'";
	  if (!Loft.equals(""))
	  sql+=" and s.loft='"+Loft+"' ";
	   if (!room.equals(""))
	  sql+=" and s.Room='"+room+"'";
	 out.print(sql);
	  //out.close();
	  ResultSet rs3=ViewBean.executeQuery(sql);
	   String htno="";
	   String kikckrate="";
	   String secname="";
	   String cusname="";
	   String roomtype="";
	   String area="";
	   float unitprice;
	   float saleprice;
	   float formerprice;
	   String date="";
	   String year="";
	   String month="";
	   String day="";
	   String year1="";
	   String month1="";
	   String day1="";
	   String note="";
	   String price="";
	   String salprice="";
	   String payment="";
	   String mj="";
	   String area1="";
	   String ajbk="";
	   String ajyr="";
	   String ajcs="";
       String ajtype="";
	   String seller="";
       String zx="";
	   String fl="";
	   String date1="";
	   String date2="";
	   String date3="";
       String cusno="";
	  while(rs3.next()){    
	     htno=rs3.getString("presell_bargain_no"); 
		 secno=rs3.getString("secno");   
	     build=getbyte(rs3.getString("building"));    
		 room=rs3.getString("Room");  
		 roomtype=getbyte(rs3.getString("roomtype"));
		 zx=getbyte(rs3.getString("fiment"));
		 fl=getbyte(rs3.getString("buildtype"));
		 area=rs3.getString("area"); 
		 area1=rs3.getString("jzarea"); 
		 unitprice=rs3.getFloat("tnunitprice"); 
		 price=String.valueOf(unitprice);
		 saleprice=rs3.getFloat("saleprice"); 
		 salprice=String.valueOf(saleprice);
		 formerprice=rs3.getFloat("formerprice"); 
		 mj=String.valueOf(formerprice);
		
		 payment=getbyte(rs3.getString("paymenttype"));
		 seller=rs3.getString("saler"); 
		 date=rs3.getString("YJ_DATE"); 
	     date1=rs3.getString("qd_DATE"); 
		 note=getbyte(rs3.getString("text")); 

		 ajbk=getbyte(rs3.getString("AjBk")); 
         if (ajbk==null){ajbk="";}
		 ajyr=rs3.getString("AjYear"); 
		 
         ajcs=rs3.getString("Ajcs"); 
		 if (ajcs==null){ajcs="0";}
		 ajtype=rs3.getString("DkType"); 
		 if (ajtype=="0"){ajtype="���������";}
		 else if (ajtype=="1"){ajtype="��ҵ����";}
		 if (ajtype==null){ajtype="0";}
		 date2=rs3.getString("AjDate");
		 date3=rs3.getString("JzDate"); 
		 cusname=getbyte(rs3.getString("cus_name")); 
		 secname=getbyte(rs3.getString("name")); 
         cusno=rs3.getString("cusno");
		 kikckrate=rs3.getString("kikckbackrate");
	 }
	
	  rs3.close(); %> 
	 
<body  >
<form method="POST" name="rgs" action=""> 

<a href="javascript:window.close();">�ر�</a>&nbsp;&nbsp;<a href="#" onclick="openwin('ShowPayView1.jsp?cusno=<%=cusno %>',400,300,200,50)">�������</a>&nbsp;&nbsp;<a href="#" onclick="openwin('../customter/listcusdata.jsp?cusno=<%=cusno %>','')">�ͻ�����</a>&nbsp;&nbsp;<a href="#" onclick="openwin('roomdata.jsp?secno=<%=secno%>&build=<%=build %>&roomno=<%=room %>&show=false','')">��������</a>
<p>
<center><font size=3>��ϸ��ͬ����</font><br>
<br>
 <table border="0" width="100%" cellspacing=1 cellpadding=1 bgcolor="#EBEBEB">
<tr>
    <td width="12%" bgcolor="#CFE6EB">&nbsp;�ͻ�</td>
    <td width="22%"><input type=text name="cusname"  value="<%=cusname %>"  size="12" style="border-style: solid; border-width: 1" ><font color=red>*</font>��</td>
     <td width="12%" bgcolor="#CFE6EB">&nbsp;��ͬ���</td>
    <td width="22%"><input type=text name="saleno"  value="<%=htno %>"  size="12" style="border-style: solid; border-width: 1" OnChange="toUpper(document.rgs.saleno)"><font color=red>*</font>��</td>
  </tr>
 <tr> 
 <td width="12%" bgcolor="#CFE6EB">&nbsp;����¥��</td>
 <td width="22%">
 <input type=text name="name"   size="12" style="border-style: solid; border-width: 1" readonly value=<%=secname %>>
 </td>
<td width="12%" bgcolor="#CFE6EB">&nbsp;��������</td>
<td width="22%">
<input type=text name="build"  value="<%=build%>"readonly size="12" style="border-style: solid; border-width: 1" >
</td>
</tr> 
<tr> <td width="12%" bgcolor="#CFE6EB">&nbsp;��������</td><td width="22%">
<input type=text name="roomno" value="<%=room%>" readonly  size="12" style="border-style: solid; border-width: 1"></td>
 <td width="12%" bgcolor="#CFE6EB">&nbsp;��������</td><td width="22%"> 
<input type=text name=fx value="<%=roomtype %>" size="12" style="border-style: solid; border-width: 1" > </td></tr>
<tr> <td width="12%" bgcolor="#CFE6EB">&nbsp;װ�ޱ�׼</td><td width="22%">
 <input type=text name="zx"  value="<%=zx%>"  size="12" style="border-style: solid; border-width: 1" > 

</td> <td width="12%" bgcolor="#CFE6EB">&nbsp;�� ��</td><td width="22%"> 
 <input type=text name=fl value="<%=fl %>" size="12" style="border-style: solid; border-width: 1" > </td>
</td></tr>	
<tr> <td width="12%" bgcolor="#CFE6EB">&nbsp;�������</td><td width="22%"><input type=text name="jzarea" value="<%=area1%>" readonly size="12" style="border-style: solid; border-width: 1"  >(ƽ����)</td>
 <td width="12%" bgcolor="#CFE6EB">&nbsp;�������</td><td width="22%"><input type=text name="area" value="<%=area%>" readonly size="12" style="border-style: solid; border-width: 1" >(ƽ����)</td></tr> 
<tr> <td width="12%" bgcolor="#CFE6EB">&nbsp;���ڵ���</td><td width="22%"><input type=text name="price"  value="<%=price %>" readonly size="12" style="border-style: solid; border-width: 1">(Ԫ/ƽ����)</td>
<td width="12%" bgcolor="#CFE6EB">&nbsp;�ܼ�</td><td width="22%"><input type=text name="mprice"  value="<%=mj %>"  readonly size="12" style="border-style: solid; border-width: 1" >(Ԫ)</td></tr> 
<tr> <td width="12%" bgcolor="#CFE6EB">&nbsp;���ʽ</td><td width="22%"> 
<input type=text name="payname"  value="<%=payment %>"  readonly size="12" style="border-style: solid; border-width: 1" >
  </td> 
  <td width="12%" bgcolor="#CFE6EB">&nbsp;��������</td><td width="22%"> 
    <input type=text name="ajyr"  value="<%=ajyr%>"  readonly size="12" style="border-style: solid; border-width: 1" >
 </td></tr>
 <tr>
 <td width="12%" bgcolor="#CFE6EB">&nbsp;���ҳ���</td><td width="22%"> 
   <input type=text name="ajcs"  value="<%=ajcs%>"  readonly size="12" style="border-style: solid; border-width: 1" >
 </td>
 <td width="12%" bgcolor="#CFE6EB">&nbsp;��������</td><td width="22%">
    <input type=text name="ajyr"  value="<%=ajyr%>"  readonly size="12" style="border-style: solid; border-width: 1" > </td>
</tr><tr>
<td width="12%" bgcolor="#CFE6EB">&nbsp;��������</td>
<td width="22%"> 
    <input type=text name="dk"  value="<%=ajtype %>"  readonly size="12" style="border-style: solid; border-width: 1" >

</td>
 <td width="12%" bgcolor="#CFE6EB">&nbsp;�ۼ�</td><td width="22%"><input type=text name="dicprice"  value="<%=salprice%>"  size="12" style="border-style: solid; border-width: 1" OnChange="check(document.rgs.dicprice)">(Ԫ)</td>
 </tr> 
 <TR>
    <td width="12%" bgcolor="#CFE6EB">&nbsp;ǩԼ����</td>
    <td width="22%">
	<input type=text name=qddate value="<%=date1 %>" readonly size="12" style="border-style: solid; border-width: 1" >
	</td>
 
 <td width="12%" bgcolor="#CFE6EB">&nbsp;��¥����</td><td width="22%">
<input type=text name=jldate value="<%=date %>" readonly size="12" style="border-style: solid; border-width: 1" ></td>
</tr>
  <tr>
    <td width="12%" bgcolor="#CFE6EB">&nbsp;��֤����</td>
    <td width="22%"><input type=text name="JzDate"  value="<%=date2 %>"   size="12" style="border-style: solid; border-width: 1" OnChange="check(document.rgs.dicprice)"></td>
  
    <td width="12%" bgcolor="#CFE6EB">&nbsp;����������</td>
    <td width="22%"><input type=text name="AjDate"   value="<%=date3 %>"   size="12" style="border-style: solid; border-width: 1" OnChange="check(document.rgs.dicprice)"></td>
  </tr>
  <tr>
    <td width="12%" bgcolor="#CFE6EB" bgcolor="#CFE6EB">&nbsp;�� �� Ա</td>
    <td width="22%">
	
	 <%
	  sql="select * from UserTable where UserId='"+seller+"'";
	  ResultSet rs1=ViewBean.executeQuery(sql);
	  while(rs1.next()){        
	   name=rs1.getString("Name");   
	   }        
     %>   
	 <input type=text name="sel"   value="<%=name %>"   size="12" style="border-style: solid; border-width: 1" >
	</td>
	 <td width="12%" bgcolor="#CFE6EB" bgcolor="#CFE6EB">&nbsp;�˷������</td>
    <td width="22%">
		 <input type=text name="kikckrate"   value="<%=kikckrate %>"   size="12" style="border-style: solid; border-width: 1" >%
		 </td>
  </tr> 
  
	   <tr> <td width="12%" bgcolor="#CFE6EB">&nbsp;��ע</td><td width="22%"  colspan="3"><textarea rows="3" name="note" cols="60" style="border-style: solid; border-width: 1"><%=note%></textarea></td></tr> 
</table>
</center>
</form>

</body>

</html>
