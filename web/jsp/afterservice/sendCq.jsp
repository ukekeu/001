<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
 <jsp:useBean id="txt" scope="page" class="ConnDatabase.WriteToTxtBean"/>
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<%
String sb_cq_date=getbyte1(request.getParameter("sb_cq_date")); 
String codes=getbyte1(request.getParameter("codes")); 
if (!sb_cq_date.equals("")){
  sb_cq_date=China.getParameter(request, "sb_cq_date");
String song_jian_date=China.getParameter(request, "song_jian_date");
ViewBean.executeUpdate("update order_contract  set sb_cq_date='"+sb_cq_date+"',song_jian_date='"+song_jian_date+"' where cq=1 and code in("+codes+")");
%>
<script>

opener.document.forms[0].submit();
window.close();
</script>

<%
}else{
 %>
<title>ѡ���Ͱ��Ȩ</title>
<script language="JavaScript" src='../public_js/basal.js'></script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script>
function okvalue(){
if (document.frm.sb_cq_date.value==""){
  alert("��ѡ���������");
  return false;
  }
  if (document.frm.song_jian_date.value==""){
  alert("��ѡ���Ͱ�����");
  return false;
  }
 document.frm.submit();
}

</script>
</head>
<center>
<form name=frm method="post" action="">
 <input type=hidden name=codes value="<%=getbyte1(request.getParameter("codes")) %>">
 <tr>
  <td width="14%">�������</td>
      <td width="18%"><INPUT TYPE="text"    NAME=sb_cq_date size=10   ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(sb_cq_date);return false;" title="��ѡ�񰴽�����"></td>
</tr>
 
<tr>
  <td width="14%">�Ͱ�����</td>
      <td width="18%"><INPUT TYPE="text"    NAME=song_jian_date size=10  ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(song_jian_date);return false;" title="��ѡ�񰴽�����"></td>
</tr>
  
</table>
 <input type=button name=submit1 value="ȷ���Ͱ�"  onclick="okvalue();"> <input type=button name=winclose value="�� ��" onclick="window.close();" >
 
</form>     
  <%} %>     
       </center>
</body>       
</html>       
