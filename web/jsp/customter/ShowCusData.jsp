<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>�ͻ���ϸ����</title>
</head>
 <%@ page language="java" import="java.sql.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>

<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
 <%
 String sql="";
 String region="";
 String no="";
 String sale="";
 String name="";
 String sex="";
 String age="";
 String custype="";
 String gmyt="";
 String tj="";
 String tel="";
 String idcard="";
 String addr="";
 String pos="";
 String date="";
 String  seller="";
 String company="";
 String visitnum="";
 String visitname="";
 String visitsex="";
 String nexus="";
 String visittj="";
 String mail="";
 String bbj = "" ;
 String sj = "" ;
 String visitage="";
 String job="";
 String jtsr="";
 String wh="";
 String personnum="";
 String linkman="";
 String homejg="";
 String chishu="";
 String signatory="";
 String demand="";
 String attention="";
 String nowjuarea="";
 String cusno=request.getParameter("cusno");
 sql="select * from customer where SerialNo='"+cusno+"'";
 //execute sql

 ResultSet rs=ViewBean.executeQuery(sql);
 if (rs.next()){
 //��FIELDS˳��һGET��VALUE

     // no=rs.getString("SerialNo");
      name=getbyte(rs.getString("Cus_Name"));
      sex=getbyte(rs.getString("Cus_Sex"));
      age=rs.getString("cus_age");
	  custype=getbyte(rs.getString("Cus_Type"));
	  gmyt=getbyte(rs.getString("Purpose"));
	  tj=getbyte(rs.getString("Knowledge_From"));
      tel=rs.getString("Phone");
      idcard=rs.getString("ID_Card");
	  addr=getbyte(rs.getString("address"));
      pos=rs.getString("Zip_Code");
       //Fomrat date 
   
	  date=rs.getString("visit_date");
     java.text.SimpleDateFormat needdate =null;
	 	
     needdate=new java.text.SimpleDateFormat("yyyy-MM-dd");

	 date=needdate.format(needdate.parse(date));
     seller=rs.getString("seller");
	 company=getbyte(rs.getString("company"));
	 visitnum=getbyte(rs.getString("visitnum"));
	 visitname=getbyte(rs.getString("visitname"));
	 visitsex=getbyte(rs.getString("visitsex"));
	 visitage=rs.getString("visitage");
	 nexus=getbyte(rs.getString("nexus"));

     visittj=getbyte(rs.getString("payment"));
     bbj = rs.getString( "bbj" ) ;
     sj = rs.getString( "sj" ) ;
	 mail=rs.getString("mail");
	 region=getbyte(rs.getString("region"));
     sale=rs.getString("FTSALE");
	 job=getbyte(rs.getString("job"));
	 wh=getbyte(rs.getString("Wh"));
	 jtsr=getbyte(rs.getString("jtsr"));
	 personnum=getbyte(rs.getString("personnum"));
	 signatory=getbyte(rs.getString("signatory"));
	 linkman=getbyte(rs.getString("contactperson"));
     chishu=rs.getString("chishu");
     homejg=getbyte(rs.getString("homejg"));
     nowjuarea=getbyte(rs.getString("nowjuarea"));
     demand=getbyte(rs.getString("demand"));
	 attention=getbyte(rs.getString("attention"));
}
rs.close(); %>

<body >
<p align=center><font size=3 class=FontColor><b>�ͻ���ϸ����</b></font></p>

<form method="POST" name="cus" action=""> 

<center>

<table width="100%" border="0" cellspacing="1"  cellpadding="1" >
<tr> 
<td colspan=4 align=center class=TITLE><font  color=white>��&nbsp;��&nbsp;��&nbsp;��</font></td></tr>

  <tr > <td width="25%" class=roomleft  align="left" height="24">&nbsp;�ͻ�����</td><td class=roomright width="25%"   align="left" height="24"> &nbsp;<%=name %></td> 
 <td width="25%" align="left" class=roomleft  height="24">&nbsp;�ԡ�����</td><td  class=roomright width="25%" align="left"   height="24"> 

&nbsp;
<%=sex %>
</td></tr>
 <tr align="left" > 
<td width="25%" align="left" class=roomleft  height="24">&nbsp;�� 
��</td><td class=roomright width="25%" align="left"   height="24">&nbsp<%=age %>
</td>
<td width="25%" align="left" class=roomleft  height="14">&nbsp;���֤��</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<%=idcard %>
</td>
</tr>
<tr align="left" > <td width="25%" align="left" class=roomleft  height="14"> &nbsp;��ϵ�绰</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<%=tel %>
</td> 

<td width="25%" class=roomleft  align="left" height="23">&nbsp;�ֻ�</td><td class=roomright width="25%"   align="left" height="23"> 
 &nbsp;<%=sj %></td>

</tr> 

<tr align="left" > <td width="25%" align="left" class=roomleft  height="14">&nbsp;BB��</td><td class=roomright  width="25%" align="left"   height="14"> 
 &nbsp;<%=bbj %>
</td>

<td width="25%" align="left" class=roomleft  height="24">&nbsp;����λ</td><td class=roomright width="25%" align="left"   height="24">&nbsp;<%=company %> 
</td>
</tr>

<tr align="left" > <td width="25%" align="left" class=roomleft  height="14">&nbsp;EMAIL��ַ</td><td class=roomright  width="25%" align="left"   height="14"> 
 &nbsp;<%=mail %>
</td>
<td width="25%" class=roomleft  align="left" height="23"> &nbsp;�� 
��</td><td class=roomright width="25%"   align="left" height="23"> &nbsp;<%=pos %></td>
</tr> 

<tr>
 <td width="25%" class=roomleft  align="left" height="23">&nbsp;��ϵ��ַ</td><td class=roomright width="25%"   align="left" height="23" colspan=3> 
 &nbsp;<%=addr %></td>
</td>
</tr>

<tr align="left" >
 <td width="25%" align="left" class=roomleft  height="14">&nbsp;��������</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<%=date %>
</td><td width="25%" align="left" class=roomleft  height="24"> &nbsp;�Ǽ���</td><td class=roomright class=roomrightwidth="25%" align="left"   height="24"> 
 &nbsp;<%=getbyte(seller) %></td>
	  </tr>
	  <tr> 
<td colspan=4 align=center class=TITLE><font   color=white>��&nbsp;��&nbsp;��&nbsp;��</font></td></tr>
 <tr align="left" > 
 <td width="25%" align="left" class=roomleft  height="14"> &nbsp;������</td><td class=roomright width="25%" align="left"   height="14"> 
  &nbsp;<%=demand %>
        </td>
        <td width="25%" align="left" class=roomleft  height="14"> &nbsp;���򸶿�</td>
        <td  class=roomright width="25%" align="left"   height="14"> 
  &nbsp;<%=visittj %></td>
  </tr> 
   <tr align="left" > 
 <td width="25%" align="left" class=roomleft  height="14"> &nbsp;��ע����</td><td class=roomright width="25%" align="left"   height="14"> 
  &nbsp;<%=attention %></td>
 <td width="25%" align="left" class=roomleft  height="14"> &nbsp;�������</td><td class=roomright width="25%" align="left"   height="14"> 
  &nbsp;</td>  
  </tr> 
 <tr> 
<td colspan=4 align=center  class=TITLE><font  color=white>&nbsp;��&nbsp;��&nbsp;��&nbsp;��</font></td></tr>
 <tr align="left" > <td width="25%" align="left" class=roomleft  height="24">&nbsp;��ͥ����</td>
<td class=roomright width="25%" align="left"   height="24">&nbsp;<%=personnum %>
</td>
 <td width="25%" align="left" class=roomleft  height="14"> &nbsp;��ͥ�ṹ </td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<%=homejg %>
</td>
</tr> 
<tr align="left" > 
<td width="25%" align="left" class=roomleft  height="14"> &nbsp;�־����</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<%=nowjuarea %>ƽ����
 </td>
   <td width="25%" align="left" class=roomleft  height="24">&nbsp;�Ļ�</td><td class=roomright width="25%" align="left"   height="24"> 
&nbsp;
<%=wh%> 
</td>
 </tr>

<tr align="left" > <td width="25%" align="left" class=roomleft  height="24"> &nbsp;��ҵ</td><td class=roomright width="25%" align="left"   height="24"> 
&nbsp;<%=job %></td>
<td width="25%" align="left" class=roomleft  height="24">&nbsp;������</td><td class=roomright width="25%" align="left"   height="24"> 
&nbsp;<%= jtsr%> &nbsp; 
�� </td></tr> <tr> <td width="25%" class=roomleft  align="left" height="24">&nbsp;�ͻ�����</td><td class=roomright width="25%"   align="left" height="24"> 
&nbsp;

<%=custype %> 
</select></td> <td width="25%" class=roomleft  align="left" height="24"> &nbsp;������;</td><td class=roomright width="25%"   align="left" height="24"> 
  &nbsp;<%=gmyt %>
 </select></td></tr> <tr align="left" > <td width="25%" align="left" class=roomleft  height="24"> &nbsp;��������</td><td  class=roomright width="25%" align="left"   height="24"> 
 &nbsp;
<%=visitnum %>&nbsp;</td>
<td width="25%" align="left" class=roomleft  height="14"> &nbsp;��ϵ��</td>
<td  class=roomright width="25%" align="left"   height="14"> &nbsp;<%=linkman %></td> 
</tr>
<tr align="left" > <td width="25%" align="left" class=roomleft  height="14"> &nbsp;ͬ������</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<%=visitname %>
</td> <td width="25%" align="left" class=roomleft  height="14"> &nbsp;ͬ�ù�ϵ</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<%=nexus %>
 </td></tr>   

 <tr align="left" > 
	  
 <td width="25%" class=roomleft  align="left" height="23"> &nbsp;���ô���</td><td class=roomright width="25%"   align="left" height="23"> &nbsp;<%=chishu %></td>
<td width="25%" align="left" class=roomleft  height="14"> &nbsp;��Ϣ��Դ</td><td class=roomright width="25%" align="left"   height="14"> 
  &nbsp;<%=tj %>
        </td> 
</tr>
</table>  

<P align=center>
<table border="0" width="100%" cellspacing="0"  cellpadding="0" bordercolor="#dbdbdb" class="tablefill">
<% 
int num=0;
 sql="select fc, fw, pt,pay,other, seller, convert(char(24),date,111) date from tail_after where cusno='"+cusno+"' order by date";
  rs=ViewBean.executeQuery(sql);
  
  while (rs.next()){
  num++;
%>
<tr><td colspan=2 class=TITLE><font color=white>��<%=num %>�θ�����¼:</font></td></tr>
<tr>
    <td width="76"class=roomleft >���ټ�¼</td>
    <td width="490"class=roomright> <%=getbyte(rs.getString("fc")) %></td>
  </tr>
  <!--
  <tr>
    <td width="76"class=roomleft >������</td>
    <td width="490"class=roomright><%=getbyte(rs.getString("fw")) %></td>
  </tr>
  <tr>
    <td width="76"class=roomleft >�����</td>
    <td width="490"class=roomright><%=getbyte(rs.getString("pay")) %></td>
  </tr>
  <tr>
    <td width="76"class=roomleft >��������</td>
    <td width="490"class=roomright><%=getbyte(rs.getString("other")) %></td>
  </tr>-->
  <tr>
    <td width="76"class=roomleft>ҵ��Ա</td>
    <td width="490"class=roomright>
      <%=getbyte(rs.getString("seller")) %>
	</td>
   </tr>
  <tr>
    <td width="76"class=roomleft>��������</td>
    <td width="490"class=roomright>
   <%=rs.getString("date") %>
       </td> 
	</tr>
	<%}
	
	rs.close(); %>   
</table>	


</center>
</form>   
       
</body>       
</html>       
