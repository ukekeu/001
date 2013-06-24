  <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
    <%@ include file="../public_js/getByteOut.jsp"%>
<%
	 
 	  String sContent1=getbyte1(request.getParameter("content1"));
	     String pagename=getbyte1(request.getParameter("pagename"));
	
 
	if (!pagename.equals("")) {
			String SQL="INSERT INTO news(newstitle,newstxt,newsdate,enddate,checker,type,reads) values('" ;
		    SQL+=getbyte1(request.getParameter("subject"))+"','"+sContent1+"',getdate(),'"+getbyte1(request.getParameter("enddate"));
			SQL+="','"+(String)session.getAttribute("loginname")+"',1,1)";
            ViewBean.executeUpdate(SQL); 
			 ViewBean.executeUpdate("DELETE news WHERE newstxt='' ");
			 
%>
<script language="JavaScript">
alert("添加成功");
opener.window.location="view_news.jsp?pagename=1";
window.close();
</script><%
			
 out.close();
	}

%>
<html>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>发布新闻</title>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language="javascript">
function dosubmit()
{
if (confirm("确认吗?")){
	if(form1.subject.value=="")
	{
		alert("公告标题不能为空");
		form1.subject.focus();
		return false;
	}
	 
 
	document.form1.submit();
	 
	}
}
</script>
</head>

<body topmargin="0" leftmargin="0">

      
       
<div align="center">       
  <center>       
  <table width="100%" cellspacing cellpadding>       
    <tr>       
        
        <td width="1%" bgcolor="#FFFFFF"></td>     
        <td width="79%" bgcolor="#FFFFFF" valign="top"> 
          <table width="100%" cellspacing cellpadding>     
          <tr>     
            <td width="100%" height="10"></td>     
          </tr>     
          <tr>     
            <td width="100%">     
              <table width="100%" cellspacing cellpadding>     
                  
                <tr>  
                    <td width="100%" height="10"> 
                      <form method="post" action="addnews.jsp" name="form1" >
                        <table width="98%" align="center" cellpadding="0" cellspacing="1" class="bgcolor3">
                          <tr> 
                            
                            <td> 
                              <div align="right">在</div>
                            </td>
                            <td><input  type=text name=enddate  size=12  ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(enddate);" title="请选择认购日期">
                              之前有效  </td>
                          </tr>
                          <tr> 
                            <td> 
                              <div align="right">标题：</div>
                            </td>
                            <td colspan="3"> 
                              <input type="text" name="subject" size="65" maxlength="100">
                            </td>
                          </tr>
                          　
                          <tr> 
                            <td valign="top"> 
                              <div align="right">内容：</div>
                            </td>
                            <td colspan="3"> 
							  <INPUT type="hidden" name="content1" value="">
			<IFRAME ID="eWebEditor1" src="../../edit/eWebEditor.jsp?id=content1&style=standard" frameborder="0" scrolling="no" width="650" height=320"></IFRAME>
	
                            
                            </td>
                          </tr>
                          
                          <tr align="center"> 
                            <td colspan="4"> <br>
							&nbsp;<input type=button name=pxp value=" 发 布 " onclick="dosubmit();">
                                <input type="hidden" name="pagename" value="addnews">
								<input type=button name=pxp value=" 退 出 " onclick="window.close();">
                                      </td>
                          </tr>
                        </table>
                      </form>
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
</div>   
<div align="center">   
 
</div>        
        
</body>        
        
</html>        
