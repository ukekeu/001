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
   String Money  =getbyte1(request.getParameter("Money"));
   if (Money.equals(""))Money="0";
   String state=getbyte1(request.getParameter("OKstate"));
   
   String name=getbyte1(request.getParameter("taxname"));
   String room   =getbyte1(request.getParameter("room"));
   String taxname_type=getbyte1(request.getParameter("taxname_type1"));
  if (!FactMoney.equals("")){
  String  SQL="";
  if (state.equals("1"))
  SQL="update GatheringTaxRecord set taxname_type="+taxname_type+",taxname='"+name+"' ,state="+state+",TaxMoney="+Money+",factmoney="+FactMoney+" where  ID ="+id;
  else
  SQL="update GatheringTaxRecord set taxname_type="+taxname_type+", taxname='"+name+"' ,state="+state+",TaxMoney="+Money+",factmoney="+FactMoney+" where  ID ="+id;
 ViewBean.executeUpdate(SQL); 
 
  setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "修改配套费或税费" , 
                  "修改"+room
                ) ;	
 
  %>
  <script>
  alert("已修改");
  opener.findSub('yingshi.jsp');
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
 
	<p align="center"><b><font size="3" color="#000080">修改费用</font></b></p>
	<%String SQL="select taxname_type,taxname,TaxMoney,factmoney,state   from GatheringTaxRecord where  ID ="+id;
	ResultSet rs= ViewBean.executeQuery(SQL); 
	if (rs.next()){
	 %>
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;费用名称</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=taxname  size=12 value="<%=rs.getString("taxname") %>"  onkeydown="key(document.cus1.TAXNAME)">
		  </td>
      </tr>
      
     
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;费用金额</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="Money" size=12 value="<%=rs.getString("TaxMoney") %>" size="20" style="border-style: solid; border-width: 1" onblur="check(this);">
        </td>
      </tr>
	    <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;已付金额</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="FactMoney" size=12 value="<%=rs.getString("factmoney") %>" size="20" style="border-style: solid; border-width: 1" onblur="check(this);">
        </td>
      </tr>
	    <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;费用类别</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<select name=taxname_type1 style="width : 100">
  		  <option value=0 <%if (rs.getInt("taxname_type")==0){out.print("selected");} %>>配套费</option>
		  <option value=1 <%if (rs.getInt("taxname_type")==1){out.print("selected");} %>>税费</option>

		  </select>
        </td>
      </tr>
	     <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;是否付清</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<select name=OKstate style="width : 100"><option value=0 <%if (rs.getInt("state")==0){out.print("selected");} %>>未付清</option><option value=1 <%if (rs.getInt("state")==1){out.print("selected");} %>>已付清</option></select>
        </td>
      </tr>
	   
    </table> 
	<%}rs.close(); %>
	 <p align="center"> 

             <input type=hidden name=cusno>
            <input type="button" value="提　交" name="modi"  onclick="checkModi();" >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="reset" value="退  出" name="button" onclick="window.close();">
          </p> 
</form>     
 
   <script>
   function checkModi(){
    if (confirm("确认修改吗？"))
   　　document.cus1.submit();
   }
      setSelectMad(document.cus1.taxname_type1,"<%=request.getParameter("taxname_type") %>");
      setSelectMad(document.cus1.state,"<%=request.getParameter("state") %>");
   </script>
       
       
</body>       
</html>       
