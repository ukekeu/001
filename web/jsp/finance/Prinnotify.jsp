<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>����</title>
<link rel=stylesheet href="../class/mad.css" >
<STYLE type=text/css>A:hover {
	FONT-SIZE: 10.5pt; COLOR: red; TEXT-DECORATION: underline
}
.a1 {
	FONT-SIZE: 9pt; LINE-HEIGHT: 14pt; FONT-FAMILY: "����"
}
.a3 {
	FONT-SIZE: 9pt; COLOR: #993300; LINE-HEIGHT: 12pt
}
.a2 {
	FONT-WEIGHT: bold; FONT-SIZE: 10.5pt; COLOR: #ff3300; FONT-FAMILY: "����"
}
A {
	FONT-SIZE: 10.5pt
}
</STYLE>
</head>
<body>
<p>&nbsp;</p><p>&nbsp;</p>
<%!
	public String getParameter(javax.servlet.http.HttpServletRequest request,String para)
								throws Exception  {
		String temp = "";
		temp = request.getParameter(para);
		if (temp == null)
			temp = "";
		temp = new String(temp.getBytes("iso-8859-1"));
		return temp;	
	}
%>
<form name=cus method=POST ACTION="">
<p align=center><font size=4><b>�߿�֪ͨ��</b></font></p>
<center>
<table BORDER=0 width="80%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#000000" class="tablefill">
  <tr align="center">
 <td>
<table border="0" width="100%" >
  <tr > 
    <td width="100%" heigth=25>
	   <p style="line-height: 200%"><u>&nbsp;&nbsp;<%=request.getParameter("cusname") %>&nbsp;&nbsp;</u> <b>ҵ����</b></p></td> 
  </tr>
<%
String Section=request.getParameter("section");
String Loft=request.getParameter("Loft");
String Building=request.getParameter("Building");
String Room=request.getParameter("Room");
String ShouldDate=request.getParameter("ShouldDate");
String day=request.getParameter("day");
String nextday=request.getParameter("nextday");
 %>
  <tr>
    <td width="100%">   <p style="line-height: 200%">
	  &nbsp;&nbsp;&nbsp;&nbsp;�����������:<u>&nbsp;<%=Section %></u>¥��<U><%=Loft%>&nbsp;</u>��<u>&nbsp;<%=Building %></u>��<U><%=Room%> &nbsp;</u>��Ԫ�� 
     ������δ����</P></td></tr><tr><td>   <p style="line-height: 200%">�����壬��������������<U><%=day %></u>�졣����<<��Ʒ��������ͬ>>�����˾�����Ը�</td></tr><tr><td>�¼������ɽ����ɽ�ļ������ڴ�
	 <U><%=nextday %></u>������ʵ�ʽɿ���ֹ��
	  </p></td><tr><td>   <p style="line-height: 200%">&nbsp;&nbsp;&nbsp;&nbsp;Ϊ��˫�������棬����¾��콱��Ƿ�������<<��Ʒ��������ͬ>> ָ���������ʺţ�������<U><%=Section %></u>¥���������Ľ����йؿ��
      </P></td></tr>
 </table>
<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>

<table width="100%" >
<tr>
<td align=right width="60%"  heigth=20></td><td width="30%" align=left>
 <u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u>���ز��������޹�˾
</td></tr>

<tr>
<td align=right width="60%"  heigth=20></td><td width="30%" align=left>
<u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u>��<u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u>��<u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</td></tr>
</table>
</td></tr></table>

</center>
<script>
window.print();
</script>
</FORM>
</body>

</html>
