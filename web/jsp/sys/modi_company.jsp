<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "��˾����" , 
                  "����"
                ) ;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>ʹ�ÿͻ����ϵǼ�</title>
</head>

<%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<body  oncontextmenu="return false">
<script language="JavaScript" src='../public_js/public.js'></script>

<%@ include file="../public_js/getByteOut.jsp"%>
<%String SQL="";
  String companyname="";
  String companytel="";
  String companyaddr="";
  String companyman="";
  String companypost="";
  String companyfax="";
  String eof="false";
  String save=China.getParameter(request,"save");
  String id=China.getParameter(request,"id");
 
  if (save.equals("")){
  SQL="select * from company where id ="+id;
  ResultSet RS=aBean.executeQuery(SQL);
    try{
  if (RS.next()){
     id=RS.getString("id");
     companyname=getbyte(RS.getString("companyname"));
     companytel=getbyte(RS.getString("companytel"));
	 companyfax=getbyte(RS.getString("companyfax"));
	 companyaddr=getbyte(RS.getString("companyaddr"));
	 companyaddr=getbyte(RS.getString("companyaddr"));
	 companyman=getbyte(RS.getString("companyman"));
	 companypost=getbyte(RS.getString("zip_code"));
	 eof="true";
  }
  RS.close();
  }catch(Exception s){}
  }
 
  if (!save.equals("")){
     id=China.getParameter(request,"modiid");
     companyname=China.getParameter(request,"companyname");
     companytel=China.getParameter(request,"companytel");
	 companyfax=China.getParameter(request,"companyfax");
     companyaddr=China.getParameter(request,"companyaddr");
     companyman=China.getParameter(request,"companyman");
	 companypost=China.getParameter(request,"post");
	 id=China.getParameter(request,"id");
	 SQL="update company set companyname='"+companyname+"',companytel='"+companytel+"',companyfax='"+companyfax+"',companyaddr='"+companyaddr+"',";
	 SQL+="companyman='"+companyman+"',zip_code='"+companypost+"' where id="+id;
	 try{
        setlog( setlogBean , 
                          ( String )session.getAttribute( "loginid" ) ,
                          "��˾����" , 
                          "�޸�"
                        ) ;
	 aBean.executeUpdate(SQL);
	 %>
	 <script>
	 
	 opener.window.location.reload();
     if (confirm("���޸�����,�Ƿ��˳���"))
     window.close();
     </script>
	 <%
	 }catch(Exception s){}

  }
  

 %>

<center>
<p>&nbsp;</p>
 <p align="center"><font size=3 class=FontColor><b>��˾����</b></font></p>
<form name=frm method="post"  action=""> 
<input type="hidden" name="modiid" value="<%=id %>">
<table BORDER=0 width="50%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#000000" class="tablefill">
  
  <tr ALIGN=left >
    <td width="15%" class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;��˾����</td>  
    <td width="35%"  class=roomright>&nbsp;<input type=text name=companyname value="<%=companyname %>" size=25 onkeydown="key(document.frm.companytel)"  ></td>
  </tr>
  <tr ALIGN=left>
    <td width="15%" class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;��˾�绰</td>  
    <td width="35%" class=roomright >&nbsp;<input type=text name=companytel value="<%=companytel %>" size=25 onkeydown="key(document.frm.companyfax)"></td>
  </tr>
<tr ALIGN=left>
    <td width="15%" class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;��˾����</td>  
    <td width="35%" class=roomright >&nbsp;<input type=text name=companyfax value="<%=companyfax %>" size=25 onkeydown="key(document.frm.companyaddr)"></td>
  </tr>

  <tr ALIGN=left>
    <td width="15%" class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;��˾��ַ</td>  
    <td width="35%" class=roomright  >&nbsp;<input type=text name=companyaddr value="<%=companyaddr %>"  size=25 onkeydown="key(document.frm.companyman)"> </td>
  </tr>
  
  <tr ALIGN=left>
    <td width="15%" class=roomleft  >&nbsp;&nbsp;&nbsp;&nbsp;��˾����</td>
    <td width="35%"  class=roomright  >&nbsp;<input type=text name=companyman  value="<%=companyman %>" size=15 onkeydown="key(document.frm.post)"></td>
  </tr>
  <tr ALIGN=left>
    <td width="15%" class=roomleft >&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>  
    <td width="35%" class=roomright  >&nbsp;<input type=text name=post value="<%=companypost %>" size=10 ></td>
  </tr>
  </table>

  <p align="center"> 
            &nbsp;&nbsp; <input type=button name=save value="�� ��" onclick="save1();">&nbsp;&nbsp; <input type=button name=save value="�� ��" onclick="window.close();">
          
          </P>
    <input type=hidden name=save value="ȷ��">
 
</center>
</form>
<script>
 
 function save1(){
   document.frm.submit();
 }
</script>
</body>

</html>
