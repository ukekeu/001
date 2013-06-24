<%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "java.sql.*,java.util.*" %>
<%@ include file="../jsp/public_js/checktime.jsp"%>
 <jsp:useBean id = "Bean" scope = "page" class = "ConnDatabase.SDatabase" />
 <jsp:useBean id = "Bean1" scope = "page" class = "ConnDatabase.SDatabase" />
  <%@ include file="../jsp/public_js/getByteOut.jsp"%>
 <%
 String id=request.getParameter("id");
 String csname="",tusername="",fusername="",fuserid="",subject="";
 String sql="Select * from imail_message where id="+id;
  String filename="";
   ResultSet rs=Bean.executeQuery(sql);
  sql="update oa_mail_state set leave=1 where main_id="+id;
	 if (rs.next()){ 
	 String txt=rs.getString("body");
	 filename= rs.getString("filename");
	  ResultSet rs1=Bean1.executeQuery( "Select name from CortrolMan where serialno='"+rs.getString("fuserid")+"'");
		 if(rs1.next()){
		 fusername=rs1.getString("name");
		 }
		 rs1.close();
  %>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>阅读邮件信息</title>
<LINK href="green.css" rel=stylesheet type=text/css>
<script language="javascript">

function change(nn,imgobj) {
if (document.images){
eval('document.images.'+nn+'.src="'+imgobj+'"');

}
}
function openwin(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"newwin","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
</script>
</head>

<body oncontextmenu="return false" >

<table width="100%" cellspacing cellpadding height="100%">
 
  <tr>
    <td width="100%" height="27" style="background-image: url('images/yellowwg/maildi.gif'); background-repeat: repeat-x" align="right" valign="top">
      <table width="235" cellspacing cellpadding>
<tr>
<td width="8"></td>
<td width="70">
<p 
onmouseout="change('img4','images/yellowwg/mm04.gif')" 
onmouseover="change('img4','images/yellowwg/mm04k.gif')"><a href="../jsp/manager/deleteMail.jsp?id=<%=id%>"><img border="0" src="images/yellowwg/mm04.gif" name=img4></a></td>
<td width="8"></td>
<td width="70">
<p 
onmouseout="change('img5','images/yellowwg/mm05.gif')" 
onmouseover="change('img5','images/yellowwg/mm05k.gif')"><a href="../jsp/manager/deleteMail1.jsp?id=<%=id%>"><img border="0" src="images/yellowwg/mm05.gif" name=img5></a></td>
<td width="8"></td>
<td width="8"></td>
<td width="70">
<p 
onmouseout="change('img1','images/yellowwg/mm01.gif')" 
onmouseover="change('img1','images/yellowwg/mm01k.gif')"><a href="../jsp/edit/sendmessage1.jsp?&bodyid=<%=id%>&resendto=<%=id%>;"><img border="0" src="images/yellowwg/mm01.gif" name=img1></a></td>
<td width="8"></td>
<td width="8"></td>
<td width="70">
       <p 
      onmouseout="change('img2','images/yellowwg/mm02.gif')" 
	onmouseover="change('img2','images/yellowwg/mm02k.gif')"><a  href="../jsp/edit/sendmessage1.jsp?tuserid=<%=rs.getString("fuserid")%>&bodyid=<%=id%>&tusername=<%=tusername%>&fusername=<%=fusername%>&tcsname=<%=csname%>&subject=re：<%=rs.getString("subject")%>"><img border="0" src="images/yellowwg/mm02.gif" name=img2></a></td>
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
  <tr class="bgcolor2"> 
    <td width="100%" height="100%" valign="top" align="center"> 
      <%
	
		
rs1=Bean1.executeQuery( "Select name from oa_mail_state  where main_id="+id);
		 while (rs1.next()){
		    if (!tusername.trim().equals(""))
		      tusername+=","+rs1.getString("name");
		    else
			  tusername=rs1.getString("name"); 
		 }
		 rs1.close();
%>
      <table width="95%" cellspacing="1" cellpadding align="center" height="100%">
        <tr class="bgcolor4"> 
          <td width="60" align="center"><font color="#FFFFFF">发件人</font></td>
          <td colspan="3"><font color="#FFFFFF"><%=fusername%></font></td>
        </tr>
        <tr class="bgcolor4">
          <td width="60" align="center"><font color="#FFFFFF">收件人</font></td>
          <td align="left" colspan="3"><a href="#" onclick="javascript:alert('收件人:<%=tusername%>');"><font color="#FFFFFF" title="收件人：<%=tusername%>"><%=tusername %> 
            <%if (tusername.length()>60 )%>
            ... 
           
            </font></a></td>
        </tr>
        <tr class="bgcolor4"> 
          <td width="60" align="center"><font color="#FFFFFF">抄送人</font></td>
          <td align="left" colspan="3"><a href="#" onclick="javascript:alert('抄送人:<%=csname%>');"><font color="#FFFFFF" title="抄送人:<%=csname%>"><%=csname %> 
            <%if (csname.length()>60 )%>
            ... 
           
            </font></a></td>
        </tr>
        <tr class="bgcolor4"> 
          <td width="60" align="center"><font color="#FFFFFF">时&nbsp; 间</font></td>
          <td width="151">&nbsp;<font color="#FFFFFF"><%=rs.getString("date")%></font></td>
          <td width="71" align="center"><font color="#FFFFFF">文件大小</font></td>
          <td width="72">&nbsp;<font color="#FFFFFF"  title="<%=txt.length()%>">
            <%if (txt.length()>1024){%>
            <%=txt.length()/1024%>k
            <%}else{%>
            <%=txt.length()%>字节
            <%}%>
            </font></td>
        </tr>
        <tr class="bgcolor4"> 
          <td width="60" align="center"><font color="#FFFFFF">标&nbsp; 题</font></td>
          <td width="307" colspan="3">&nbsp;<font color="#FFFFFF"><%=rs.getString("subject")%></font></td>
        </tr>
        <tr> 
          <td width="398" colspan="4" height="10"></td>
        </tr>
		<%if (!filename.equals("")){ %>
        <tr> 
          <td colspan="4" height="100%">附件
		  
		   <%StringTokenizer st22 = new StringTokenizer(filename,"&") ;
	         while (st22.hasMoreElements()) {
	         filename=(String)st22.nextElement();
			 if (filename.indexOf(".gif")>=0||filename.indexOf(".txt")>=0||filename.indexOf(".jpg")>=0) {
			 %>
			 <a href="<%=filename %>"  ><img src="../jsp/images/i_sign.gif" border=0></a>
	
			 <%
			 }else{
	  %>
	 
	 <a href="#" onclick="openwin('downFile.jsp?fileurel=imail/<%=filename %>',10,10,10,10);"><img src="../jsp/images/i_sign.gif" border=0></a>
	      <%}
	  }
	  } %>&nbsp;
		  </td>
        </tr>
        <tr> 
          <td height="200" colspan="4" bgcolor="#FFFFFF"> <iframe src="brief.jsp?id=<%=id%>" width="398" height="400" frameborder="0"></iframe> 
          </td>
        </tr>
     
		
      </table>
	  <%}
	 
	  rs.close(); 
	  
	  Bean.executeUpdate(sql);
	  %>