<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
  <%@ page import = "java.sql.*,common.*" %>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />
   <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
  <%@ include file="../public_js/getByteOut.jsp"%>

<html>
<head>
	<title>����ָ��</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body>


<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="101">
  <tr>
    <td width="6%" rowspan="3" height="50" align="center">¥��<p>����</td>
    <td width="24%" colspan="4" rowspan="2" height="33" align="center">
    XXX�£����ȡ��ָ꣩�����</td>
    <td width="28%" colspan="4" rowspan="2" height="33" align="center">
    XXX�£����ȡ��꣩����ָ��������</td>
    <td width="42%" colspan="6" height="16" align="center">XXX�£����ȡ��꣩����ָ��������</td>
  </tr>
  <tr>
    <td width="21%" height="16" colspan="3" align="center">�����ʽ�</td>
    <td width="21%" height="16" colspan="3" align="center">�Ͻ�ָ��</td>
  </tr>
  <tr>
    <td width="6%" height="16" align="center"></td>
    <td width="6%" height="16" align="center"></td>
    <td width="6%" height="16" align="center"></td>
    <td width="6%" height="16" align="center"></td>
    <td width="7%" height="16" align="center"></td>
    <td width="7%" height="16" align="center"></td>
    <td width="7%" height="16" align="center"></td>
    <td width="7%" height="16" align="center"></td>
    <td width="7%" height="16" align="center"></td>
    <td width="7%" height="16" align="center"></td>
    <td width="7%" height="16" align="center"></td>
    <td width="7%" height="16" align="center"></td>
    <td width="7%" height="16" align="center"></td>
    <td width="7%" height="16" align="center"></td>
  </tr>
  <tr>
    <td width="6%" height="1" align="center"></td>
    <td width="6%" height="1" align="center"></td>
    <td width="6%" height="1" align="center"></td>
    <td width="6%" height="1" align="center"></td>
    <td width="6%" height="1" align="center"></td>
    <td width="7%" height="1" align="center"></td>
    <td width="7%" height="1" align="center"></td>
    <td width="7%" height="1" align="center"></td>
    <td width="7%" height="1" align="center"></td>
    <td width="7%" height="1" align="center"></td>
    <td width="7%" height="1" align="center"></td>
    <td width="7%" height="1" align="center"></td>
    <td width="7%" height="1" align="center"></td>
    <td width="7%" height="1" align="center"></td>
    <td width="7%" height="1" align="center"></td>
  </tr>
</table>



</body>
</html>
