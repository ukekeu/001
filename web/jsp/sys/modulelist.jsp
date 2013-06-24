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
 String id=request.getParameter("id");

 String ChangeModule=request.getParameter("ModuleName");
 if (ChangeModule==null)ChangeModule="";
 StrSql="select MModuleNo,MModuleName from ModuleCortrol  where MModuleNo<>'' and MModuleName<>'' group by MModuleNo,MModuleName"; 
 ResultSet rs=null;
 int i=0;
 %>
<center>
<body  oncontextmenu="return false" onload="setSelectMad(document.form1.ModuleName,'<%=ChangeModule%>');">
<form name=form1 method=post >
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
  document.form1.action="modulelist.jsp";
  document.form1.submit() ;
}


function f_setQuan( )
{
    if( document.forms[ 0 ].ModuleName.options[ document.forms[ 0 ].ModuleName.selectedIndex ].value == "" ) {
        alert( "请选择主模块!" ) ;
        return ( false ) ;
    }
    if (document.forms[ 0 ].manstate.options[document.forms[ 0 ].manstate.selectedIndex].text=="")
    {
    	alert("请选择权限属性！");
        document.forms[ 0 ].manstate.focus();
        return (false);
    }
    
    if (document.forms[ 0 ].section.value.length<1)
    {
    	alert("请选择楼盘(如果多选请先按住Ctrl按点击楼盘名)！");
        document.forms[ 0 ].section.focus();
        return (false);
    }    
    document.forms[ 0 ].action = "savepopedom.jsp" ;
    document.forms[ 0 ].submit() ;   
}

function f_jian() 
{
    if( document.forms[ 0 ].ModuleName.options[ document.forms[ 0 ].ModuleName.selectedIndex ].value == "" ) {
        alert( "请选择主模块!" ) ;
        return ( false ) ;
    }
    document.forms[ 0 ].action = "modu_drop_power.jsp" ;
    document.forms[ 0 ].submit() ;
}
</script>
<table><tr><td>

主模块：
<select name=ModuleName onChange="Changesubmit();"> 
<option></option>
<%try{
   rs=aBean.executeQuery(StrSql);
  
   while (rs.next()){
   String MModuleNo=rs.getString("MModuleNo");
   String MModuleName=getbyte(rs.getString("MModuleName"));
  %>
  <option value="<%=MModuleNo %>"><%=MModuleName %>
  
   <%}
  }catch(Exception s){out.println(s.getMessage());out.print("SystemError"+StrSql);}
  
  rs.close(); %>
  </select> &nbsp;<br>分配权限:<br>
  <INPUT TYPE=CHECKBOX VALUE=A name=add checked>添加&nbsp;<INPUT TYPE=CHECKBOX VALUE=E name=edit checked>修改<br>
  <INPUT TYPE=CHECKBOX VALUE=D name=dele checked>删除&nbsp;<INPUT TYPE=CHECKBOX VALUE=F name=find checked>查找   
		 </select><br>属性:<select name=manstate>
	     <option></option>
	     <option value=0>私有</option>
   	     <option value=1>公共</option>
		 </select>
		 </td><td valign=top>&nbsp;指定楼盘：<br>
		 <select name="section"  multiple style="border-style: solid; border-width: 1"> 
         <%
		 try{
         rs=aBean.executeQuery("select SerialNo,name from section");
         while (rs.next()){
            String No=rs.getString("SerialNo");
            String Name=getbyte(rs.getString("name"));
			out.print("<option value="+No+">"+Name+"</option>");
		 }
		 }catch(Exception s){}
		  %>
         </select>
		 </td></tr></table>
  <p>
 
<table BORDER=0 width="70%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#000000" class="tablefill">
    <tr>
	<td  >子模块名称</td>
    <td  >是否使用</td>
  </tr>
 <%if (!ChangeModule.equals("")){ 
   StrSql="select CModuleNo,CModuleName from ModuleCortrol where NEXUS='C' and MModuleNo='"+ChangeModule+"'";

    int ii=1;
  try{
   rs=aBean.executeQuery(StrSql);

   while (rs.next()){
   String CModuleNo=getbyte(rs.getString("CModuleNo"));
   String CModuleName=getbyte(rs.getString("CModuleName"));
  %>
    <tr><input type=hidden name=ModuleNo<%=ii %> value="<%=CModuleNo %>">
	<td  ><%=CModuleName %></td>
    <td  ><input type=checkbox name=popedom<%=ii %> value=1 checked>
	  
	</td>

  </tr>
   <%
   ii++;
   }
  }catch(Exception s){out.println(s.getMessage());out.print(StrSql);}
  
  rs.close();
  %>
    
<input type=hidden name=Count value=<%=ii-1 %>>

<% } %>
  <%
// aBean1.ShowConnNum();
// aBean.ShowConnNum();
// aBean1.freeCon();//free conntion
// aBean.freeCon();//free conntion
  %>
</table>
 <p align=center>
 <input type=button name=setQuan value="设置权限" onclick="f_setQuan( )">
 &nbsp;&nbsp;
 <input type=button name=jianShao value="去除权限" onclick="f_jian()">
 &nbsp;&nbsp;
 <input type=button name=b1 value="  退出  " onclick="javascript:document.location.href='cortrolman.jsp'">
 </p>
 
 <input type=hidden name="id" value=<%=id %>>
 
 <%
 String zid = request.getParameter("zid") ;
 if(  zid != null ) {
 	%>
	<input type=hidden name="zid" value=<%= zid%> >
	<%
 }
 %>


</form>
</center>

</body>

</html>
