<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>��������Ա</title>
</head>

<%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/CheckSection.jsp"%>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<body onload="document.frm.code.focus();;setSelectMad(document.frm.section,'<%=request.getParameter("section") %>');">
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="JavaScript" src='../public_js/public.js'></script>
<form name=frm method="post"  action="seller_ac.jsp">
<%@ include file="../public_js/getByteOut.jsp"%>

<center>

<p align="center"><b><font class=FontColor size="3" ><b>��������Ա</font></b></p>
<table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center   class="tablefill">
  
  <tr>
    <td width="25%"  class=roomleft >&nbsp;����¥�̣�</td>  
    <td width="25%"   class=roomright>&nbsp;<select name="section"  > 
   <option></option>
<%  
String section=request.getParameter("section");

if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from Crm_Project where SerialNo in("+SectionS+")";
	  ResultSet rs2=aBean.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"' >"+sec+"</option>");
	  }
	 	    rs2.close();
	
     %> </select></td>
	 </tr>
	  <tr>
    <td width="25%"  class=roomleft >&nbsp;�� �ţ�</td>  
    <td width="25%"  class=roomright>&nbsp;<input type=text name=code onkeydown="key(document.frm.name)" size=15></td>
  </tr>
	 <tr>
    <td width="25%"  class=roomleft >&nbsp;��   ����</td>  
    <td width="25%"  class=roomright>&nbsp;<input type=text name=name onkeydown="key(document.frm.sex)" size=15></td>
  </tr>
 <tr>
    <td width="25%"  class=roomleft >&nbsp;��  ��</td>  
    <td width="25%"  class=roomright>&nbsp;<select name=sex onkeydown="key(document.frm.tel)"><option>��</option><option>Ů</option></td>
  </tr>
  <tr>
    <td width="25%"  class=roomleft >&nbsp;��ϵ�绰:</td>
    <td width="25%"  class=roomright>&nbsp;<input type=text name=tel  size=15 onkeydown="key(document.frm.mail)">
  </td>
</tr><tr>
    <td width="25%"  class=roomleft >&nbsp;��ϵmail��</td>  
    <td width="25%"  class=roomright>&nbsp;<input type=text name=mail  size=15></td>
  </tr>
  
  </table>
  <p align=center>
<input type=button name=save value="ȷ   ��" onclick="saveSeller();">
 <input type=reset name=del value="ȡ   ��" onclick="window.close();">
</p>

</center>
</form>
<script>

function saveSeller(){
 if (document.frm.section.value==""){alert("��ѡ������¥��");return false;}
  if (document.frm.code.value==""){alert("��д����Ա���");return false;}
 if (document.frm.name.value==""){alert("��д����Ա����");return false;}
 
document.frm.submit();

}
</script>
</body>

</html>
