<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>户型图</title>
</head>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/CheckSection.jsp"%>
 <script language="javascript" src="../public_js/public.js"></script>
<body topmargin="0" oncontextmenu="return false" >
<%  String menusel=China.getParameter(request,"menusel");
   SecNo=China.getParameter(request,"SecNo");
    if(menusel.equals("")) menusel="1";
	 
 %>
<form method="POST" name="cus" action="RoomTypeViewPic.jsp">
  <input type=hidden name="menusel" value="<%=menusel %>">
<table width="180" border="0" cellspacing="0" cellpadding="0" class="L2"  >
  <tr> 
    
	  <td  class="<%if(menusel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.menusel.value=1;window.location='RoomTypeViewPic.jsp?SecNo=<%=SecNo %>&menusel=1';"><font color='<%if(menusel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>图形一览</a>
	</td>   
	 <td  class="<%if(menusel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.menusel.value=0;window.location='AddRoomTypePic.jsp?SecNo=<%=SecNo %>&menusel=0';"><font color='<%if(menusel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>添加图片</a>
	</td> 
	</tr>   
</table>
  <p align="center"><b><font size="3" color="#000080">图片一览</font></b></p>
    <table width="99%" align=center border="0" cellspacing="0"   cellpadding="0" ><INPUT TYPE=HIDDEN  name="SerialNo" >
	<tr><td>
	 <table width=99% align=center border="0"><tr height="16"  ><td align="left">楼盘：<select name="SecNo" onchange="document.cus.submit();"> 
   <option></option>
<%  

	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";

	  ResultSet rs2=ViewBean.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
		if (SecNo.equals(""))SecNo=no1;
	  }
	  if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	
     %> </select>
	
	</td>
	 </tr>
	 </table>
	
	</td><td align="right"><input type=button name=updatePic value="同步更新到房间资料" onclick="checkupdate();"></td></tr>
	</table>
    <table width="99%" align=center border="0" cellspacing="0" bgcolor="#ffffff"  cellpadding="0" bordercolor="#dbdbdb" class="tablefill"><INPUT TYPE=HIDDEN  name="SerialNo" >
		<tr > 
        <td    align="center"   class=roomleft >户型名称</td>
        <td  class=roomleft   align="center"  > 
          图片预览
        </td>
		<td align="center">&nbsp;</td>
      </tr>
	  <%
	  String picid=China.getParameter(request,"picid");
	  if (!picid.equals("")){	  
	  ViewBean.executeUpdate("delete RoomTypePic where id="+picid);
	  }
	  String SQL="select *  from RoomTypePic where sectionno='"+SecNo+"'";
 
	  ResultSet rs=ViewBean.executeQuery(SQL);
	  while (rs.next()){
	   %>
      <tr align="center" > 
        <td   align="center"   height="3" class=roomright ><%=rs.getString("roomtype") %></td>
        <td   class=roomright align="center"   height="3"> 
          <a href="<%=rs.getString("roomtypepic") %>" target="_blank" title="点击可以放大显示"><img width=200  border=0 src="<%=rs.getString("roomtypepic") %>" ></a>
        </td>
		<td align="center"><a href="RoomTypeViewPic.jsp?picid=<%=rs.getString("id") %>&SecNo=<%=SecNo %>&menusel=1">删除</a></td>
      </tr> 
	   <%}rs.close(); %>
 
	 
       </table>     
 
</form> 
<script>
setSelectMad(document.cus.SecNo,'<%=SecNo%>');
function checkupdate(){
  if (confirm("确认更新房间资料中的户型图？"))
   openwin3("RoomTypePicUpdate.jsp?SecNo=<%=SecNo %>",4,3,1,1);


}
</script>
</body>       
</html>       
