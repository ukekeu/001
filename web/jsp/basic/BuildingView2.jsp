<%@ page contentType="text/html;charset=GBK" %><!--ҳ��ʾ���ı���-->
<%@ include file="../public_js/checktime.jsp"%><!--ϵͳʹ��ʱ��check-->
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>¥����ѯ</title>
</head>
<%@ page language="java" import="java.sql.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/> <!--���ݿ����class-->
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/><!--ģ��Ȩ��check-->
<%@ include file="../public_js/getByteOut.jsp"%><!--����ת��function-->


<body >


<script language="javascript" src="../public_js/public.js">
</script>
<form method="POST" name="cus" action="">

<table BORDER=0 width="102%" CELLSPACING=0 CELLPADDING=0 bordercolor="#FFFFFF" ALIGN=center class="tablefill" >
    <tr class=listtitle align="center" > 
      <TD width="10%"><font color=white>�������M2</font></td>
	  <td width="8%"><font color=white>��������</font></td>
	<!-- <td width="10%"><font color=white>�������M2</font></td>
	  <td width="8%"><font color=white>��������</font></td>-->
	  <td width="10%"><font color=white>δ�����M2</font></td>
	  <td width="8%"><font color=white>δ������</font></td>
	  <td width="12%"><font color=white>Ԥ�ƻ���(Ԫ)</font></td>

    </tr>
    <%
String SectionNo="";
String SecName="";

String maxFloor="";
String minFloor="";
String maxRoom="";
String minRoom="";
String Building=request.getParameter("Build");
String Loft=request.getParameter("Loft");
String SecNo=request.getParameter("SecNo");
String SecNa=request.getParameter("SecNa");
int ii=0;
int i=0;
%>
	  

	<tr    align="center" onclick="savepara('<%=SecNa %>','<%=SecNo%>','<%=Loft%>','<%=Building%>');changeclass1(this,'clickbg','listcontent');">
  
     
	<%
	java.text.DecimalFormat df1 = new java.text.DecimalFormat("###,###,###.##"); 
	String count="select salestate,count(*) as num,sum(area) as area from room where  seccode='"+SecNo+"' and Building='"+Building+"' and Loft='"+Loft+"' group by salestate ";
	int coun=0;
	float sumarea=0;
	
	ResultSet rs2=ViewBean1.executeQuery(count);
	while  (rs2.next()){
	     i++;
		 coun+=rs2.getInt("num");
		 sumarea+=rs2.getFloat("area");
	}	 
	rs2.close();
	float ArryArea[]=new float[i];
	int ArryCount[]=new int[i];
	float ArryMoney[]=new float[i];
	String ArryState[]=new String[i];
	String CountSql="select salestate,count(*) as num,sum(area) as area,sum(sumprice) as sumprice from room  where seccode='"+SecNo+"' and Building='"+Building+"'  and Loft='"+Loft+"'  group by salestate  ";
	 ResultSet rs1=null;
	 try{
	  rs1=ViewBean1.executeQuery(CountSql);
	 }catch(Exception s){out.print("ִ�г���ԭ�����£�");out.println(s.getMessage());out.close();}
	 i=0;
	 //��������ʱд��arry��
    while (rs1.next()){
	 ArryState[i]=rs1.getString("salestate");
	 ArryCount[i]=rs1.getInt("num");
	 ArryArea[i]=rs1.getFloat("area");
	 ArryMoney[i]=rs1.getFloat("sumprice");
	 i++;
	}
	rs1.close();
	int SaleNum=0;
	float money=0;
	int NoSaleNum=0;
	float SaleArea=0;
	float NoSale=0;
	//�ۼ������ۼ�δ�����
	for (int j=0;j<i;j++){
	  if (ArryState[j].equals("1")){NoSale+=ArryArea[j];NoSaleNum+=ArryCount[j];money+=ArryMoney[j];}
      if (ArryState[j].equals("3")||ArryState[j].equals("2")){SaleArea+=ArryArea[j];SaleNum+=ArryCount[j];}
	}
	 %>
	<td width="10%" align=left>&nbsp;<%=df1.format(sumarea) %> </td><td width="8%" align=left>&nbsp;<%=coun %></td><td width="10%" align=left>&nbsp;<%=df1.format(NoSale) %></td><td width="8%" align=left>&nbsp;<%=NoSaleNum %></td><td width="12%" align=left>&nbsp;<%=df1.format(money) %></td>
   </tr> 
   </table>
	
</body>
</form>
</html>