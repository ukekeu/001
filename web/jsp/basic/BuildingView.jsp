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
 <jsp:useBean id="df1" scope="page" class="FormatData.FormatData"/> 
<script language="JavaScript">
    var startnum="";
	var parasecname="";
	var parasecno="";
	var parabuild="";
	var paraloft="";
	function delsection() {
		if ( confirm("ȷʵ��ɾ���ö����еķ�������?"))
			window.location = "BuildingRoomDelete.jsp?Section="+document.cus.SecNo.value+"&Building="+document.cus.Building.value;
	}
	function Bdelsection() {
		if ( confirm("ȷʵ��ɾ���ö����е����ϣ������������ͷ������ϣ�?"))
			window.location = "BuildingDelete.jsp?Section="+document.cus.SecNo.value+"&Building="+document.cus.Building.value;
	}
	
	function View(){
	   if (parasecno==""){alert("��ѡ��һ��(ֻ�赥���б���ĳ��һ��)");}
		 else{window.location="RoomView.jsp?Search=aa"+"&SecNo="+parasecno+"&SecName="+parasecname+"&Build="+parabuild+"&Loft="+paraloft; }
	}  
   function printView(){
     openwin("printBuildView.jsp?SecNo=<%=request.getParameter("SecNo") %>&SecNa=<%=request.getParameter("SecNa") %>",650,500,10,10);
   
   
   }	
	function savepara(para1,para2,para3,para4){
		 parasecname=para1;
		 parasecno=para2;
		 paraloft=para3;
		 parabuild=para4;
	}
</script>

<body >

<%
 	
  String SecNo=request.getParameter("SecNo");
   String Loft=request.getParameter("Loft");
  String SecNa=getbyte2(request.getParameter("SecNa"));
 %>
<script language="javascript" src="../public_js/public.js">
</script>
<form method="POST" name="cus" action="">
 <p align="center"><b><font size="3" class=FontColor><%=getbyte2(request.getParameter("SecNa")) %></font></b>
  </p>
  <%@ include file="../public_js/qx_checke.jsp"%>
  <%
 
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"B001");
   if (Cortrol==null)Cortrol="";
   
   %>
   <%if (Cortrol.indexOf("A")>=0) {%>
   &nbsp;&nbsp;<input type=button value="¥ ��" title="����¥������" onclick="openwin('indexTree.jsp?SecNo=<%=SecNo %>',350,300,100,100);">
   <%} %>
   <%if (Cortrol.indexOf("D")>=0) {%>
   <input type=button value="��������" onclick="View();">&nbsp;&nbsp;
   <%} %>
     <%if (Cortrol.indexOf("F")>=0) {%>
   <input type=button value="��  ӡ" onclick="printView();">&nbsp;&nbsp;
   <%} %>
<table BORDER=0 width="102%" CELLSPACING=0 CELLPADDING=0 bordercolor="#FFFFFF" ALIGN=center class="tablefill" >
    <tr class=listtitle align="center" > 
     
	  <td width="4%"  ><font color=white>����</font></td>
      <TD width="10%"><font color=white>�������M2</font></td>
	  <td width="6%"><font color=white>��������</font></td>
	  <td width="10%"><font color=white>�Ϲ����M2</font></td>
	  <td width="6%"><font color=white>�Ϲ�����</font></td>
	    <td width="10%"><font color=white>ǩԼ���M2</font></td>
	  <td width="6%"><font color=white>ǩԼ����</font></td>
	    <td width="10%"><font color=white>�ٶ����M2</font></td>
	  <td width="6%"><font color=white>�ٶ�����</font></td>
	  
	  <td width="10%"><font color=white>δ�����M2</font></td>
	  <td width="6%"><font color=white>δ������</font></td>
	  <td width="12%"><font color=white>Ԥ�ƻ���(Ԫ)</font></td>

    </tr>
    <%
String SectionNo="";
String SecName="";
String Building="";
String maxFloor="";
String minFloor="";
String maxRoom="";
String minRoom="";
 

String sql="select Loft from sectiontree where SerialNo='"+SecNo+"' group by Loft";
ResultSet rs3=ViewBean2.executeQuery(sql);
int ii=0;
while (rs3.next()){
   Loft=getbyte(rs3.getString("Loft"));  
   sql="select * from sectiontree where SerialNo='"+SecNo+"' and Loft='"+Loft+"'";
   ii++;
 %> 
  <tr  align="center" class=listcontent > 
  
	   <td  width="8%" ><%=Loft %></td>
	   <td colspan=18> 
	    
	  
	<table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center >
	<tr  id=TR<%=ii %>   align="center" onclick="savepara('<%=SecNa %>','<%=SecNo%>','<%=Loft%>','<%=Building%>');changeclass1(this,'clickbg','listcontent');">
 
     
	<%
	String count="select salestate,count(*) as num,sum(area) as area from room where  seccode='"+SecNo+"' and  Loft='"+Loft+"' group by salestate ";
	int coun=0;
	double sumarea=0;
	int i=0;
	ResultSet rs2=ViewBean1.executeQuery(count);
	while  (rs2.next()){
	     i++;
		 coun+=rs2.getInt("num");
		 sumarea+=rs2.getDouble("area");
	}	 
	rs2.close();
	double ArryArea[]=new double[i];
	int ArryCount[]=new int[i];
	double ArryMoney[]=new double[i];
	String ArryState[]=new String[i];
	String CountSql="select salestate,count(*) as num,sum(area) as area,sum(sumprice) as sumprice from room  where seccode='"+SecNo+"'   and Loft='"+Loft+"'  group by salestate  ";
	ResultSet rs1=null;
	 try{
	   rs1=ViewBean1.executeQuery(CountSql);
	 }catch(Exception s){out.print("ִ�г���ԭ�����£�");out.println(s.getMessage());out.close();}
	 i=0;
	 //��������ʱд��arry��
    while (rs1.next()){
	 ArryState[i]=rs1.getString("salestate");
	 
	 ArryCount[i]=rs1.getInt("num");
	 ArryArea[i]=rs1.getDouble("area");
	 ArryMoney[i]=rs1.getDouble("sumprice");
	 i++;
	}
	rs1.close();
	int SaleNum=0;
	double money=0;
	int NoSaleNum=0;
	double SaleArea=0;
	double NoSale=0;
	int rgnum=0;
	double rgarea=0;
	int ldnum=0;
	double ldarea=0;
	//�ۼ������ۼ�δ�����
	for (int j=0;j<i;j++){
	  if (ArryState[j].equals("1")||ArryState[j].equals("4")){NoSale+=ArryArea[j];NoSaleNum+=ArryCount[j];money+=ArryMoney[j];}
      if (ArryState[j].equals("3")){SaleArea+=ArryArea[j];SaleNum+=ArryCount[j];}
	   if (ArryState[j].equals("2")){rgarea+=ArryArea[j];rgnum+=ArryCount[j];}
	    if (ArryState[j].equals("5")){ldarea+=ArryArea[j];ldnum+=ArryCount[j];}
	}
	 %>
	<td width="10%" align=left>&nbsp;<%=df1.getFloat2(sumarea,2) %> </td><td width="6%" align=left>&nbsp;<%=coun %></td><td width="10%" align=left>&nbsp;<%=df1.getFloat2(rgarea,2) %></td><td width="6%" align=left>&nbsp;<%=rgnum %></td><td width="10%" align=left>&nbsp;<%=df1.getFloat2(SaleArea,2) %></td><td width="6%" align=left>&nbsp;<%=SaleNum %></td><td width="10%" align=left>&nbsp;<%=df1.getFloat2(ldarea,2) %></td><td width="6%" align=left>&nbsp;<%=ldnum %></td><td width="10%" align=left>&nbsp;<%=df1.getFloat2(NoSale,2) %></td><td width="6%" align=left>&nbsp;<%=NoSaleNum %></td><td width="12%" align=left>&nbsp;<%=df1.getFloat2(money,2) %></td>
   </tr> 
   </table>
	 
	</td>
	</tr>
    <%

}rs3.close();
%> 
<%String CountSql="select count(*) as num,sum(area) as area,sum(sumprice) as sumprice,sum(sumprice)/sum(area) avg  from room  where seccode='"+SecNo+"' ";
 String sumnum="";
 String sumarea="";
 String sumprice="";
 String avg="";
  rs3=ViewBean2.executeQuery(CountSql);

if (rs3.next()){sumnum=rs3.getString("num");sumarea=df1.getFloat1(rs3.getFloat("area"),2);sumprice=df1.getFloat2(rs3.getDouble("sumprice"),2);avg=df1.getFloat1(rs3.getFloat("avg"),2);}
rs3.close();
%>
</table>
<br>
<table BORDER=0 width="102%" CELLSPACING=0 CELLPADDING=0 bordercolor="#FFFFFF" ALIGN=center class="tablefill" >
    <tr class=listtitle align="center" > 

 <td>���ۺϼƣ�</td>
<td>��������<%=sumnum %></td><td>���������<%=sumarea %></td><td>���۽�<%=sumprice %></td><td>���۾��ۣ�<%=avg %></td>
</tr>

 
<%  CountSql="select count(*) as num,sum(area) as area,sum(sumprice) as sumprice,sum(sumprice)/sum(area) avg from room  where seccode='"+SecNo+"' and (salestate=1 or salestate=4) ";
   sumnum="";
     sumarea="";
   sumprice="";
   avg="";
  rs3=ViewBean2.executeQuery(CountSql);

if (rs3.next()){sumnum=rs3.getString("num");sumarea=df1.getFloat1(rs3.getFloat("area"),2);sumprice=df1.getFloat2(rs3.getDouble("sumprice"),2);avg=df1.getFloat1(rs3.getFloat("avg"),2);}
rs3.close();
%>
 
    <tr class=listcontent align="center" > 

 <td>δ�ۺϼƣ�</td>
<td>δ��������<%=sumnum %></td><td>δ�������<%=sumarea %></td><td>δ�۽�<%=sumprice %></td><td>δ�۾��ۣ�<%=avg %></td>
</tr>  

<%  CountSql="select count(*) as num,sum(area) as area,sum(sumprice) as sumprice,sum(sumprice)/sum(area) avg from room  where seccode='"+SecNo+"' and (salestate=5) ";
   sumnum="";
     sumarea="";
   sumprice="";
   avg="";
  rs3=ViewBean2.executeQuery(CountSql);

if (rs3.next()){sumnum=rs3.getString("num");sumarea=df1.getFloat1(rs3.getFloat("area"),2);sumprice=df1.getFloat2(rs3.getDouble("sumprice"),2);avg=df1.getFloat1(rs3.getFloat("avg"),2);}
rs3.close();
%>
 
    <tr class=listtitle align="center" > 

 <td>�ٶ��ϼƣ�</td>
<td>�ٶ�������<%=sumnum %></td><td>�ٶ������<%=sumarea %></td><td>�ٶ���<%=sumprice %></td><td>�ٶ����ۣ�<%=avg %></td>
</tr>  
<%  CountSql="select count(*) as num,sum(jzarea) as area,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) avg from order_contract  where section='"+SecNo+"' and state=1";
   sumnum="";
     sumarea="";
   sumprice="";
   avg="";
  rs3=ViewBean2.executeQuery(CountSql);

if (rs3.next()){sumnum=rs3.getString("num");sumarea=df1.getFloat1(rs3.getFloat("area"),2);sumprice=df1.getFloat2(rs3.getDouble("sumprice"),2);avg=df1.getFloat1(rs3.getFloat("avg"),2);}
rs3.close();
%>
  <tr class=listcontent align="center" > 

 <td>�Ϲ��ϼƣ�</td>
<td>�Ϲ�������<%=sumnum %></td><td>�Ϲ������<%=sumarea %></td><td>�Ϲ���<%=sumprice %></td><td>�Ϲ����ۣ�<%=avg %></td>
</tr>
<%  CountSql="select count(*) as num,sum(jzarea) as area,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) avg from order_contract  where section='"+SecNo+"' and state=2";
   sumnum="";
     sumarea="";
   sumprice="";
   avg="";
  rs3=ViewBean2.executeQuery(CountSql);

if (rs3.next()){sumnum=rs3.getString("num");sumarea=df1.getFloat1(rs3.getFloat("area"),2);sumprice=df1.getFloat2(rs3.getDouble("sumprice"),2);avg=df1.getFloat1(rs3.getFloat("avg"),2);}
rs3.close();
%>
  <tr class=listtitle align="center" > 

 <td>ǩԼ�ϼƣ�</td>
<td>ǩԼ������<%=sumnum %></td><td>ǩԼ�����<%=sumarea %></td><td>ǩԼ��<%=sumprice %></td><td>ǩԼ���ۣ�<%=avg %></td>
</tr>
</table>
��
</body>
</form>
</html>