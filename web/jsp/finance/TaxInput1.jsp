<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>

<%
   String room=getbyte2(request.getParameter("room"));
  String code=request.getParameter("code");
  String taxcode=getbyte1(request.getParameter("taxcode"));
  String id=getbyte1(request.getParameter("id"));
   String taxmoney=getbyte1(request.getParameter("taxmoney"));
  if (!taxcode.equals("")){
    String Receiver=getbyte1(request.getParameter("Receiver"));
    String Date1=getbyte1(request.getParameter("Date1"));
	String FactMoney=getbyte1(request.getParameter("FactMoney"));
	String BillNum=getbyte1(request.getParameter("BillNum"));
	String  SQL="";
	  SQL="select TaxName,TaxMoney,taxname_type from GatheringTaxRecord where ID IN ("+taxcode+")";
	 ResultSet  rs=  ViewBean1.executeQuery(SQL);
	  while (rs.next()){
        SQL="insert into  factGatheringTaxRecord (contractno,TaxName,date,money,no,handler,TaxName_type) Values( ";
	    SQL+=id+",'"+rs.getString("TaxName")+"','"+Date1+"',"+FactMoney+",'"+BillNum+"','"+Receiver+"',"+rs.getString("taxname_type")+")";
	    ViewBean2.executeUpdate(SQL);
      }
     rs.close(); 
	  SQL=" update  GatheringTaxRecord set state=0,factmoney=factmoney+"+FactMoney+" where  ID IN ("+taxcode+")";
	 // out.print(SQL+"<BR>");
	  ViewBean1.executeUpdate(SQL);
	  SQL=" update  GatheringTaxRecord set state=1,factdate='"+Date1+"' where  factmoney >=TaxMoney and ID IN ("+taxcode+")";
	 // out.print(SQL);
	 ViewBean1.executeUpdate(SQL);
	 setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "代收记录" , 
                  "代收"+room
                ) ;	
   	%>
	 <script>alert("已代收！");opener.window.location.reload();window.close();</script>
	<%
  }
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>代收登记(交部分)</title>

</head>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
 


<body   bgcolor="#EBEBEB">

<form method="POST" name="cus1" action="">
<input type=hidden name=id value=<%=id %>>
 
<input type=hidden name=taxcode value=<%=code %>>
	<p align="center"><b><font size="3" color="#000080">代收登记</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;代收日期</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=12 value="<%=DateInfo.currentYear() + "-" + DateInfo.currentMonth() + "-" + DateInfo.currentDay() %>"  onkeydown="key(document.cus1.TAXNAME)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">
		  </td>
      </tr>
      
     
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;代收金额</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="FactMoney" value="<%=taxmoney %>" size="20" style="border-style: solid; border-width: 1" onblur="check(this);">
        </td>
      </tr>
	  
      <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;票据号码</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name=BillNum size="20" onkeydown="key(document.cus1.Receiver)"style="border-style: solid; border-width: 1">
        </td>
      </tr>
      <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;收款员</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name=Receiver  onkeydown="key(document.cus1.Save)" value=<%=(String)session.getAttribute("loginname") %> size="20" style="border-style: solid; border-width: 1">
        </td>
      </tr>
    </table> 
	 <div align="center"> 

             <input type=hidden name=cusno>
            <input type="submit" value="提　交" name="Save" <%if (Float.parseFloat(taxmoney)==0){out.print("disabled");} %> >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="reset" value="退  出" name="button" onclick="window.close();">
          </div> 
</form>     
 
   
       
       
</body>       
</html>       
