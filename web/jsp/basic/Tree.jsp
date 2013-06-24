<%@ page contentType="text/html;charset=GBK" %>
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
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/getByteOut.jsp"%>


<body  class=listtitle oncontextmenu="return false"   >
<script language="javascript" src="../public_js/public.js">
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
<center>
<form method="POST" name="cus" action="SectionView.jsp">
<%

 String SecNo=request.getParameter("SecNo");
 if (SecNo==null)SecNo="";
 
 String FindWhere="";

if (!SecNo.equals("")) FindWhere=" where SerialNo='"+SecNo+"'";

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
<table width="100%">
<tr><td>
   <%for (int n=0;n<i;n++){ %>
     <DIV class=TXTColor id=KB<%=n %>Parent>
	
   <%if (n==0){%>
  <font color=white>
   <%out.print(StrNameArr[jj]);
	%>
	</font>
	  <input type=checkbox name=SecNo value=<%=StrCodeArr[n]+"*Loft"%> border=0 onclick="checkClick(this)" alt="增加阁名/区号/期数">
</td></tr>

   
    <%
     String LoftSql="select Loft FROM sectiontree where SerialNo='"+StrCodeArr[jj]+"' group by Loft order by  loft";
	 String Loft="";
	 String Building="";
	 try{
       RsTrrr2=ViewBean.executeQuery(LoftSql);
       while (RsTrrr2.next()){
	      
	      Loft=getbyte(RsTrrr2.getString("Loft"));
	      
		  out.print("<tr><td> <font color=white>");
		  out.print("&nbsp;&nbsp;&nbsp;&nbsp;"+Loft+"<input type=checkbox name=SecNo value='"+StrCodeArr[n]+"-"+Loft+"*Build' border=0 onclick='checkClick(this)' ><br>");
		  out.print("</font></td></tr>");
		  String BuildSql="select Build FROM sectiontree where SerialNo='"+StrCodeArr[jj]+"' and Loft='"+Loft+"' group by Build";
		   try{
             RsTrrr3=ViewBean2.executeQuery(BuildSql);
			 
             while (RsTrrr3.next()){
	           Building=getbyte(RsTrrr3.getString("Build"));
			   if (!Building.equals(""))
	           out.print("<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+Building+"</td></tr>");
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
	 <tr><td>
	<font color=white><%out.print(StrNameArr[n]);%>
	</font>
	</td></tr>
<input type=checkbox name=SecNo value=<%=StrCodeArr[n]+"*Loft"%> border=0 onclick="checkClick(this)" alt="增加阁名/区号/期数">
 <%
     String LoftSql="select region FROM sectiontree where SerialNo='"+StrCodeArr[n]+"' group by region";
	 String Loft="";
	 String Building="";
	 try{
       RsTrrr2=ViewBean.executeQuery(LoftSql);
       while (RsTrrr2.next()){
	      Loft=getbyte(RsTrrr2.getString("region"));
	      out.print("<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;"+Loft+"<input type=checkbox name=SecNo value='"+StrCodeArr[n]+"-"+Loft+"*Build' border=0 onclick='checkClick(this)' ></td></tr>");
		  String BuildSql="select Build FROM sectiontree where SerialNo='"+StrCodeArr[n]+"' and region='"+Loft+"' group by Build";
		   try{
             RsTrrr3=ViewBean2.executeQuery(BuildSql);
             while (RsTrrr3.next()){
	           Building=getbyte(RsTrrr3.getString("Build"));
	           if (!Building.equals(""))
			   out.print("<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+Building+"</td></tr>");
	          }
	         RsTrrr3.close();
	      }catch(Exception s) {}
	   }
	   RsTrrr2.close();
	  }catch(Exception s) {}
    
       jj++;}
	%>
	
   
   <%} %>
   </td></tr>
   </table>
   <%ViewBean.closeConn();
  ViewBean1.closeConn();
  ViewBean2.closeConn();
        %>
</body>
<script>
function checkClick(para){
  var Num=document.cus.SecNo.length;//当前checkbox的length
  for(var j=0;j<Num;j++)
     {document.cus.SecNo[j].checked=false;}//取消以前所有选中的checkbox
  para.checked=true;//设置当前选中

  if (para.checked){
    var StrValue=para.value;
 
	if (StrValue.substring(StrValue.indexOf("*")+1)=="Loft"&&StrValue.indexOf("-")<0){
	  parent.Operation.window.location="AddLoft.jsp?SecNo=<%=SecNo %>";
	  parent.Operation.document.cus.SecNo.value=StrValue.substring(0,StrValue.indexOf("*"));
	  parent.Operation.document.cus.Para.value=StrValue.substring(StrValue.indexOf("*")+1);
	  parent.Operation.document.cus.add1.disabled=false;
	  parent.Operation.document.cus.add.disabled=false;
	  
	  //parent.Operation.DIVNAME.innerText="楼阁名称：";
	}else if (StrValue.substring(StrValue.indexOf("*")+1)=="Build"&&StrValue.indexOf("-")>=0&&(StrValue.indexOf("-")==StrValue.lastIndexOf("-"))){
 
	  parent.Operation.document.cus.SecNo.value=StrValue.substring(0,StrValue.indexOf("-"));
	  parent.Operation.document.cus.Loft.value=StrValue.substring(StrValue.indexOf("-")+1,StrValue.indexOf("*"));
	  parent.Operation.document.cus.Para.value=StrValue.substring(StrValue.indexOf("*")+1);
	  parent.Operation.document.cus.add1.disabled=true;
	  parent.Operation.document.cus.add.disabled=true;
	  //parent.Operation.DIVNAME.innerText="楼栋名称：";
	}else{
	
      parent.Operation.document.cus.SecNo.value=StrValue.substring(0,StrValue.indexOf("-"));
	  parent.Operation.document.cus.Loft.value=StrValue.substring(StrValue.indexOf("-")+1,StrValue.indexOf("*"));
	 
	  parent.Operation.document.cus.Build.value="";//StrValue.substring(StrValue.lastIndexOf("-")+1,StrValue.indexOf("*"));
	 
	  parent.Operation.document.cus.Para.value=StrValue.substring(StrValue.indexOf("*")+1);
	
	} 
 }
 
}
</script>
</form>
</center>
</html>
