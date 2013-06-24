  <%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
    <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>销售分析</title>
</head>
<script language="javascript" src="../public_js/public.js">
</script>
<body >
<%
String section=getbyte1(request.getParameter("section"));

 
List S_Loft=new LinkedList();//存放栋号
List S_loft_n=new LinkedList();//存放栋号对的套数
 

 
 %> 
 <%@ include file="../public_js/CheckSection.jsp"%>
<form name=frm>
楼盘：<select name="section" onchange="document.frm.submit();"> 
   <option></option>
<%  

      if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";

	  ResultSet rs2=ViewBean.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	  if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	  if (section.equals(""))section=defaultNo;
     %> </select>
	 <%
	 
String SQL="SELECT LOFT,count(*) num  FROM Order_Contract where SECTION='"+section+"' group by loft";
 ResultSet rs=null;
 
  rs=ViewBean.executeQuery(SQL);
  
  while (rs.next()){
    String aaa=getbyte(rs.getString("LOFT"));
    if (aaa!=null){
	   S_Loft.add(aaa);
	   S_loft_n.add(rs.getString("num"));
	
	}
	}
	rs.close();
	 
	  %>
<script>
 setSelectMad(document.frm.section,'<%=section%>');
</script>
<br>
<b>按栋号</b>
<table height=16  width="100%" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr bgcolor='#EAECEC'><td height=16  width="20%">&nbsp;栋号</td><td height=16  width="20%">总套数</td><td height=16  width="20%">已销售套数</td><td height=16  width="20%">销售率</td><td height=16  width="20%">形象进度</td></tr>
<%

 SQL="SELECT LOFT,count(*) num  FROM ROOM where seccode='"+section+"' group by loft";
 
 
  rs=ViewBean.executeQuery(SQL);
  
  while (rs.next()){
    String aaa=getbyte(rs.getString("LOFT"));
	String n=rs.getString("num");
	String s_n="0";
    if (aaa!=null){
	  if (S_Loft.contains(aaa)){
		   int index=S_Loft.indexOf(aaa);
		   s_n=(String)S_loft_n.get(index);
		} 
	 %>
	<tr><td height=16  width="20%">&nbsp;<%=aaa %></td>
	<td height=16  width="15%"><%=n %></td><td height=16  width="15%"><%=s_n %></td>
	<td height=16  width="20%">&nbsp;<%=FormtD.getFloat(Integer.parseInt(s_n)/Float.parseFloat(n)*100,2) %>%</td>
	
		<td width="30%">&nbsp;<%if (Integer.parseInt(s_n)>0){ %><img src="../images/line.gif" height=16  width="<%=FormtD.getFloat(Integer.parseInt(s_n)/Float.parseFloat(n)*100,2) %>"><%} %></td>

	</tr> 
	 
	 <%
	
	}
	}
	rs.close();
 %>
 </table>
<%


S_loft_n.clear();
S_Loft.clear();
SQL="SELECT roomtype,count(*) num  FROM Order_Contract where SECTION='"+section+"' group by roomtype";
 
 
  rs=ViewBean.executeQuery(SQL);
  
  while (rs.next()){
    String aaa=getbyte(rs.getString("roomtype"));
    if (aaa!=null){
	   S_Loft.add(aaa);
	   S_loft_n.add(rs.getString("num"));
	
	}
	}
	rs.close();
 %>
  <b>按户型</b>
<table height=16  width="100%" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr bgcolor='#EAECEC'><td height=16  width="20%">&nbsp;户型</td><td height=16  width="20%">总套数</td><td height=16  width="20%">已销售套数</td><td height=16  width="20%">销售率</td><td height=16  width="20%">形象进度</td></tr>
<%

 SQL="SELECT roomtype,count(*) num  FROM ROOM where seccode='"+section+"' group by roomtype";
 
 
  rs=ViewBean.executeQuery(SQL);
  
  while (rs.next()){
    String aaa=getbyte(rs.getString("roomtype"));
	String n=rs.getString("num");
	String s_n="0";
    if (aaa!=null){
	  if (S_Loft.contains(aaa)){
		   int index=S_Loft.indexOf(aaa);
		   s_n=(String)S_loft_n.get(index);
		} 
	 %>
	<tr><td>&nbsp;<%=aaa %></td><td><%=n %></td><td><%=s_n %></td><td><%=FormtD.getFloat(Integer.parseInt(s_n)/Float.parseFloat(n)*100,2) %>%</td>
	<td width="30%">&nbsp;<%if (Integer.parseInt(s_n)>0){ %><img src="../images/line.gif" height=16  width="<%=FormtD.getFloat(Integer.parseInt(s_n)/Float.parseFloat(n)*100,2) %>"><%} %></td>


	</tr> 
	 
	 <%
	
	}
	}
	rs.close();
 %>
 </table>
 
 
<%
S_loft_n.clear();
S_Loft.clear();
SQL="SELECT r.Direction,count(*) num  FROM Order_Contract o,room r where o.SECTION='"+section+"' and r.seccode=o.section and r.loft=o.loft and r.room_code=o.room_no group by r.Direction";
  rs=ViewBean.executeQuery(SQL);
 
  while (rs.next()){
    String aaa=getbyte(rs.getString("Direction"));
    if (aaa!=null){
	   S_Loft.add(aaa);
	   S_loft_n.add(rs.getString("num"));
	
	}
	}
	rs.close();
 %>
   <b>按朝向</b>
<table height=16  width="100%" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr bgcolor='#EAECEC'> <td height=16  width="20%">&nbsp;朝向</td><td height=16  width="20%">总套数</td><td height=16  width="20%">已销售套数</td><td height=16  width="20%">销售率</td><td height=16  width="20%">形象进度</td></tr>
<%

 SQL="SELECT Direction,count(*) num  FROM ROOM where seccode='"+section+"'  group by Direction";
 
 
  rs=ViewBean.executeQuery(SQL);
  
  while (rs.next()){
    String aaa=getbyte(rs.getString("Direction"));
	String n=rs.getString("num");
	String s_n="0";
    if (aaa!=null){
	  if (S_Loft.contains(aaa)){
		   int index=S_Loft.indexOf(aaa);
		   s_n=(String)S_loft_n.get(index);
		} 
	 %>
	<tr><td>&nbsp;<%=aaa %></td><td><%=n %></td><td><%=s_n %></td><td><%=FormtD.getFloat(Integer.parseInt(s_n)/Float.parseFloat(n)*100,2) %>%</td>
	<td width="30%">&nbsp;<%if (Integer.parseInt(s_n)>0){ %><img src="../images/line.gif" height=16  width="<%=FormtD.getFloat(Integer.parseInt(s_n)/Float.parseFloat(n)*100,2) %>"><%} %></td>
	
	</tr> 
	 
	 <%
	
	}
	}
	rs.close();
 %>
 </table>
 
 
 
<%
S_loft_n.clear();
S_Loft.clear();
SQL="SELECT jzarea,count(*) num  FROM Order_Contract where SECTION='"+section+"' group by jzarea";
 
 
  rs=ViewBean.executeQuery(SQL);
  
  while (rs.next()){
    String aaa=FormtD.getFloat(rs.getFloat("jzarea"),3);
    if (aaa!=null){
	   S_Loft.add(aaa);
	   S_loft_n.add(rs.getString("num"));
	
	}
	}
	rs.close();
 %>
    <b>按面积</b>
<table height=16  width="100%" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr bgcolor='#EAECEC'><td height=16  width="20%">&nbsp;面积</td><td height=16  width="20%">总套数</td><td height=16  width="20%">已销售套数</td><td height=16  width="20%">销售率</td><td height=16  width="20%">形象进度</td></tr>

<%

 SQL="SELECT area,count(*) num  FROM ROOM where seccode='"+section+"' group by area";
 
 
  rs=ViewBean.executeQuery(SQL);
  
  while (rs.next()){
    String aaa=FormtD.getFloat(rs.getFloat("area"),3);
	String n=rs.getString("num");
	String s_n="0";
    if (aaa!=null){
	  if (S_Loft.contains(aaa)){
		   int index=S_Loft.indexOf(aaa);
		   s_n=(String)S_loft_n.get(index);
		} 
	 %>
	<tr><td>&nbsp;<%=aaa %></td><td><%=n %></td><td><%=s_n %></td><td><%=FormtD.getFloat(Integer.parseInt(s_n)/Float.parseFloat(n)*100,2) %>%</td>
	<td width="30%">&nbsp;<%if (Integer.parseInt(s_n)>0){ %><img src="../images/line.gif" height=16  width="<%=FormtD.getFloat(Integer.parseInt(s_n)/Float.parseFloat(n)*100,2) %>"><%} %></td>

	</tr> 
	 
	 <%
	
	}
	}
	rs.close();
 %>
 </table>
</form>
</body>

</html>