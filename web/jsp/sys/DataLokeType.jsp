 

<%@ page contentType="text/html;charset=GBK" %>

 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/CheckSection.jsp"%>
<HTML>
<HEAD>
<TITLE>数据事务设置</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
</HEAD>
 

<script language="javascript" src="../public_js/public.js">
</script>
<%
String SecNo1=getbyte1(request.getParameter("section"));
String ch=getbyte1(request.getParameter("choose"));
String Ltime=getbyte1(request.getParameter("Ltime"));
String va=getbyte1(request.getParameter("va"));
String sectionno=request.getParameter("sectionno");
if (sectionno!=null){
  ViewBean1.executeUpdate("delete DataTransSet where  section_no='"+sectionno+"'");	

}
String A1="",A2="",A3="",SQL="", loke_time="1";
try{
if  (!SecNo1.equals("")&&!va.equals("")){ 
  SQL="select  loke_time from DataTransSet WHERE section_no='"+SecNo1+"'";

ResultSet rs=ViewBean1.executeQuery(SQL);	
if (rs.next()){
  SQL="update DataTransSet set loke_time="+Ltime+" where section_no='"+SecNo+"'";
  ViewBean1.executeUpdate(SQL);	
 
}else{
  SQL="insert into DataTransSet(section_no,loke_time) VALUES('"+SecNo1+"',"+Ltime+")";
 
 ViewBean1.executeUpdate(SQL);	

}

rs.close();

}
}catch(Exception s){out.print(SQL);}
if (!SecNo1.equals("")){
 SQL="select loke_time  from DataTransSet WHERE section_no='"+SecNo1+"'";

ResultSet rs=ViewBean1.executeQuery(SQL);	
if (rs.next()){
 loke_time=rs.getString("loke_time").trim();
  A1="checked";
 }
rs.close();

}
 
 %>
<body  oncontextmenu="return false"  onload="setSelectMad(document.frm.section,'<%=request.getParameter("section") %>')">
 <form name=frm>
 <input type=hidden name=va>
<center>
<table width="90%" align="center" >
<tr><td colspan="2"><font size=4>数据事务设置</font></td></tr>
<tr><td colspan="2"></td></tr>
<tr><td colspan="2" >
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
	
     %> </select></td></tr>
	 <tr><td><input type="radio" value="0" <%=A1 %> name="ch" onclick="document.frm.choose.value=0;" >对房间资料修改及认购登记(修改)时，进行数据锁定，锁定时间:<input type=text value="<%=loke_time %>" size=3 name="Ltime" onblur="checkNaN(this);">分钟</td><td><%if (A1.equals("checked")){ %><a href="DataLokeType.jsp?dele=aa&sectionno=<%=request.getParameter("section") %> ">取消事务</a><%} %></td></tr>
 </table>
	 <table width="50%" border="0">
<tr><td  align="center"><input type=button name=saveSet value=" 提 交 " onclick="check();"></td></tr>

</table>
<input type=hidden name=choose>
	 </center>
	 </form>
<script>
function check(){
 if (document.frm.section.value==""){alert("请选择楼盘名称");return false;}
  if (document.frm.ch.checked){
    if (document.frm.Ltime.value==""){alert("请输入锁定时间");document.frm.Ltime.focus();return false;}
  
  }else{alert("请选中单选框");return false;}
 document.frm.va.value="123";
 document.frm.submit();

}
 
</script>
 
</body>
</html>
