<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
 

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>费用名称设置</title>
</head>

<%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<body onload="document.frm.codename.focus();" oncontextmenu="return false" >
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="JavaScript" src='../public_js/public.js'></script>

<%@ include file="../public_js/getByteOut.jsp"%>
<%
  String codename=getbyte1(request.getParameter("codename"));
  String section=getbyte1(request.getParameter("section"));
  String taxtype=getbyte1(request.getParameter("taxtype"));
  String type=getbyte1(request.getParameter("type"));
  String type1=getbyte1(request.getParameter("type1"));
    String type3=getbyte1(request.getParameter("type3"));
    String lt=getbyte1(request.getParameter("lt"));
	if (lt.equals(""))lt="0";
  if (!codename.equals("")){
    String SQL="INSERT INTO tax(section,Tax_Name,tax_type,type,type1,type2,type3) values('"+section+"','"+codename+"',"+taxtype+","+type+",'"+type1+"',"+lt+",'"+type3+"')";
    aBean.executeUpdate(SQL);
	setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "费用设置" , 
                  "增加"
                ) ;
	%>
	<SCRIPT>
	 if (!confirm("已保存数据，是否继续?")){
	  opener.document.forms[0].submit();
	  window.close();
	  }
	</script>
	<%
  }
  try{
  ResultSet rs=aBean.executeQuery("select * from tax where section='"+section+"'");
  out.print("<script>");
  out.print("var ch_Name=new Array();");
  int iii=0;
   while (rs.next()){
		 out.print("ch_Name["+String.valueOf(iii)+"]="+"\""+getbyte(rs.getString("Tax_Name"))+"\""+";");
    
	 iii++;
      }	 
	  out.print("</script>");
	  rs.close();
}catch(Exception s){  out.print(s.getMessage());out.close();}


 
 %>
 <form name=frm method="post"  action="" onsubmit="return Validate();"> 
<center>
<p>&nbsp;</p>
 <p align="center"><font size=3 class=FontColor><b>费用名称设置</b></font></p>
<input type=hidden name=section value="<%=request.getParameter("section") %>">
 
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
   
  <tr  ALIGN=center>
    <td width="20%" class=listtitle ><font color=white>费用名称</font></td>  
    <td width="50%" ALIGN=left class=roomright  >&nbsp;<input type=text name=codename  size=20   ></td>
  </tr>
   <tr  ALIGN=center>
    <td width="20%" class=listtitle ><font color=white>费用类别</font></td>  
    <td width="50%" ALIGN=left class=roomright  >&nbsp;<select name=taxtype><option value=0>配套费</option><option value=1>税费</option></select></td>
  </tr>
    <tr  ALIGN=center>
    <td width="20%" class=listtitle ><font color=white>交费客户</font></td>  
    <td width="50%" ALIGN=left class=roomright  >&nbsp;<select name=type><option value=0>所有客户</option><option value=1>按揭客户</option><option value=3>境外客户</option><option value=2>入户客户</option></select></td>
  </tr>
  <tr  ALIGN=center>
    <td width="20%" class=listtitle ><font color=white>房&nbsp;&nbsp;&nbsp;&nbsp;类</font></td>  
    <td width="50%" ALIGN=left class=roomright  >&nbsp;<select name=type3>
	<option value=""></option>
	<option value="所有">所有</option>
		  <%
	  String   StrSql="select type,codename from CODE where Child=0 and type='c' order by type";
      ResultSet  codeRS=null;
    
    codeRS=aBean.executeQuery(StrSql);
   %>
				  <%
		   while (codeRS.next()){
			 out.print("<option value='"+getbyte(codeRS.getString("codename"))+"'>"+getbyte(codeRS.getString("codename"))+"</option>");
		   }
		   codeRS.close();
				%>
				
				</select></td>
  </tr>
    <tr  ALIGN=center>
    <td width="20%" class=listtitle ><font color=white>房屋用途</font></td>  
    <td width="50%" ALIGN=left class=roomright  >&nbsp;<select name=type1>
	<option value=""></option>
	<option value="所有">所有</option>
		  <%
	      StrSql="select type,codename from CODE where Child=0 and type='yt' order by type";
       
    
    codeRS=aBean.executeQuery(StrSql);
   %>
				  <%
		   while (codeRS.next()){
			 out.print("<option value='"+getbyte(codeRS.getString("codename"))+"'>"+getbyte(codeRS.getString("codename"))+"</option>");
		   }
		   codeRS.close();
				%>
				
				</select></td>
  </tr>
  
  </table>

  <p align="center"> 
 <input name="lt" type="hidden" value=0>
            &nbsp;&nbsp;
			<input type=button name=submit1 value="提 交" onclick="Validate();">
		
           &nbsp;
		   <input type=button name=cancel value="关 闭" onclick="window.close();">
	   &nbsp;
    
          </P>
 



</center>
</form>
<script>
function checkedNoExist(){
    if (document.frm.codename.value==""){document.frm.codename.focus();return false;}
    for (var i=0;i<ch_Name.length;i++){
	    if (document.frm.codename.value==ch_Name[i]){
		 alert("此费用名称已存在");
		 document.frm.codename.focus();
		 return false;
		}
	
	}
 } 
 
 
  function Validate()
   {
	
    if (document.frm.codename.value==""){
        alert("请输入你的代码名称");
        return (false);}
		
		 if (document.frm.type3.value==""&&document.frm.type1.value==""){ 
		{
	       alert("房类或用途至少选择一项");
	       return (false);}
		}
     if (document.frm.type3.value!=""&&document.frm.type1.value!=""){ 
		{
	       alert("房类或用途只能选择一项");
	       return (false);}
		}
	if (confirm("确定保存你填写的数据吗？"))	
	  {
	  document.frm.submit();
   return (true);
   }
   }
 
</script>
</body>

</html>
