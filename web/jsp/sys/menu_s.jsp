<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import="java.sql.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>

<HTML><HEAD>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<META content=NO-CACHE http-equiv=PRAGMA>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<META content="Microsoft FrontPage 4.0" name=GENERATOR>
<base target="main">
</HEAD>
<BODY  leftMargin=0 topMargin=0 class="leftmenu">

      <SCRIPT language=JavaScript1.2>
NS4 = (document.layers) ? 1 : 0;
IE4 = (document.all) ? 1 : 0;
ver4 = (NS4 || IE4) ? 1 : 0;

if (ver4) {
    with (document) {
        write("<STYLE TYPE='text/css'>");
        if (NS4) {
            write(".parent {position:absolute; visibility:visible}");
            write(".child {position:absolute; visibility:visible}");
            write(".regular {position:absolute; visibility:visible}")
        }
        else {
            write(".child {display:none}")
        }
        write("</STYLE>");
    }
}

function getIndex(el) {
    ind = null;
    for (i=0; i<document.layers.length; i++) {
        whichEl = document.layers[i];
        if (whichEl.id == el) {
            ind = i;
            break;
        }
    }
    return ind;
}

function arrange() {
    nextY = document.layers[firstInd].pageY +document.layers[firstInd].document.height;
    for (i=firstInd+1; i<document.layers.length; i++) {
        whichEl = document.layers[i];
        if (whichEl.visibility != "hide") {
            whichEl.pageY = nextY;
            nextY += whichEl.document.height;
        }
    }
}

function initIt(){
    if (!ver4) return;
    if (NS4) {
        for (i=0; i<document.layers.length; i++) {
            whichEl = document.layers[i];
            if (whichEl.id.indexOf("Child") != -1) whichEl.visibility = "hide";
       }
        arrange();
    }
    else {
        divColl = document.all.tags("DIV");
        for (i=0; i<divColl.length; i++) {
            whichEl = divColl(i);
            if (whichEl.className == "child") whichEl.style.display = "none";
        }
    }
}


function mOvr(src,clrOver){ 
	if (!src.contains(event.fromElement)) { 
		src.style.cursor = 'hand'; 
		src.bgColor = clrOver; 
	}
}
function mOut(src,clrIn)  { 
	if (!src.contains(event.toElement)) {
		src.style.cursor = 'default'; 
		src.style.cursor
		src.bgColor = clrIn; 
	}

} 

function expandIt(el) {
    if (!ver4) return;
    if (IE4) {
        whichEl = eval(el + "Child");
        if (whichEl.style.display == "none") {
            whichEl.style.display = "block";
        }
        else {
            whichEl.style.display = "none";
        }
    }
    else {
        whichEl = eval("document." + el + "Child");
        if (whichEl.visibility == "hide") {
            whichEl.visibility = "show";
        }
        else {
            whichEl.visibility = "hide";
        }
        arrange();
    }
}

onload = initIt;

</SCRIPT>

<script language="javascript" src="../public_js/menu.js">
</script>
<%@ include file="../public_js/getByteOut.jsp"%>
<TABLE    border=0 cellPadding=0 cellSpacing=0 width=118%   align="top" height="100%"> 
  <TR align="top" align=left>
    <TD   valign="top" >
	<%String param="M"; %>
	<%@ include file="../public_js/CheckPopedom.jsp"%>
	  <%
	  String userid=(String)session.getAttribute("loginid");
	  

	  String SqlStr="select Url,CModuleNo,CModuleName  from ModuleCortrol where MModuleNo='M' and CModuleNo in(select ModuleNo from PopedomConrtrol where SellerId='"+userid+"') and nexus='C' order by CModuleNo";	  
	  ResultSet rs=null;
	  int i=1;
	  try{
	      rs = ViewBean.executeQuery(SqlStr);
	     while (rs.next()){
     %>		  
		<BR><IMG height=13 name="filebox<%=i %>"  value="<%=i %>"  src="../picture/file.gif" width=19  onclick="aad(filebox<%=i %>,17);">
		<%String Url=getbyte(rs.getString("Url"));
		 if (Url.indexOf("?")>=0){
		 %>
		<a href="../<%=Url%>&param=<%=getbyte(rs.getString("CModuleNo")) %>"   onclick="aad(filebox<%=i %>,14);"><font color="#FFFFFF"><%=getbyte(rs.getString("CModuleName")) %></font></a>
		<%}else if (Url.indexOf("rpt")>=0){
		 %>
		<a href="<%=Url%>"   onclick="aad(filebox<%=i %>,14);"><font color="#FFFFFF"><%=getbyte(rs.getString("CModuleName")) %></font></a>
		<%} else{ 
		
		  	if(  Url.equalsIgnoreCase("sys/cortrolman.jsp") ){
		%>
				<a href="../<%=Url%>?param=<%=getbyte(rs.getString("CModuleNo"))%>"   onclick="aad(filebox<%=i %>,14);"><font color="#FFFFFF"><%=getbyte(rs.getString("CModuleName")) %></font></a>					
			    
				 
			<%
			}else{
			%>
				<a href="../<%=Url%>?param=<%=getbyte(rs.getString("CModuleNo")) %>"   onclick="aad(filebox<%=i %>,14);"><font color="#FFFFFF"><%=getbyte(rs.getString("CModuleName")) %></font></a>
			<%
			}
	
	}i++;
		 }
	  }  
	  catch(Exception s){}
	  rs.close();
	   %>

    <%	
	//ViewBean.ShowConnNum();
	//ViewBean.freeCon();//free conntion
    %>
	<br>
	<!--a href="senddata.jsp">数据同步</a-->
	</TD>
  
  </TR>
  </TABLE>
  </BODY>
  </HTML>
