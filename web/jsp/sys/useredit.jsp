<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%!
	public String getParameter(javax.servlet.http.HttpServletRequest request,String para)
								throws Exception  {
		String temp = "";
		temp = request.getParameter(para);
		if (temp == null)
			temp = "";
		temp = new String(temp.getBytes("ISO8859_1"),"GBK");
		return temp;	
	}
%>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "用户管理" , 
                  "修改"
                ) ;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>修改用户</title>
</head>

<%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<body  oncontextmenu="return false">
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="JavaScript" src='../public_js/public.js'></script>
<form name=frm method="post"  action="usermodify.jsp">

<%@ include file="../public_js/getByteOut.jsp"%>

<center>
<%
 
String loginID=(String)session.getAttribute("loginid");
String SID=getParameter(request,"tid");
String SQL="select * from CortrolMan WHERE id='"+SID+"'";
String control="";
String SerialNo="";
String Name="";
String tel="";
String job="",mac="";
String DEPT="",company="";
ResultSet qx=null;

  qx = aBean.executeQuery ( SQL );
if (qx.next()){
  control=qx.getString("job");
  SerialNo=qx.getString("SerialNo");
  Name=getbyte(qx.getString("Name"));
  tel=getbyte(qx.getString("tel"));
  job=getbyte(qx.getString("job"));
  DEPT=getbyte(qx.getString("DEPT"));
  company=getbyte(qx.getString("company"));
  mac=getbyte(qx.getString("mac"));
}
qx.close();

 %>
<p align="center"><b><font class=FontColor size="3" ><b>修改用户</font></b></p>
<table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#000000" class="tablefill">
  
  <tr>
    <td width="25%"  class=roomleft >&nbsp;登录ID：</td>  
	<input type=hidden name=marginno  size=10 value="<%=SerialNo %>">
	<input type=hidden name=ID  size=10 value="<%=SID %>">
    <td width="25%"   class=roomright>&nbsp;<input type=text name=EN  size=10 value="<%=SerialNo %>" readonly></td>
 </tr>

  <tr>
    <td width="25%"  class=roomleft >&nbsp;用户姓名：</td>  
    <td width="25%"  class=roomright>&nbsp;<input type=text name=CN  size=10 value="<%=Name %>"></td>
  </tr>
  <tr>
    <td width="25%"  class=roomleft >&nbsp;所属公司：</td>
    <td width="25%"  class=roomright>&nbsp;<select name="company"><option></option>
		  <%
           String StrSql="select CompanyName  from company  ";
           ResultSet codeRS=null;
		   codeRS=aBean.executeQuery(StrSql);
		   String CompanyName="";
		   while (codeRS.next()){
		     CompanyName=getbyte(codeRS.getString("CompanyName"));
			  out.print("<option value='"+CompanyName+"'>"+CompanyName+"</option>");
		   }
		   codeRS.close();
		   %>
		  </select> 
  </td>
</tr>
<tr>
    <td width="25%"  class=roomleft >&nbsp;所在部门：</td>
    <td width="25%"  class=roomright>&nbsp;<select name="DEPT"><option></option>
		  <%
              StrSql="select type,codename from CODE  WHERE TYPE='DE' order by type";
             codeRS=null;
		   codeRS=aBean.executeQuery(StrSql);
		   String codename="";
		   while (codeRS.next()){
		     codename=getbyte(codeRS.getString("codename"));
			  out.print("<option value='"+codename+"'>"+codename+"</option>");
		   }
		   codeRS.close();
		   %>
		  </select> 
  </td>
</tr>
  <tr>
    <td width="25%"  class=roomleft >&nbsp;职 位：</td>
    <td width="25%"  class=roomright>&nbsp;<select name="JOB">
	<option></option>
		 <%
              StrSql="select type,codename from CODE  WHERE TYPE='B' order by type";
             codeRS=null;
		   codeRS=aBean.executeQuery(StrSql);
		     codename="";
		   while (codeRS.next()){
		     codename=getbyte(codeRS.getString("codename"));
			  out.print("<option value='"+codename+"'>"+codename+"</option>");
		   }
		   codeRS.close();
		   %>
		  </select> 
  </td>
  <script>
   setSelectMad(document.frm.JOB,'<%=job%>');  
   setSelectMad(document.frm.DEPT,'<%=DEPT%>');  
   setSelectMad(document.frm.company,'<%=company%>');  
   
   
  </script>
 </tr>

  <tr>
    <td width="25%"  class=roomleft >&nbsp;联系电话：</td>  
    <td width="25%"  class=roomright>&nbsp;<input type=text name=TEL  size=20 value="<%=tel %>"></td>
  </tr>
    <tr>
    <td width="25%"  class=roomleft >&nbsp;MAC地址：</td>  
    <td width="25%"  class=roomright>&nbsp;<input type=text name=mac  size=20 value="<%=mac %>"></td>
  </tr>
  </table>
  <p align=center>
<input type=submit name=save value="确   定">
<input type=reset name=del value="取   消" onclick="window.close();">
</p>

</center>
</form>
</body>

</html>
