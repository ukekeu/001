 
 
    <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
    <%@ include file="../public_js/getByteOut.jsp"%>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<SCRIPT language="JavaScript1.2" type="text/javascript">
function checkData(form)
{ 
   var ans;	
   ans=IsBlank("emp_code","������������ƣ�");
   if(!ans) return false;
    
   ans=IsBlank("object","��ѡ����Ȩ����");
   if(!ans) return false;
   
   return true;
}
</SCRIPT> 
<script language="javascript" src="../public_js/public.js"></script>
<title>�����������</title>
</head>
<body topmargin="0" leftmargin="0">
<form name="pm" method="post" action="add_flow_type_action.jsp" onSubmit="return checkData()">
 
<center>
 <table border="0" width="95%"  cellspacing="1" cellpadding="0" class="L2">
  <tr>
    <td width="100%" class="title" align="center">�������</td>
  </tr>
 </table>
  <table border="0" width="95%"  cellspacing="1" cellpadding="0" class="L2">
	<tr>
      <td width="20%" align="right" class=firsttd>������ƣ�</td>
      <td width="30%" class=listtd>
	  <input type=text name="emp_code" value="" size=50 ><font color=red>*</font>
      </td>
	   </tr>
 
	<tr>
      <td width="20%" align="right" class=firsttd>��Ȩ����</td>
      <td width="30%" class=listtd>
        <textarea name="object" cols="50" rows="5"></textarea><font color=red>*</font><input type=button name="addobject" onclick="openwin2('user_tree.jsp','500','300',100,100);" value="...">
      </td>
    </tr> 
    
	<tr>
	  <td width="20%" align="right" class=firsttd>��ע��</td>
      <td width="30%" class=listtd  >
	  <textarea name="remark" cols="55" rows="5"></textarea>
	  </td>
	</tr>
  </table>
  <br>
  <table border="0" width="95%"  cellspacing="1" cellpadding="0" class="L2">
  <tr>
    <td align="right">
	 
	<input type=submit name=ok value="����" class="button">
	 
	<input type="button" onclick="javascript:window.close()" value="�ر�" class=button>
	</td>
  </tr>
</table>
</center>
</form>
 
</body>
</html>