<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>楼盘图</title>
</head>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<body topmargin="0" oncontextmenu="return false" >
<%  String menusel=China.getParameter(request,"menusel");
   String SecNo=China.getParameter(request,"SecNo");
    if(menusel.equals("")) menusel="0";
 %>
<form method="POST" name="cus" action="SectionPicInsert.jsp"  ENCTYPE="multipart/form-data">
  <input type=hidden name="menusel" value="<%=menusel %>">
<table width="180" border="0" cellspacing="0" cellpadding="0" class="L2"  >
   <tr> 
     <td  class="<%if(menusel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.menusel.value=0;window.location='AddPic.jsp?SecNo=<%=SecNo %>&menusel=0';"><font color='<%if(menusel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>添加图片</a>
	</td>
	  <td  class="<%if(menusel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.menusel.value=1;window.location='ViewPic.jsp?SecNo=<%=SecNo %>&menusel=1';"><font color='<%if(menusel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>图片管理</a>
	</td>    
</table>
  <p align="center"><b><font size="3" color="#000080">图片一览</font></b></p>
    <table width="99%" align=center border="0" cellspacing="0" bgcolor="#ffffff"  cellpadding="0" bordercolor="#dbdbdb" class="tablefill"><INPUT TYPE=HIDDEN  name="SerialNo" >
		<tr > 
        <td    align="center"   class=roomleft >图片名称</td>
        <td  class=roomleft   align="center"  > 
          图片预览
        </td>
		<td align="center">&nbsp;</td>
      </tr>
	  <%
	  String picid=China.getParameter(request,"picid");
	  if (!picid.equals("")){	  
	  ViewBean.executeUpdate("delete Section_pic where id="+picid);
	  }
	  String SQL="select *  from Section_pic where SerialNo='"+SecNo+"'";
	  ResultSet rs=ViewBean.executeQuery(SQL);
	  while (rs.next()){
	   %>
      <tr align="center" > 
        <td   align="center"   height="3" class=roomright ><%=rs.getString("mapname") %></td>
        <td   class=roomright align="center"   height="3"> 
          <a href="<%=rs.getString("mapurl") %>" target="_blank" title="点击可以放大显示"><img width=100  border=0 src="<%=rs.getString("mapurl") %>" ></a>
        </td>
		<td align="center"><a href="ViewPic.jsp?picid=<%=rs.getString("id") %>&SecNo=<%=SecNo %>&menusel=1">删除</a></td>
      </tr> 
	   <%}rs.close(); %>
 
	 
       </table>     
          <p align="center"> 
            <input type="submit" value="提　交" name="submit">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		    <input type="button" value="退  出" name="reset" onclick="window.close();">

          </p>
      
   
    
</form> 
</body>       
</html>       
