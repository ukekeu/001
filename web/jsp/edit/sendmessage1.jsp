<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,common.*,java.util.*,java.util.Date" %> 
 <jsp:useBean id = "Bean" scope = "page" class = "ConnDatabase.SDatabase" />
 
  <%@ include file="../public_js/Repalce.jsp"%>
  <%@ include file="../public_js/getByteOut.jsp"%>
 <%String SQL="select body,subject,filename from imail_message where id="+request.getParameter("bodyid");
 ResultSet rs=Bean.executeQuery(SQL);
 String body="原邮件：<br>";
  String title="回复:";
    String filename="";
 if(rs.next()){
 body+=rs.getString("body");
 title+=rs.getString("subject");
  filename=rs.getString("filename");
 }
 rs.close(); 
  %>
	  
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>转发邮件</title>
<link rel="stylesheet" href="../class/news.css" >
<script language="JavaScript">
function dod()
{
	if(window.event.keyCode==27) window.location.reload();
}

function op(e)
{
	window.open(''+e,null,'width=433,height=460,toolbar=no,scrollbars=no');
}
function aa()
{ 
 
	if(form1.tuser1.value=="")
	{
		alert("请选择收件人!");
		return false;
	}
	if(form1.subject.value=="")
	{
		alert("标题不能为空");
		return false;
	}
form1.submit();
}
function bb()
{
if(form1.subject.value=="")
  {
     alert("标题不能为空");
     return false;
  }
form1.pagename.value="dosave";
form1.submit();
}
</script>
</head>

<body topmargin="0" leftmargin="0"   >

    
       
<div align="center">       
  <center>       
    <table width="100%" cellspacing cellpadding >
      <tr>       
          
             
        <td width="1%" bgcolor="#FFFFFF">　</td>     
        <td width="80%" bgcolor="#FFFFFF" valign="top"> 
          <table width="100%" cellspacing cellpadding>     
          <tr>     
            <td width="100%" height="10"></td>     
          </tr>     
          <tr>     
            <td width="100%">     
              <table width="100%" cellspacing cellpadding>     
                  <form method="post" action="sendMail.jsp" name="form1"    ENCTYPE="multipart/form-data" >
                  <tr>  
                  <td width="100%" height="10" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>       
                </tr>  
               <tr>  
                  <td width="100%" height="10">  
                    
                        <table border="0" cellspacing="0" cellpadding="0" class="L2" width="98%" align="center">
                          <tr> 
                            <td colspan="2"><b> 
                              <input type="hidden" name="tuserid" value="<%=getbyte1(request.getParameter("tuserid"))%>">
                              <input type="hidden" name="pagename" value="send">
                              <input type="hidden" name="testsend" value="abc">
                              &nbsp;</b></td>
                          </tr>
                          <tr> 
                            <td width="80"> <b>&nbsp;&nbsp;收件人：</b></td>
                            <td> 
                              <input type="text" name="tuser1" size="70" readonly class="input4" value="<%=getbyte1(request.getParameter("fusername")) %>">
							  
							  <input type="button" name="sendman1" value="选择" onClick="window.open('../sys/user_tree.jsp?selectman=form1.tuser1','f','menubar=no,scrollbars=yes,width=600,height=460,left=150,top=50')">
                            </td>
                          </tr>
                           <tr> 
                            <td width="80"> <b>&nbsp;&nbsp;抄&nbsp;&nbsp;送：</b></td>
                            <td> 
                              <input type="text" name="tuser2" size="70" readonly class="input4">
                           
							  <input type="button" name="sendman2" value="选择" onClick="window.open('../sys/user_tree1.jsp?selectman=form1.tuser2','','menubar=no,scrollbars=yes,width=600,height=460,left=150,top=50')">
                            </td>
                          </tr>
                          <tr> 
                            <td width="80"> <b>&nbsp;&nbsp;暗&nbsp;&nbsp;送：</b></td>
                            <td> 
                              <input type="text" name="tuser3" size="70" readonly class="input4">
                          
							  <input type="button" name="sendman3" value="选择" onClick="window.open('../sys/user_tree2.jsp?selectman=form1.tuser3','','menubar=no,scrollbars=yes,width=600,height=460,left=150,top=50')">
                            </td>
                          </tr>
                          <tr> 
                            <td width="80"> <b>&nbsp;&nbsp;主&nbsp;&nbsp;题：</b></td>
                            <td> 
                              <input type="text" name="subject" size="70" value="<%=title %>" class="input4">
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="2"> <b>&nbsp;&nbsp;正&nbsp;&nbsp;文：</b></td>
                          </tr>
                          <tr> 
						     <td width="80">&nbsp;</td>
                            <td  > 
						  	<INPUT type="hidden" name="content1" value="<%=body %>">
		                 <IFRAME ID="eWebEditor1" src="ewebeditor.jsp?id=content1&style=coolblue" frameborder="0" scrolling="no" width="550" height="350"></IFRAME>
	                   
						 
                      </td>
                            <td>
							 
		 
							 
                            </td>
                          </tr>
                                         <tr>
          <td  class=roomleft >&nbsp; 附   件：</td>
          <td  class=roomright>
		  <input type="file" name="Map1"  size=10>
		  
		  <input type="file" name="Map2"  size=10>
		 
		  <input type="file" name="Map3" size=10 >
		  </td>   
        </tr>
                 <tr> 
                            <td colspan="2">上载文件类型:jpg,doc,xsl,rar类型，其他类型可能下载不了.</td>
                          </tr> 
                          
                        </table>
                  </td>       
                </tr>  
              </table>        
            </td>        
          </tr>        

        </table>       
      </td>       
    </tr>   
  </table>   
  </center>  
 <input type="hidden" name="zf_file" value="<%=filename %>">
   <input type="button" name="dosend" value="发 送" onClick="aa()"><input type="button" name="dodsend" value="退 出" onClick="window.close();"> 
</div>   
 </form>
</body>        
        
</html>        
