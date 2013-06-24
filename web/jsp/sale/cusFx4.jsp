  <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
    <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
	<title>客户分析</title>
</head>

<body>
<form name=form1 method="post" >
 <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >

<%
String sqlddd=" update customer set cus_age=year(visit_date)-convert(int,'19'+substring(id_card,9,2)) where    len(id_card) =18 ";
ViewBean.executeUpdate(sqlddd); 
sqlddd=" update customer set cus_age=year(visit_date)-convert(int,'19'+substring(id_card,7,2)) where    len(id_card) =15 ";

ViewBean.executeUpdate(sqlddd); 
String aa[]=request.getParameterValues("fxzb");
String cus_state=request.getParameter("cus_state");
String state1=cus_state;
 String section=request.getParameter("section");
  String Date1=getbyte1(request.getParameter("Date1"));
 String Date2=getbyte1(request.getParameter("Date2"));
String dateWhere="";
 if (!Date1.equals(""))dateWhere="  and  date between '"+Date1+"' and '"+Date2+"'";
 cus_state="   serialno in (select customer from order_contract where state<>3 and section='"+section+"' "+dateWhere+")";
 

 float sumNum=0;
 String SQL="";
   String Loft="";
	Loft=getbyte1(request.getParameter("Loft"));
	if (!Loft.equals("")) Loft=" and loft='"+Loft+"'";
 SQL="  select customer, count(*) num from order_contract where state<>3 and section='"+section+"' "+Loft+dateWhere+" group by customer";
   ResultSet rs=null;
 rs=ViewBean.executeQuery(SQL);
while (rs.next()){sumNum+=1;}
 
 rs.close();
  for (int nn=0;nn<aa.length;nn++){
  String StrAge="";
  String age1=request.getParameter("age1");
  String age2=request.getParameter("age2");
  if (aa[nn].equals("cus_age"))StrAge=" and cus_age>='"+age1+"' and  cus_age<= '"+age2+"'";
 
SQL="SELECT "+aa[nn]+",count(*) num  FROM customer where   "+cus_state+StrAge+"  group by "+aa[nn];
// SQL="SELECT  "+aa[nn]+",  case when "+aa[nn]+">=20 and "+aa[nn]+"<=29 then count(*)  when "+aa[nn]+">=30 and "+aa[nn]+"<=39 then count(*) when "+aa[nn]+">=40 and "+aa[nn]+"<=49 then count(*)  when "+aa[nn]+">=50 and "+aa[nn]+"<=59 then count(*)  when "+aa[nn]+">=60 and "+aa[nn]+"<=69 then count(*) end num FROM customer where   "+cus_state+"  group by "+aa[nn];
 
 rs=ViewBean.executeQuery(SQL);

 String messtitle="";
 if (aa[nn].equals("demand"))messtitle="户型";
 else  if (aa[nn].equals("Knowledge_From"))messtitle="信息来源";
 else  if (aa[nn].equals("attention"))messtitle="关注问题";
 else  if (aa[nn].equals("homejg"))messtitle="家庭结构";
 else  if (aa[nn].equals("Wh"))messtitle="学历";
 else  if (aa[nn].equals("region"))messtitle="区域";
 else  if (aa[nn].equals("Job"))messtitle="工作行业";
 else  if (aa[nn].equals("Purpose"))messtitle="购买用途";
 else  if (aa[nn].equals("Cus_Sex"))messtitle="性别";
 else  if (aa[nn].equals("cus_age"))messtitle="年龄";
 else  if (aa[nn].equals("Floor"))messtitle="购买楼层";    
 else  if (aa[nn].equals("nowjuarea"))messtitle="现居住面积";          
 else  if (aa[nn].equals("yixianmianji"))messtitle="现居住面积";     		 
 else  if (aa[nn].equals("fiment"))messtitle="装修要求";     		 
 else  if (aa[nn].equals("visitstate"))messtitle="来访方式";     		 
 else  if (aa[nn].equals("payment"))messtitle="付款方式";   
 
 %>
 
 <P align="center"><font size=3>按<%=messtitle %>分析结果</font></P>
<table height=16  width="100%" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr><td height=16  width="20%">&nbsp;类型</td><td height=16  width="20%">人数</td><td height=16  width="20%">比例</td></tr>
<%
  while (rs.next()){
    String a1=getbyte(rs.getString(aa[nn]));
	String nnn=getbyte(rs.getString("num"));
     if (a1.equals(""))a1="未知";
	 else if (aa[nn].equals("visitstate")){
	  if (a1.equals("0"))a1="来访";
	  else a1="来电";
	 
	 }
	 
	 
%>
<tr><td height=16  width="20%"><%=a1%></td><td height=16  width="20%"><%=nnn %></td>
<td width="30%">&nbsp;<%if (Integer.parseInt(nnn)>0){ %><img src="../images/line.gif" height=16  width="<%=FormtD.getFloat(Integer.parseInt(nnn)/sumNum*100,2) %>"><%=FormtD.getFloat(Integer.parseInt(nnn)/sumNum*100,2) %>%<%} %></td>
	

</tr>
<%
  }
  rs.close();
 %>
 <tr><td >合计:</td><td><%=String.valueOf(sumNum).substring(0,String.valueOf(sumNum).indexOf(".")) %></td><td>&nbsp;<img src="../images/line.gif" height=16  width="100">100%</td></tr>
</table>
<%} %>
</div>
</form>
</center>
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
 bringToExcel();
  window.close();
</script>

</body>
</html>
