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
 
<title>������������</title>
</head>

<%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<body onload="document.frm.codename.focus();"  oncontextmenu="return false">
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="JavaScript" src='../public_js/public.js'></script>
<form name=frm method="post"  action=""> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%
  String codename=getbyte1(request.getParameter("codename"));
  String section=getbyte1(request.getParameter("section"));
  String taxtype=getbyte1(request.getParameter("taxtype"));
  String type=getbyte1(request.getParameter("type"));
  String type1=getbyte1(request.getParameter("type1"));
   String type3=getbyte1(request.getParameter("type3"));
    String lt=getbyte1(request.getParameter("lt"));
	String code=getbyte1(request.getParameter("code"));
 
	
	if (lt.equals(""))lt="0";
  if (!codename.equals("")){
    String SQL="update  tax set Tax_Name='"+codename+"'";
	SQL+=",tax_type="+taxtype+",type="+type+",type1='"+type1+"',type3='"+type3+"',type2="+lt+"";
	SQL+=" where code="+code;
 
   aBean.executeUpdate(SQL);
	setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "��������" , 
                  "�޸�"
                ) ;
	%>
	<SCRIPT>
	
	 
	  opener.window.location.reload();
	  window.close();
	  
	</script>
	<%
  }
  try{
  ResultSet rs=aBean.executeQuery("select * from tax where code="+code);
 
 

  int iii=0;
   while (rs.next()){
		codename=rs.getString("tax_name");
		taxtype=rs.getString("tax_type");
		type=rs.getString("type");
		type1=rs.getString("type1");
		lt=rs.getString("type2");
		type3=rs.getString("type3");
	 iii++;
      }	 
	
	  rs.close();
}catch(Exception s){  out.print(s.getMessage());out.close();}


 
 %>
 
<center>
<p>&nbsp;</p>
 <p align="center"><font size=3 class=FontColor><b>������������</b></font></p>
<input type=hidden name=code value="<%=code %>">
 
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
   
  <tr  ALIGN=center>
    <td width="20%" class=listtitle ><font color=white>��������</font></td>  
    <td width="50%" ALIGN=left class=roomright  >&nbsp;<input type=text name=codename  size=20  value="<%=codename %>" ></td>
  </tr>
   <tr  ALIGN=center>
    <td width="20%" class=listtitle ><font color=white>�������</font></td>  
    <td width="50%" ALIGN=left class=roomright  >&nbsp;<select name=taxtype><option value=0>���׷�</option><option value=1>˰��</option></select></td>
  </tr>
    <tr  ALIGN=center>
    <td width="20%" class=listtitle ><font color=white>���ѿͻ�</font></td>  
    <td width="50%" ALIGN=left class=roomright  >&nbsp;<select name=type><option value=0>���пͻ�</option><option value=1>���ҿͻ�</option><option value=2>�뻧�ͻ�</option><option value=3>����ͻ�</option></select></td>
  </tr>
   <tr  ALIGN=center>
    <td width="20%" class=listtitle ><font color=white>��&nbsp;&nbsp;&nbsp;&nbsp;��</font></td>  
    <td width="50%" ALIGN=left class=roomright  >&nbsp;<select name=type3>
	<option value=""></option>
	<option value="����">����</option>
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
    <td width="20%" class=listtitle ><font color=white>������;</font></td>  
    <td width="50%" ALIGN=left class=roomright  >&nbsp;<select name=type1>
	<option value=""></option>
	<option value="����">����</option>
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
<input name="lt" type="hidden" value=0 >
  <p align="center"> 
 
            &nbsp;&nbsp;
				<input type=button name=submit1 value="�� ��" onclick="Validate();">
		
           &nbsp;
		   <input type=button name=cancel value="�� ��" onclick="window.close();">
	   &nbsp;
    
          </P>
 



</center>
</form>
<script>
function checkedNoExist(){
    if (document.frm.codename.value==""){document.frm.codename.focus();return false;}
    for (var i=0;i<ch_Name.length;i++){
	    if (document.frm.codename.value==ch_Name[i]){
		 alert("�˷��������Ѵ���");
		 document.frm.codename.focus();
		 return false;
		}
	
	}
 } 
 
 
  function Validate()
   {
	
    if (document.frm.codename.value==""){
        alert("��������Ĵ�������");
        return (false);}
		
		 if (document.frm.type3.value==""&&document.frm.type1.value==""){ 
		{
	       alert("�������;����ѡ��һ��");
	       return (false);}
		}
     if (document.frm.type3.value!=""&&document.frm.type1.value!=""){ 
		{
	       alert("�������;ֻ��ѡ��һ��");
	       return (false);}
		}
	if (confirm("ȷ����������д��������"))	
	   document.frm.submit();
   return (true);
   }
 
 
</script>
<script>
   setSelectMad(document.frm.taxtype,'<%=taxtype %>');
   setSelectMad(document.frm.type,'<%=type %>');
   setSelectMad(document.frm.type1,'<%=type1 %>');
      setSelectMad(document.frm.type3,'<%=type3 %>');
 </script>
</body>

</html>
