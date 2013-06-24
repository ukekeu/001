<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>


<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>新增用户</title>
</head>

<%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<body oncontextmenu="return false" >
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="JavaScript" src='../public_js/public.js'></script>
<form name=frm method="post"  action="add_userupdate.jsp">

<%@ include file="../public_js/getByteOut.jsp"%>

<center>
<%
 
String loginID=(String)session.getAttribute("loginid");
String SQL="select * from CortrolMan WHERE SerialNo='"+loginID+"'";
String control="";
ResultSet qx=null;

  qx = aBean.executeQuery ( SQL );
if (qx.next()){
  control=qx.getString("job");
}
qx.close();

 %>
<p align="center"><b><font class=FontColor size="3" ><b>新增用户</font></b></p>
<table BORDER=0 width="95%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#000000" class="tablefill">
  
  <tr>
    <td width="25%"  class=roomleft >&nbsp;登录ID：</td>  
    <td width="25%"   class=roomright>&nbsp;<input type=text name=loginID  size=10 ></td>
</tr>
<tr>
    <td width="25%"  class=roomleft >&nbsp;用户姓名：</td>  
    <td width="25%"  class=roomright>&nbsp;<input type=text name=loginName  size=10></td>
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
    <td width="25%"  class=roomright>&nbsp;<select name="JOB"><option></option>
		  <%
            StrSql="select type,codename from CODE  WHERE TYPE='B' order by type";
          
		   codeRS=aBean.executeQuery(StrSql);
		 
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
    <td width="25%"  class=roomleft >&nbsp;联系电话：</td>  
    <td width="25%"  class=roomright>&nbsp;<input type=text name=TEL  size=20></td>
  </tr>
  <tr>
    <td width="25%"  class=roomleft >&nbsp;MAC地址：</td>  
    <td width="25%"  class=roomright>&nbsp;<input type=text name=mac  size=20 value=""></td>
  </tr>
  </table>
  <p align=center>
<input type=button name=savedata value="确   定" onclick="checkdata();">
 
    <input type=reset name=del value="取   消" onclick="window.close();">
</p>

</center>
</form>
<script>
  function checkdata(){
   if (document.frm.loginID.value==""){ alert("请填写用户登录ID");document.frm.loginID.focus();return false;}
   if (document.frm.loginName.value==""){ alert("请填写用户姓名");document.frm.loginName.focus();return false;}
   if (document.frm.company.value==""){ alert("请填写用户所属公司");document.frm.company.focus();return false;}
  
   /* if (!isNaN(document.frm.disc.value)){
      if (parseFloat(document.frm.disc.value)>100||parseFloat(document.frm.disc.value)<60)
       alert("折扣数有误,请重新录入");return false;
   
   }else{
       alert("折扣数有误!");return false;
   } */
  document.frm.submit();
   return true;
  }
</script>

</body>

</html>
