<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="TaxBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/news.css" rel=stylesheet>
<title>���ձ���</title>
</head>
 
<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>

<body>
  <p align="center"><b><font size="3" color="#000080">����ӦǩԼ�ͻ�</font></b>
<table BORDER=0 width="100%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
    <tr bgcolor="#CFE6EB">
      <td width="13%" align="center" height="23" bgcolor="#CFE6EB" >¥����</td>
      <td width="10%" align="center" height="23" bgcolor="#CFE6EB" >����</td>
      <td width="6%" align="center" height="23" bgcolor="#CFE6EB" >����</td>
      <td width="10%" align="center" height="23" bgcolor="#CFE6EB" >�ͻ�����</td>
     <td width="14%" align="center" height="23" bgcolor="#CFE6EB" >�绰</td>
	  <td width="12%" align="center" height="23" bgcolor="#CFE6EB">�Ϲ�����</td>
      <td width="10%" align="center" height="23" bgcolor="#CFE6EB" >�Ϲ�����</td>
      <td align="center" height="23" width="10%" bgcolor="#CFE6EB" >�ɽ���</td>
      <td align="center" height="23" width="10%" bgcolor="#CFE6EB" >����Ա</td>
    </tr>
<%
String sql="";

	//Fomrat date
    java.text.SimpleDateFormat Sdate =null;
   	sql="select * from VIEW_QYCustomer  order by ID DESC";

	//out.print(sql);
//���ò�ѯ����Ĵ�ű���
int ID=0;
String Section="";
String Building="";
String Room="";
String CusName="";
String SerialNo="";
String Date="";
String strSalePrice="";
String State="";
String Phone="";
String Seller="";
String Loft="";
//out.print(sql);
//Add try...catch for search,2001-09-06
try{
	ResultSet rs=ViewBean.executeQuery(sql);
    
	String str="string";
	while (rs.next()){
	  //��FIELDS˳��һGET��VALUE
	  Section=getbyte(rs.getString("Name"));
	  Building=getbyte(rs.getString("building"));
	  Room=rs.getString("Room_no");
	  CusName=getbyte(rs.getString("Cus_Name"));
	  SerialNo=rs.getString("SerialNo");
	  Date=rs.getString("Date");
	 	  strSalePrice=rs.getString("salerprice");
	  java.text.DecimalFormat MoneyFormat = new java.text.DecimalFormat("###,###,###.##");
	  strSalePrice=MoneyFormat.format(java.lang.Float.parseFloat(strSalePrice));
	  Phone=rs.getString("Phone");
	  Seller=getbyte(rs.getString("Seller"));
 %>
    <tr align="center" BGCOLOR="#e6f9ff"  onmouseout="mOut(this,'#e6f9ff');" onmouseover="mOvr(this,'#EAECEC');">
      <td width="13%"><%=Section%></td>
      <td width="13%"><%=Building%></td>
      <td width="9%" ><%=Room%></td>
	
	   <td width="10%"><%=CusName%></td>
	   	   <td width="13%"><%=Phone %></td>

      <td width="16%"><a href="../sale/showrg.jsp?rgsno=<%=SerialNo%>" target="_blank"title="������Բ鿴�Ϲ���ϸ����"><%=SerialNo%></a></td>
      <td width="14%"><%=Date%></td>
      <td  width="17%"><%=strSalePrice%></td>
	   <td  width="17%"><%=Seller%></td>
    </tr>
    <%
	}
  rs.close();
 
}catch(Exception se){
	out.print("ϵͳ�����������£�");
	//out.print(se.getMessage());
	out.close(); 
}
%> 
</table>
  
<p align="center"><b><font size="3" color="#000080">����Ӧ�տ�ͻ�</font></b>
<table border=0 width="100%" class=parent id=KB3Parent cellspacing=1 cellpadding=3 align=center style="table-layout:fixed;word-break:break-all">
    <tr bgcolor="#CFE6EB">
      <td width="12%" align="center" height="23" bgcolor="#CFE6EB"  >¥����</td>
      <td width="8%" align="center" height="23" bgcolor="#CFE6EB"  >����</td>
      <td width="7%" align="center" height="23" bgcolor="#CFE6EB"  >����</td>
      <td width="10%" align="center" height="23" bgcolor="#CFE6EB"  >���ʽ</td>
	  <td width="8%" align="center" height="23" bgcolor="#CFE6EB"  >�ۼ�</td>
	  <td width="20%" align="center" height="23" bgcolor="#CFE6EB"  >�ͻ�����(�绰)</td>
      <td width="12%" align="center" height="23" bgcolor="#CFE6EB"  >��ͬ���</td>
      <td width="5%" align="center" height="23" bgcolor="#CFE6EB"  >����</td>
      <td align="center" height="23" width="10%" bgcolor="#CFE6EB"  >Ӧ�����</td>
      <td align="center" height="23" width="10%" bgcolor="#CFE6EB"  >����Ա</td>
     </tr>
<%
	//�趨��ѯ
	java.text.SimpleDateFormat SKdate =null;
	//SKdate=new java.text.SimpleDateFormat("MM-dd-yyyy");
	//String SKToday=SKdate.format(new java.util.Date()).toString();
	sql="select * from VIEW_CUSYJK   order by Name";

//���ò�ѯ����Ĵ�ű���
String SecName="";
String BargainNo="";
float SalePrice=0;
float ShouldMoney=0;
float UrgeMoney=0;
float JNMoney=0;
float TotalMoney=0;
String ChargesName="";
float InMoney=0;
String payment="";
String aa="";
String shouldQS="";
String shouldDate="";
//out.print(sql);
//Add try...catch for search,2001-09-06
try{
	ResultSet rs1=ViewBean.executeQuery(sql);

	while (rs1.next()){
	  //��FIELDS˳��һGET��VALUE
	  SecName=getbyte(rs1.getString("Name"));
	  Building=getbyte(rs1.getString("building"));
	  Room=rs1.getString("room");
	 
	  BargainNo=rs1.getString("presell_bargain_no");
	  SalePrice=rs1.getFloat("saleprice");
	  payment=getbyte(rs1.getString("paymenttype"));
	  CusName=getbyte(rs1.getString("cus_name"));
	  Phone=rs1.getString("Phone");
	  shouldQS=rs1.getString("shouldQS");
	  shouldDate=rs1.getString("shouldDate");
	  ShouldMoney=rs1.getFloat("ShouldMoney");
	  java.text.DecimalFormat MoneyFormat = new java.text.DecimalFormat(" ###,###,###.##");
	  strSalePrice=MoneyFormat.format(ShouldMoney); 
	  Seller=getbyte(rs1.getString("saler"));
	  
 %> 
    <tr align="center" bgcolor="#e6f9ff"  onMouseOut="mOut(this,'#e6f9ff');" onMouseOver="mOvr(this,'#EAECEC');">
      <td width="12%"  height="16"  ><%=SecName%></td>
      <td width="12%"  height="16"  ><%=Building%></td>
      <td width="7%"  height="16"  ><%=Room%></td>
	   <td width="7%"  height="16"  ><%=payment%></td>
	    <td width="7%"  height="16"  ><%=MoneyFormat.format(SalePrice)%></td>
      <td width="11%"  height="16" title="���˿ͻ���ϵ�绰����ɵ绰֪ͨ�ͻ�����ý���"> <%=CusName%>(<%=Phone %>)</td>
      <td width="12%"  height="14"  ><%=BargainNo%></td>
      <td width="11%"  height="14"  ><%=shouldQS%></td>
      <td height="10" width="13%"  ><%=strSalePrice%></td>
      <td height="10" width="13%"  ><%=Seller%></td>
    </tr>
<%
  }
  rs1.close();
}catch(Exception se){
	out.print("ϵͳ�����������£�");
	out.print(se.getMessage());
	//out.print(sql);
	out.close(); 
}
%> 
</table>
<p align="center"><b><font size="3" color="#000080">Ӧ��֤�ͻ�</font></b>
  <table border=0 width="100%" class=parent id=KB3Parent cellspacing=1 cellpadding=3 align=center style="table-layout:fixed;word-break:break-all">
    <tr bgcolor="#cfe6eb">
      <td bgcolor="#cfe6eb" width="8%">
        <div align="CENTER">¥����</div>
      </td>
      <td bgcolor="#cfe6eb" width="8%">
        <div align="CENTER">����</div>
      </td>
      <td bgcolor="#cfe6eb" width="8%"> 
        <div align="center">����</div>
      </td>
      <td width="14%"> 
        <div align="center">�ͻ�����</div>
      </td>
      <td width="13%"> 
        <div align="center">��ͬ���</div>
      </td>
      <td width="13%"> 
        <div align="center">��ͬǩ������</div>
      </td>
      <td width="13%"> 
        <div align="center">�ɽ���</div>
      </td>
    </tr>
<%
  	int id=0;
	String sectionName="";
	String buildDisp="";
	String room;
	String cus_name;
	String htno;
	String date;
	String salePrice = "";
	boolean noNull = false;
	ResultSet aRS = null;
	String aStr="";
	
	aStr = "select * from yjzcustomerv order by id desc,building,room,date desc";

try{
	aRS = ViewBean.executeQuery(aStr);
	while(aRS.next()) {
		id = aRS.getInt("id");
		sectionName = getbyte(aRS.getString("name"));
		buildDisp = getbyte(aRS.getString("building"));
		room = aRS.getString("room");
		cus_name = getbyte(aRS.getString("customer"));
		htno = aRS.getString("htno");
		date = aRS.getString("date");
		date = date.substring(0,4) + "-" + date.substring(5,7) + "-" + date.substring(8,10);
		salePrice = aRS.getString("saleprice");
 %> 
    <tr bgcolor="#EAF4F7">
      <td width="8%">
        <div align="CENTER"><%= sectionName %></div>
      </td>
      <td width="8%">
        <div align="CENTER"><%= buildDisp %></div>
      </td>
      <td width="8%"> 
        <div align="center"><%= room %></div>
      </td>
      <td width="14%"> 
        <div align="center"><%= cus_name %></div>
      </td>
      <td width="13%"> 
        <div align="center"><%= htno %></div>
      </td>
      <td width="13%"> 
        <div align="center"><%= date %></div>
      </td>
      <td width="13%"> 
        <div align="center"><%= salePrice %></div>
      </td>
    </tr>
<%
    }
	aRS.close();
}catch(Exception se){
	out.print("ϵͳ�����������£�");
	out.print(se.getMessage());
	out.print(sql);
	out.close(); 
}
%> 
</table>

<p align="center"><b><font size="3" color="#000080">Ӧ�����ͻ�</font></b>
  <table border=0 width="100%" class=parent id=KB3Parent cellspacing=1 cellpadding=3 align=center style="table-layout:fixed;word-break:break-all">
    <tr bgcolor="#CFE6EB"> 
      <td bgcolor="#cfe6eb" width="8%">
        <div align="CENTER">¥����</div>
      </td>
	  <td bgcolor="#cfe6eb" width="8%">
        <div align="CENTER">����</div>
      </td>
      <td bgcolor="#cfe6eb" width="8%">
        <div align="CENTER">����</div>
      </td>
      <td bgcolor="#cfe6eb" width="8%"> 
        <div align="center">����</div>
      </td>
      <td width="14%"> 
        <div align="center">�ͻ�����</div>
      </td>
      <td width="13%"> 
        <div align="center">��ͬ���</div>
      </td>
      <td width="13%"> 
        <div align="center">��ͬǩ������</div>
      </td>
      <td width="13%"> 
        <div align="center">�ɽ���</div>
      </td>
    </tr>
<%
String sectionName2="";
aStr = "select * from ycacustomerv order by id desc,building,room,YJ_DATE desc";

try{
	aRS = ViewBean.executeQuery(aStr);
	while( aRS.next()) {				
		id = aRS.getInt("id");
		sectionName2 = getbyte(aRS.getString("name"));
		Loft = getbyte(aRS.getString("Loft"));
		buildDisp = getbyte(aRS.getString("building"));
		
		room = aRS.getString("room");
		cus_name = getbyte(aRS.getString("customer"));
		htno = aRS.getString("htno");
		date = aRS.getString("YJ_DATE");
		//date = date.substring(0,4) + "-" + date.substring(5,7) + "-" + date.substring(8,10);
		salePrice = aRS.getString("saleprice");
 %> 
    <tr bgcolor="#EAF4F7">
      <td width="8%">
        <div align="CENTER"><%= sectionName2 %></div>
      </td>
	  <td width="8%">
        <div align="CENTER"><%= Loft %></div>
      </td>
      <td width="8%">
        <div align="CENTER"><%= buildDisp %></div>
      </td>
      <td width="8%"> 
        <div align="center"><%= room %></div>
      </td>
      <td width="14%"> 
        <div align="center"><%= cus_name %></div>
      </td>
      <td width="13%"> 
        <div align="center"><%= htno %></div>
      </td>
      <td width="13%"> 
        <div align="center"><%= date %></div>
      </td>
      <td width="13%"> 
        <div align="center"><%= salePrice %></div>
      </td>
    </tr>
<%
    }
	aRS.close();
}catch(Exception se){
	out.print("ϵͳ�����������£�");
	out.print(se.getMessage());
	//out.print(sql);
	out.close(); 
}
%> 
</table>
  
<p align="center"><b><font size="3" color="#000080">Ӧ��¥�ͻ�</font></b>
  <table border=0 width="100%" class=parent id=KB3Parent cellspacing=1 cellpadding=3 align=center style="table-layout:fixed;word-break:break-all">
    <tr bgcolor="#CFE6EB"> 
      <td bgcolor="#cfe6eb" width="8%">
        <div align="CENTER">¥����</div>
      </td>
      <td bgcolor="#cfe6eb" width="8%">
        <div align="CENTER">����</div>
      </td>
      <td bgcolor="#cfe6eb" width="8%"> 
        <div align="center">����</div>
      </td>
      <td width="14%"> 
        <div align="center">�ͻ�����</div>
      </td>
      <td width="13%"> 
        <div align="center">��ͬ���</div>
      </td>
      <td width="13%"> 
        <div align="center">��ͬǩ������</div>
      </td>
      <td width="13%"> 
        <div align="center">�ɽ���</div>
      </td>
    </tr>
<%
aStr = "select * from yjlcustomerv order by id desc,building,room,date desc";

try{
	aRS = ViewBean.executeQuery(aStr);
	
	while(aRS.next()) {
		id = aRS.getInt("id");
		sectionName2 = getbyte(aRS.getString("name"));
		buildDisp = getbyte(aRS.getString("building"));
		
		room = aRS.getString("room");
		cus_name = getbyte(aRS.getString("customer"))  ;
		htno = aRS.getString("htno");
		date = aRS.getString("date");
		date = date.substring(0,4) + "-" + date.substring(5,7) + "-" + date.substring(8,10);
		salePrice = aRS.getString("saleprice");
 %> 
    <tr bgcolor="#EAF4F7">
      <td width="8%">
        <div align="CENTER"><%= sectionName2 %></div>
      </td>
      <td width="8%">
        <div align="CENTER"><%= buildDisp %></div>
      </td>
      <td width="8%"> 
        <div align="center"><%= room %></div>
      </td>
      <td width="14%"> 
        <div align="center"><%= cus_name %></div>
      </td>
      <td width="13%"> 
        <div align="center"><%= htno %></div>
      </td>
      <td width="13%"> 
        <div align="center"><%= date %></div>
      </td>
      <td width="13%"> 
        <div align="center"><%= salePrice %></div>
      </td>
    </tr>
<%
    }
	aRS.close();
}catch(Exception se){
	out.print("ϵͳ�����������£�");
	out.print(se.getMessage());
	out.print(sql);
	out.close(); 
}
%> 
</table>


</body>
</form>
</html>