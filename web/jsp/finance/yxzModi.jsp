<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%
  String yxz_area=getbyte1(request.getParameter("yxz_area"));
  String yxzprice=getbyte1(request.getParameter("yxzprice"));
 String SQL="";
   String roomno=request.getParameter("roomno");
   String section=request.getParameter("section");
   String id=getbyte1(request.getParameter("id"));
   if (!id.equals("")){
    String bxga=getbyte1(request.getParameter("bxga"));
    String bxgj=getbyte1(request.getParameter("bxgj"));
	 SQL="UPDATE room SET yxz_area="+yxz_area;
	 SQL=", yxz_area_price="+yxzprice;
	SQL+=" where seccode='"+section+"' and loft+room_code='"+roomno+"'";
	ViewBean.executeUpdate(SQL);
   %> <script>alert("已保存！");opener.window.location.reload();window.close();</script>
	<%
  }
 
    SQL="select yxz_area,yxz_area_price from  room  where seccode='"+section+"' and loft+room_code='"+roomno+"'";
  
	String jq_date1="";
 
    ResultSet rs=ViewBean.executeQuery(SQL);
	if (rs.next()){
	     yxz_area=fa.getFloat(rs.getFloat("yxz_area"),2);
		 yxzprice=fa.getFloat(rs.getFloat("yxz_area_price"),2);
			 }
	rs.close();
 
	  
	%>
	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>阳台罩资料</title>

</head>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
 


<body   bgcolor="#EBEBEB">

<form method="POST" name="cus1" action="yxzModi.jsp?roomno=<%=roomno %>&section=<%=section %>">
<input type=hidden name=id value=<%=roomno %>>
 
	<p align="center"><b><font size="3" color="#000080">防盗安全网资料</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;面积</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=yxz_area size=12 value="<%=yxz_area %>"  onkeydown="key(document.cus1.bxgj)">
		  </td>
      </tr>
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;单价</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=yxzprice size=12 value="<%=yxzprice %>"  onkeydown="key(document.cus1.bxgj)">
		  </td>
      </tr>
     
	
	  
       
    </table> 
	<br>
	 <div align="center"> 

             <input type=hidden name=cusno>
            <input type="button" value="提　交" name="Save" onclick="if (confirm('请确认你的修改?'))document.cus1.submit();" >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="reset" value="退  出" name="button" onclick="window.close();">
          </div> 
</form>     
 
   
       
       
</body>       
</html>       
