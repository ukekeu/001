<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/news.css" rel=stylesheet>
<title>����Ӧ�����ͻ�</title>
</head>

<%@ page language="java" import="java.sql.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/> 
<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>

<%
String SectionS=""; 
SectionS=request.getParameter("Section");
%>

<body onload="setSelectMad(document.cus.Section,'<%= SectionS %>');">
<DIV id="Layer1" style="position: absolute; left: 0; top: -7; width: 600; height: 242; z-index: 1">
<hr width=635> 
</div>
<DIV id="Layer1" style="position: absolute; left: 0; top: 5; width: 635; height: 242; z-index: 1">

  <form method="POST" name="cus" action="">
  <%
  //get session value

	String user = setpro.getId();
	String type = setpro.getType();
	boolean sale = setpro.getSale();
	boolean hasRight = false;
	if (user==null)
	 {%> ���ѳ�ʱ,<a href="../default.htm" target="_blank">�����µ�¼</a> <%out.close();}%> 
<%
//ȡ�ò�ѯ����
String StrWhere="";
if(request.getParameter("Search")!=null){
	if(SectionS.length()>0){
			StrWhere=" secno='"+SectionS+"'";
	}
}
  %>
  <input type="hidden" name="StrWhere" value="<%=StrWhere%>">
  <table border="0" width="100%">
    <tr> 
      <td valign="top" colspan="2"> 
        <p align="center"><b><font size="3" color="#000080">����Ӧ�����ͻ�</font></b>
      </td>
    </tr>
    <tr> 
      <td valign="top" height="10" colspan="2"></td>
    </tr>
	<tr> 
      <td valign="top" bgcolor="#96C7D1" colspan="4">¥������&nbsp;&nbsp;&nbsp; 
        <select size="1" name="Section">          
          <%
     String Sql="select SerialNo,Name from Section";
     ResultSet Rs=ViewBean.executeQuery(Sql);
     while (Rs.next()){
	    %> 
          <option value=<%=Rs.getString("SerialNo") %>><%=Rs.getString("Name") %></option>
          <%}
   Rs.close();
 %> 
        </select>		
        <input type="submit" name="Search" value="��ѯ">
		&nbsp;<a href="QYCustomerPrt.jsp?PrintState=<%= StrWhere%>">��ӡԤ��</a>
		</td>
		</tr>
	</table>
    
    <%
String sql="";

	//Fomrat date
    java.text.SimpleDateFormat Sdate =null;
    Sdate=new java.text.SimpleDateFormat("MM-dd-yyyy");
	String Today=Sdate.format(new java.util.Date()).toString();
		
	//�趨��ѯ
	if (StrWhere.length()>0) {
	   		sql="select * from VIEW_GHCustomer where "+StrWhere;
			hasRight = true;
	}else{
			sql="select * from VIEW_GHCustomer ";
			hasRight = true;
	}
//out.print(sql);
//���ò�ѯ����Ĵ�ű���

String Section="";
String Building="";
String Room="";
String CusName="";
String SerialNo="";
String SalePrice="";

//out.print(sql);
//Add try...catch for search,2001-09-06
try{
	ResultSet rs=ViewBean.executeQuery(sql);
%>

<%String str="string";
	while (rs.next()){
	  //��FIELDS˳��һGET��VALUE
	  Section=rs.getString("Name");
	  Building=rs.getString("building");
	  Room=rs.getString("Room");
	  CusName=rs.getString("Cus_Name");
	  SerialNo=rs.getString("SerialNo");
	  SalePrice=rs.getString("saleprice");
	  //Modify by freejoy,2001-09-05, format the Money
	  java.text.DecimalFormat MoneyFormat = new java.text.DecimalFormat(" ###,###,###.##");
	  SalePrice=MoneyFormat.format(java.lang.Float.parseFloat(SalePrice));
	  
	  if (str.equals("string")){
 %> 
    <table border="0" width="100%" cellspacing cellpadding>
	<tr> 
      <td width="504" valign="top" bgcolor="#96C7D1">¥��: <%=Section%></td>      
    </tr>
  </table>
  <table border="0" width="100%" cellspacing cellpadding>
    <tr> 
      <td width="13%" align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1">����</td>
      <td width="9%" align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1">����</td>
      <td width="13%" align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1">�ͻ�</td>
      <td width="16%" align="center" height="23" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1">��ͬ���</td>
      <td align="center" height="23" width="17%" bgcolor="#CFE6EB" style="border-style: solid; border-width: 1">�ɽ���</td>
    </tr>
    <%} %> 
    <tr align="center" BGCOLOR="#e6f9ff"  onmouseout="mOut(this,'#e6f9ff');" onmouseover="mOvr(this,'#EAECEC');"> 
      <td width="13%"  height="16" style="border-style: solid; border-width: 1"><%=Building%></td>
      <td width="9%"  height="16" style="border-style: solid; border-width: 1"><%=Room%></td>
      <td width="13%"  height="16" style="border-style: solid; border-width: 1"><%=CusName%></td>
      <td width="16%"  height="14" style="border-style: solid; border-width: 1"><%=SerialNo%></td>
      <td height="10" width="17%" style="border-style: solid; border-width: 1"><%=SalePrice%></td>
    </tr>
    <%
	str="aa";
  }
  rs.close();
 
}catch(Exception se){
	out.print("ϵͳ�����������£�");
	out.print(se.getMessage());
	out.close(); 
}

%> 
  </table>
  <hr size="1" color="#C0C0C0">
</div>
</body>
</form>
</html>