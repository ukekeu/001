<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "ģ������" , 
                  "���"
                ) ;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>ϵͳģ������</title>
</head>

<%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<body oncontextmenu="return false">
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="JavaScript" src='../public_js/public.js'></script>
<form name=frm method="post"  action="savemodule.jsp">
<script>
function selecode(){
  document.frm.MModuleNo.value=document.frm.TYPE1.options[document.frm.TYPE1.selectedIndex].value; 
  document.frm.MModuleName.value=document.frm.TYPE1.options[document.frm.TYPE1.selectedIndex].text;
  MM_showHideLayers('CODE','','hide');
  sh3="false";
  document.frm.CModuleName.focus();
}
</script>
<div id="CODE" style="position:absolute; left:350px; top:60px; width:150px; height:52px; z-index:1; visibility: hidden"> 

<%@ include file="../public_js/getByteOut.jsp"%>

 <select  name="TYPE1"  onchange="selecode();" multiple size=10>
 <%
  String no=request.getParameter("no");
  if (no!=null){
     aBean.executeUpdate("delete ModuleCortrol where CModuleNo='"+no+"'");
   }
 
   String sql="select MModuleNo,MModuleName from ModuleCortrol  group by MModuleNo,MModuleName"; 
   ResultSet rs=null;
  try{
   rs=aBean.executeQuery(sql);
   while (rs.next()){
   String MModuleNo=rs.getString("MModuleNo");
   String MModuleName= getbyte(rs.getString("MModuleName")) ;
    out.println("<option value="+MModuleNo+">"+MModuleName+"</option>");
   }
  }catch(Exception s){out.println(s.getMessage());}
  
  rs.close(); %>
  </select>
</div>

<center>
   <p align="center"><font size=3><b>ģ������</b></font></p>
<table BORDER=0 width="60%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#000000" class="tablefill">
  <tr>
    <td width="50%"  >&nbsp;ģ�����</td>  
    <td width="50%"  >&nbsp;<input type=text name=MModuleNo  size=10 onblur="toUpper(document.frm.MModuleNo);"><input type=button name=sele value=".." title="ѡ����ڵ�����" onclick="shList('CODE');"></td>
  </tr>
  <tr>
    <td width="50%"  >&nbsp;ģ������</td>  
    <td width="50%"  >&nbsp;<input type=text name=MModuleName  size=10></td>
  </tr>
<!--
  <tr>
    <td width="50%"  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������</td>
    <td width="50%"  >&nbsp;<input type=text name=codeno  size=10></td>
  </tr>
-->  
  <tr>
    <td width="50%"  >&nbsp;��ģ������</td>  
    <td width="50%"  >&nbsp;<input type=text name=CModuleName  size=15><select name=PC><option value='C'>��ģ����</option><option value='P'>��ģ����</option></select></td>
  </tr>
  <tr>
    <td width="50%"  >&nbsp;ģ����ʵ�ַ</td>  
    <td width="50%"  >&nbsp;<input type=text name=ModuleUrl  size=20></td>
  </tr>
  </table>
 
<p align=center>
<input type=submit name=save value="ȷ��">
<input type=reset name=cancel value="��д">

 </p>

</center>
</form>
<jsp:include page="modulelist1.jsp" flush="true"/>
</body>

</html>
