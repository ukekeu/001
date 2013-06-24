<%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id = "Bean" scope = "page" class = "ConnDatabase.SDatabase" />
 <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <%@ include file="../jsp/public_js/getByteOut.jsp"%>
 <%@ include file="../jsp/public_js/checktime.jsp"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>阅读BBS</title>
<LINK href="green.css" rel=stylesheet type=text/css>
<script language="javascript">

function change(nn,imgobj) {
if (document.images){
eval('document.images.'+nn+'.src="'+imgobj+'"');

}
}
 function delemail(){
  var aaa="";
  for (var aa=0;aaa<document.form1.fff.length();aa++){
   if (document.form1.fff[aa].checked)alert(document.form1.fff[aa].value);
  }

}
</script>
</head>

<body><form name=form1 method="post" >
<%@ include file="../jsp/public_js/countpagenum.jsp"%>
<table width="100%" cellspacing cellpadding  >
 
  <tr>
    <td width="100%" height="27" style="background-image: url('images/yellowwg/maildi.gif'); background-repeat: repeat-x" align="right" valign="top">
      <table width="235" cellspacing cellpadding>
<tr>
<!-- ddddddddddddd-->
<!-- 全部回复ddddddddddd-->

 <td width="8"></td>
 <td width="8"></td>
 <td width="8"></td>
 <td width="8"></td>
     <td width="8"></td>
          <td width="70">
            <p 
      onmouseout="change('img6','images/yellowwg/mm06.gif')" 
      onmouseover="change('img6','images/yellowwg/mm06k.gif')"><a href="#"  onClick="window.close()"><img border="0" src="images/yellowwg/mm06.gif" name=img6></a></td>
          <td width="10"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr > 
    <td width="100%"   valign="top" align="center"> 
      <%
	
  
String sql="";
 
   sql="select Top "+pageSize+"   * from  bbsview where   id  not in (Select top "+prenum +" id from  bbsview )  " ;
  sqlcount="SELECT count(id) code from bbsview  ";
 
  

ResultSet rs=null;
 
rs=Bean.executeQuery(sql);
%>

        <table width="100%" cellspacing="1" cellpadding=1 align="center" border="0">
        
		<%
      try{
					  while (rs.next()){
					  String   face=rs.getString("face");
					  String   subject=rs.getString("subject");
					  String   redate=getbyte(rs.getString("redate"));
					  if (!redate.equals(""))redate=redate.substring(0,redate.indexOf("."));
					  String   date=rs.getString("date");
					   String   writerid=rs.getString("writerid");
					   String redu=rs.getString("redu");
					   %>
                  <tr bgcolor="#ECF2F2"> 
                    <td colspan="2"> <img src="../bbs/images/face<%=face%>.gif"><a href="#" <a href="#" onClick="window.open('../jsp/manager/see1.jsp?forumid=1&id=<%=rs.getString("id")%>','','left=40,top=20,height=490,width=680,resizable=yes,scrollbars=yes');return false;" title="贴子主题:<%=rs.getString("subject")%>">
                     <%=rs.getString("subject")%>
					
				     [<%=writerid %>
                      <%if (redate.equals("")){ %>
					  &nbsp;New!
					  <%} %>]
                     <%if (!redate.equals("")){ %>
                   (最新回复: <%=redu %> 时间：<%=redate %>)
				   <%} %>
                  </a></td>
                  </tr>
                  <%}rs.close();
				   }catch(Exception s){} %>
     
      </table>
	 </td>
	 </tr>
	 </table>
	 
	      <%@ include file="../jsp/public_js/changepage.jsp"%>
		 