<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="incdb.jsp"%>
<%@ include file="../jsp/public_js/checktime.jsp"%>
<jsp:useBean id="user" class="test.bbsuser" scope="page"/>
<jsp:useBean id="bbs" class="test.bbs" scope="page"/>
<jsp:useBean id="board" class="test.bbsboard" scope="page"/>
<%
String strSQL;//                       '执行的SQL语句
java.sql.ResultSet sqlRst;				   //'ADODB RECORDSE 对象

int boardid;
String tempSTR,whereTo;
byte[] tmpbyte;
String tt;       // '错误变量
boardid=0;

tempSTR=request.getParameter("boardid");
boardid=java.lang.Integer.parseInt(tempSTR);
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
}
//-->
</script>
<!--首次进入本页-->
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
        <p align="center"><font color="#FFFFFF">我 要 发 言</font></td> 
    </tr> 
    <tr> 
      <td width="100%" bgcolor="#FFFFFF" valign="top">　 
 
 
<div align="center"> 
  <center> 
<table border="0" width="440"> 
  <tr> 
    <td width="100%" valign="top"> 
<% 
String boardname="";

if (board.getBoardInfo(boardid)){
  boardname=board.getBoardName();
}

%>       
      <form method="POST" action="bbsave.jsp"  name="bbs_add_form"> 
         <TR><td>                                                                                                                            
        <p align="left" style="margin-top: 0; margin-bottom: 0"><b><font color="#008000">主题:</font></b><input type="text" name="bbstopic" size="50"></p>                                                                                                                                    
      </td>    </tr>
	   <TR><td>  
	    <p align="left" style="margin-top: 0; margin-bottom: 0"><font color="#008000"><b>表情:</b></font> 
		 </td>    </tr>
		  <TR><td> <table><tr>
    <TD> <input type="radio" value="010.gif" checked name="expression"><IMG src="../edit/sysimage/emot/01.gif"></TD>
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
	                                  
        <input type="hidden" name="boardid" value="<%=boardid%>"><input type="hidden" name="parentid" value="<%=0%>">                                 
     </td>    </tr>
	 <tr>    <td>  
		<input type="button" value=" 发 表 " name="B1" onclick="check_input();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;       
        <input class="buttonface" type="reset" value=" 取 消 " name="B2"> 
		 </td>    </tr>
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

<%
int bbsid,parentid,child,bbshits,length;
String username,useremail,userip,expression,usersign,bbstopic,dateandtime,userpassword,bbscontent;

String B1=request.getParameter("B1");
if (B1!=null){
//开始加贴操作
tempSTR=request.getParameter("parentid");
parentid=java.lang.Integer.parseInt(tempSTR);
child=0;
username=request.getParameter("username");
username=username.trim();
tmpbyte=username.getBytes("ISO8859_1");
username=new String(tmpbyte);

userpassword=request.getParameter("userpassword");
userpassword=userpassword.trim();
userip="127.0.0.1";
expression=request.getParameter("expression");
bbstopic=request.getParameter("bbstopic");
bbstopic=bbstopic.trim();
tmpbyte=bbstopic.getBytes("ISO8859_1");
bbstopic=new String(tmpbyte);

bbscontent=request.getParameter("content1");
tmpbyte=bbscontent.getBytes("ISO8859_1");
bbscontent=new String(tmpbyte);

//dateandtime="";
bbshits=0;
length=bbscontent.length();
//'========================================================================
if ((username==null)||(userpassword==null)||(bbstopic==null)) {
  tt="内容没有填全 请重新填写";
  
%>
<script language="JavaScript">
      window.location="bbsadd.jsp?boardid="+boardid+"&tt="+tt;
</script>  
<%}
//end if ((username==null)||(userpassword==null)||(bbstopic==null))
//'========================================================================

if (!user.checkUserPassword(username,userpassword)) {
  tt="password or username is wrong!!!please try again! ";                               
%>
<script language="JavaScript">
     window.location="bbsadd.jsp?boardid="+boardid+"&tt="+tt;
</script>  
<%  
}else{
useremail=user.getUserEmail();
usersign=user.getUserSign();

bbs.setBbsParentid(parentid);
bbs.setBbsBoardid(boardid);
bbs.setBbsChild(child);
bbs.setBbsUsername(username);
bbs.setBbsUseremail(useremail);
bbs.setBbsUserip(userip);
bbs.setBbsExpression(expression);
bbs.setBbsUsersign(usersign);
bbs.setBbsTopic(bbstopic);
bbs.setBbsContent(bbscontent);
bbs.setBbsHits(bbshits);
bbs.setBbsLength(length);
bbs.addNewBbs();

user.changeUserClass(username,2);//'读出用户信息并给用户加分：2分                                      
board.updateBoardTopics(boardid,1);//'版面主题数加1                               
%>
<%whereTo="bbslist.jsp?boardid="+boardid;%>
<jsp:forward page='<%=whereTo%>'/>
<%
}//end else
}//if (B1!=null)
%>  
 
</body>                     
</html>                    