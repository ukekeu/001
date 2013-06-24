<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>

<%@ include file="../public_js/getByteOut.jsp"%>
<%
 
  String dta=getbyte1(request.getParameter("dta"));
  String id=getbyte1(request.getParameter("id"));
   String dtj=getbyte1(request.getParameter("dtj"));
  if (!dtj.equals("")){
    String bxga=getbyte1(request.getParameter("bxga"));
    String bxgj=getbyte1(request.getParameter("bxgj"));
	String SQL="insert into  yang_tai_zao (contractno,bxg_area,bxg_price,dt_area,dt_price) Values( ";
	       SQL+=id+","+bxga+","+bxgj+","+dta+","+dtj+")";
	 
     ViewBean.executeUpdate(SQL);
	  
	%>
	 <script>alert("已保存！");opener.window.location.reload();window.close();</script>
	<%
  }
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

<form method="POST" name="cus1" action="">
<input type=hidden name=id value=<%=id %>>
 
	<p align="center"><b><font size="3" color="#000080">阳台罩资料</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;不锈钢罩面积</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=bxga size=12 value="0"  onkeydown="key(document.cus1.bxgj)">
		  </td>
      </tr>
      
     
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;不锈钢罩单价</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="bxgj" value="0" size="20" onblur="check(this);"  onkeydown="key(document.cus1.dta)" >
        </td>
      </tr>
	  
      <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;锻铁面积</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name=dta size="20" value=0 onkeydown="key(document.cus1.dtj)" >
        </td>
      </tr>
      <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;锻铁单价</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name=dtj  onkeydown="key(document.cus1.Save)" value=0 size="20">
        </td>
      </tr>
    </table> 
	<br>
	 <div align="center"> 

             <input type=hidden name=cusno>
            <input type="button" value="提　交" name="Save" onclick="document.cus1.submit();" >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="reset" value="退  出" name="button" onclick="window.close();">
          </div> 
</form>     
 
   
       
       
</body>       
</html>       
