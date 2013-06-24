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
  String saleId=request.getParameter("saleid");
  String monthpay=request.getParameter("monthpay");
    String monthpay1=request.getParameter("monthpay1");
  String ajyear=request.getParameter("ajyear");
    String ajyear1=request.getParameter("ajyear1");
	String bank_person=getbyte1(request.getParameter("bank_person"));
   String ajbk=getbyte1(request.getParameter("ajbk"));
   String bk=getbyte1(request.getParameter("bk"));
  String ajcs=request.getParameter("ajcs");
  String dd=request.getParameter("dd");
  String ajDate=request.getParameter("ajDate1");
  String ajdy=getbyte1(request.getParameter("ajdy"));
  String gtcz=getbyte1(request.getParameter("gtcz"));
  String gz=request.getParameter("gz");
   String bx=request.getParameter("bx");
  String ajhtno=getbyte1(request.getParameter("ajhtno"));
  if (dd!=null){
    String sql="update order_contract set ajhtno='"+ajhtno+"',bank_person='"+bank_person+"',";
	sql+="ajbk='"+bk+"',ajcs="+ajcs;
	sql+=",gzstate="+gz+",bxstate="+bx;
	if (!ajyear1.equals(""))
	 sql+=",ajyear="+ajyear1;
	if (!gtcz.equals(""))
	 sql+=",gtcz_date='"+gtcz+"'";
	else 
	 sql+=",gtcz_date=null";
	 if (!ajdy.equals(""))
	 sql+=",gtsj_date='"+ajdy+"'";
	else 
	 sql+=",gtsj_date=null";
 
	sql+=",MonthPayMoney="+monthpay1+",ajdate='"+ajDate+"' where code="+saleId;
 
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
 setSelectMad(document.frm.ajyear1,'<%=ajyear %>');
 
  setSelectMad(document.frm.gz,'<%=request.getParameter("gzstate") %>');
 setSelectMad(document.frm.bx,'<%=request.getParameter("bxstate") %>');
 }
 
 </script>
 <script>
function okvalue(){
if (document.frm.ajDate1.value==""){
  alert("请选择按揭的日期");
  return false;
  }
 document.frm.submit();
}

</script>
<body onload="full();">
 

<form name=frm method="post" action="inputAj.jsp">
<input type=hidden name=saleid value="<%=saleId %>">
<table>
<tr>
<td>按揭合同编号</td><td><input type=text size=15 name=ajhtno value=<%=request.getParameter("ajHt") %>></td>
</tr>
<tr>
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
<tr>
  <td width="14%">国土送件日期</td>
      <td width="18%"><INPUT TYPE="text"    NAME=ajdy size=10  onkeydown="key(document.cus.ajDate1)" value=<%=request.getParameter("gtsj_date") %>><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(ajdy);return false;" title="请选择日期"></td>
</tr>
<tr>
  <td width="14%">国土出证日期</td>
      <td width="18%"><INPUT TYPE="text"    NAME=gtcz size=10  onkeydown="key(document.cus.ajDate1)" value=<%=request.getParameter("gtcz_date") %>><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(gtcz);return false;" title="请选择日期"></td>
</tr>
<tr>
 <td width="14%"  >公证情况</td>
      <td width="18%" ><select name="gz" style="width : 105"><option value="0">未办</option><option value="1">已办</option></select></td>
	</tr>
<tr>  
      <td width="14%" >保险情况</td>
      <td width="18%" ><select name="bx" style="width : 105"><option value="0">未办</option><option value="1">已办</option></select></td>

</tr>
<tr>  <td width="14%">按揭日期</td>
      <td width="18%"><INPUT TYPE="text"  readonly NAME=ajDate1 size=10  onkeydown="key(document.cus.ajDate1)" value=<%=request.getParameter("ajDate") %>><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(ajDate1);return false;" title="请选择按揭日期"><font color="red">*</font></td>
</tr>
<tr>  <td width="14%">经办人</td>
      <td width="18%"><INPUT TYPE="text"    NAME=bank_person size=10  value=<%=getbyte1(request.getParameter("bank_person")) %>  ><font color="red">*</font></td>
</tr>
<tr>
<td>按揭年限</td><td><select name=ajyear1><option></option>
          <%for (int i=1;i<=30;i++){
		out.print("<option value="+String.valueOf(i)+">"+String.valueOf(i)+"年</option>");
		} %>
        </select></td></td>
</tr>
<tr>
<td>按揭成数</td><td><input type=text size=10 name=ajcs value="<%=ajcs %>"></td>
</tr>
<tr>
<td>月供款</td><td><input type=text size=10 name="monthpay1" value="<%=monthpay %>"></td>
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
