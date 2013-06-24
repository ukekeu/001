<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel="stylesheet" type="text/css" href="UltraGrid.css">	
<title>客户调查数据项定义</title>
</head>
<script language="javascript" src="../public_js/public.js"></script>
  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>

 
<%
String SecNo=getbyte1(request.getParameter("SecNo"));
String codes=getbyte1(request.getParameter("codes"));
String deletecode=getbyte1(request.getParameter("deletecode"));
String SQL="";
if (!deletecode.equals("")){
   SQL="delete  CustomerDc where code="+deletecode;
   ViewBean.executeUpdate(SQL);
}
if (!codes.equals("")){
   SQL="insert into CustomerDc(codeName,sectionno) values('"+codes+"','"+SecNo+"')";
   ViewBean.executeUpdate(SQL);
}
SQL="select * from CustomerDc where sectionno='"+SecNo+"'";
ResultSet rs=ViewBean.executeQuery(SQL);	
 %>
<body oncontextmenu="return false" >
<form name=frm>
<input type=hidden name=SecNo value="<%=SecNo %>">
 
<table width="100%"><tr><td>调查项:<input type=text size=12 name=codes>&nbsp;<input type=button name=ok value="提交" onclick="savedata();"></td><td align="right"><input type=button name=ok value="打印" onclick="openwin1('PrintDcSetCode.jsp');">&nbsp;&nbsp;<input type=button name=ok value="复 制" onclick="copyData();"></td></tr></table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
  <tr align="center"  class=listtitle>
    <td width="10%">序号</td>
    <td width="20%">调查项</td>
	 <td width="65%">调查内容</td>
	  <td width="25%"> </td>
  </tr>
  <%
  int i=0;
   while (rs.next()){
     i++;
   %>
 <tr align="center">
    <td width="10%" ><%=i %></td>
    <td width="15%"><%=rs.getString("codeName") %></td>
	<td width="65%" align="left">
	<%
	 SQL="select  CodeValue,code from CustomerDcValue where dcCode="+rs.getString("code");
	 
	 ResultSet rs1=ViewBean1.executeQuery(SQL);	
    while (rs1.next()){
	    String codcename=rs1.getString("CodeValue");
		String code=rs1.getString("code");
	     %>
		   <input name="codcename" type="checkbox" value="<%=code %>" checked onclick="cancelChoose(this.checked,this.value);" ><%=codcename %> 
		 <% 
       }
	rs1.close();
	 %>
	
	</td>
	 <td width="30%"><a href="#" onclick="openwin1('DcSetCodeValue.jsp?SecNo=<%=SecNo %>&code=<%=rs.getString("code") %>',200,200,200,200);" title="添加内容"><img src="../images/edit.gif" border="0" ></a>&nbsp;<a href="#" onclick="if (confirm('确认吗？删除将连同内容一起删除'))window.location='DcSetCode.jsp?deletecode=<%=rs.getString("code") %>&SecNo=<%=SecNo %>';" title="删除调查项"><img src="../images/button_sc.gif" border="0" ></a>
	 </td>
  </tr>
  <%}
  rs.close(); %>
  
</table>


</form>
<script>
function savedata(){
  if (document.frm.codes.value=="")
   {alert("请填写数据项！");
   document.frm.codes.focus();
    return false;
   }
   document.frm.submit();
}
function cancelChoose(para,para1){
  if (!para&&confirm("确认删除此数据项吗？")){
     openwin1("deleteDcCode.jsp?SecNo=<%=SecNo %>&code="+para1,10,10,10,10);
    
  }

}
function copyData(){
      openwin1("copy_cus_dc.jsp",500,150,100,100);
 
}
</script>

</body>
</html>
