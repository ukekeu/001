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
   String taxtype=getbyte1(request.getParameter("taxtype"));
   String taxoject=getbyte1(request.getParameter("taxoject"));
   String name=getbyte1(request.getParameter("name"));
    String room=getbyte1(request.getParameter("room"));
  
  if (!FactMoney.equals("")){
  String  SQL="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney";
  SQL+=",taxname_type,taxtype) values('"+id+"','"+name+"',"+FactMoney;
  SQL+=","+taxtype+","+taxoject+")";
     ViewBean.executeUpdate(SQL); 
	setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "补增配套费记录" , 
                  "补增"+room
                ) ;	
				
	String sql="select  money as TaxMoney,TaxName from factGatheringTaxRecord where TaxName='"+name+"' and contractno ='"+id+"'  ";//order by room_no desc";
     ResultSet  rs=ViewBean.executeQuery(sql);
   
   while (rs.next()){
     String modiTaxstate="update  GatheringTaxRecord  set state=case when TaxMoney>"+rs.getString("TaxMoney")+" then 0 else 1 end,factMoney="+rs.getString("TaxMoney")+" where ltrim(rtrim(taxname))='"+rs.getString("TaxName").trim()+"' and ContactNo="+id;
	 ViewBean2.executeUpdate(modiTaxstate);
	 
 }
 rs.close();
  %>
  <script>
  alert("已增加");
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
<title>补加费用</title>

</head>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
 


<body   bgcolor="#EBEBEB">

<form method="POST" name="frm" action="">
<input type=hidden name=id value=<%=id %>>
 <input type=hidden name=room value=<%=getbyte2(request.getParameter("room")) %>>
	<p align="center"><b><font size="3" color="#000080">增加项目</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;费用名称</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=name  size=12    >
		  </td>
      </tr>
      
     
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;费用金额</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="FactMoney" size=12 size="20" style="border-style: solid; border-width: 1" onblur="check(this);">
        </td>
      </tr>
	    <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;收费对象</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<select name=taxoject style="width : 98">
  		  <option value=0>个人</option>
		  <option value=1>单位</option>

		  </select>
        </td>
      </tr>
	    <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;费用类别</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<select name=taxtype  style="width : 98" >
  		  <option value=0>配套费</option>
		  <option value=1>税费</option>

		  </select>
        </td>
      </tr>
    </table> 
	 <p align="center"> 

             <input type=hidden name=cusno>
            <input type="button" value="提　交" name="modi" onclick="checkdata();" >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="reset" value="退  出" name="button" onclick="window.close();">
          </p> 
</form>     
  <script>
 function checkdata(){
  if (document.frm.name.value==""){alert("请录入补增的项目名称!");return false;}
  if (document.frm.FactMoney.value==""){alert("请录入补增的项目金额!");return false;}
   document.frm.modi.disabled=true;
  document.frm.submit();
 }
 
 </script>
   
       
       
</body>       
</html>       
