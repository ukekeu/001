<%@ page contentType="text/html;charset=GBK" %>

 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/CheckSection.jsp"%>
<HTML>
<HEAD>
<TITLE>销售价格计算方式</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

</HEAD>
 

<script language="javascript" src="../public_js/public.js">
</script>
<%
String SecNo1=getbyte1(request.getParameter("section"));
String ch=getbyte1(request.getParameter("choose"));
String ch1=getbyte1(request.getParameter("ch1"));
if (ch1.equals(""))ch1="0";
String saveSet1=getbyte1(request.getParameter("saveSet1"));
String ch2=getbyte1(request.getParameter("ch2"));
if (ch2.equals(""))ch2="0";
String sumlen=getbyte1(request.getParameter("sumlen"));
String unitlen=getbyte1(request.getParameter("unitlen"));
 String yssumlen=getbyte1(request.getParameter("yssumlen"));
String ysunitlen=getbyte1(request.getParameter("ysunitlen"));
 
String A1="",A2="",A3="",A4="",A5="",SQL="";
try{
if  (!SecNo1.equals("")&&!ch.equals("")&&!saveSet1.equals("")){ 
  SQL="select  PRICE_TYPE from SALE_PRICE_TYPE WHERE secno='"+SecNo1+"'";

ResultSet rs=ViewBean1.executeQuery(SQL);	
 if (rs.next()){
  SQL="update SALE_PRICE_TYPE set yssumlen="+yssumlen+",ysunitlen="+ysunitlen+",unitlen="+unitlen+",PRICE_TYPE="+ch+",disc="+ch1+",salepricecounttype="+ch2+" where secno='"+SecNo1+"'";
  ViewBean1.executeUpdate(SQL);	
 
}else{
  SQL="insert into SALE_PRICE_TYPE(SECNO,PRICE_TYPE,unitlen,sumlen,disc,salepricecounttype,ysunitlen,yssumlen) VALUES('"+SecNo1+"',"+ch+","+unitlen+","+sumlen+","+ch1+","+ch2+","+ysunitlen+","+yssumlen+")";
 ViewBean1.executeUpdate(SQL);	

}

rs.close();
%>
<script>alert("已保存设置");</script>
<%
}
}catch(Exception s){out.print(SQL);}
String type="";
if (!SecNo1.equals("")){
 SQL="select PRICE_TYPE ,unitlen,sumlen,disc,salepricecounttype,ysunitlen,yssumlen from SALE_PRICE_TYPE WHERE secno='"+SecNo1+"'";
ysunitlen="0";yssumlen="0";unitlen="0";sumlen="0";
ResultSet rs=ViewBean1.executeQuery(SQL);	
if (rs.next()){
   type=rs.getString("PRICE_TYPE").trim();
 unitlen=rs.getString("unitlen").trim();
 sumlen=rs.getString("sumlen").trim();
   yssumlen=rs.getString("yssumlen").trim();
  ysunitlen=rs.getString("ysunitlen").trim();
  ch1=rs.getString("disc").trim();
  String salepricecounttype=rs.getString("salepricecounttype").trim();
  if (type.equals("0"))A1="checked";
  else   if (type.equals("1"))A2="checked";
  else   if (type.equals("2"))A3="checked";
  if (ch1.equals("1"))A4="checked";
 
  
   if (salepricecounttype.equals("1"))A5="checked";
}
rs.close();

}
if (sumlen.equals(""))sumlen="0";
if (unitlen.equals(""))unitlen="0";
if (yssumlen.equals(""))yssumlen="0";
if (ysunitlen.equals(""))ysunitlen="0";
 %>
<body  oncontextmenu="return false" onload="setSelectMad(document.frm.section,'<%=request.getParameter("section") %>')">
 <form name=frm>
<center>
<br><br><br><br><br>
<table width="90%" align="center" >
<tr><td colspan="2" align="center"><font size=3>销售价格计算方式设置</font></td></tr>
<tr><td colspan="2"></td></tr>
<tr><td colspan="2" >
楼盘名称：<select name="section" onchange="document.frm.submit();"> 
   <option></option>
<%  
 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";	
      String sql1="select SerialNo,Name from Crm_Project where SerialNo  in("+SectionS+")";
	  ResultSet rs2=ViewBean1.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
 
	    rs2.close();
	
     %> </select></td></tr>
	 <tr><td><input type="radio" value="0" <%=A1 %> name="ch" onclick="document.frm.choose.value=0;" >1、以总价为准：建筑单价=总价/建筑面积,套内建筑单价=总价/套内建筑面积</td></tr>
<tr><td><input type="radio" <%=A2 %>  name="ch" value="1" onclick="document.frm.choose.value=1;">2、以建筑单价为准：总价=建筑单价*建筑面积,套内建筑单价=总价/套内建筑面积</td></tr>
<tr><td><input type="radio" <%=A3 %>  name="ch" value="2" onclick="document.frm.choose.value=2;">3、以套内建筑单价为准：建筑单价＝总价/建筑面积,总价＝套内建筑单价*套内建筑面积</td></tr>
<tr><td>成交单价保留小数位:<input type=text size=3 name="unitlen" value=<%=unitlen %>>&nbsp;成交总价保留小数位:<input type=text size=3 name="sumlen" value=<%=sumlen %>></td></tr>
<tr><td>预售单价保留小数位:<input type=text size=3 name="ysunitlen" value=<%=ysunitlen %>>&nbsp;预售总价保留小数位:<input type=text size=3 name="yssumlen" value=<%=yssumlen %>></td></tr>

<tr><td><input type="checkbox" <%=A4 %>  name="ch1"  value="1" >4、认购时折扣计算方式，选中表示按预售总价进行折扣计算出认购的总价</td></tr>
<tr><td><input type="checkbox" <%=A5 %>  name="ch2"   value="1" >5、在认购登记时是否根据套内单价*套内建筑面积反算认购总价</td></tr>	
 </table>
	 <table width="50%" border="0">
<tr><td  align="center"><input type=button name=saveSet value=" 提 交 " onclick="check();"></td></tr>

</table>
<input type=hidden name=saveSet1>
<input type=hidden name=choose value="<%=type %>">
	 </center>
	 </form>
<script>
function check(){
 if (document.frm.section.value==""){alert("请选择楼盘名称");return false;}

 if (document.frm.choose.value==""){alert("请选择计算方式");return false;}
 document.frm.saveSet1.value="1"
 document.frm.submit();

}

</script>

</body>
</html>
