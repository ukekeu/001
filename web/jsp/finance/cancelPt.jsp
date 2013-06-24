 <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/logrecord.jsp" %>
<html>
<head>
	<title>取消配套费</title>
</head>

<body>
<%
   String codes=request.getParameter("codes");
   String cancelcode=getbyte1(request.getParameter("cancelcode"));
   String bak=getbyte1(request.getParameter("bak"));
    String room=getbyte1(request.getParameter("room"));
   if (!cancelcode.equals("")){
   String sql="update GatheringTaxRecord set cancel=1,cancelbak='"+bak+"' where id in ("+cancelcode+")";

   ViewBean.executeUpdate(sql);
   setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "取消配套费记录" , 
                  "取消"+room
                ) ;	

 %>
 <script>alert("已取消");opener.window.location.reload();window.close();</script>
 <%} %>
	<form name=frm  method="post">
	<input type=hidden name=cancelcode value="<%=codes %>">
	 <input type=hidden name=room value=<%=getbyte2(request.getParameter("room")) %>>

<p align="center"><b><font size="3" color="#000080">取消备注</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;备注</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=bak>
		  </td>
      </tr>
       
	   
    </table> 
	<br>
	 <div align="center"> 

             <input type=hidden name=cusno>
            <input type="button" value="提　交" name="modi"  onclick="checkdata();" >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="reset" value="退  出" name="button" onclick="window.close();">
          </div> 
</form>     
 <script>
 function checkdata(){
  if (document.frm.bak.value==""){alert("请录入取消原因!");return false;}
  document.frm.submit();
 }
 
 </script>
</body>
</html>
