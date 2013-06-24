<%@ page contentType="text/html;charset=GBK" %>

<%@ include file="../public_js/logrecord.jsp" %>

<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%

%>
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<HEAD>
<TITLE>按揭登记</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chAjRset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js">
</script>
<%
  String saleId=request.getParameter("codes");
 
	String bank_person=getbyte1(request.getParameter("bank_person"));
   String ajbk=getbyte1(request.getParameter("bk"));
 
  String ajDate=request.getParameter("ajDate1");
 
 
  if (!ajbk.equals("")){
    String sql="update order_contract set bank_person='"+bank_person+"',";
	sql+="ajbk='"+ajbk+"',ajdate='"+ajDate+"' where code in ("+saleId+")";
 
ViewBean.executeUpdate(sql);

setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "按揭管理" , 
                  "按揭登记"
                ) ; 
  %>
  <script>
  alert("已保存数据");
  opener.document.forms[0].submit();
   window.close();
  </script>
  <%
 
  }
  
  

 %>
 <script>
 function full(){
 
 setSelectMad(document.frm.bk,'<%=ajbk %>');
 
 }
 
 </script>
 <script>
function okvalue(){
if (document.frm.bk.value==""){
  alert("请选择按揭银行");
  return false;
  }
  if (document.frm.ajDate1.value==""){
  alert("请选择按揭的日期");
  return false;
  }
 document.frm.submit();
}

</script>
<body onload="full();">
 

<form name=frm method="post" action="inputAjs.jsp">
<input type=hidden name=codes value="<%=saleId %>">
<table>
 
<td>按揭银行</td><td><select name="bk"  style="width : 105">
         <option value=""></option>
		  <%
	   String  StrSql="select type,codename from CODE where type='T' order by type";
    ResultSet    codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   %>
				  <%
		   while (codeRS.next()){
		     String bk1=getbyte(codeRS.getString("codename"));
			 out.print("<option value='"+bk1+"'>"+bk1+"</option>");
		   }
		   codeRS.close();
				%>
        </select></td>
</tr> 
<tr>  <td width="14%">按揭日期</td>
      <td width="18%"><INPUT TYPE="text"  readonly NAME=ajDate1 size=10  onkeydown="key(document.cus.ajDate1)" value=<%=getbyte(request.getParameter("ajDate")) %>><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(ajDate1);return false;" title="请选择按揭日期"><font color="red">*</font></td>
</tr>
<tr>  <td width="14%">经办人</td>
      <td width="18%"><INPUT TYPE="text"    NAME=bank_person size=13  onkeydown="key(document.cus.ajDate1)" value=""><font color="red">*</font></td>
</tr>
 
</table>
<br>
<center>
<input type=hidden name=dd value="ok">
<input type=button name=save value="提 交" onclick="document.frm.submit();">&nbsp;&nbsp;&nbsp;<input type=button name=save value="退 出" onclick="window.close();">&nbsp;
</center>
</form>


</body>
</html>
