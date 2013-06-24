<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import = "java.sql.*" %>
 <jsp:useBean id = "Bean" scope = "page" class = "ConnDatabase.SDatabase" />
 <jsp:useBean id = "Bean1" scope = "page" class = "ConnDatabase.SDatabase" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>WAGNER</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.bg {
	background-image: url('images/index3_03.jpg');
	background-repeat: repeat-y;
	background-position: left top
}
-->
</style>
</head>

<body>
<form name="form1" method="post">
<table width="100%" height="90%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top" bgcolor="#FFFFFF">      
      <table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="44"></td>
        </tr>
      </table>
      <table width="100%" height="90%"  border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="174" height="90%" valign="top" bgcolor="#313E82"><img src="images/Visitors_02.gif" width="174" height="400"></td>
          <td width="560" valign="top"  colspan="3"  >
		  <table width="100%" height="36"   border="0" cellpadding="0" cellspacing="1">
            <tr>
              <td bgcolor="#FFFFFF"></td>
            </tr>
          </table>  
		    <!--#include file="inc/conn.asp"-->    
	          
            <table  width="830" height="100%"  border="0" cellpadding="0" cellspacing="0" bgcolor="C4C6C7">
              <tr valign="top">
			  <% int yy=0,mm=0; 
			   if (getbyte1(request.getParameter("yy")).equals("")){
				  yy=year(date);
				  mm=month(date);
				 }else{
				  yy=cint(request("yy"));
				  mm=cint(request("mm"));
				 }
				  Date	mowDate=new Date(yy-1900,mm-1,1);
				// tdate=DateSerial(yy,mm,1); %>
                <td  class=lefttd height="25"> 
        <select name="yy" onChange="submitform();" class="input4">
          <%for (int i=year1-5;i<=year1+20;i++){%> 
          <option<%if (i==yy){%> selected<%}%>><%=i%></option>
          <%}%> 
        </select>年</td>
      <td  class=lefttd height="25"> 
          <select name="mm" onChange="submitform();" class="input4">
            <%for (int i=1;i<=12;i++){%> 
            <option<%if (i==mm){%> selected<%}%>><%=i%></option>
            <%}%> 
          </select>月
       &nbsp;&nbsp;<a href="AddVisitors.asp" ><img src="images/add.gif" width="27" height="9" border="0"></a></td>
              </tr>
              <tr>
                <td valign="top" width="100%">
				<table width="100%"  border="0">
				<tr><td width="20%">&nbsp;</td>
				<%
while (mowDate.getMonth()+1==mm){
%> 
          <%
		  for (int i=1;i<=7;i++){
 
%> 
            <td height="15"   <%if (weekday(tdate)==1 || weekday(tdate)==7) {%> bgcolor="#808080" <%} %> <%if (month(tdate)==mm && DatePart("w",tdate)==i ){%> style="cursor:hand"     <%}%> bgcolor="#F3F3F3"> 
              <div align="center"><%if (month(tdate)==mm and DatePart("w",tdate)==i ){%><b><%if (day(tdate)==day(now())){%><font color=red size=3 title=""><b><%=day(tdate)%></b></font><%}else{%><font  title=""><%=day(tdate)%></font><%}%></b><%}%></div>
            </td>
            <%
  if (DatePart("w",tdate)==i )
   mowDate=DateAdd("d",1,tdate)
   
  }
%> 
          <%
 }
%> </tr>

<%
  sql="select context,name,code,day(sdate) as nn,day(edate) as nnn ,month(edate) as nnnn,month(sdate) as nnnnn from dayplan where (year(sdate)="&yy&" and month(sdate)="&mm&") or (year(edate)="&yy&" and month(edate)="&mm&") order by sdate "

  set rss=server.createobject("ADODB.Recordset")
  rss.Open sql,Conn,3,3
  while not rss.eof 
 %>
 
 <tr>
 <td width="20%"><a href="ModiVisitors.asp?code=<%=rss("code") %>" target="_parent"><img src="images/edit.gif" width="25" height="9" border="0"></a>&nbsp;<a href="#" title="<%=rss("context") %>"><%=rss("name") %></a></td>
 <%  if request("yy").count=0 then
				  yy=year(date)
				  mm=month(date)
				 else
				  yy=cint(request("yy"))
				  mm=cint(request("mm"))
				 end if
				 tdate=DateSerial(yy,mm,1) %>
 <%
 a=1
 do while month(tdate)=mm
%>  
          <%
  for i=1 to 7

%>   <td height="15"

		 <%if day(tdate)=day(now()) then  
		   if  cint(mm)<rss("nnnn")then
		    if day(tdate)>=rss("nn")   then %> 
			 background="images/color.gif"  title="a"
		  <%end if
		  else
		   if rss("nnnn")<>rss("nnnnn")then
		     if  day(tdate)<=rss("nnn")then %> background="images/color.gif"  <%end if %>
		   <%else%>
		   <% if day(tdate)>=rss("nn") and day(tdate)<=rss("nnn")then %> background="images/color.gif"  <%end if %>
		   	 <%end if %>
		<% end if
		 else 
		    if  cint(mm)<rss("nnnn")then
		    if day(tdate)>=rss("nn")  then %> 
			 background="images/color.gif"  title="b"
		  <%end if
		  else
		   
		 if rss("nnnn")<>rss("nnnnn")then
		     if  day(tdate)<=rss("nnn")then %> background="images/color.gif"  <%end if %>
		   <%else%>
		   <% if day(tdate)>=rss("nn") and day(tdate)<=rss("nnn")then %> background="images/color.gif"  <%end if %>
		    <%end if %>	  	
		<% end if
		 end if%> 
		 > 
         
            </td>
           
            <%a=a+1
  if DatePart("w",tdate)=i then
   tdate=DateAdd("d",1,tdate)
  end if
  next
%> 
          <%
 loop
%>
 </tr>

 <%rss.movenext
 wend
 rss.close
  %>
				
				</table>
                  </td>
              </tr>
            </table></td>
          <td width="17" valign="top" bgcolor="#C4C6C7" >
		  <table width="100%"  border="0" cellspacing="0"  cellpadding="0">
            <tr>
              <td height="36" bgcolor="#FFFFFF">&nbsp;</td>
            </tr>
          </table>           </td>
           
        </tr>
      </table>      </td>
  </tr>
  <tr>
    <td height="11" valign="top"><img src="images/index3_07.gif" height="11" width="995"></td>
  </tr>
</table>
</form>
</body>
</html>