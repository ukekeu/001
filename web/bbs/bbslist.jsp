<%@ page session="true" %>
<%@ include file="../jsp/public_js/checktime.jsp"%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="incdb.jsp"%>
<jsp:useBean id="bbs" class="test.bbs" scope="page"/>
<jsp:useBean id="board" class="test.bbsboard" scope="page"/>
<jsp:useBean id="bbscom" class="test.bbscom" scope="page"/>
<%
int boardid,method;
String tempSTR;
boardid=0;
method=0;
String delon="false";
byte[] tmpbyte;

tempSTR=request.getParameter("boardid");
boardid=java.lang.Integer.parseInt(tempSTR);

tempSTR=request.getParameter("method");
if (tempSTR==null){ method=0;}
else{method=java.lang.Integer.parseInt(tempSTR);}

//'method=0正常显示贴子
//'method=1搜索=主题
//'method=2搜索=发言人
//'method=3搜索=时间
//'method=4搜索=精华贴(所有版面)
//'method=8版主管理（DEL）
%>
<%
int iPageSize;                  //                    '每页显示的记录数
int iPageCount;                 //                   '页面总数
int iPageCurrent=0;               //                 '显示的当前页面
int iPageLast=0;                  //                    '上一页
int iPageNext=0;                  //                    '下一页
int iRecordsShown; 
int iRecordsCount; //记录总数
int iRecordsStart; //起始记录
int i;//                            '循环变量
String par="";//                          '查询参数 

java.sql.ResultSet rs;				   
java.sql.ResultSet sqlRst;				

int bbsid,parentid,child,bbshits,length;
String username,useremail,userip,expression,usersign,bbstopic,bbscontent,bbshot;
String boardname,boardmaster,masterword,masteremail;
java.util.Date dateandtime= new java.util.Date();

username="";
boardname="";
boardmaster="";
masterword="";
masteremail="";

board.updateBoardHits(boardid,1);   //'版面点击数加1

if (board.getBoardInfo(boardid)){
  boardname=board.getBoardName();
  boardmaster=board.getBoardMaster();
  masterword=board.getBoardMasterword();
  masteremail=board.getBoardMasteremail();
}        //'找出本版块资料,版名,版主,版主的话

iRecordsCount=0;
iPageCount=0;
iPageSize =10;			//   '每页显示10条记录,可更改部分.

//'如果是首次显示,则当前页为1,否则根据请求的页数显示 
tempSTR=request.getParameter("pages");
if (tempSTR==null){ iPageCurrent=1;}
else{ iPageCurrent=java.lang.Integer.parseInt(tempSTR);}

par=request.getParameter("par");
if (par==null) {par="";}
tmpbyte=par.getBytes("ISO8859_1");
par=new String(tmpbyte);

iRecordsCount=bbs.getRecordsCount(method,boardid,par);
iPageCount=0;
if (iRecordsCount!=0) {
   iPageCount=iRecordsCount/iPageSize;
   if ((iRecordsCount%iPageSize)!=0){
      iPageCount++;					   //页面总数；
   }
}

bbscom.setPages(iPageCount,iPageCurrent);

iPageLast=bbscom.getPagesLast();
iPageNext=bbscom.getPagesNext();
iPageCurrent=bbscom.getPagesCurrent();

if (method==8) {  //  '管理员开关
//'method=8版主管理（DEL）

  delon="false";
  if (session.getValue("superlogin")!="true"){  // '非正常版主登录
  %>
  <script language="JavaScript">
     window.location="superlog.jsp";
  </script>  
  <%
  }else{
    delon="true";
  }//' end if

}  //'End if
%> 
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>New Page 3</title>
<base target="rtop">
<link rel="stylesheet" type="text/css" href="bbs03.css">
</head>
<body link="#000080" vlink="#000080" alink="#000080">
<div align="center"> 
  <center> 
<table border="0" width="600"> 
  <tr> 
    <td width="100%"><a href="mailto:<%=masteremail%>">版主:<%=boardmaster%></a>&nbsp; <b><%=boardname%></b>      <%=masterword%></td>          
  </tr>          
</table>          
  </center>          
</div>          
<!--表头部分 -->
 <div align="center">
  <center>
 <table border="1" width="600" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FAD185" cellspacing="0" cellpadding="3">
  <tr>
    <td width="30" bgcolor="#000080">                                                  
      <p align="center"><a href="bbsadd.jsp?boardid=<%=boardid%>" target="_self"><font color="#FFFFFF">留言</font></a></p>                                              
    </td>                                                                                              
    <td width="30" bgcolor="#000080">                                                  
     <p align="center"><a href="bbslist.jsp?boardid=<%=boardid%>" target="_self"><font color="#FFFFFF">刷新</font></a></p>                                             
    </td> 
    <td width="30" bgcolor="#000080">                                                
     <p align="center"><a href="query.jsp"><font color="#FFFFFF">查询</font></a></p> 
    </td> 
    <td width="100"  bgcolor="#000080">                                              
      <p align="center"><a href="bbslist.jsp?boardid=<%=boardid%>&method=4"><font color="#FFFFFF">精华区</font></a></p>                                          
    </td>
    <td width="200" bgcolor="#000080">  
      <p align="center">
	  <%if (iPageCount>1) {%><A HREF="bbslist.jsp?boardid=<%=boardid%>&pages=1&method=<%=method%>&par=<%=par%>">
	  <font color="#FFFFFF">首页</font></A><%}%>

  	  <%if (iPageLast!=0) {%>
	  <A HREF="bbslist.jsp?boardid=<%=boardid%>&pages=<%=iPageLast%>&method=<%=method%>&par=<%=par%>"><font color="#FFFFFF">上页</font></A><%}%>

	  <%if (iPageNext!=0) {%>
	  <A HREF="bbslist.jsp?boardid=<%=boardid%>&pages=<%=iPageNext%>&method=<%=method%>&par=<%=par%>"><font color="#FFFFFF">下页</font></A><%}%>

	  <%if (iPageCount>1) {%>
	   <A HREF="bbslist.jsp?boardid=<%=boardid%>&pages=<%=iPageCount%>&method=<%=method%>&par=<%=par%>"><font color="#FFFFFF">尾页</font></A><%}%>
	   
	   <font color="#FFFFFF"><%=iPageCurrent%>/<%=iPageCount%></font></p>                                    
    </td>                                                                                               
    <td width="110" valign="middle" bgcolor="#000080">                                                  
      <form method="GET" action="bbslist.jsp" style="margin-top: 0; margin-bottom: 0">                  
        <p align="center" style="margin-top: 0; margin-bottom: 0"><font color="#FFFFFF">转到:<input type="text" name="pages" size="3" value="1">页<input type="submit" value="GO" name="GO"></font></p>                                                                           
        <input type="hidden" name="boardid" value="<%=boardid%>">      
        <input type="hidden" name="method" value="<%=method%>">      
        <input type="hidden" name="par" value="<%=par%>">      
        </form>                                                                                     
    </td>                                                                                               
  </tr>                                                                                               
</table>                                                                                            
  </center>                                                                                           
 </div>                                                                                
<!--表头部分结束 -->                                                                    
<P></P>           
<%
if (iPageCurrent>0) {%>
<div align="left">          
  <table border="0" width="600">          
    <tr>          
      <td width="100%">
	  <ul>          
<%
sqlRst=bbs.listBbs(method,iPageSize,iPageCurrent,boardid,par);
while(sqlRst.next()&&iPageSize<=10&&iPageSize>0){
bbsid=sqlRst.getInt("bbsid");
parentid=sqlRst.getInt("parentid");
child=sqlRst.getInt("child");

username=sqlRst.getString("username");
useremail=sqlRst.getString("useremail");
userip=sqlRst.getString("userip");
expression=sqlRst.getString("expression");
usersign=sqlRst.getString("usersign");
bbstopic=sqlRst.getString("bbstopic");
bbscontent=sqlRst.getString("bbscontent");
//dateandtime=sqlRst.getString("dateandtime");
dateandtime=sqlRst.getDate("dateandtime");

bbshits=sqlRst.getInt("bbshits");
length=sqlRst.getInt("length");
iPageSize--;
bbshot=sqlRst.getString("bbshot");
 if (bbshot==null)bbshot="";
%>                                                             

          <li>                                                                                          
           <p align="left"><img border="0" src="images/<%=expression%>"><%=bbsid %><a href="bbsaddre.jsp?boardid=<%=boardid%>&bbsid=<%=bbsid%>" ><%=bbstopic%></a>                                                          
           &lt;<font color="#FF0000"><%if (length==0){%>无内容<%}else{%><%=length%>Bytes<%}%></font>&gt;-【<a href="mailto:<%=useremail%>"><b><%=username%></b></a>】=<i><%=dateandtime%></i>=[ID:<%=bbsid%>点击:<%=bbshits%>回复:<%=child%>]
           <%if (bbshot.compareTo("ok")==0){%><font color="#FF0000">★</font><%}%>          
           <%if (delon=="true"){%><a href="delete.jsp?bbsid=<%=bbsid%>">删除</a>            
           ###<%if (bbshot.compareTo("ok")!=0) {%><a href="addfav.jsp?bbsid=<%=bbsid%>">加入精华区</a>                 
           <%}else{%><a href="subfav.jsp?bbsid=<%=bbsid%>">从精华区删除</a><%}}%>
		   
<!--跟贴开始----------------------->                                                                                                    
<%
if ((method==0)||(method==8)||(method==4)||(method==1)) {
//if (false){
//'0正常显示             //'4 精华区显示             //'8 管理员显示          //'1搜索主题    

rs=bbs.listBbsRe(bbsid);              //：列出某贴的所有跟贴

while(rs.next()){
iPageSize--;
bbsid=rs.getInt("bbsid");
parentid=rs.getInt("parentid");

username=rs.getString("username");
useremail=rs.getString("useremail");
userip=rs.getString("userip");
expression=rs.getString("expression");
usersign=rs.getString("usersign");
bbstopic=rs.getString("bbstopic");
bbscontent=rs.getString("bbscontent");
//dateandtime=rs.getString("dateandtime");
dateandtime=rs.getDate("dateandtime");
bbshits=rs.getInt("bbshits");
length=rs.getInt("length");
%>
<ul>                                                                                                    
<li type="circle">
           <p align="left"><img border="0" src="images/<%=expression%>"><a href="bbsaddre.jsp?boardid=<%=boardid%>&bbsid=<%=parentid%>" ><%=bbstopic%></a>
           &lt;<font color="#FF0000"><%if (length==0){%>无内容<%}else{%><%=length%>Bytes<%}%></font>&gt;-【<a href="mailto:<%=useremail%>"><b><%=username%></b></a>】=<i><%=dateandtime%></i>=</li>[ID:<%=bbsid%>点击:<%=bbshits%>]
		   <%if (delon=="true") {%> <a href="delete.jsp?bbsid=<%=bbsid%>">删除</a><%}%>                                                                                                        
</ul>                                                                                                    

<%
}  //end while
rs.close();
}	 //end if

%> 
<!--跟贴结束-------------------------> 
<hr size="0" color="#808080">                                           
<%
}  //全部记录结束
sqlRst.close();
%>

          </ul>              

      </td>                    
    </tr>                  
  </table>                
</div>               
<!--表头部分 -->
 <div align="center">
  <center>
 <table border="1" width="600" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FAD185" cellspacing="0" cellpadding="3">
  <tr>
    <td width="30" bgcolor="#000080">                                                  
      <p align="center"><a href="bbsadd.jsp?boardid=<%=boardid%>" target="_self"><font color="#FFFFFF">留言</font></a></p>                                              
    </td>                                                                                              
    <td width="30" bgcolor="#000080">                                                  
     <p align="center"><a href="bbslist.jsp?boardid=<%=boardid%>" target="_self"><font color="#FFFFFF">刷新</font></a></p>                                             
    </td> 
    <td width="30" bgcolor="#000080">                                                
     <p align="center"><a href="query.jsp"><font color="#FFFFFF">查询</font></a></p> 
    </td> 
    <td width="100"  bgcolor="#000080">                                              
      <p align="center"><a href="bbslist.jsp?boardid=<%=boardid%>&method=4"><font color="#FFFFFF">精华区</font></a></p>                                          
    </td>
    <td width="200" bgcolor="#000080">  
      <p align="center">
	  <%if (iPageCount>1) {%><A HREF="bbslist.jsp?boardid=<%=boardid%>&pages=1&method=<%=method%>&par=<%=par%>">
	  <font color="#FFFFFF">首页</font></A><%}%>

  	  <%if (iPageLast!=0) {%>
	  <A HREF="bbslist.jsp?boardid=<%=boardid%>&pages=<%=iPageLast%>&method=<%=method%>&par=<%=par%>"><font color="#FFFFFF">上页</font></A><%}%>

	  <%if (iPageNext!=0) {%>
	  <A HREF="bbslist.jsp?boardid=<%=boardid%>&pages=<%=iPageNext%>&method=<%=method%>&par=<%=par%>"><font color="#FFFFFF">下页</font></A><%}%>

	  <%if (iPageCount>1) {%>
	   <A HREF="bbslist.jsp?boardid=<%=boardid%>&pages=<%=iPageCount%>&method=<%=method%>&par=<%=par%>"><font color="#FFFFFF">尾页</font></A><%}%>
	   
	   <font color="#FFFFFF"><%=iPageCurrent%>/<%=iPageCount%></font></p>                                    
    </td>                                                                                               
    <td width="110" valign="middle" bgcolor="#000080">                                                  
      <form method="GET" action="bbslist.jsp" style="margin-top: 0; margin-bottom: 0">                  
        <p align="center" style="margin-top: 0; margin-bottom: 0"><font color="#FFFFFF">转到:<input type="text" name="pages" size="3" value="1">页<input type="submit" value="GO" name="GO"></font></p>                                                                           
        <input type="hidden" name="boardid" value="<%=boardid%>">      
        <input type="hidden" name="method" value="<%=method%>">      
        <input type="hidden" name="par" value="<%=par%>">      
        </form>                                                                                     
    </td>                                                                                               
  </tr>                                                                                               
</table>                                                                                            
  </center>                                                                                           
 </div>                                                                                
<!--表头部分结束 -->
<%}else{   //'屏蔽错误，如果页面数为0，显示如下信息
%>
很抱歉，没有找到您所需要的记录！请重新查询！
<%
}%>
</body>              
</html>        