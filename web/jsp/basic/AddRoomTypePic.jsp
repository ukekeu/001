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
<body topmargin="0" oncontextmenu="return false" >
<%  String menusel=China.getParameter(request,"menusel");
   
    if(menusel.equals("")) menusel="0";
	
 %>
 <%
 String StrSql="select type,codename,bak from CODE where child=0  and type='A' order by type";
   ResultSet codeRS=null;
   String CodeName[]=new String[50];
   String CodeType[]=new String[50];
   String CodeBak[]=new String[50];
  codeRS=ViewBean.executeQuery(StrSql);
   int i=0;
   while (codeRS.next()){
     CodeType[i]=codeRS.getString("type");
     CodeName[i]=getbyte(codeRS.getString("codename"));
	 CodeBak[i]=getbyte(codeRS.getString("bak"));
	 i++;
   }
   codeRS.close();
 %>
<form method="POST" name="cus" action="RoomTypePicInsert.jsp"  ENCTYPE="multipart/form-data">
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
  <p align="center"><b><font size="3" color="#000080">楼盘图片上载</font></b></p>
  <table width=50% align=center border="0"><tr height="16"  ><td align="left">楼盘：<select name="SecNo"> 
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
	  }
	  if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	
     %> </select>
	 </td>
	 </tr>
	 </table>
    <table width="50%" align=center border="0" cellspacing="0" bgcolor="#ffffff"  cellpadding="0" bordercolor="#dbdbdb" class="tablefill">
         <tr > 
        <td width="16%"   align="center"   class=roomleft >户型</td>
        <td width="57%" class=roomleft   align="center"  > 
          选择图片文件
        </td>
      </tr>
      <tr align="center" > 
        <td width="16%" align="center"   height="3" class=roomright >
		<select name="picname1"  style="width : 105">
        <option value=""></option>
		  <%
    for (int ii=0;ii<50;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("A"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
          %>
        </select>
		
		
		</td>
        <td width="57%" class=roomright align="center"   height="3"> 
          <p align="center"> 
            <input type="file" size=25 name="Pic1" style="border-style: solid; border-width: 1">
          </p>
        </td>
      </tr> 
	   <tr align="center" > 
        <td width="16%" align="center"   height="3" class=roomright >
		<select name="picname2"  style="width : 105">
        <option value=""></option>
		  <%
    for (int ii=0;ii<50;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("A"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
          %>
        </select>
		</td>
        <td width="57%" class=roomright align="center"   height="3"> 
          <p align="center"> 
            <input type="file" size=25 name="Pic2" style="border-style: solid; border-width: 1">
          </p>
        </td>
      </tr> 
	   <tr align="center" > 
        <td width="16%" align="center"   height="3" class=roomright >
		<select name="picname3"  style="width : 105">
        <option value=""></option>
		  <%
    for (int ii=0;ii<50;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("A"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
          %>
        </select>
		
		</td>
        <td width="57%" class=roomright align="center"   height="3"> 
          <p align="center"> 
            <input type="file" size=25 name="Pic3" style="border-style: solid; border-width: 1">
          </p>
        </td>
      </tr> 
	   <tr align="center" > 
        <td width="16%" align="center"   height="3" class=roomright >
		<select name="picname4"  style="width : 105">
        <option value=""></option>
		  <%
    for (int ii=0;ii<50;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("A"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
          %>
        </select>
		
		</td>
        <td width="57%" class=roomright align="center"   height="3"> 
          <p align="center"> 
            <input type="file" size=25 name="Pic4" style="border-style: solid; border-width: 1">
          </p>
        </td>
      </tr> 
	   <tr align="center" > 
        <td width="16%" align="center"   height="3" class=roomright >
		<select name="picname5"  style="width : 105">
        <option value=""></option>
		  <%
    for (int ii=0;ii<50;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("A"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
          %>
        </select>
		
		</td>
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
            <input type="button" value="提　交" name="submit1" onclick="saveDATAcheck();">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		    <input type="button" value="退  出" name="reset" onclick="window.close();">

          </p>
      
   
    
</form> 
<script>
  function saveDATAcheck(){
     if(document.cus.SecNo.value==""){
	    alert("请选择楼盘名称");
	    return false;
	 }
	document.cus.submit();
	   }
</script>
</body>       
</html>       
