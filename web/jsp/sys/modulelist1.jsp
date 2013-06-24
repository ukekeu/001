<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>代码列表</title>
</head>
  <%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
   <%@ include file="../public_js/getByteOut.jsp"%>
<body  oncontextmenu="return false">
<%!
	public String getParameter(javax.servlet.http.HttpServletRequest request,String para)
								throws Exception  {
		String temp = "";
		temp = request.getParameter(para);
		if (temp == null)
			temp = "";
		temp = new String(temp.getBytes("iso-8859-1"));
		return temp;	//
	}
%>
<script language="javascript" src="../public_js/public.js"></script>
<%
 String Stype="";
 String Scodeno="";
 String Scodename="";
 String StrSql="";
 String id=request.getParameter("id");
 String ChangeModule=request.getParameter("ModuleName");
 if (ChangeModule==null)ChangeModule="";
 StrSql="select id,MModuleNo,MModuleName,URL,CModuleNo,case when active=1 then '启用' else '禁用' end activea from ModuleCortrol where nexus='P'"; 
 ResultSet rs=null;
 ResultSet rs1=null;
 int i=0;
 %>
<center>
<form name=form1 method=post action="">
<script>
var RSID="";
function savepara(id){
  RSID=id;
}
function delSeller(id) {
		if ( confirm("确实想删除该条记录?"))
			window.location = "savecortrolman.jsp?id=" + id;
	}
	
function Changesubmit(){
  document.form1.submit() ;
}
function checkdele(para){
   if ( confirm("确实想删除该子模块吗?"))
    window.location = "moduleset.jsp?no=" + para;
   
}
</script>
<table width="70%"><tr><td align="right">&nbsp;&nbsp;<input type=reset name=opeonmenu value="启用" onclick="openmenu();"><input type=reset name=closeloke value="禁用" onclick="lokemenu();"></td></tr></table>

<table BORDER=0 width="70%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#000000" class="tablefill">
    <tr ALIGN=CENTER>
    <td  width="15%" >模块名称</td>
	<td  width="35%">访问地址</td>
	<td  width="10%">状态</td>
	<td  width="15%">删除</td>
  </tr>
  
<%//try{
   rs=aBean.executeQuery(StrSql);
  int n=1;
  int ii=0;
   while (rs.next()){
   ii++;
   String MModuleNo=rs.getString("MModuleNo");
   String MModuleName=getbyte(rs.getString("MModuleName"));
   String ADDR=getbyte(rs.getString("Url"));
  %>
    <tr id=TR<%=ii %> ALIGN=CENTER Onclick="Butcolo(this,'#EAECEC','#ffffff');">
	<a href="javascript:detail('<%=n %>')" >
    <td   width="15%"><%=MModuleName %></td>
	<td  width="35%">&nbsp;</td>
	<td  width="10%"><%= rs.getString("activea")%></td>
   	</a>
	<td  width="15%" ><a href="javascript:checkdele('<%=rs.getString("CModuleNo") %>')">删除</a >&nbsp;<input name="choosemk" value="<%=rs.getString("id") %>" type="checkbox"></td>
	</tr>
 <tr><td  colspan="7">
      <div id="detail<%=n %>" style="display:none">
	    <table width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#000000" class="tablefill"> 
	  
   <%n++;
     StrSql="select CModuleName,Url,CModuleNo,id,case when active=1 then '启用' else '禁用' end activea from ModuleCortrol where MModuleNo='"+MModuleNo+"' and nexus='C'";
    
       rs1=aBean1.executeQuery(StrSql);
	     while (rs1.next()){
          out.print("<tr ><td  width='15%'>&nbsp;&nbsp;&nbsp;"+getbyte(rs1.getString("CModuleName"))+"</td><td width='35%'>&nbsp;&nbsp;"+getbyte(rs1.getString("Url"))+"</td>");
		  %>
		  		  <td width='10%' align='center' ><%= rs1.getString("activea")%></td>
		  <td width='15%' align='center' >
		  <a href="javascript:checkdele('<%=rs1.getString("CModuleNo") %>')">删除</a >&nbsp;<input name="choosemk" value="<%=rs1.getString("id") %>" type="checkbox"></td></tr>
	    <% }
		 rs1.close();
  
	
	 out.print("</table>");
	 %>
	<%
    out.print("</div></td></tr>");
}
  
  
  rs.close(); %>
</table>

</form>

<script>
 function openmenu(){
	 
	 
	 if (getseldocs2()==""){alert("选择启用的菜单");return false;}
	 
	  
	     if (confirm("确认启用吗"))
	   openwin1("yjCheck.jsp?state=1&code="+getseldocs2(),10,10,10,10);
	  
	 
	 }
	  function lokemenu(){
	 
	 
	 if (getseldocs2()==""){alert("选择禁用的菜单");return false;}
	 
	  
	     if (confirm("确认禁用吗"))
	   openwin1("yjCheck.jsp?state=0&code="+getseldocs2(),10,10,10,10);
	  
	 
	 }
   	 function getseldocs2() {
     var x=0;
	 var seldocs = new Array();
	 if (form1.choosemk.length){ 
       for (i=0;i<form1.choosemk.length;i++) {
         if (form1.choosemk[i].checked) 
		   { 
		    seldocs[x]=form1.choosemk[i].value ;
			x++;
   		   }
	    }	
	  }else  if (form1.choosemk.checked)
		 { 
		    seldocs[0]=form1.choosemk.value ;
 	     }

   return seldocs ;
}

</script>
</center>

</body>

</html>
