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
   <jsp:useBean id="aBean2" scope="page" class="ConnDatabase.SDatabase" />
   <%@ include file="../public_js/getByteOut.jsp"%>
<body oncontextmenu="return false" >
<%!
	public String getParameter(javax.servlet.http.HttpServletRequest request,String para)
								throws Exception  {
		String temp = "";
		temp = request.getParameter(para);
		if (temp == null)
			temp = "";
		temp = new String(temp.getBytes("iso-8859-1"));
		return temp;	
	}
%>
<script language="javascript" src="../public_js/public.js"></script>
<%
 String Stype="";
 String Scodeno="";
 String Scodename="";
 String StrSql="";
 StrSql=" select * from CortrolMan  ";
 ResultSet rs=null;
int i=0;
int n=0;
 %>
<center>
更换用户密码
<br><br>
<table align=center  BORDER=0 width="80%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#000000" class="tablefill">
  <tr align="center">
 
	<td  >用户ID</td> 
	<td  >设置权限</td>
	<td  >密码操作</td>
  </tr>
  
  <%    
  try{
    rs=aBean.executeQuery(StrSql);
    while (rs.next()){
        i++;
	    n++;     
        int id=rs.getInt("id");
        String SerialNo=rs.getString("SerialNo");
        String Name=getbyte(rs.getString("Name"));
        String tel=getbyte(rs.getString("tel"));
        String job=getbyte(rs.getString("job"));
  %>  
 <tr align=center id=TR<%= i %> Onclick="Butcolo(this,'#EAECEC','#ffffff');savepara('<%= id %>')"">
    <td>
     <%= SerialNo %>
    </td>
	<td align=left>
	 <a href="modulelist.jsp?id=<%=SerialNo%>">
	  设置权限
	 </a>&nbsp;
	 <a href="usermodulelist.jsp?SerialNo=<%=SerialNo%>">
	  查看权限
	 </a>
   </td>
   	<td  ><a href="#" onclick="openwin('set_password.jsp?userid=<%=SerialNo %>&user=<%=Name %>',300,200,120,120);">更换密码</a></td>
 </tr>
 
  <%}
 }catch(Exception s){out.println(s.getMessage());out.print(StrSql);}
  
  rs.close(); %>
  
</table>

</center>
<script>
var RSID="";
function savepara(id){
    RSID=id;
}
function delSeller(id) {
    if( id == "" ) {
        alert( "请选中一位操作员!" ) ;
        return false ;
    }
    if ( confirm("确实想删除该条记录?")) {
    	window.location = "savecortrolman.jsp?id=" + id;
    }
}
	
</script>

</body>

</html>
