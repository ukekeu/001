<%@ page contentType="text/html;charset=GBK" %>
 <%@ page import = "java.sql.*" %> 
 <%@ include file="../public_js/checktime.jsp"%>
<jsp:useBean id = "sellerListBean" scope = "page" class = "ConnDatabase.SDatabase" /> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <html>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<head>
	
	<title>����Աһ��</title>
<script language="javascript" src="../public_js/public.js">
</script>
	<script>
	function delSeller(id) {
		if ( confirm("ȷʵ��ɾ��������¼?"))
			window.location = "SaveSeller.jsp?id=" + id + "&seller_oper=dele";
	}
	
	
	</script>
</head>

<body oncontextmenu="return false" onload="setSelectMad(document.frm.section,'<%=getbyte1(request.getParameter("section")) %>');">

<form name=frm method="post" t>
<table width="100%"> <tr> <td> <div align="center"><font size=3>��¥Ա�б�</font></div></td></tr> 
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
<input type=button name=add value="�� ��" onclick="openwin1('sellerinput.jsp?section='+document.frm.section.value,320,350,100,100);">&nbsp;<input type=button name=mondiy value="�� ��" onclick="modiSeller();">&nbsp;<input type=button name=delete value="ɾ ��" onclick="deleseller();">&nbsp;<input type=button name=delete value="�� ��" onclick="copyseller();"><br>
<table>
 <tr>
    <td width="25%">&nbsp;����¥�̣�
	
   
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
<font color=white>ѡ��</font></td><td><font color=white>����Ա���� </font></td><td> <font color=white>�Ա� </font></td><td> <font color=white>��ϵ�绰 </font></td><td> <font color=white>��ϵmail </font></td></tr>
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
  if (i>1){alert("�޸�����Ա����ʱ��ֻ��ѡ��һλ");return false;}
  if (i==0){alert("��ѡ����Ҫ�޸ĵ�����Ա����");return false;}
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
     if (i==0){alert("��ѡ����Ҫɾ��������Ա����");return false;}
	if (confirm("ȷ��ɾ����"))
	 document.frm.submit();
 }
 function copyseller(){
  openwin("copyseller.jsp",500,400,100,100);
 
 }
</script>
</form>
</body>
</html>
