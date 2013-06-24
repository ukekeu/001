<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>今日提醒</title>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet></head>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="loginBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="cBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
   <jsp:useBean id="FormatD" scope="session" class="FormatData.FormatData"/>
<%@ include file="../public_js/CheckSection.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>

<script>
function full(){
setSelectMad(document.frm.section,'<%=request.getParameter("section") %>');
 
 }

</script>

<body onload="full()"><!--background="../images/mem.jpg"-->
<script>
function checkdate(){
if (frm.Date1.value.length<1 && frm.Date2.value.length<1){
	    	alert("请选择日期！");
	        return false;
	    }
   frm.submit();
}
</script>
<%String FbDate=request.getParameter("FbDate");
  if(FbDate==null)FbDate="";
  String Date1=request.getParameter("Date1");
  if(Date1==null)Date1="";
  String Date2=request.getParameter("Date2");
  if(Date2==null)Date2="";
  int i=0;
  String SQL="select romno,cus_name,payment1,salerprice,jzarea from viewsalelist where  state1='认购' ";
  if(!Date1.equals(""))
    SQL=SQL+" and REPLACE(date,'/','-')>='"+Date1+"'";
   else
    SQL=SQL+" and REPLACE(date,'/','-')=substring(convert(char(24),getdate(),120),1,10)";
  if(!Date2.equals(""))
    SQL=SQL+" and REPLACE(date,'/','-')<='"+Date2+"'";
   
String  section=getbyte1(request.getParameter("section")) ;
if (!section.equals(""))
  section=" and section ='"+section+"'";
  /*if(FbDate.equals(""))
    SQL=SQL+" and date=substring(convert(char(24),getdate(),111),1,10)";
  if(FbDate.equals("1"))
    SQL=SQL+" and dateadd(dy, -3, getdate()) < REPLACE(date,'/','-') ";
  if(FbDate.equals("2"))
    SQL=SQL+" and dateadd(dy, -7, getdate()) < REPLACE(date,'/','-') ";
  if(FbDate.equals("3"))
    SQL=SQL+" and dateadd(dy, -15, getdate()) < REPLACE(date,'/','-') ";
  if(FbDate.equals("4"))
    SQL=SQL+" and dateadd(dy, -30, getdate()) < REPLACE(date,'/','-') ";
  if(FbDate.equals("5"))
    SQL=SQL+" and dateadd(dy, -60, getdate()) < REPLACE(date,'/','-') ";
  if(FbDate.equals("6"))
    SQL=SQL+" and dateadd(dy, -180, getdate()) < REPLACE(date,'/','-') ";
  if(FbDate.equals("7"))
    SQL=SQL+" and dateadd(dy, -360, getdate()) < REPLACE(date,'/','-') ";
	*/
  ResultSet rs=null;
  String section1="";
if (section.equals("")){section=" and section in ("+SectionS+")";

section1=" and o.section in ("+SectionS+")";
}else{
section1=" and o.section in ('"+getbyte1(request.getParameter("section"))+"')";
}
 
  rs= ViewBean.executeQuery(SQL+section);
  double sumarea=0;
  double area=0;
  float price=0;
  float sumprice=0;
 %>
<div width=400>
<form name=frm>
<input type=hidden name=cusname value="">
<input type=hidden name=secname value="">
  <p align="center"><b><font size="3">今日销售情况</font></b></P>

<p align="center">
楼盘：<select name="section" onchange="document.frm.submit();"> 
   <option></option>
<%  

	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";

	  ResultSet rs2=loginBean.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	  if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	
     %> </select>
&nbsp;
<input  size="10" name="Date1" value="<%=Date1 %>"><input  onclick="fPopUpCalendarDlg(Date1);return false;" type="button" value=".." name="cale">----
<input  size="10" name="Date2" value="<%=Date2 %>"><input  onclick="fPopUpCalendarDlg(Date2);return false;" type="button" value=".." name="cale">
<input type="Button" name="bsub" value="查询" onclick="checkdate();">	
                  </p>
<script>
  //setSelectMad(document.forms[0].FbDate, "<%= FbDate %>") ;
</script>
认购情况
 <table width="100%"    cellspacing='1'  cellpadding='1' bordercolor="#000000" class="tablefill"  >
  <tr  class=listtitle align="center" >
      <TD height="25">序号</td>
      <TD>房间代码</td><TD>客户姓名</td><TD>付款方式</td><TD>建筑面积M<sup>2</sup></td><TD>总价(元)</td>
  </tr>
 <%while (rs.next()){i++; %>
   <tr  align="center"class=listcontent ><TD><%=i %></td>
   <TD><%=getbyte(rs.getString("romno")) %></td>
   <TD><%=getbyte(rs.getString("cus_name")) %></td>
   <TD><%=getbyte(rs.getString("payment1")) %></td>
    <TD><%area=rs.getDouble("jzarea");
	     out.print(area);
		 sumarea+=area;
	   %></td>
	<TD>￥<%
	  price=rs.getFloat("salerprice");
	  out.print(FormatD.getFloat1(price,0));
	   sumprice+=price; %></td>
  </tr>
  <%}
  rs.close(); %>
  <tr  align="center" class=listcontent > <TD><b>小计：</b></td>
   <TD>&nbsp;</td>
   <TD>&nbsp;</td>
   <TD>&nbsp;</td>
    <TD><b><%=FormatD.getFloat2(sumarea,4) %></b></td>
	<TD><b>￥<%=FormatD.getFloat(sumprice,0) %></b></td>
  </tr>
  
 
  <%
  
 
  SQL="select count(*) num,sum(jzarea) jzarea,sum(salerprice) salerprice  from viewsalelist   where  state1='认购'"+section+"  group by state1 ";
   rs= ViewBean.executeQuery(SQL);
  if (rs.next()){
   %>
    <tr  align="center"> 
      <TD bgcolor="#CECECE"><b>累计：</b></td>

      <TD colspan="2" bgcolor="#CECECE"><b>总套数:<%=rs.getInt("num") %></b></td>
      <TD bgcolor="#CECECE">&nbsp;</td>
      <TD bgcolor="#CECECE"><b><%=FormatD.getFloat(rs.getFloat("jzarea"),3) %></b></td>
	  <TD bgcolor="#CECECE"><b>￥<%=FormatD.getFloat(rs.getFloat("salerprice"),1) %></b></td>
  </tr>
   <%}
  rs.close(); %>
</TABLE>
<br>
签约情况

 <table width="100%"    cellspacing='1'  cellpadding='1'   >
  <tr  align="center" class=listtitle>
      <TD height="25">序号</td>
      <TD>房间代码</td><TD>客户姓名</td><TD>付款方式</td><TD>建筑面积M<sup>2</sup></td><TD>总价(元)</td>
  </tr>
 <%
  SQL="select romno,cus_name,payment1,salerprice,jzarea from viewsalelist where state1='已签约' ";
   if(!Date1.equals(""))
    SQL=SQL+" and REPLACE(visadate,'/','-')>='"+Date1+"'";
   else
     SQL=SQL+" and REPLACE(visadate,'/','-')=substring(convert(char(24),getdate(),120),1,10)";
  if(!Date2.equals(""))
    SQL=SQL+" and REPLACE(visadate,'/','-')<='"+Date2+"'";

  i=0;
    sumarea=0;sumprice=0;
  rs= ViewBean.executeQuery(SQL+section);
 while (rs.next()){i++; %>
   <tr  align="center" class=listcontent ><TD><%=i %></td>
   <TD><%=getbyte(rs.getString("romno")) %></td>
   <TD><%=getbyte(rs.getString("cus_name")) %></td>
   <TD><%=getbyte(rs.getString("payment1")) %></td>
    <TD><%area=rs.getDouble("jzarea");
	     out.print(area);
		 sumarea+=area;
	   %></td>
	<TD>￥<%
	  price=rs.getFloat("salerprice");
	  out.print(FormatD.getFloat1(price,0));
	   sumprice+=price; %></td>
  </tr>
  </tr>
  <%}
  rs.close(); %>
  <tr  align="center" class=listcontent><TD><b>小计：</b></td>
   <TD>&nbsp;</td>
   <TD>&nbsp;</td>
   <TD>&nbsp;</td>
    <TD><b><%=FormatD.getFloat2(sumarea,4) %></b></td>
	<TD><b>￥<%=FormatD.getFloat(sumprice,0) %></b></td>
  </tr>
  
  <%
  SQL="select count(*) num,sum(jzarea) jzarea,sum(salerprice) salerprice  from viewsalelist   where  state1='已签约' "+section+" group by state1 ";
   rs= ViewBean.executeQuery(SQL);
 
  if (rs.next()){
   %>
    <tr  align="center"> 
      <TD bgcolor="#CECECE"><b>累计：</b></td>
 
      <TD colspan="2" bgcolor="#CECECE"><b>总套数:<%=rs.getInt("num") %></b></td>
      <TD bgcolor="#CECECE">&nbsp;</td>
      <TD bgcolor="#CECECE"><b><%=FormatD.getFloat(rs.getFloat("jzarea"),3) %></b></td>
	  <TD bgcolor="#CECECE"><b>￥<%=FormatD.getFloat(rs.getFloat("salerprice"),0) %></b></td>
  </tr>
   <%}
  rs.close(); %>
</TABLE>
<br>
收款情况

 <table width="100%"    cellspacing='1'  cellpadding='1'' bgcolor=ffffff  >
  <tr  align="center"  class=listtitle>
      <TD height="25">序号</td>
      <TD>房间代码</td><TD>客户姓名</td><TD>收款金额(元)</td>
  </tr>
 <%
  SQL="select o.sectionname+o.loft+o.room_no as romno,c.cus_name,f.factmoney*f.CurrRate as money from FactGatheringRecord f,order_contract o,customer c where  f.cusno=c.serialno and f.contractno=o.code   "+section1;
   if(!Date1.equals(""))
    SQL=SQL+" and  substring(convert(char(24),f.Gather_Date,120),1,10)>='"+Date1+"'";
   else   SQL=SQL+" and  substring(convert(char(24),f.Gather_Date,120),1,10)=substring(convert(char(24),getdate(),120),1,10)";

  if(!Date2.equals(""))
    SQL=SQL+" and substring(convert(char(24),f.Gather_Date,120),1,10)<='"+Date2+"'";
	

  i=0;
  double money=0;
  double summoney=0;

  rs= ViewBean.executeQuery(SQL);
 while (rs.next()){i++; %>
   <tr  align="center" class=listcontent><TD><%=i %></td>
   <TD><%=getbyte(rs.getString("romno")) %></td>
   <TD><%=getbyte(rs.getString("cus_name")) %></td>
   <TD>￥<%money=rs.getDouble("money");
         out.print(FormatD.getFloat2(money,1));
		 summoney+=money;
		 %></td>
  </tr>
  <%}
  rs.close(); %>
   <tr  align="center" class=listcontent><TD><b>小计：</b></td>

   <TD>&nbsp;</td>
   <TD>&nbsp;</td>

	<TD><b>￥<%=FormatD.getFloat2(summoney,0) %></b></td>
  </tr>
  <% SQL="select sum(f.factmoney) as money from FactGatheringRecord f,order_contract o where o.code=f.contractno and o.state<>3 "+section1;
   rs= ViewBean.executeQuery(SQL);

  if (rs.next()){
   summoney=rs.getDouble("money");
  }
  rs.close();
   %>
    <tr  align="center"> 
      <TD bgcolor="#CECECE"><b>累计：</b></td>
 
 
      <TD bgcolor="#CECECE">&nbsp;</td>
      <TD bgcolor="#CECECE">&nbsp;</td>
	  <TD bgcolor="#CECECE"><b>￥<%=FormatD.getFloat2(summoney,1) %></b></td>
  </tr>
  </table>
  <br>
放款情况

  <table width="100%"    cellspacing='1'  cellpadding='1'' bgcolor=ffffff  >
    <tr  align="center" class=listtitle>
      <TD height="25">序号</td>
      <TD>房间代码</td><TD>客户姓名</td><TD>放款金额(元)</td>
  </tr>
  <%SQL="";
if(!Date1.equals(""))
    SQL=SQL+" and substring(convert(char(24),o.fkDate,120),1,10)>='"+Date1+"'";
   else   SQL=SQL+" and substring(convert(char(24),o.fkDate,120),1,10)=substring(convert(char(24),getdate(),120),1,10)";

  if(!Date2.equals(""))
    SQL=SQL+" and substring(convert(char(24),o.fkDate,120),1,10)<='"+Date2+"'";
	//if(FbDate.equals(""))

  SQL="select o.sectionname+o.loft+o.room_no as romno,c.cus_name,f.FactMonye as money from FactAjCharges f,order_contract o,customer c where  f.Customer=c.serialno and f.contractno=o.code "+section1+SQL;
  i=0;
 summoney=0;
 
  rs= ViewBean.executeQuery(SQL);
 while (rs.next()){i++; %>
   <tr  align="center"  class=listcontent><TD><%=i %></td>
   <TD><%=getbyte(rs.getString("romno")) %></td>
   <TD><%=getbyte(rs.getString("cus_name")) %></td>
   <TD>￥<%price=rs.getFloat("money");
         out.print(FormatD.getFloat1(price,0));
		 summoney+=price;
		 %></td>
  </tr>
  <%}
  rs.close(); %>
   <tr  align="center" class=listcontent><TD><b>小计：</b></td>

   <TD>&nbsp;</td>
   <TD>&nbsp;</td>

	<TD><b>￥<%=FormatD.getFloat2(summoney,0) %></b></td>
  </tr>
  
  <%
   SQL="select sum(f.FactMonye) as money from FactAjCharges f ,order_contract o where o.code=f.contractno and o.state<>3 "+section1  ;
   rs= ViewBean.executeQuery(SQL);

  if (rs.next()){
   summoney=rs.getDouble("money");
  }
  
   %>
    <tr  align="center"> 
      <TD bgcolor="#CECECE"><b>累计：</b></td>
 
 
      <TD bgcolor="#CECECE">&nbsp;</td>
      <TD bgcolor="#CECECE">&nbsp;</td>
	  <TD bgcolor="#CECECE"><b>￥<%=FormatD.getFloat2(summoney,1) %></b></td>
  </tr>
   
</TABLE>

<right>
   <iframe src="../public_js/calendarDlg.jsp" width="225" height="180" frameborder="0"></iframe> 
 </right>
				
</form>
</div>
</body>
</html>
