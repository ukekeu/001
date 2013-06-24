<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>先生</title>
<link rel=stylesheet href="../class/mad.css" >
<STYLE type=text/css>A:hover {
	FONT-SIZE: 10.5pt; COLOR: red; TEXT-DECORATION: underline
}
.a1 {
	FONT-SIZE: 9pt; LINE-HEIGHT: 14pt; FONT-FAMILY: "宋体"
}
.a3 {
	FONT-SIZE: 9pt; COLOR: #993300; LINE-HEIGHT: 12pt
}
.a2 {
	FONT-WEIGHT: bold; FONT-SIZE: 10.5pt; COLOR: #ff3300; FONT-FAMILY: "宋体"
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
<p align=center><font size=4><b>催款通知单</b></font></p>
<center>
<table BORDER=0 width="80%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#000000" class="tablefill">
  <tr align="center">
 <td>
<table border="0" width="100%" >
  <tr > 
    <td width="100%" heigth=25>
	   <p style="line-height: 200%"><u>&nbsp;&nbsp;<%=request.getParameter("cusname") %>&nbsp;&nbsp;</u> <b>业主：</b></p></td> 
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
	  &nbsp;&nbsp;&nbsp;&nbsp;阁下所购买的:<u>&nbsp;<%=Section %></u>楼盘<U><%=Loft%>&nbsp;</u>阁<u>&nbsp;<%=Building %></u>栋<U><%=Room%> &nbsp;</u>单元的 
     费用尚未按规</P></td></tr><tr><td>   <p style="line-height: 200%">定缴清，截至今天已逾期<U><%=day %></u>天。根据<<商品房买卖合同>>条款，我司决定对阁</td></tr><tr><td>下计收滞纳金，滞纳金的计收日期从
	 <U><%=nextday %></u>至阁下实际缴款日止。
	  </p></td><tr><td>   <p style="line-height: 200%">&nbsp;&nbsp;&nbsp;&nbsp;为了双方的利益，请阁下尽快奖所欠款项缴至<<商品房买卖合同>> 指定的银行帐号，或亲临<U><%=Section %></u>楼盘销售中心缴清有关款项。
      </P></td></tr>
 </table>
<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>

<table width="100%" >
<tr>
<td align=right width="60%"  heigth=20></td><td width="30%" align=left>
 <u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u>房地产开发有限公司
</td></tr>

<tr>
<td align=right width="60%"  heigth=20></td><td width="30%" align=left>
<u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u>年<u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u>月<u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u>日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
