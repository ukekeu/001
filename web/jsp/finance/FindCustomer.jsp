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
<%
String subSQL="";
 	String VIPNO=getbyte1(request.getParameter("VIPNO"));
 String Section=request.getParameter("section");
 
 String serialNo="";
if (!VIPNO.equals(""))VIPNO=" and VIPNO='"+VIPNO+"'";
 String eof="true";
 if (!Section.equals(""))Section=" and section='"+Section+"'";
int ii=0;
 sql="select VIPNO,Cus_Name,SJ,Phone,ID_CARD,SerialNo,Zip_Code,Address from View_Chenyi where VIPNO<>'' "+Section+VIPNO;
  ResultSet rs=ViewBean.executeQuery(sql);

%>


<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
 <font size=2>
 
VIP卡号：<input type=text size=15 name=VIPNO title="" onkeydown="key(document.cus1.Find)"><input type=submit name=findvip value="查 找">
 
<!--onclick="FindOption();"-->
</font>
<script>
function ordersubmit(){
	document.cus1.submit();	 
	}
function FindOption(){
var str="";
var Fstr="";
var eof="";
Fstr=document.cus1.cusname.value;
   for (var i=0;i<document.cus1.cuslist.length;i++){
     str=document.cus1.cuslist.options[i].text;
	 document.cus1.cuslist.options[i].selected=false;
	   if (str.indexOf(Fstr)>=0){
		   document.cus1.cuslist.options[i].selected=true;
		   eof="a";
   	     break;
       }
	}
	if (eof==""){alert("没找到你的资料");;document.cus1.cusname.select();}
	document.cus1.cusname.focus()
}	
</script>	
<br>
  <table width="100%" border="0" CELLSPACING=1 CELLPADDING=1  ALIGN=center>
<tr  class=TXTColor align="center">
<td>序号</td><td>客户姓名</td><td>联系电话</td><td>身份证号</td>
</tr>
<%
int i=0;
while (rs.next()){
i++;
Eof="false";
String no=rs.getString("SerialNo");
String name=getbyte(rs.getString("cus_name"));
String tel=getbyte(rs.getString("Phone"));

String sj=getbyte(rs.getString("sj"));
if (sj.equals(""))sj="  ";
 
String ID_Card=rs.getString("ID_Card");
String Address=getbyte(rs.getString("Address"));
String Zip_Code=getbyte(rs.getString("Zip_Code"));
    String strt="";
	String strs="";
	String strs1="";
	if (tel.indexOf(" ")>0)strt=" ";
	if (tel.indexOf("/")>0)strt="/";
	if (ID_Card.indexOf(" ")>0)strs=" ";
	if (ID_Card.indexOf("/")>0)strs="/";
	if (name.indexOf(" ")>0)strs1=" ";
	if (name.indexOf("/")>0)strs1="/"; 
%>
 <tr id=TR<%=i %> align="left" title="单击选择后，系统自动关闭窗口" class=listcontent onmouseover="mout(this);changeclass1(this,'clickbg','listcontent');" onclick="aa('<%=no%>','<%=name%>','<%=tel%>','<%=sj%>','<%=ID_Card%>','<%=Address%>','<%=Zip_Code%>');"  > 
<td><%=i %></td>
<td><%=Repalce(name,strs1) %></td><td><%=Repalce(tel,strt) %></td><td><%=Repalce(ID_Card,strs) %></td><!--<td><%=Address %></td>-->
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
<%} %>
 <script>
function aa(para1,para2,para3,para4,para5,para6,para7){
  if (window.opener.document.cus.FindB1)
window.opener.document.cus.FindB1.value="详情";
 window.opener.document.cus.cusname.value=para1;
 window.opener.document.cus.cusname1.value=para2;
 window.opener.document.cus.cusname2.value=para2;
  if (window.opener.document.cus.tel)
 window.opener.document.cus.tel.value=para3; 

 if (window.opener.document.cus.sj)
 window.opener.document.cus.sj.value=para4;
  
  if (para3=="") window.opener.document.cus.tel.value=para4;
 if (window.opener.document.cus.carid)
  window.opener.document.cus.carid.value=para5
 if (window.opener.document.cus.Address)
    window.opener.document.cus.Address.value=para6;
 if (window.opener.document.cus.post) 
   window.opener.document.cus.post.value=para7; 
setSelectMad(window.opener.document.cus.editnow,"1");  
close();
}
</script>



</form>
</body>

</html>
