<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>���۲�ѯ</title>
</head>
<%@ page language="java" import="java.sql.*,java.lang.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>


<script language="javascript" src="../public_js/public.js">
</script>

 
<%
String vipno=China.getParameter(request,"vipno");
String saleroom=China.getParameter(request,"saleroom");
String no=China.getParameter(request,"no");
if (!no.equals("")){
 String SQL="DELETE VIP_S_Room WHERE projectno+loft+room='"+no+"'";
ViewBean.executeUpdate(SQL);
SQL="update room set ssstate=0  WHERE seccode+loft+room_code='"+no+"'";
ViewBean.executeUpdate(SQL);
%>
<script>
opener.window.frm.submit();;
	 window.close();
</script>
<%
}
  %>
 <body  topmargin="1">
 
<form method="POST" name="cus" action="Room_list.jsp" onsubmit="return check(this);" >
  
		   <p align=center ><font size=3 class=FontColor><b>��ѯ���</b></font></p>
   
  <table width=100%><tr height="3"><td></td></tr></table>    	
   <table BORDER=0 width="100%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center >
  <tr class=listtitle>
      <td   align="center"   > VIP�� </td>
      <td   align="center"   > �Ϲ��� </td> 
       <td   align="center"   > ȡ�� </td> 
   	    </tr>
  
<%
 
  String sql="";
 
  sql="select  vipno,loft+room room,projectno+loft+room room_code  from VIP_S_Room where VIPno='"+vipno+"' or room='"+saleroom+"'";
 
  ResultSet rs=null;
  try{
  rs=ViewBean.executeQuery(sql);
 
 while (rs.next()){
 
	vipno=rs.getString("vipno");
	String room=getbyte(rs.getString("room"));
	String room_code=getbyte(rs.getString("room_code"));
	 
 
	
  %>
  
 
    <tr align="center" class='listcontent' onmouseover="mout(this);"  > 

   
      <td    ><%=vipno %></td>
      <td    ><%=room %></td>
      <td    ><a href="saleFind.jsp?no=<%=room_code %>">ȡ��</a></td>
           </tr>
    <%
}
  rs.close();
}catch(Exception s)  {out.print(s.getMessage());out.close();}
 %>
</table> 

</body>
</html>