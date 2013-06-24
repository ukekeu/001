<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="incdb.jsp"%>
<%@ include file="../jsp/public_js/checktime.jsp"%>
<jsp:useBean id="user" class="test.bbsuser" scope="page"/>
<jsp:useBean id="bbs" class="test.bbs" scope="page"/>
<jsp:useBean id="board" class="test.bbsboard" scope="page"/>
 <%@ include file="../jsp/public_js/getByteOut.jsp"%>

<%
int boardid,bbsid,parentid,child,bbshits,length;
String username,useremail,userip,expression,usersign,bbstopic,bbscontent,dateandtime,userpassword;
String boardname;

String tt,strSQL,tempSTR,whereTo;
byte[] tmpbyte;
java.sql.ResultSet sqlRst;				   //'ADODB RECORDSE 对象

tempSTR=request.getParameter("boardid");
boardid=java.lang.Integer.parseInt(tempSTR);

tempSTR=request.getParameter("bbsid");
bbsid=java.lang.Integer.parseInt(tempSTR);
 

tt=request.getParameter("tt");
if (tt==null){
 tt="";
}
%>  
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>加贴</title>
<link rel="stylesheet" type="text/css" href="bbs03.css">
</head>
<body>
<script Language="JavaScript">
<!--
function isspacestring(mystring)
//是否为空格字符串;true为空，FALSE为非空
{ var istring=mystring;
  var temp,i,strlen;
  temp=true;
  strlen=istring.length;
  for (i=0;i<strlen;i++)
  {
    if ((istring.substring(i,i+1)!=" ")&(temp))
     { temp=false;  }
  }
 return temp;
}

function firstisspace(mystring)
//检查首字母是否是空格，TRUE首字母为空格；FALSE首字母不为空格
{ var istring=mystring;
  var temp,i;
  temp=true;
    if (istring.substring(0,1)!=" ")
     { temp=false;  }
 return temp;
}

function isemail(mystring)
{
  var istring=mystring;
  var atpos=mystring.indexOf("@");
  var temp=true;
  if (atpos==-1) //email中没有@符号；不正确的EMAIL
  {
     temp=false;
  }
  return temp;
}

function check_input()
{

 
 
  if ((bbs_add_form.bbstopic.value == "")|(isspacestring(bbs_add_form.bbstopic.value)))
  {
    alert("您没写主题.");
    bbs_add_form.bbstopic.focus();
    return (false);
  }
   
  bbs_add_form.submit();
 // return (true);
}
//-->
</script>

<!--首次进入本页-->
<%
boardname="";
parentid=0;
username="";
bbstopic="";
dateandtime="";
bbscontent="";
usersign="";

if (board.getBoardInfo(boardid)){
  boardname=board.getBoardName();
}

bbs.changeBbsHits (bbsid,1);     //'BBS点击数加1

out.print(bbsid);
if (bbs.getBbsInfo(bbsid)){
  parentid=bbs.getBbsParentid();
  username=bbs.getBbsUsername();
  bbstopic=bbs.getBbsTopic();
  dateandtime="";
  bbscontent=bbs.getBbsContent();
  usersign=bbs.getBbsUsersign();
}
%>  
<!-------------主贴----------------->
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td width="100%">
      <p align="center"><b><%=bbstopic%></b></p>
      <hr color="#000080" size="1">
      <p><%=username%> 于<%=dateandtime%> 发表于:<b><%=boardname%></b></p>                                               
      <p><%=bbscontent%> </p>                   
                                               
      <hr color="#000080">                                              
    </td>                                              
  </tr>                                              
</table>              
<!--------------所有跟贴---------------->             
<%
sqlRst=bbs.listBbsRe (bbsid);
while(sqlRst.next()){

username=sqlRst.getString("username");
bbstopic=sqlRst.getString("bbstopic");
dateandtime=sqlRst.getString("dateandtime");
bbscontent=sqlRst.getString("bbscontent");
usersign=sqlRst.getString("usersign");

if (bbscontent==null){
 bbscontent="";
}
if (usersign==null){
usersign="";
}
//}
%>             
            
<table border="0" width="100%" cellspacing="0" cellpadding="0">             
  <tr>             
    <td width="100%">             
      <p><%=username%>  于<%=dateandtime%> 发表于:<b><%=boardname%></b></p>           
      <p><b><%=bbstopic%></b></p>                                               
      <p><%=bbscontent%> </p>                   
                                                   
      <hr color="#000080" size="1">                                              
    </td>                                              
  </tr>                                              
</table>              
<%}
sqlRst.close();
%>             
                                             
<div align="center">                                              
  <center>                                              
<table border="0" width="100%">                                              
  <tr>                                              
    <td width="100%">                                              
      <p align="center"><%=tt%></p>                                              
    </td>                                              
  </tr>                                              
</table>                                                
  </center>                                              
</div>                                                                                           

<div align="center">                                              
  <center>                                              
  <table border="1" width="500" bordercolorlight="#000000" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF">                                              
    <tr>                                              
      <td width="100%" bgcolor="#000080">                                              
        <p align="center"><font color="#FFFFFF">我 要 回 复</font></td>                                  
    </tr>                                               
    <tr>                                               
      <td width="100%" bgcolor="#FFFFFF" valign="top">　                                               
<div align="center">                                               
  <center>                                               
<table border="0" width="440">                                               
  <tr>                                               
    <td width="100%" valign="top">                                               

      <form method="POST" action="bbshf.jsp"  name="bbs_add_form"> 
        <p style="margin-top: 0; margin-bottom: 0"><b><font color="#008000">版面:</font></b><a href="bbslist.jsp?boardid=<%=boardid%>"><%=boardname%></a></p>
          <TR><td>                                                                                                                            
        <p align="left" style="margin-top: 0; margin-bottom: 0"><b><font color="#008000">主题:</font></b><input type="text" name="bbstopic" size="50"></p>                                                                                                                                    
      </td>    </tr>
	   <TR><td>  
	    <p align="left" style="margin-top: 0; margin-bottom: 0"><font color="#008000"><b>表情:</b></font> 
		 </td>    </tr>
		  <TR><td> <table><tr>
    <TD> <input type="radio" value="010.gif" name="expression" checked><IMG src="../edit/sysimage/emot/01.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/02.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/03.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/04.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/05.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/06.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/07.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/08.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/09.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/10.gif"></TD> 
     <TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/41.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/42.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/43.gif"></TD>
	
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/34.gif"></TD>
		</TR>
  <TR>
    <TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/21.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/22.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/23.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/24.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/25.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/26.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/27.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/28.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/29.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/30.gif"></TD> 

  
	
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/33.gif"></TD>
	
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/48.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/49.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/50.gif"></TD></TR>
	<tr> 
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/44.gif"></TD>
    <TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/11.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/12.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/13.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/14.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/15.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/16.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/17.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/18.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/19.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/45.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/20.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/32.gif"></TD>
	
	 <TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/31.gif"></TD>
	</TR>
	<TR>
	
	   
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/35.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/36.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/37.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/38.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/39.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/40.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/46.gif"></TD>
	<TD> <input type="radio" value="010.gif" name="expression"><IMG src="../edit/sysimage/emot/47.gif"></TD>

	 </TR>
		 </table>
		 </td></tr>
		    <tr>    <td> 
          <INPUT type="hidden" name="content1" value="">
		<IFRAME ID="eWebEditor1" src="../edit/eWebEditor.jsp?id=content1&style=standard" frameborder="0" scrolling="no" width="650" height="250"></IFRAME>
	                                  
         </td>    </tr>
		<tr>    <td>  
		<input class="buttonface" type="button" value=" 发 表 " name="B1" onclick="check_input();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;       
        <input class="buttonface" type="reset" value=" 取 消 " name="B2"> 
		 </td>    </tr>
		<input type="hidden" name="bbsid" value="<%=bbsid%>">
     
	    <input type="hidden" name="boardid" value="<%=boardid%>"><input type="hidden" name="parentid" value="<%=parentid%>">                                                    
      </form>                                                     
    </td>                                              
  </tr>                                            
</table>                                          
  </center>                                       
</div>                                     
</td>                         
    </tr>                     
  </table>                    
  </center>                   
</div>
</body>                     
</html>                    