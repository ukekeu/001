<%@ page contentType="text/html;charset=GBK" import="java.sql.*," %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>权限修改</title>

</head>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
<center>
<body  oncontextmenu="return false">
<form name=f1 method=post >
<table>

<tr><td>
<%
String id = request.getParameter( "id" ) ;
String mm = request.getParameter( "mm" ) ;
String sqZN = "select mmodulename from vw_module where mmoduleno = '" + mm + "' " ;
ResultSet rsZN = aBean.executeQuery( sqZN ) ;
String mname = "" ;
if( rsZN.next() ) {
    mname = rsZN.getString( 1 ) ;
}
rsZN.close();
%>

主模块: <%= getbyte( mname ) %>

  <br>分配权限:<br>
  
 <%
 String sq = "select Cortrol , state , ManModuleCortrol.section "
           + " from ManModuleCortrol where SellerId='" + id + "'"
           + " and ManModule='" + mm + "' " ;
 ResultSet rs_sq = aBean.executeQuery( sq ) ;
 String quan = "" ;
 String state = "" ;
 String sec = "" ;
 if( rs_sq.next() ) {
    quan = rs_sq.getString( 1 ) ;
    state = rs_sq.getString( 2 ) ;
    sec = rs_sq.getString( 3 ) ;
 }
 rs_sq.close() ;
 
 %>
 
    <INPUT TYPE=CHECKBOX VALUE=A name=add  <% if( quan.indexOf("A") >= 0 ) { out.print( "checked" ) ; } %> >添加&nbsp;
    <INPUT TYPE=CHECKBOX VALUE=E name=edit <% if( quan.indexOf("E") >= 0 ) { out.print( "checked" ) ; } %> >修改<br>
    <INPUT TYPE=CHECKBOX VALUE=D name=dele <% if( quan.indexOf("D") >= 0 ) { out.print( "checked" ) ; } %> >删除&nbsp;
    <INPUT TYPE=CHECKBOX VALUE=F name=find <% if( quan.indexOf("F") >= 0 ) { out.print( "checked" ) ; } %> >查找
  
    <br>属性:
    <select name=manstate>
    <option value=0 <% if( state.equals( "0" ) ) { out.print( "selected" ) ; } %> >私有</option>
    <option value=1 <% if( state.equals( "1" ) ) { out.print( "selected" ) ; } %> >公共</option>
    </select>
    
    </td>
    
    <td valign=top>&nbsp;指定楼盘：<br>
    <select name="section"  multiple style="border-style: solid; border-width: 1"> 
    <%
    String sq_lp = " select serialno , name from Section " ;
    ResultSet rs_lp = aBean.executeQuery( sq_lp ) ;
    while( rs_lp.next() ) {
        String lpNo = rs_lp.getString( 1 ) ;
        String lpName = rs_lp.getString( 2 ) ;
    %>
        <option value=<%= lpNo%> <% if( sec.indexOf( lpNo ) >= 0 ) { out.print( "selected" ) ; } %> >
         <%= getbyte( lpName ) %>
        </option>
    <%
    }
    rs_lp.close();
    %>
    </select>
	</td>
	
   </tr></table>
   
  <p>
 
  <table BORDER=0 width="70%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#000000" class="tablefill">
    <tr>
	<td  >子模块名称</td>
    <td  >是否使用</td>
    </tr>
    <%
    String sq_sub_have = " select  ModuleNo from PopedomConrtrol where SellerId = '"
                         + id + "'and ManModuleNo = '" + mm + "' " ;
    ResultSet rs_sub_have = aBean.executeQuery( sq_sub_have ) ;
    String allSubHave = "" ;
    while( rs_sub_have.next() ) {
        String subNo = rs_sub_have.getString( 1 ) ;
        allSubHave = allSubHave + subNo + "***" ;
    }   

    String sq_sub_all = " select distinct cmoduleno , cmodulename from modulecortrol "
                       + " where mmoduleno = '" + mm + "' and nexus='c' " ;
                       
    //out.print( sq_sub_all + "<br>" );
    ResultSet rs_sub_all = aBean.executeQuery( sq_sub_all ) ;
    int rows = 1 ;
    while( rs_sub_all.next() ) {
        String sNo = rs_sub_all.getString( 1 ) ;
        String sName = rs_sub_all.getString( 2 ) ;
    %>   
        
       <tr>
        <input type=hidden name=ModuleNo<%= rows %> value="<%= sNo %>">
    	<td >
    	 <%= getbyte( sName ) %>
    	</td>
        <td >
         <input type=checkbox name=popedom<%= rows %> value=1 <% if( allSubHave.indexOf( sNo ) >= 0 ) { out.print( "checked" ) ; } %> >
    	</td>
       </tr>
    <%
        rows ++ ;
    }
    %>
<input type=hidden name=Count value=<%= ( rows - 1 ) %> >
<input type=hidden name=id value=<%= id %> >
<input type=hidden name=ModuleName value=<%= mm %> >
</table>

 <p align=center>
 <input type=button name=setQuan value="修改权限" onclick="f_setQuan( )">
 &nbsp;&nbsp;
 <input type=button name=b1 value="  退出  " onclick="javascript:window.close()">
 </p>
 


<script lang=javascript>
function f_setQuan(){
    document.forms[ 0 ].action = "quan_edit_a.jsp" ;
    document.forms[ 0 ].submit() ;     
}
</script>

</form>
</center>

</body>

</html>
