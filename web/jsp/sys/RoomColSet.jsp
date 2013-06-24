<%@ page contentType="text/html;charset=GBK" %>

 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/CheckSection.jsp"%>
<HTML>
<HEAD>
<TITLE>销控表显示列设置</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

</HEAD>
 

<script language="javascript" src="../public_js/public.js">
</script>
<%
String SecNo1=getbyte1(request.getParameter("section"));
 String saveSet1=getbyte1(request.getParameter("saveSet1"));
String cols=getbyte1(request.getParameter("cols"));
 String SQL="";
try{
if  (!SecNo1.equals("")&&!cols.equals("")&&!saveSet1.equals("")){ 
  
  SQL="update Crm_Project set ts="+cols+"  where SerialNo='"+SecNo1+"'";
  ViewBean1.executeUpdate(SQL);	
  SQL="update LoftBuildCode set ts="+cols+"  where SECNO='"+SecNo1+"'";
  ViewBean1.executeUpdate(SQL);	
%>
<script>alert("已保存设置");</script>
<%
}
}catch(Exception s){out.print(SQL);}
String type="";
if (!SecNo1.equals("")){
 SQL="select ts from Crm_Project WHERE SerialNo='"+SecNo1+"'";
 
ResultSet rs=ViewBean1.executeQuery(SQL);	
if (rs.next()){
   cols=rs.getString("ts").trim(); 
}
rs.close();

}
 if (cols.equals(""))cols="20";
 %>
<body     marginheight="100%" topmargin="100%" oncontextmenu="return false" onload="setSelectMad(document.frm.section,'<%=request.getParameter("section") %>')">
 <form name=frm>
 
<table width="50%" border="0" align="center"   width="100%">
<tr    ><td  align="center" colspan="2"><font size=3>参数设置</font></td></tr>
 <tr><td>
楼盘名称：<select name="section" onchange="document.frm.submit();"> 
   <option></option>
<%  
 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";	
      String sql1="select SerialNo,Name from Crm_Project  ";
	  ResultSet rs2=ViewBean1.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
 
	    rs2.close();
	
     %> </select></td> <td>销控表中每行最多显示：<input type=text size=3 name="cols" value=<%=cols %>>列</td> <td  align="center"><input type=button name=saveSet value=" 提 交 " onclick="check();"></td></tr>

</table>
 <input type=hidden name=saveSet1>
	 </form>
<script>
function check(){
 if (document.frm.section.value==""){alert("请选择楼盘名称");return false;}
  document.frm.saveSet1.value="1"
 document.frm.submit();

}

</script>

</body>
</html>
