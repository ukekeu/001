<%@ page contentType="text/html;charset=GBK" %>
 
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>今日应备案客户</title>
</head>

<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/>  
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>
<script>
function AlertDate(){
  document.form1.action="JZCustomer.jsp";
  document.form1.submit();

}
</script>
<%String reportAddrs=(String)session.getAttribute("reportAddr"); %>
<%String DisplayS=China.getParameter(request,"Display"); %>
<%if (DisplayS.equals(""))DisplayS="d6";
 
String section=request.getParameter("section");
String paulurl="";
if(section==null || section.equals(""))
{
	paulurl="";
}else{
	paulurl=" and section='"+section+"'";
}  
%>
<%@ include file="../public_js/countpagenum.jsp"%>
<%@ include file="../public_js/CheckSection.jsp"%>
<body topmargin="1" onload="setSelectMad(document.form1.section,'<%= section %>');">
<form method="POST" name="form1" action="">
   <p align="center"><b><font size="3" color="#000080">应公证客户 </font></b></p>
    <p align="left">
   
	按楼盘显示：<select name="section" onchange="javascript:document.forms[0].submit();"> 
   <option value=""></option>
   <%	
      String sqls="select SerialNo,Name from CRM_Project"+FindWhere+" group by  Name,SerialNo order by name";

	  ResultSet rs2=ViewBean.executeQuery(sqls);
	  String sec="";
	  String no1="";
	  String daa="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
	   if(no1.equalsIgnoreCase(section)){
		   daa=" selected";
		   }else{
			   daa="";
		   }
       out.print("<option value='"+no1+"'"+daa+">"+sec+"</option>");
	  }
	  rs2.close();
     %> </select>  &nbsp;<input type=button name=Prin value="打印" onclick="" title="暂无">
</p>  
    <%
String sql="";
String sql1="";
String sql2="";

FindWhere=" where  section in  "+FindWhere.substring(FindWhere.indexOf("("));
if (DisplayS.equals(""))DisplayS="d6";
DisplayS=DisplayS.substring(1);

		 
			sql="select * from dy_customer"+FindWhere+paulurl+" and  convert(char(24),dateadd(dd,-"+DisplayS+",jztx),111)=convert(char(24),getdate(),111)  and ContractNo not in ((Select top "+prenum +" ContractNo from dy_customer  "+FindWhere+paulurl+" and  convert(char(24),dateadd(dd,-"+DisplayS+",jztx),111)<=convert(char(24),getdate(),111) order by jztx )) order by jztx";
          sqlcount="select count(*) ContractNo from dy_customer"+FindWhere+paulurl +" and  convert(char(24),dateadd(dd,-"+DisplayS+",jztx),111)<=convert(char(24),getdate(),111) ";
		 
 //out.print(sql);

//设置查询结果的存放变量
String SecName="";
String Loft="";
String Building="";
String Room="";
String CusName="";
String Phone="";
String ConstractNo="";
float SalePrice=0;
String jztx="";
String VisaDate="";
String Seller="";
String Area="";
String aa="";
int i=0;
try{
	ResultSet rs=ViewBean.executeQuery(sql);
	
%>
  <table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>
  <tr class=TXTColor>
      <!--td  align="center" height="23" >楼盘</td>
      <td  align="center" height="23" >区号</td>
	  <td  align="center" height="23" >栋号</td-->
      <td  align="center" height="4" >序号</td>
      <td  align="center" height="26" >房间代码</td>
      <td  align="center" height="23" >合同编号</td>
      <td  align="center" height="23" >成交价</td>
      <td  align="center" height="23"  >签约日期</td>
	  
	  <td  align="center" height="23" >客户</td>
	  <td  align="center" height="23" >联系电话</td>
   
	  <td  align="center" height="23"  >销售员</td>
    </tr>
<%  
	while (rs.next()){
	  i++;
	  //按FIELDS顺序一GET　VALUE
	  SecName=getbyte(rs.getString("Name"));
	  Loft=getbyte(rs.getString("Loft"));
	  Building=getbyte(rs.getString("building"));
	  Room=rs.getString("room_no");
	  aBean.executeUpdate("update VIEW_JZCustomer set out=1 where Name='"+SecName+"' and Loft='"+Loft+"' and building='"+Building+"' and Room_no='"+Room+"'");
	  Area=rs.getString("jzarea");
	  SalePrice=rs.getFloat("RMBPrice");
      ConstractNo=rs.getString("ContractNo");
	  CusName=getbyte(rs.getString("customer"));
	  Phone=rs.getString("Phone");
	  jztx=rs.getString("jztx");
	  VisaDate=rs.getString("VisaDate");
	  Seller=getbyte(rs.getString("Seller"));
	  int syday=rs.getInt("syday");
  if (aa.equals("")){
 %> 
 
<%} %>	
	<tr id=TR<%=i %> align="center"  class='listcontent' onmouseover="mout(this);" onclick="changeclass1(this,'clickbg','listcontent');" > 
      <!--td    height="16"  ><%=SecName%></td>
	  <td    height="16"  ><%=Loft%></td>
	  <td    height="16"  ><%=Building%></td-->
      <td    height="16"  ><%=i%></td>
      <td    height="16"  ><%=SecName+Loft+Building+Room%></td>
	  <td    height="14"  ><%=ConstractNo%></td>
	  <td    height="14"  ><%=SalePrice%></td>
	  <td    height="10"  ><%=VisaDate%></td>
	    <td    height="16"  ><%=CusName%></td>
      <td    height="16" align="left" ><%=Repalce(Phone,"/").trim()%></td>
      
	  <td    height="10"  ><%=Seller%></td>	
    </tr>
    <%aa="true";
  }
  rs.close();
    out.print("</table>");
	  
}catch(Exception se){
	out.print("系统出错，出错如下：");
	out.print(se.getMessage());
	out.print(sql);
	out.close(); 
}
if (i==0)out.print("当前没有任务");
%> 
  </table>
   <%@ include file="../public_js/changepage.jsp"%>
</body>
</form>
</html>