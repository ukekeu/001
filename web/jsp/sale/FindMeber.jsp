 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>查找客户</title>
</head>
<%@ page language="java" import="java.sql.*,java.util.Date,java.util.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>

<script language="javascript" src="../public_js/public.js">
</script>

<%
 String sql="";
 String Eof="";
 
  %>
<body  >

<form name=cus1 method="post" action="">
<input type=hidden name=aa value="ok">
<%
String subSQL="";
 	String VIPNO=getbyte1(request.getParameter("VIPNO"));
	String cus_name=getbyte1(request.getParameter("cus_name"));
 String Section=request.getParameter("section");
 String aa=getbyte1(request.getParameter("aa"));
 String serialNo="";
 
if (!cus_name.equals(""))cus_name="    and c.cus_name like '%"+cus_name+"%'";
 
 
int ii=0;
 


%>


<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
 <font size=2>
 
客户姓名:<input type=text size=15 name=cus_name title="" onkeydown="key(document.cus1.findvip)">
<input type=submit name=findvip value="查 找">
</form>
 
<!--onclick="FindOption();"-->
</font>
 
<br>
  <table width="100%" border="0" CELLSPACING=1 CELLPADDING=1  ALIGN=center>
<tr  class=TXTColor align="center">
<td>序号</td><td>客户姓名</td><td>联系电话</td><td>所在单元</td>
</tr>
<%
if (cus_name.equals("")){out.print("请查找业主姓名");out.close();}else{

 sql="select c.Cus_Name,c.SJ,c.Phone,o.sectionname+o.loft+o.building+o.room_no room from order_contract o,customer c  where c.serialno=o.customer    "+ cus_name;
 
  ResultSet rs=ViewBean.executeQuery(sql);
int i=0;
while (rs.next()){
i++;
Eof="false";
 
String name=getbyte(rs.getString("cus_name"));
String tel=getbyte(rs.getString("Phone"));

String sj=getbyte(rs.getString("sj"));
if (sj.equals(""))sj="  ";
 
String room=rs.getString("room");
 
    String strt="";
	String strs="";
	String strs1="";
	if (tel.indexOf(" ")>0)strt=" ";
	if (tel.indexOf("/")>0)strt="/";
 
	if (name.indexOf(" ")>0)strs1=" ";
	if (name.indexOf("/")>0)strs1="/"; 
%>
 <tr id=TR<%=i %> align="left" title="单击选择后，系统自动关闭窗口" class=listcontent onmouseover="mout(this);changeclass1(this,'clickbg','listcontent');" onclick="aaa('<%=room %>');"  > 
<td><%=i %></td>
<td><%=Repalce(name,strs1) %></td><td><%=Repalce(tel,strt) %></td><td><%=room %></td> 
</tr>

    <%}%>
</table>
<%
  rs.close();
  if (Eof.equals("")){
  
   %>
   <script>
alert("系统没有查找到客户资料，请直接在合同资料登记表中录入");


</script>
<%}
} %>
 <script>
function aaa(para1){

  if (window.opener.document.cus.memberNO)
window.opener.document.cus.memberNO.value=para1;
  
close();
}
</script>




</body>

</html>
