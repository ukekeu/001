<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>复制客户调整数据项</title>
<script language="JavaScript" src='../public_js/basal.js'></script>
</head>
 
<script language="javascript" src="../public_js/public.js">
</script> 

<body  oncontextmenu="return false" >
<%
  String section=getbyte1(request.getParameter("section"));
  String tosection=getbyte1(request.getParameter("tosection"));
  String dcType1=getbyte1(request.getParameter("dcType1"));
   String dcType2=getbyte1(request.getParameter("dcType2"));
  if (!section.equals("")&&!tosection.equals("")){
   String SQL="select * from CustomerDc where sectionno='"+tosection+"'";
   if (!dcType2.equals(""))
   SQL+=" AND TYPE="+dcType2;
   
   try{
   
   ResultSet rs=ViewBean.executeQuery(SQL);	
   if (!rs.next()){
      if (dcType1.equals("")&&dcType2.equals(""))
      SQL="insert into CustomerDc(codeName,sectionno,type) SELECT codeName, '"+tosection+"',type FROM CustomerDc   where sectionno='"+section+"'";
      else  if (dcType1.equals("0")&&dcType2.equals("1"))
	  SQL="insert into CustomerDc(codeName,sectionno,type) SELECT codeName, '"+tosection+"',1 FROM CustomerDc   where type=0 and sectionno='"+section+"'";
      
    
	  
	 ViewBean1.executeUpdate(SQL);	
	    if (dcType1.equals("")&&dcType2.equals(""))
	  SQL="select code, codeName from CustomerDc where sectionno='"+tosection+"'";
	   else  if (dcType1.equals("0")&&dcType2.equals("1"))
	 SQL="select code, codeName from CustomerDc where type=1 and sectionno='"+tosection+"'";
	 
	    ResultSet rs1=ViewBean1.executeQuery(SQL);	
	   while (rs1.next()){
	        String valueCode=rs1.getString("code");
			String codeName=rs1.getString("codeName");
			    if (dcType1.equals("")&&dcType2.equals(""))
	            SQL="insert into CustomerDcValue(dcCode,CodeValue)  SELECT "+valueCode+",CodeValue FROM CustomerDcValue   where dcCode in (select code from CustomerDc where sectionno='"+section+"' and codename='"+codeName+"')";
                else  if (dcType1.equals("0")&&dcType2.equals("1"))
				  SQL="insert into CustomerDcValue(dcCode,CodeValue)  SELECT "+valueCode+",CodeValue FROM CustomerDcValue   where dcCode in (select code from CustomerDc where type=0 and sectionno='"+section+"' and codename='"+codeName+"')";
               
			 ViewBean2.executeUpdate(SQL);	
	   }
	   rs1.close();
	    out.print("<script>");
	    out.print("alert('复制成功!');");
	    out.print("opener.document.frm.submit();");
		 out.print("window.close();");
	   out.print("</script>");
	  
   }else{
         out.print("已存在部份数据项，不能通过复制，否则出现重复;");
   }
   rs.close();
   }catch(Exception s){out.println("复制失败原因："+s.getMessage());}
  }
 
 %>
            

      
<br>
	   <form name=frm method="post"   >
	    <table width="99%" cellspacing="1" cellpadding>
                 
					
                    <tr>
                      <td   align="center"> 源楼盘:</td>
					  <td     align="left">
					  <%@ include file="../public_js/CheckSection.jsp"%>
					  <%
      String sql="select SerialNo,Name from CRM_Project "+FindWhere;
					   ResultSet rs2=ViewBean.executeQuery(sql);
	                    String sec="";
	                    String no=""; %>
<select name="section"     style="width=110;">
					     
						  <%while (rs2.next()){
	                          no=rs2.getString("SerialNo");
	                          sec=getbyte(rs2.getString("Name"));
     	                      out.print("<option value='"+no+"'>"+sec+"</option>");
	                         }
	                        rs2.close();
	                     
                              %> 
							</select>
							</td><td>--></td>
							<td> 目标楼盘 <%
        sql="select SerialNo,Name from CRM_Project  "+FindWhere;
					     rs2=ViewBean.executeQuery(sql);
	                      sec="";
	                      no=""; %>
<select name="tosection"    style="width=110;">
					      <option value=""></option>
						  <%while (rs2.next()){
	                          no=rs2.getString("SerialNo");
	                          sec=getbyte(rs2.getString("Name"));
     	                      out.print("<option value='"+no+"'>"+sec+"</option>");
	                         }
	                        rs2.close();
	                        String Sql = "" ;
                              %> 
							</select></td>
							</tr>
							<tr>
							<td>&nbsp;</td>
							<td><select name=dcType1 style="width=110;">
							<option value="">全部复制</option>
							<option value=0>复制未交问卷</option>
							 
							</select>
							</td>
							<td>--></td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name=dcType2 style="width=110;">
							<option value="">全部复制</option>
						 
							<option value=1>复制成交问卷</option>
							</select>
							</td>
							 
					</tr>
					 
				</table>
				<p align="center"> <input type=submit name=submit1 value="开始复制" onclick="return checkdate(this);"> <input type=button name=winclose value="关 闭" onclick="window.close();" ></p>
</form>     
       
       
       
</body>       
</html>       
