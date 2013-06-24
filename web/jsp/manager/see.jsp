<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 

<jsp:useBean id="Bean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
 
 <%@ include file="../public_js/getByteOut.jsp"%>
<%
  
  
		String  sql="";
	 
		try{
		 
				
	sql="select face, subject,redate,date,writerid,body from community_forum where  id="+request.getParameter("id");
	 ResultSet rs=aBean1.executeQuery(sql);
	 String subject="";
	 String face="";
	 String writer="";
	 String date="";
	  String Sbody="";
	  String redate="";
	  String loginuserid=(String)session.getAttribute("loginname");
	 
	 if (rs.next()){
		 face=rs.getString(1);
		 subject=rs.getString(2);
		 redate=getbyte(rs.getString(3));
		 date=rs.getString(4);
		 writer=getbyte(rs.getString(5));
	     Sbody=getbyte(rs.getString("body"));
		 
	 }
	 rs.close();
 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>查看帖子</title>
<LINK href="yellow.css" rel=stylesheet type=text/css>
<script language="JavaScript">
function dosubmit()
{
	if(form1.Message.value=="")
	{
		alert("内容不能为空");
		return false;
	}
}
function change(nn,imgobj) {
if (document.images){
eval('document.images.'+nn+'.src="'+imgobj+'"');
}}
//插入UBB代码

 
</SCRIPT>

</head>

<body oncontextmenu="return false" >
<form method="post" action="see_action.jsp" name="form1" >
<div align="right">
<INPUT type=submit name=b11 value="保 存"> 
 
	<INPUT type=button name=b31 value="退 出" onclick="window.close();"> </div>
<table width="100%" cellspacing cellpadding>
 
  <tr>
    <td width="100%" height="100%" valign="top" align="center">
      <br>
        <table width="95%" cellspacing="1" cellpadding>
          <tr>
          <td width="80"  bgcolor="#EAF2F0">　标　　题：</td>
            <td colspan="3">&nbsp;<%=subject%>&nbsp;</td>
        </tr>
        <tr>
            <td width="80" bgcolor="#EAF2F0">　作　　者：</td>
            <td colspan="3">&nbsp;<%=writer%><img src="../../bbs/images/face<%=face%>.gif">&nbsp;</td>
        </tr>
        <tr>
            
            <td width="80" bgcolor="#EAF2F0">　发表时间：</td>
            <td>&nbsp;<%=date%><%if (loginuserid.equals(writer)){ %>
				 
				<a href="delete_bbs_action.jsp?id=<%=request.getParameter("id")%>">删除</a>
			<% }%></td>     
			
        </tr>     
      </table>     
      <table width="95%" cellspacing="1" cellpadding>     
        <tr>     
          <td   align="center">     
            <table width="100%" cellspacing cellpadding>
                <tr>    
                <td width="100%"><%=Sbody%></td>    
				</tr>
				
            </table>    
          </td>    
        </tr>    
      </table>    
      <table width="95%" cellspacing="1" cellpadding>
          <%sql="select face, subject,redate,date,writerid,body,id from community_forum  where parent="+request.getParameter("id")+" order by date";
     
	  rs=Bean.executeQuery(sql); 
	%> 
        <tr> 
            <td width="100%" height="25"><b>回复帖子：</b></td>
        </tr>
         <%while (rs.next()){
	         face=rs.getString(1);
			 subject=rs.getString(2);
			 redate=getbyte(rs.getString(3));
			 date=rs.getString(4);
			 writer=rs.getString(5);
		     Sbody=rs.getString(6);
			 
			 String id=rs.getString(7);
			%>
        <tr> 
            <td width="100%" >　<img src="../../bbs/images/face<%=face%>.gif">　回复人：<%=writer%>（<%=redate%>）&nbsp;
			<% if (loginuserid.equals(writer)){ %>
		 		<a href="delete_bbs_action.jsp?id=<%=id%>">删除</a>
			<% }%>
			</td>
		</tr>
		<tr>
		</tr>
        <tr> 
          <td width="100%" bgcolor="#EAF2F0">
		  <%=Sbody %></td>
        </tr>
		 
          <%
			}
			rs.close();
	 
	%> 
      </table>
	    <table width="95%" cellspacing="1" cellpadding>
        <tr>
            <td width="100%" height="25">　<b>我要回复：</b></td>
        </tr>
		 
<tr>
	<td width="100%" height="25">
	   <input type="hidden" name="ids" value="<%=request.getParameter("id")%>">
            <input type="hidden" name="forumid" value="119>">
            <input type="hidden" name="pagename" value="see">
<TABLE border="0" cellpadding="2" cellspacing="1">
<TR>
	 
	<TD>
		<INPUT type="hidden" name="content1" value="">
			<IFRAME ID="eWebEditor1" src="../edit/ewebeditor.jsp?id=content1&style=coolblue" frameborder="0" scrolling="no" width="650" height="350"></IFRAME>
	   </TD>
</TR>
<tr><td>
 <table width="502" border="0" cellpadding="0" cellspacing="0" align="center">
              <tr> 
                <td width="502" ><br>
                
                    <input type="radio" name="face" value="1" checked>
              <img src="../../bbs/images/face1.gif" ><%for (int i=2 ;i<= 40;i++){%> 
              <input type="radio" name="face" value="<%=i%>">
              <img src="../../bbs/images/face<%=i%>.gif"><%}%></td>
              </tr>
            </table>
			</td></tr>
<TR>
	<TD  align=right>
	<INPUT type=submit name=b1 value="保 存"> 
 
	<INPUT type=button name=b3 value="退 出" onclick="window.close();"> 
	</TD>
</TR>
 </table>
		</td>
</tr>
       
</table>
    <% }catch(Exception s){out.print(s+sql);} %>
</form>
</body>

</html>
