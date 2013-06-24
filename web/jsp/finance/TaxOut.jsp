<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%
  String code=request.getParameter("code");
  String taxcode=getbyte1(request.getParameter("taxcode"));
 
   String taxmoney=getbyte1(request.getParameter("taxmoney"));
  if (!taxcode.equals("")){
    String Receiver=getbyte1(request.getParameter("Receiver"));
    String Date1=getbyte1(request.getParameter("Date1"));
	String FactMoney=getbyte1(request.getParameter("FactMoney"));
	String BillNum=getbyte1(request.getParameter("BillNum"));
	String  SQL="";
	  if (taxcode.indexOf(",")>=0)
	  SQL=" update  factGatheringTaxRecord set out_money=money, out_date='"+Date1+"',out_person='"+Receiver+"' where code IN ("+taxcode+")";
	  else
	   SQL=" update  factGatheringTaxRecord set out_money="+FactMoney+", out_date='"+Date1+"',out_person='"+Receiver+"' where code IN ("+taxcode+")";
 	  ViewBean1.executeUpdate(SQL);
   	%>
	 <script>alert("已代付！");opener.document.f1.submit();window.close();</script>
	<%
  }
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>代付登记</title>

</head>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
 


<body   bgcolor="#EBEBEB">

<form method="POST" name="cus1" action="">
 
 
<input type=hidden name=taxcode value=<%=request.getParameter("id") %>>
	<p align="center"><b><font size="3" color="#000080">代付登记</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;代付日期</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=12 value="<%=DateInfo.currentYear() + "-" + DateInfo.currentMonth() + "-" + DateInfo.currentDay() %>"  onkeydown="key(document.cus1.TAXNAME)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">
		  </td>
      </tr>
      
     
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;代付金额</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="FactMoney"  size=15  value="<%=request.getParameter("outtax") %>" size="20" style="border-style: solid; border-width: 1" onblur="check(this);">
        </td>
      </tr>
	  
      
      <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;代付人</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name=Receiver size=15 onkeydown="key(document.cus1.Save)" value=<%=(String)session.getAttribute("loginname") %> size="20" style="border-style: solid; border-width: 1">
        </td>
      </tr>
    </table> 
	 <div align="center"> 

           
            <input type="submit" value="提　交" name="Save"  >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="reset" value="退  出" name="button" onclick="window.close();">
          </div> 
</form>     
 
   
       
       
</body>       
</html>       
