 <%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>���ҿͻ�</title>
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
 String strSUBMIT=request.getParameter("SUBMIT");
 String strCusName=request.getParameter("cusna");
 String strCusNo=request.getParameter("serialNo");
 String strCusTel=request.getParameter("tel");
 String strsection=request.getParameter("section");
 String CusNo=request.getParameter("cusno");
 String cusname=request.getParameter("cusname");
 String cusname1=request.getParameter("cusname1");
 String type=getbyte(request.getParameter("type"));
 
 String orderbytype=China.getParameter(request,"orderbytype");
 String orderby=China.getParameter(request,"orderby");
 //����ʽ
if (!orderbytype.equals("")&&!orderby.equals("")){
  if (orderbytype.equals("0")&&orderby.equals("0")) orderby=" order by c.visit_date desc";
  if (orderbytype.equals("0")&&orderby.equals("1")) orderby=" order by c.visit_date asc";
  if (orderbytype.equals("1")&&orderby.equals("0")) {orderby=" order by c.cus_name desc";}
  if (orderbytype.equals("1")&&orderby.equals("1")) orderby=" order by c.cus_name asc";
}else{
	orderby=" order by c.cus_name desc,c.visit_date desc";
	
	}
 
 if (strSUBMIT!=null)
     strCusName=getbyte(strCusName);
	%>
	
	<script>
function full(){
 setSelectMad(document.form11.orderbytype,'<%=orderbytype %>');
 setSelectMad(document.form11.orderby,'<%=China.getParameter(request,"orderby") %>');
}

</script>
<body onload="full();">
<form name=cus1 method="post" action="">
<%
String subSQL="";
 if (cusname!=null)cusname=getbyte(cusname);

 else cusname="";
 
 String Section=request.getParameter("section");
 String paracusname=request.getParameter("FindCus");
 String serialNo="";

 String eof="true";
int ii=0;
 sql="select c.SerialNo,c.cus_name,c.Phone,c.sj,c.ID_Card,c.Address,"
     +"c.Zip_Code ,o.sectionname+o.loft+o.room_no room from customer c,order_contract o where c.serialno =o.customer and o.section='"+strsection+"'   "+orderby;
	  ResultSet rs=ViewBean.executeQuery(sql);

%>


<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
 <font size=2>
�ɰ��ͻ�����������ϵ�绰�����š����֤�š���ϵ��ַ����<br>
��������ֵ��<input type=text size=15 name=cusname title="����������ҵĿͻ����ջ������󵥻������ҡ�" onkeydown="key(document.form11.Find)">
���:<select name=type>
<option></option>
<option value="signatory">�ͻ�����</option>
<option value="phone">��ϵ�绰</option>
<option value="ID_Card">���֤��</option>
<option value="Address">��ϵ��ַ</option>
<option value="room">�ѹ�����</option>
</select>
<input type=submit name=Find value="����" ><br>
 ����:<select name="orderbytype"  onchange="ordersubmit();">
    
	 <option value=1>���ͻ�����</option>
 <option value=0>����������</option>
	 </select>
	 <select name="orderby" onchange="ordersubmit();">
     
	 <option value=1>����</option>
<option value=0>����</option>
	 </select>
<!--onclick="FindOption();"-->
</font>
<script>
function ordersubmit(){
	document.form11.submit();	 
	}
function FindOption(){
var str="";
var Fstr="";
var eof="";
Fstr=document.form11.cusname.value;
   for (var i=0;i<document.form11.cuslist.length;i++){
     str=document.form11.cuslist.options[i].text;
	 document.form11.cuslist.options[i].selected=false;
	   if (str.indexOf(Fstr)>=0){
		   document.form11.cuslist.options[i].selected=true;
		   eof="a";
   	     break;
       }
	}
	if (eof==""){alert("û�ҵ��������");;document.form11.cusname.select();}
	document.form11.cusname.focus()
}	
</script>	
<br>
  <table width="100%" border="0" CELLSPACING=1 CELLPADDING=1  ALIGN=center>
<tr  class=TXTColor align="center">
<td>���</td><td>�ͻ�����</td><td>��ϵ�绰</td><td>����Ԫ</td>
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
String room=getbyte(rs.getString("room"));
    String strt="";
	String strs="";
	String strs1="";
	if (ID_Card.indexOf(" ")>0)strs=" ";
	if (ID_Card.indexOf("/")>0)strs="/";
	if (name.indexOf(" ")>0)strs1=" ";
	if (name.indexOf("/")>0)strs1="/"; 
%>
 <tr id=TR<%=i %> align="left" title="����ѡ���ϵͳ�Զ��رմ���" class=listcontent onmouseover="mout(this);changeclass1(this,'clickbg','listcontent');" onclick="aa('<%=name%>','<%=tel+sj%>','<%=Address%>','<%=room %>');"  > 
<td><%=i %></td>
<td><%=Repalce(name,strs1) %></td><td><%=Repalce(tel,strt) %></td><td><%=room %></td><!--<td><%=Address %></td>-->
</tr>

    <%}%>
</table>
<%
  rs.close();
  if (Eof.equals("")){
  
   %>
   <script>
alert("ϵͳû�в��ҵ��ͻ����ϣ���ֱ���ں�ͬ���ϵǼǱ���¼��");


</script>
<%} %>
 <script>
function aa(para1,para2,para3,para4){
  window.opener.document.form1.customer.value=para1;
  window.opener.document.form1.tel.value=para2; 
  window.opener.document.form1.addr.value=para3;
  window.opener.document.form1.room.value=para4; 

  close();
}
</script>



</form>
</body>

</html>
