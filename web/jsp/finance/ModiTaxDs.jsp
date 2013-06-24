<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
 
   String id=getbyte1(request.getParameter("id"));
   String FactMoney=getbyte1(request.getParameter("FactMoney"));
   String Date1=getbyte1(request.getParameter("Date1"));
   String name=getbyte1(request.getParameter("taxname"));
     String room   =getbyte1(request.getParameter("room"));
	  String NO   =getbyte1(request.getParameter("NO"));
	    String bak   =getbyte1(request.getParameter("bak"));
      String taxname_type=getbyte1(request.getParameter("taxname_type1"));
  if (!FactMoney.equals("")){
  String  SQL="";
  if (!Date1.equals(""))
    SQL=" update factGatheringTaxRecord set no='"+NO+"', bak='"+bak+"',taxname_type="+taxname_type+",Money="+FactMoney+",date='"+Date1+"',TAXNAME='"+name+"' where  code ="+id;
 else 	
   SQL=" update factGatheringTaxRecord set  no='"+NO+"', bak='"+bak+"',taxname_type="+taxname_type+",Money="+FactMoney+",date=null,TAXNAME='"+name+"' where  code ="+id;
   
     ViewBean.executeUpdate(SQL); 
      SQL="update GatheringTaxRecord set factmoney="+FactMoney+" where  TAXNAME='"+name+"' AND  ContactNo =(select ContractNo from factGatheringTaxRecord where  code ="+id+") ";
      ViewBean.executeUpdate(SQL); 
	  SQL="update GatheringTaxRecord set state=1 where factmoney=TaxMoney and  TAXNAME='"+name+"' AND  ContactNo =(select ContractNo from factGatheringTaxRecord where  code ="+id+") ";
      ViewBean.executeUpdate(SQL); 
	   SQL="update GatheringTaxRecord set state=0 where factmoney<TaxMoney and  TAXNAME='"+name+"' AND  ContactNo =(select ContractNo from factGatheringTaxRecord where  code ="+id+") ";
      ViewBean.executeUpdate(SQL); 
	  setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "修改代收" , 
                  "修改"+room
                ) ;	
 
  %>
  <script>
  alert("已修改");
  opener.document.forms[0].submit();
  window.close();
  </script>
  <%} %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>修改费用</title>

</head>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
 


<body   bgcolor="#EBEBEB">

<form method="POST" name="cus1" action="">
<input type=hidden name=id value=<%=id %>>
 <input type=hidden name=room value=<%=getbyte2(request.getParameter("room")) %>>
	<p align="center"><b><font size="3" color="#000080">修改代收</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;费用名称</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=taxname  size=12 value="<%=getbyte2(request.getParameter("name")) %>"  onkeydown="key(document.cus1.TAXNAME)">
		  </td>
      </tr>
      
     
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;费用金额</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="FactMoney" size=12 value="<%=request.getParameter("taxmoneys") %>" size="20" style="border-style: solid; border-width: 1" onblur="check(this);">
        </td>
      </tr>
	    <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;票据编号</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="NO" size=12 value="<%=request.getParameter("no")  %>" size="20" style="border-style: solid; border-width: 1" onblur="check(this);">
        </td>
      </tr>
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;交费日期</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=12 value="<%=request.getParameter("JKdate") %>"  onkeydown="key(document.cus1.FactMoney)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">
        </td>
      </tr>
	  
	     <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;费用类别</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<select name=taxname_type1 style="width : 100">
  		  <option value=0>配套费</option>
		  <option value=1>税费</option>

		  </select>
        </td>
      </tr>
	   <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;备注</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<INPUT TYPE="text"  NAME=bak size=20    value="<%=getbyte2(request.getParameter("dsbak")) %>">
        </td>
      </tr>
    </table> 
	 <p align="center"> 

             <input type=hidden name=cusno>
            <input type="submit" value="提　交" name="modi"  >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="reset" value="退  出" name="button" onclick="window.close();">
          </p> 
</form>     
 
   
   <script>
      setSelectMad(document.cus1.taxname_type1,"<%=request.getParameter("taxname_type") %>");

   </script>
       
       
       
</body>       
</html>       
