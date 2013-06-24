<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>

<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
   <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>修改文档信息</title>
</head>


<script language="javascript" src="../public_js/public.js"></script>
 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

	 
<script>
function check(aForm){
   if (aForm.title.value.length<1)
	  	{
	   	alert("请输入主题！");
	     aForm.title.focus();
	     return (false);
	   }	
  
      
 return (true);
}
</script>
<body> 
<p align=center><font size=3 class=FontColor><b>文档信息</b></font></p>
<form method="POST" name="cus" action="modi_knowledge_at.jsp" onsubmit="return check(this);"  ENCTYPE="multipart/form-data">
<table width="100%" border="0" cellspacing="1"  cellpadding="1" >
 
  <%
   String  id=request.getParameter("id");
   String SQL="select type,title,text,adjunct from knowledge_data where id="+id;
   String my_id="";
   try{
    ResultSet rs=null;
   ViewBean.executeUpdate("update knowledge_data set see_num=see_num+1 where id="+id);
   rs=ViewBean.executeQuery(SQL);
   
   if (rs.next()){
   String type=getbyte(rs.getString("type"));
  
   %>
 <tr><input type=hidden name=id value="<%=id %>">
    <td width="15%" class=roomleft >&nbsp;类 别</td>
    <td width="75%" class=roomright>
	<select name=type>
	<option value="<%=type %>"><%=type %></option>
	<%String StrSql="select type from knowledge_type where user_id like '%"+(String )session.getAttribute( "loginid")+"%'";
	 ResultSet codeRS=ViewBean1.executeQuery(StrSql);
     
     while (codeRS.next()){
	   type=getbyte(codeRS.getString("type"));
       out.print("<option value='"+type+"' >"+type+"</option>");
	 
   }
   codeRS.close();
 %>
	</select>
	　</td>
  </tr>
  <tr>
    <td width="15%"class=roomleft>&nbsp;主    题</td>
    <td width="75%"class=roomright>
  
          <input type=text   name="title"  readonly value="<%=getbyte(rs.getString("title")) %>">         
       </td>
	   </tr>
	   <tr>
          <td width="15%"class=roomleft >&nbsp; 正   文</td>
          <td width="75%"class=roomright>
		  <INPUT type="hidden" name="content1" value="<%=getbyte(rs.getString("text")) %>">
			 <IFRAME ID="eWebEditor1" src="../edit/ewebeditor.jsp?id=content1&style=coolblue" frameborder="0" scrolling="no" width="550" height="350"></IFRAME>
	   
		  </td>   
        </tr>
      <tr>
          <td width="15%"class=roomleft >&nbsp; 附   件</td>
          <td width="75%"class=roomright>
		  <input type="file" name="Map"  >
		  </td>   
        </tr>
		
</table>
<p>
<div align="center"> 
          <input type="button" value="收藏到文件夹" name="in" onclick="folder()">&nbsp;
            <input type="submit" value="提　交" name="submit" >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <input type="button" value="退  出" name="cancel" onclick="opener.window.location='knowledge_view.jsp';window.close();">
          </div>
</p>
<script>
function folder(){

window.location="my_folder_at.jsp?id=<%=id %>";
}

</script>
  </form>    
  <%}rs.close();
  }catch(Exception s){out.print(s);out.close();} %>   
</body>

</html>
