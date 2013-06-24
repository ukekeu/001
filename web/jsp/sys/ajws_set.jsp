<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>

<%@ include file="../public_js/logrecord.jsp" %>


<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">

<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>按揭设置</title>
</head>
 <%@ page language="java" import="java.sql.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
   <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/CheckSection.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<script language="javascript" src="../public_js/public.js"></script>
 
<body oncontextmenu="return false" >


<form method="POST" name="cus" action="SectionView.jsp">

  <p align="center"><b><font size="3" class=FontColor>楼盘资料一览表</font></b>
  </p>
 
 	   
 <table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>
  <tr class=listtitle>
    <td width="14%" align="center"  ><font color=white>楼盘名称</font></td>
    <td width="8%"  align="center"  ><font color=white>按揭方式</font></td>
	<td width="6%"  align="center"  ><font color=white>设置按揭方式</font></td>	
	
  </tr>
 <%
 String no=request.getParameter("no");
 String state_type=request.getParameter("type");
 if (no!=null){
 ViewBean.executeUpdate("update hsm_Ajk set state_type="+state_type+" where section_no='"+no+"'");
 setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "按揭设置" , 
                  "变更"
                ) ;
 }
 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";	
String sql="";
sql="SELECT dbo.[Crm_Project].Name, dbo.hsm_Ajk.state_type,"; 
sql+=" dbo.[Crm_Project].SerialNo FROM dbo.[Crm_Project] INNER JOIN";
sql+=" dbo.hsm_Ajk ON dbo.[Crm_Project].SerialNo = dbo.hsm_Ajk.section_no  ";
 

String secno="";
String secname="";
String type=""; 
String type_name=""; 
 
ResultSet rs=ViewBean.executeQuery(sql);
int i=0;
 while (rs.next()){
     i=i+1;
  secname=getbyte(rs.getString("Name"));
  type=getbyte(rs.getString("state_type"));
  secno=rs.getString("SerialNo");
  if (type.equals("1"))type_name="按揭款以千为单位";
  else type_name="按揭款以万为单位";
 %>
  <tr id=TR<%=i %> align="center" class=listcontent  >
  
    <td width="14%"  > <%=secname %></td>
    <td width="10%"  ><%=type_name %></td>
    <td width="8%"   ><a href="ajws_set.jsp?no=<%=secno %>&type=1">以千单位</a>&nbsp;<a href="ajws_set.jsp?no=<%=secno %>&type=0">以万单位</a></td>
  </tr>
  <%
 
  }
  rs.close();
 
%>
 
</body>
</form>
</html>



