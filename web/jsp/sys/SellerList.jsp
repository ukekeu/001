<%@ page contentType="text/html;charset=GBK" %>
 <%@ page import = "java.sql.*" %> 
 <%@ include file="../public_js/checktime.jsp"%>
<jsp:useBean id = "sellerListBean" scope = "page" class = "ConnDatabase.SDatabase" /> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <html>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<head>
	
	<title>销售员一览</title>
<script language="javascript" src="../public_js/public.js">
</script>
	<script>
	function delSeller(id) {
		if ( confirm("确实想删除该条记录?"))
			window.location = "SaveSeller.jsp?id=" + id + "&seller_oper=dele";
	}
	
	
	</script>
</head>

<body oncontextmenu="return false" onload="setSelectMad(document.frm.section,'<%=getbyte1(request.getParameter("section")) %>');">

<form name=frm method="post" t>
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
   sellerListBean.executeUpdate("delete seller where code in "+sellers);
  }
}
 %>
<input type=button name=add value="增 加" onclick="openwin1('sellerinput.jsp?section='+document.frm.section.value,320,350,100,100);">&nbsp;<input type=button name=mondiy value="修 改" onclick="modiSeller();">&nbsp;<input type=button name=delete value="删 除" onclick="deleseller();">&nbsp;<input type=button name=delete value="复 制" onclick="copyseller();"><br>
<table>
 <tr>
    <td width="25%">&nbsp;所属楼盘：
	
   
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
	
     %> </select> </td>
	 </tr>
	 </table>
 <table border=0 width=100% align=center  cellspacing=1 cellpadding=1 >
<tr class=listtitle align=center><td>
<font color=white>选择</font></td><td><font color=white>销售员姓名 </font></td><td> <font color=white>性别 </font></td><td> <font color=white>联系电话 </font></td><td> <font color=white>联系mail </font></td></tr>
<%
 String section=getbyte1(request.getParameter("section"));
 if (!section.equals(""))section="where section_no='"+section+"'";
 else section =" where section_no =''";
String SQL="SELECT s.* FROM seller s "+section;
 ResultSet rs = sellerListBean.executeQuery(SQL);
 
while (rs.next()){
 %>
<tr class='listcontent'  align=center><td><input type="checkbox" name="choose" value="<%=getbyte(rs.getString("code")) %>"></td><td><%=getbyte(rs.getString("seller")) %></td><td><%=getbyte(rs.getString("sex")) %></td><td> <%=getbyte(rs.getString("tel")) %></td><td><%=getbyte(rs.getString("mail")) %></td></tr>
 
<%}rs.close(); %>
</table>
<script>
 function modiSeller(){
  var i=0;
  var id="";
  if (document.frm.choose.length)
  for(var aa=0;aa<document.frm.choose.length;aa++){
      if (document.frm.choose[aa].checked){i++;id=document.frm.choose[aa].value;document.frm.choose[aa].checked=false;}
  }else{
    if (document.frm.choose.checked){i++;id=document.frm.choose.value;document.frm.choose.checked=false;}
  
  }
  if (i>1){alert("修改销售员资料时，只能选择一位");return false;}
  if (i==0){alert("请选择需要修改的销售员资料");return false;}
  openwin1("modiseller.jsp?id="+id,320,350,100,100);
 }
 function deleseller(){
     var i=0;
  var id="";
  if (document.frm.choose.length)
	  for(var aa=0;aa<document.frm.choose.length;aa++){
	      if (document.frm.choose[aa].checked)i++;
 }else{
    if (document.frm.choose.checked){i++;id=document.frm.choose.value;}
    }  
     if (i==0){alert("请选择需要删除的销售员资料");return false;}
	if (confirm("确认删除吗？"))
	 document.frm.submit();
 }
 function copyseller(){
  openwin("copyseller.jsp",500,400,100,100);
 
 }
</script>
</form>
</body>
</html>
