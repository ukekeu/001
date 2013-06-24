<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "公司资料" , 
                  "浏览"
                ) ;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>使用客户资料登记</title>
</head>

<%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<body oncontextmenu="return false" >
<script language="JavaScript" src='../public_js/public.js'></script>

<%@ include file="../public_js/getByteOut.jsp"%>
<%String SQL="";
  String companyname="";
  String companytel="";
  String companyaddr="";
  String companyman="";
  String companypost="";
  String eof="false";
  String save=China.getParameter(request,"save");
  String dele=request.getParameter("dele");
  if (dele==null)dele="";
  
  if (!dele.equals("")){
   SQL="";
   try{
    setlog( setlogBean , 
                      ( String )session.getAttribute( "loginid" ) ,
                      "公司资料" , 
                      "删除"
                    ) ;
      int rows = new Integer( request.getParameter("rows") ).intValue();	
	int a[] = new int[rows];
	String sql = "";
	String sql2 = "" ;
	boolean succ= true;	
	
	for( int i=0 ; i<=rows ; i++ ){
		String sTid = request.getParameter("ic" + i);
	 if( sTid!= null ) {
			sql = "delete company where id = " + sTid;
			
			int temp = aBean.executeUpdate(sql);
			
			if( temp == 0 ) {
				succ = false;
			}
		}
	}						
  
   }catch(Exception s){out.print(s.getMessage());}
  } %>
  
  <form name=form1>
 <p  class=BT align="center"> 公司资料一览表</P>
 <table width=100% border="0">
  <tr height="16" bgcolor="#EAEAEA">
   <td align="left">
 
     <input type=button name=add value="增 加" onclick="window.open('add_company.jsp','er','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=450,height=350');">
  
 <!--
     <input type=button name=modi value="修 改"  onclick="zhuEdit();">
  -->
    <input type=button name=del value="删 除"  onclick="delcompany();"> 
   
   </td>
  </tr>
 </table>
 <table border=0 width=100% align=center id=AutoNumber cellspacing=1 cellpadding=1 >
   <tr class=listtitle>
 <td></td>  
 <td>公司名称</td><td>地址</td><td>电话</td><td>传真</td><td>公司法人</td><td>邮件</td><td>修改</td></tr>
<%int u=0;
  SQL="SELECT id,companyname,companytel,companyfax,companyaddr,";
	 SQL+="companyman,zip_code FROM company ";
      ResultSet LIST=aBean.executeQuery(SQL);
	  while (LIST.next()){
	  u++;
	   String id=LIST.getString("id");
	  %>
		<tr class='listcontent'><td><input type=checkbox name=ic<%= u%>   onclick="choosedata('<%=u %>',this.checked);" value="<%=id %>"></td><td><%=getbyte(LIST.getString("companyname")) %></td><td><%=getbyte(LIST.getString("companyaddr")) %></td><td><%=getbyte(LIST.getString("companytel")) %></td><td><%=getbyte(LIST.getString("companyfax")) %></td><td><%=getbyte(LIST.getString("companyman")) %></td><td><%=getbyte(LIST.getString("zip_code")) %></td><td><a href="#"  onclick="window.open('modi_company.jsp?id=<%=id %>','er','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=450,height=350');"> 修改</a></td></tr>
	  <% }
	  LIST.close();
	  if (u==0){
	    aBean.executeUpdate("delete user_reg");
	  
	  }
	  %>
	  </table>
</center>
  <input type=hidden name=rows value=<%= u%> >
  <input type=hidden name=dele>
</form>
<script>
function choosedata(para1,para2) {
     var x=0;
 
	 var seldocs = new Array();
	 var temp=form1.elements.length;
     for (i=0;i<form1.elements.length;i++) {
       if ((form1.elements[i].type=="checkbox")&&(form1.elements[i].name=="ic"+para1))
		 { 
	 		 form1.elements[i].checked=para2;
 
   		 }
		 
    }
}	
 function delcompany(){
     if (confirm("确认删除吗?")){
   document.form1.action="company.jsp?del=yes";
 
   document.form1.dele.value="ok";
   document.form1.submit();
   }
 }
 
 function save1(){
   document.form1.submit();
 }
</script>
</body>

</html>
