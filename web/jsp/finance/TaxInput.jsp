<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>

  <%@ include file="../public_js/logrecord.jsp" %>
<%
  String code=request.getParameter("code");
  String taxcode=getbyte1(request.getParameter("taxcode"));
  String id=getbyte1(request.getParameter("id"));
   String taxmoney=getbyte1(request.getParameter("taxmoney"));
   String room=getbyte2(request.getParameter("room"));
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
	    SQL+=id+",'"+rs.getString("TaxName")+"','"+Date1+"',"+rs.getString("TaxMoney")+",'"+BillNum+"','"+Receiver+"',"+rs.getString("taxname_type")+")";
	    ViewBean2.executeUpdate(SQL);
      }
     rs.close(); 
	  SQL=" update  GatheringTaxRecord set state=1,factmoney=TaxMoney,factdate='"+Date1+"' where ID IN ("+taxcode+")";
	  ViewBean1.executeUpdate(SQL);
	  setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "���ռ�¼" , 
                  "����"+room
                ) ;	
   	%>
	 <script>alert("�Ѵ��գ�");opener.document.f1.submit();window.close();</script>
	<%
  }
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>���յǼ�</title>

</head>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
 


<body   bgcolor="#EBEBEB">

<form method="POST" name="cus1" action="">
<input type=hidden name=id value=<%=id %>>
 
<input type=hidden name=taxcode value=<%=code %>>
	<p align="center"><b><font size="3" color="#000080">���յǼ�</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;��������</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=12 value="<%=DateInfo.currentYear() + "-" + DateInfo.currentMonth() + "-" + DateInfo.currentDay() %>"  onkeydown="key(document.cus1.TAXNAME)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">
		  </td>
      </tr>
      
     
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;���ս��</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="FactMoney"  readonly value="<%=taxmoney %>" size="20" style="border-style: solid; border-width: 1" onblur="check(this);">
        </td>
      </tr>
	  
      <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;Ʊ�ݺ���</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name=BillNum size="20" onkeydown="key(document.cus1.Receiver)"style="border-style: solid; border-width: 1">
        </td>
      </tr>
      <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;�տ�Ա</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name=Receiver  onkeydown="key(document.cus1.Save)" value=<%=(String)session.getAttribute("loginname") %> size="20" style="border-style: solid; border-width: 1">
        </td>
      </tr>
    </table> 
	 <div align="center"> 

             <input type=hidden name=cusno>
            <input type="submit" value="�ᡡ��" name="Save" <%if (Float.parseFloat(taxmoney)==0){out.print("disabled");} %> >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="reset" value="��  ��" name="button" onclick="window.close();">
          </div> 
</form>     
 
   
       
       
</body>       
</html>       
