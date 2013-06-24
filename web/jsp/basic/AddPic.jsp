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
  <p align="center"><b><font size="3" color="#000080">楼盘图片上载</font></b></p>
    <table width="99%" align=center border="0" cellspacing="0" bgcolor="#ffffff"  cellpadding="0" bordercolor="#dbdbdb" class="tablefill">
          <INPUT TYPE=HIDDEN  name="SecNo" value="<%=SecNo %>">      <tr > 
        <td width="16%"   align="center"   class=roomleft >图片名称</td>
        <td width="57%" class=roomleft   align="center"  > 
          选择图片文件
        </td>
      </tr>
      <tr align="center" > 
        <td width="16%" align="center"   height="3" class=roomright ><input type=text name=picname1 size=15></td>
        <td width="57%" class=roomright align="center"   height="3"> 
          <p align="center"> 
            <input type="file" size=25 name="Pic1" style="border-style: solid; border-width: 1">
          </p>
        </td>
      </tr> 
	   <tr align="center" > 
        <td width="16%" align="center"   height="3" class=roomright ><input type=text name=picname2 size=15></td>
        <td width="57%" class=roomright align="center"   height="3"> 
          <p align="center"> 
            <input type="file" size=25 name="Pic2" style="border-style: solid; border-width: 1">
          </p>
        </td>
      </tr> 
	   <tr align="center" > 
        <td width="16%" align="center"   height="3" class=roomright ><input type=text name=picname3 size=15></td>
        <td width="57%" class=roomright align="center"   height="3"> 
          <p align="center"> 
            <input type="file" size=25 name="Pic3" style="border-style: solid; border-width: 1">
          </p>
        </td>
      </tr> 
	   <tr align="center" > 
        <td width="16%" align="center"   height="3" class=roomright ><input type=text name=picname4 size=15></td>
        <td width="57%" class=roomright align="center"   height="3"> 
          <p align="center"> 
            <input type="file" size=25 name="Pic4" style="border-style: solid; border-width: 1">
          </p>
        </td>
      </tr> 
	   <tr align="center" > 
        <td width="16%" align="center"   height="3" class=roomright ><input type=text name=picname5 size=15></td>
        <td width="57%" class=roomright align="center"   height="3"> 
          <p align="center"> 
            <input type="file" size=25 name="Pic5" style="border-style: solid; border-width: 1">
          </p>
        </td>
      </tr> 
	  <tr align="center" > 
        <td width="16%" align="center"  colspan="2"   height="3" class=roomright >备注:文件名中不能包括中文，否则可能不能正常查看</td>
        
      
      </tr> 
       </table>     
          <p align="center"> 
            <input type="submit" value="提　交" name="submit">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		    <input type="button" value="退  出" name="reset" onclick="window.close();">

          </p>
      
   
    
</form> 
</body>       
</html>       
