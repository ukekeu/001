<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>�����б�</title>

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
		if ( confirm("ȷʵ��ɾ��������¼?"))
			window.location = "savecortrolman.jsp?id=" + id;
	}
	
function Changesubmit(){
  document.form1.action="modulelist.jsp";
  document.form1.submit() ;
}


function f_setQuan( )
{
    if( document.forms[ 0 ].ModuleName.options[ document.forms[ 0 ].ModuleName.selectedIndex ].value == "" ) {
        alert( "��ѡ����ģ��!" ) ;
        return ( false ) ;
    }
    if (document.forms[ 0 ].manstate.options[document.forms[ 0 ].manstate.selectedIndex].text=="")
    {
    	alert("��ѡ��Ȩ�����ԣ�");
        document.forms[ 0 ].manstate.focus();
        return (false);
    }
    
    if (document.forms[ 0 ].section.value.length<1)
    {
    	alert("��ѡ��¥��(�����ѡ���Ȱ�סCtrl�����¥����)��");
        document.forms[ 0 ].section.focus();
        return (false);
    }    
    document.forms[ 0 ].action = "savepopedom.jsp" ;
    document.forms[ 0 ].submit() ;   
}

function f_jian() 
{
    if( document.forms[ 0 ].ModuleName.options[ document.forms[ 0 ].ModuleName.selectedIndex ].value == "" ) {
        alert( "��ѡ����ģ��!" ) ;
        return ( false ) ;
    }
    document.forms[ 0 ].action = "modu_drop_power.jsp" ;
    document.forms[ 0 ].submit() ;
}
</script>
<table><tr><td>

��ģ�飺
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
  </select> &nbsp;<br>����Ȩ��:<br>
  <INPUT TYPE=CHECKBOX VALUE=A name=add checked>���&nbsp;<INPUT TYPE=CHECKBOX VALUE=E name=edit checked>�޸�<br>
  <INPUT TYPE=CHECKBOX VALUE=D name=dele checked>ɾ��&nbsp;<INPUT TYPE=CHECKBOX VALUE=F name=find checked>����   
		 </select><br>����:<select name=manstate>
	     <option></option>
	     <option value=0>˽��</option>
   	     <option value=1>����</option>
		 </select>
		 </td><td valign=top>&nbsp;ָ��¥�̣�<br>
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
	<td  >��ģ������</td>
    <td  >�Ƿ�ʹ��</td>
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
 <input type=button name=setQuan value="����Ȩ��" onclick="f_setQuan( )">
 &nbsp;&nbsp;
 <input type=button name=jianShao value="ȥ��Ȩ��" onclick="f_jian()">
 &nbsp;&nbsp;
 <input type=button name=b1 value="  �˳�  " onclick="javascript:document.location.href='cortrolman.jsp'">
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
