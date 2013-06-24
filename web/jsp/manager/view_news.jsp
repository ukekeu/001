  <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
    <%@ include file="../public_js/getByteOut.jsp"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>新闻一览  </title>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language="JavaScript">
<!--
function chkall()
{
	if(form1.del)
	{
		if(form1.del.disabled!=true) form1.del.checked=form1.checkall.checked;
		for(i=0;i<form1.del.length;i++)
		if(form1.del[i].disabled!=true) form1.del[i].checked=form1.checkall.checked;
	}
}
//-->
</script>
</head>

<body topmargin="0" leftmargin="0">

<div align="center">
<center>
 
</center>       
</div>       
       <%@ include file="../public_js/countpagenum.jsp"%>
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
                 
				  <%
				  String act=getbyte1(request.getParameter("act"));
				  if (!act.equals("")){
				  String sell="";
				  String  [] sells=request.getParameterValues("del");
				  if (sells!=null){
					for (int a=0;a<sells.length;a++){
					  if (sell.equals(""))  sell=getbyte1(sells[a]);
					  else sell+=","+getbyte1(sells[a]);
					}
				   }
				   if (!sell.equals(""))
				   ViewBean.executeUpdate("delete news where id in("+sell+")");
				   
				  }
				   ResultSet rs=null;		
		 
		String sql="Select * from news where enddate>=getdate() and type=1 order by newsdate desc";
		
		sql="select Top "+pageSize+" *     from news where    id not in (Select top "+prenum +" id from news    where type=1 order by newsdate desc) and type=1  order by newsdate desc";
 
          sqlcount="SELECT count(id) from news  where   type=1 ";

		  
    rs=ViewBean.executeQuery(sql);
				 
				 	%>      
                <tr>  
                    <td width="100%" height="10"> 
                      <form method="post" action="view_news.jsp" name="form1">
					  <input type=hidden name=act>
                        <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                          <tr class="bgcolor3"> 
                            <td width="495"> 
							 &nbsp;<input type=button name=pxp value=" 发布新闻 " onclick="open('addnews.jsp','','menubar=no,scrollbars=yes,resizable=yes,width=750,height=462,left=200,top=100');"> 
							  &nbsp;<input type=button name=pxp value=" 删除新闻 "  onClick="if (confirm('确认吗?')){form1.act.value='del';form1.submit();}"> 
							
                              <input type="checkbox" name="checkall" value="checkbox" onClick="chkall()">
                              全选 
 
                         
							
                            </td>
							
                            <td width="137"> 
                            
                            </td>
                          </tr>
                          <tr> 
                            <td width="355">&nbsp;</td>
                            <td width="137">&nbsp;</td>
                          </tr>
                        </table>
                        
                        <table width="95%" cellpadding="0" cellspacing="1" align="center">
                          <tr  class=listtitle>  
                            <td width="29"> 
                              <div align="center"><font color="#FFFFFF">选择</font></div>
                            </td>
                            <td width="300"> 
                              <div align="center"><font color="#FFFFFF">标题</font></div>
                            </td>
                            <td width="118"> 
                              <div align="center"><font color="#FFFFFF">发布时间</font></div>
                            </td>
                            <td width="118"> 
                              <div align="center"><font color="#FFFFFF">结束时间</font></div>
                            </td>
                            
                            <td width="56"> 
                              <div align="center"><font color="#FFFFFF">发布者</font></div>
                            </td>
                          </tr>
                          <%
		    while (rs.next()){
			%> 
                          <tr class=listcontent> 
                            <td width="19"> 
                              <div align="center"> 
                                <input type="checkbox" name="del" value="<%=rs.getString("id")%>"<%if (!rs.getString("checker").equals((String)session.getAttribute("loginname"))) %> disabled >
                              </div>
                            </td>

                            <td width="300"><a href="#" onClick="window.open('../../imail/seenews.jsp?id=<%=rs.getString("id")%>','','menubar=no,scrollbars=yes,resizable=yes,width=545,height=450,left=200,top=80')"><%=rs.getString("newstitle")%></a></td>
                            <td width="118"> 
                              <div align="center"><%=rs.getDate("newsdate").toString()%></div>
                            </td>
                            <td width="118"> 
                              <div align="center"><%=rs.getDate("enddate").toString()%></div>
                            </td>
                             
                               <td width="56"> 
                              <div align="center"><%=rs.getString("checker")%></div>
                            </td>
                          </tr>
                          <%
			 
			}
			rs.close();%> 
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
   <%@ include file="../public_js/changepage.jsp"%>
</div>        
        
</body>        
        
</html>        
