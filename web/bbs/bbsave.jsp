<%@ page import = "java.sql.*,java.util.*" contentType="text/html;charset=GBK" %>

 <%@ include file="../jsp/public_js/checktime.jsp"%>
 <jsp:useBean id = "Bean1" scope = "page" class = "ConnDatabase.SDatabase" />
  <%@ include file="../jsp/public_js/getByteOut.jsp"%>

<%
String strSQL;//                       '执行的SQL语句
 

int boardid;
String tempSTR,whereTo;
 
String tt;       // '错误变量
boardid=0;


 
%>                                                                                    

<%
int bbsid,parentid,child,bbshits,length;
String username,useremail,userip,expression,usersign,bbstopic,dateandtime,userpassword,bbscontent;

String B1=request.getParameter("bbstopic");
if (B1!=null){
//开始加贴操作
tempSTR=request.getParameter("parentid");
parentid=java.lang.Integer.parseInt(tempSTR); 
tempSTR=getbyte2(request.getParameter("boardid"));
boardid=java.lang.Integer.parseInt(tempSTR);
tt=getbyte2(request.getParameter("tt"));
child=0;
username=(String)session.getAttribute("loginid");
 
userip=request.getRemoteAddr();
expression=getbyte2(request.getParameter("expression"));
bbstopic=getbyte2(request.getParameter("bbstopic"));
 

bbscontent=getbyte2(request.getParameter("content1"));
 
bbshits=0;
length=bbscontent.length(); 
 
 String strS = "INSERT INTO bbs(parentid,boardid,child,username,userip,expression,bbstopic,bbscontent,bbshits,length)";
 strS+=" VALUES(" + parentid + "," + boardid + "," + child + ",'" + username + "','" +  userip + "','" + expression + "','" ;
 strS+= bbstopic + "','" + bbscontent + "'," + bbshits + "," + String.valueOf(length) + ")";
      try{
	  Bean1.executeUpdate(strS);
	      out.print(strS);
	   }catch(Exception s){ out.print(s+strS)  ;
	   }         
%>
 <%
 
} 
%>  
 <script>//window.close();</script>
 <html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>保存</title>
<base target="rtop">
<link rel="stylesheet" type="text/css" href="bbs03.css">
</head>
</body>                     
</html>                    