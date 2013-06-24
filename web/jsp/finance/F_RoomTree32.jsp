<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>楼栋树</title>
</head>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>



<script language="javascript" src="../public_js/public.js">
</script>

<script language="javascript" src="../public_js/menu.js">
</script>
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
</script>
<body  class=tree  oncontextmenu="return false">
<form method="POST" name="cus" action="SectionView.jsp">
<%@ include file="../public_js/CheckSection.jsp"%>

<%
int id=0;

 String SqlTree="SELECT count(*) as num,Name,SerialNo FROM CRM_Project "+FindWhere+" group by  Name,SerialNo order by name";

 ResultSet RsTrrr1=null;
 ResultSet RsTrrr2=null;
 ResultSet RsTrrr3=null;
 int i=200;//数组最大值
 String StrNameArr[]=new String[i];
 String StrLoftArr[]=new String[i];
 String StrBuildingArr[]=new String[i];
 String StrCodeArr[]=new String[i];
 int StrNumArr[]=new int[i];
 i=0;
 
 try{
  RsTrrr1=ViewBean.executeQuery(SqlTree);
  while (RsTrrr1.next()){
    StrNumArr[i]=RsTrrr1.getInt("num");
    StrNameArr[i]=getbyte(RsTrrr1.getString("name")) ;
	StrCodeArr[i]=getbyte(RsTrrr1.getString("SerialNo"));
	
    i++;
  }
 }catch(Exception s){}
 
 RsTrrr1.close();
  
 int jj=0;
 int nnn=0;
 %>		
<table >
   <%for (int n=0;n<i;n++){ %>
     <DIV class=parent id=KB<%=n %>Parent>
	
   <%if (n==0){%>
   <tr ><td>
   <font size=3><b>
   <a href="F_GetList.jsp?SecNo=<%=StrCodeArr[n] %>" target="frmright"  >
   <%out.print(StrNameArr[jj]);
   
	%>
	</a>
	</b></font>
	</td></tr>
    <%
     String LoftSql="select Loft FROM sectiontree where SerialNo='"+StrCodeArr[jj]+"' group by Loft order by  loft";
	 String Loft="";
	 String Building="";

	 try{
       RsTrrr2=ViewBean.executeQuery(LoftSql);
       while (RsTrrr2.next()){
	      Loft=getbyte(RsTrrr2.getString("Loft"));
	      out.print("<tr ><td>");
		  out.print("<SPAN class=navPoint id=switchPoint>4</SPAN>&nbsp;");
		  %>
		  <a href="F_GetList.jsp?SecNo=<%=StrCodeArr[n] %>&Loft=<%=Loft %>" target="frmright"  >
		  <%
		  out.print(Loft);
		  %>
		  </a>
		  <%
		  out.print("</td></tr>");
		  String BuildSql="select Build FROM sectiontree where SerialNo='"+StrCodeArr[jj]+"' and Loft='"+Loft+"' group by Build";
		  
		   try{
             RsTrrr3=ViewBean2.executeQuery(BuildSql);
             while (RsTrrr3.next()){
			 id++;
	           Building=getbyte(RsTrrr3.getString("Build"));
	           out.print("<tr ><td>");
			   out.print("&nbsp;");
			   %>
			   <IMG height=13 name="filebox<%=id %>"  value="<%=id %>"  src="../picture/dot_01.gif" width=10 border=0  onclick="aad1(filebox<%=id %>,100);">
			   <a href="F_GetList.jsp?SecNo=<%=StrCodeArr[jj] %>&Loft=<%=Loft %>&SecName=<%=StrNameArr[jj]%>&Build=<%=Building %>" target="frmright" onclick="aad1(filebox<%=id %>,100);" title='单击后在右边定义房号'>
			 <!--  <font color=white >-->
			   <%
			   out.print(Building+"&nbsp;");
			   
			   %>
			  <!-- </font>-->
	          </a>
			  
			  <%
			  out.print("<tr ><td>");
			  }
	         RsTrrr3.close();
	      }catch(Exception s) {}
	   }
	   RsTrrr2.close();
	  }catch(Exception s) {}
    %>

	<%   
       jj++;
     }else if (!StrNameArr[n].equals(StrNameArr[n-1])){%>
	<%
	  out.print("<tr ><td>");
       out.print(StrNameArr[n]);
	    out.print("</td ></tr>");  
	%>
	 <%
     String LoftSql="select loft FROM sectiontree where SerialNo='"+StrCodeArr[n]+"' group by loft";
	 String Loft="";
	 String Building="";
	 try{
       RsTrrr2=ViewBean.executeQuery(LoftSql);
       while (RsTrrr2.next()){
	      Loft=getbyte(RsTrrr2.getString("loft"));
		  out.print("<tr ><td>");
	      out.print("<SPAN class=navPoint id=switchPoint>4</SPAN>&nbsp;");
		  out.print(Loft);
		  out.print("</td ></tr>");
		  String BuildSql="select Build FROM sectiontree where SerialNo='"+StrCodeArr[n]+"' and loft='"+Loft+"' group by Build";
		   try{
             RsTrrr3=ViewBean2.executeQuery(BuildSql);
             while (RsTrrr3.next()){
			 id++;
	           Building=getbyte(RsTrrr3.getString("Build"));
			     out.print("<tr ><td>");
	            out.print("&nbsp;");
			    %>
			   <IMG height=13 name="filebox<%=id %>"  value="<%=id %>"  src="../picture/dot_01.gif" width=10 border=0  onclick="aad1(filebox<%=id %>,200);">				
			   <a href="../afterservice/AjList2002.jsp?SecNo=<%=StrCodeArr[n] %>&Loft=<%=Loft %>&SecName=<%=StrNameArr[n] %>&Build=<%=Building %>" target="frmright"  onclick="aad1(filebox<%=id %>,200);"  title='单击后在右边定义房号'>
			   <%
			   out.print(Building+"&nbsp;");
			     out.print("</a>");
			     out.print("</td ></tr>");
	          }
	         RsTrrr3.close();
	      }catch(Exception s) {}
	   }
	   RsTrrr2.close();
	  }catch(Exception s) {}
    
       jj++;}
	%>
   <%} %>
   </td>
   </tr>
   </table>
<%ViewBean.closeConn();
    ViewBean1.closeConn();
	ViewBean2.closeConn();
   %>
</body>
</form>
</html>
