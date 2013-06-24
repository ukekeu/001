<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%
  String yang_tai_zhao_sarea=getbyte1(request.getParameter("yang_tai_zhao_sarea"));
  String dt_area=getbyte1(request.getParameter("dt_area"));
  String dtp=getbyte1(request.getParameter("dtp"));
  String bxgp=getbyte1(request.getParameter("bxgp"));
 String SQL="";
   String roomno=request.getParameter("roomno");
   String section=request.getParameter("section");
   String id=getbyte1(request.getParameter("id"));
   if (!id.equals("")){
    String bxga=getbyte1(request.getParameter("bxga"));
    String bxgj=getbyte1(request.getParameter("bxgj"));
	 SQL="UPDATE room SET dt_area="+dt_area;
	SQL+=", yang_tai_zhao_sarea ="+yang_tai_zhao_sarea;
	SQL+=", dt_area_price ="+dtp;
	SQL+=", yang_tai_zhao_price ="+bxgp;
	SQL+=" where seccode='"+section+"' and loft+room_code='"+roomno+"'";
	ViewBean.executeUpdate(SQL);
   %> <script>alert("已保存！");opener.window.location.reload();window.close();</script>
	<%
  }
 
    SQL="select dt_area,yang_tai_zhao_sarea,dt_area_price,yang_tai_zhao_price from  room  where seccode='"+section+"' and loft+room_code='"+roomno+"'";
  
	String jq_date1="";
 
    ResultSet rs=ViewBean.executeQuery(SQL);
	if (rs.next()){
	     dt_area=fa.getFloat(rs.getFloat("dt_area"),2);
		 yang_tai_zhao_sarea=fa.getFloat(rs.getFloat("yang_tai_zhao_sarea"),2);
		 dtp=fa.getFloat(rs.getFloat("dt_area_price"),2);
		 bxgp=fa.getFloat(rs.getFloat("yang_tai_zhao_price"),2); 
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

<form method="POST" name="cus1" action="YtaizModi.jsp?roomno=<%=roomno %>&section=<%=section %>">
<input type=hidden name=id value=<%=roomno %>>
 
	<p align="center"><b><font size="3" color="#000080">阳台罩资料</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;锻铁面积</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=dt_area size=12 value="<%=dt_area %>"  onkeydown="key(document.cus1.bxgj)">
		  </td>
      </tr>
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;锻铁单价</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=dtp size=12 value="<%=dtp %>"  onkeydown="key(document.cus1.bxgj)">
		  </td>
      </tr>
     
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;不锈钢罩面积</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="yang_tai_zhao_sarea" value="<%=yang_tai_zhao_sarea %>" size="20" onblur="check(this);"  onkeydown="key(document.cus1.dta)" >
        </td>
      </tr>
	    <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;不锈钢罩单价</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="bxgp" value="<%=bxgp %>" size="20" onblur="check(this);"  onkeydown="key(document.cus1.dta)" >
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
