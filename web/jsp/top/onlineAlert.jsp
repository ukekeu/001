<%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
 <%@ page import="java.sql.*,java.util.*" %>
 
  <jsp:useBeanid="onlineuser" class="online.ListUser" scope="application"/>
 <jsp:useBean id="userBean" scope="page" class="ConnDatabase.SDatabase" />
 <jsp:useBean id="smenu" scope="page" class="ConnDatabase.menu" />
 
  <%@ include file="../public_js/getByteOut.jsp"%>
   
<html>
 <LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 <head>
	<title>�Ի�����</title>
</head>
<STYLE type=text/css>BODY {
	MARGIN: 0px
}
.style4 {
	COLOR: #43994f
}
.style6 {
	FONT-SIZE: 15px
}
.style8 {
	COLOR: #e1411d
}
</STYLE>
 <%String alterinfo=getbyte1(request.getParameter("alterinfo")); 
 
  if (!alterinfo.equals("")){
   String acc=getbyte1(request.getParameter("acc")); 
   String send_person=(String)session.getAttribute("loginname");
   String sql="insert into online_alter(acc_person,info,send_person) values('"+acc+"','"+alterinfo+"','"+send_person+"')"; 
  userBean.executeUpdate(sql);
  %>
  <script>window.close();</script>
  <%out.close();
  }else{
 %>
 
<body  topmargin="0" leftmargin="0"   marginheight="100%"   oncontextmenu="return false"    >
 <form name=frm method="post" action=""> 
 
 <table width="100%"   border="0"     bgColor=#fef2f0    >
 <tr><td><font size="3"><b>������Ϣ��:</b></font><input  name=acc type=text  readonly value="<%=getbyte1(request.getParameter("acc")) %>"></td></tr>
</table> 
<table width="100%"   border="0"     bgColor=#fef2f0    >
<tr><td align="right"  ><img src="../images/color.gif" height="1" width="100%"></td></tr>
</table>
 <table width="100%"   border="0"     bgColor=#fef2f0    >
 <tr><td><textarea cols="65" rows="7" name="alterinfo"></textarea></td></tr>
</table> 
<table width="100%"   border="0"     bgColor=#fef2f0    >
<tr><td align="right"  ><img src="../images/color.gif" height="1" width="100%"></td></tr>
</table>
 <table width="100%"   border="0"     bgColor=#fef2f0    >
 <tr><td align="right"><input type=button name="sendinfo" value="������Ϣ" onclick="alertCheck();">&nbsp;<input type=button name="closeWIN" value="��   ��" onclick="window.close();" title="ȷ���˳���"></td></tr>
</table> 
</form>
<script>
function alertCheck(){
 if(document.frm.alterinfo.value==""){alert("����д������Ϣ����!");document.frm.alterinfo.focus();return false;}
  document.frm.submit();

}

</script>
<%} %>
</body>
</html>
