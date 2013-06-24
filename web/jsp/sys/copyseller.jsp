<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ page import = "java.sql.*" %> 
<jsp:useBean id = "sellerListBean" scope = "page" class = "ConnDatabase.SDatabase" /> 
   <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<LINK href="../class/news.css" rel=stylesheet>
<head>
	
	<title>人员复制</title>
<script language="javascript" src="../public_js/public.js">
</script>
	<script>
	function delSeller(id) {
		if ( confirm("确实想删除该条记录?"))
			window.location = "SaveSeller.jsp?id=" + id + "&seller_oper=dele";
	}
		
	</script>
</head>

<body onload="setSelectMad(document.frm.section,'<%=getbyte1(request.getParameter("section")) %>');" oncontextmenu="return false" >

<form name=frm method="post">
<table width="100%"> <tr> <td> <div align="center"><font size=3>售楼员列表</font></div></td></tr> 
</table>
<%
String sellerid[]=request.getParameterValues("choose");
String sellers="";
if (sellerid!=null){
for (int a=0;a<sellerid.length;a++){
 if (sellers.equals(""))sellers=sellerid[a];
 else sellers+=","+sellerid[a];
}
if (!sellers.equals("")){
  sellers="("+sellers+")";
  String StrSql = "insert into  seller(section_No,seller_no,seller,sex,tel,mail) select '"+request.getParameter("section1")+"', seller_no,seller,sex,tel,mail from seller  where code in"+sellers;
 sellerListBean.executeUpdate(StrSql);
 out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
 out.println("alert('复制成功！！');"); 
  out.println("opener.document.frm.submit();");
 out.println("window.close();");
 out.println("</SCRIPT>");
 
 
  }
}
 %>
<table width="99%" >
 <tr>
    <td width="50%">&nbsp;所属楼盘：
	
   
   &nbsp;<select name="section" onchange="document.frm.submit();" > 
   <option></option>
   
<%@ include file="../public_js/CheckSection.jsp"%>
<%
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
	
      String sql1="select SerialNo,Name from Crm_Project where SerialNo in("+SectionS+")";


	  ResultSet rs2=sellerListBean.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	 	    rs2.close();
	
     %> </select></td><td>复制到:&nbsp;<select name="section1"   > 
   <option></option>
<%  
       sql1="select SerialNo,Name from Crm_Project where SerialNo in("+SectionS+")";

	  rs2=sellerListBean.executeQuery(sql1);	
	 
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	 	    rs2.close();
	
     %> </select></td><td><input type=button name=copy value="提 交" onclick="copyseller();"></td>
	 </tr>
	 </table>
 <table border=0 width=99%   cellspacing=1 cellpadding=1 >
<tr class=listtitle align=center><td>
<font color=white>选择</font></td><td><font color=white>销售员姓名 </font></td><td> <font color=white>性别 </font></td><td> <font color=white>联系电话 </font></td> </td> </tr>
<%
 String section=getbyte1(request.getParameter("section"));
 if (!section.equals(""))section="where section_no='"+section+"'";
 else section="where section_no =''"; 
String SQL="SELECT s.* FROM seller s "+section;
 ResultSet rs = sellerListBean.executeQuery(SQL);
 
while (rs.next()){
 %>
<tr class='listcontent' align=center><td><input type="checkbox" name="choose" value="<%=getbyte(rs.getString("code")) %>"></td><td><%=getbyte(rs.getString("seller")) %></td><td><%=getbyte(rs.getString("sex")) %></td> <td><%=getbyte(rs.getString("tel")) %></td></tr>
 
<%}rs.close(); %>
</table>
<script>
 function modiSeller(){
  var i=0;
  var id="";
  for(var aa=0;aa<document.frm.choose.length;aa++){
      if (document.frm.choose[aa].checked){i++;id=document.frm.choose[aa].value;}
  }
  if (i>1){alert("修改销售员资料时，只能选择一位");return false;}
  if (i==0){alert("请选择需要修改的销售员资料");return false;}
  openwin1("modiseller.jsp?id="+id,320,350,100,100);
 }
 function copyseller(){
     var i=0;
  var id="";
  for(var aa=0;aa<document.frm.choose.length;aa++){
      if (document.frm.choose[aa].checked)i++;
  }
     if (i==0){alert("请选择需要复制的销售员");return false;}
	 if (document.frm.section1.value==""){alert("请选择目标楼盘");return false;}
	if (confirm("确认复制吗？"))
	 document.frm.submit();
 }
</script>
</form>
</body>
</html>
