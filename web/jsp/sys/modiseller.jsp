<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>�޸�����Ա����</title>
</head>

<%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<body  oncontextmenu="return false"> 
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="JavaScript" src='../public_js/public.js'></script>
<form name=frm method="post"  action="seller_ac.jsp">

<%@ include file="../public_js/getByteOut.jsp"%>

<center>
<%
  String id=request.getParameter("id");
  String SQL="SELECT s.* FROM seller s WHERE code="+id;
   ResultSet rs = aBean.executeQuery(SQL);
   String section="",sellercode="",sellername="",sex="",tel="",mail="";
   
if (rs.next()){
   section=rs.getString("section_no");
   sellercode=rs.getString("seller_no");
   sellername=getbyte(rs.getString("seller"));
   sex=rs.getString("sex");
   tel=rs.getString("tel");
   mail=getbyte(rs.getString("mail"));
}rs.close();
 %>
<p align="center"><b><font class=FontColor size="3" ><b>�޸�����Ա����</font></b></p>
<table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center   class="tablefill">
  
  <tr>
    <td width="25%"  class=roomleft >&nbsp;����¥�̣�</td>  
    <td width="25%"   class=roomright>&nbsp;<select name="section"  > 
   <option></option>
<%  

	
      String sql1="select SerialNo,Name from Crm_Project";

	  ResultSet rs2=aBean.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	 	    rs2.close();
	
     %> </select></td>
	 </tr>
	  <tr>
    <td width="25%"  class=roomleft >&nbsp;�� �ţ�</td>  
    <td width="25%"  class=roomright>&nbsp;<input type=text name=code  size=15 value="<%=sellercode %>"></td>
  </tr>
	 <tr>
    <td width="25%"  class=roomleft >&nbsp;��   ����</td>  
    <td width="25%"  class=roomright>&nbsp;<input type=text name=name  size=15 value="<%=sellername%>"></td>
  </tr>
 <tr>
    <td width="25%"  class=roomleft >&nbsp;��  ��</td>  
    <td width="25%"  class=roomright>&nbsp;<select name=sex><option value="��">��</option><option value="Ů">Ů</option></td>
  </tr>
  <tr>
    <td width="25%"  class=roomleft >&nbsp;��ϵ�绰:</td>
    <td width="25%"  class=roomright>&nbsp;<input type=text name=tel  size=15 value="<%=tel%>">
  </td>
</tr><tr>
    <td width="25%"  class=roomleft >&nbsp;��ϵmail��</td>  
    <td width="25%"  class=roomright>&nbsp;<input type=text name=mail  size=15 value="<%=mail%>"></td>
  </tr>
  
  </table>
  <p align=center>
  <input type=hidden name=id value="<%=id %>">
<input type=button name=save value="ȷ   ��" onclick="saveSeller();">
 <input type=reset name=del value="ȡ   ��" onclick="window.close();">
</p>

</center>
<script>
setSelectMad(document.frm.section,"<%=section %>");
setSelectMad(document.frm.sex,"<%=sex %>");

function saveSeller(){
 if (document.frm.section.value==""){alert("��ѡ������¥��");return false;}
  if (document.frm.code.value==""){alert("��д����Ա���");return false;}
 if (document.frm.name.value==""){alert("��д����Ա����");return false;}
 
document.frm.submit();

}
</script>
</form>
</body>

</html>
