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
<%	  

String B1= getbyte1(request.getParameter("content1"));
 
if (!B1.equals("")){

//开始加贴操作
tempSTR=request.getParameter("bbsid");
parentid=java.lang.Integer.parseInt(tempSTR);
child=0;
 
userip="127.0.0.1";
expression=getbyte1(request.getParameter("expression"));
 bbstopic=getbyte1(request.getParameter("bbstopic"));
//bbstopic=bbstopic.trim();
//tmpbyte=bbstopic;
//bbstopic=new String(tmpbyte);

bbscontent=request.getParameter("content1");
tmpbyte=bbscontent.getBytes("ISO8859_1");
bbscontent=new String(tmpbyte);

//dateandtime="";
bbshits=0;
length=bbscontent.length();
 

useremail=user.getUserEmail();
usersign=user.getUserSign();

bbs.setBbsParentid(parentid);
bbs.setBbsBoardid(boardid);
bbs.setBbsChild(child);
//bbs.setBbsUsername(username);
//bbs.setBbsUseremail(useremail);
bbs.setBbsUserip(userip);
bbs.setBbsExpression(expression);
bbs.setBbsUsersign(usersign);
 
 bbs.setBbsTopic(bbstopic);
 bbs.setBbsContent(bbscontent);
 bbs.setBbsHits(bbshits);
 bbs.setBbsLength(length);
bbs.addNewBbs();

//user.changeUserClass(username,1);   //'读出用户信息并给用户加分：1分                                      
//bbs.changeBbsChild (parentid,1);    //'BBS主贴回复数加1                                       
 
%>
<%whereTo="bbslist.jsp?boardid="+boardid;%>
<%out.print(whereTo); %>
<jsp:forward page='<%=whereTo%>'/>
<%
 //end else
}//if (B1!=null)
%>  
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>回复</title>
<link rel="stylesheet" type="text/css" href="bbs03.css">
</head>
<body>                
</div>
</body>                     
</html>                    