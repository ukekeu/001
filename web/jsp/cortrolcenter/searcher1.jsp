<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>

 
 <%@ include file="../public_js/qx_checke.jsp"%>
 
<html>
<head>
	<title>客户选房试算</title>
</head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="javascript" src="../public_js/public.js">
</script>
 
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean2" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
 
   <jsp:useBean id="saleshow" scope="page" class="sale.ChooseRoomState" />
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%>
<%@ include file="../public_js/CheckSection.jsp"%>
<%
 

String strMessage=China.getParameter(request,"mess");
String SecName=request.getParameter("SecName");
String Region=China.getParameter(request,"Region");
String condi=China.getParameter(request,"condi");

String RegionStr="";
   
String state="";
String fontColor="";
String strYN=request.getParameter("yn");
String strSection="";


String Loft="";
String strBuilding="";
 

%> 
<SCRIPT language=javascript>
 
 
function submitC(){
  document.frm.action="manRoomCodeShowS.jsp";
  document.frm.submit();


}
function getseldocs1() {
     var x=0;
	 var seldocs = new Array();
     var seldocs1 = new Array();
	 var temp=document.frm.elements.length;
 
     for (i=0;i<document.frm.yl.length;i++) {
	 if (document.frm.yl[i].checked)
		 {
       		seldocs[x]="'"+document.frm.yl[i].value+"'";
			seldocs1[x]=document.frm.yl[i].value;
			x++;
   		 }
	  }	
     var returnvalue="";
	  if (seldocs!="")
	   returnvalue=seldocs;//+"/"+seldocs1
   return returnvalue
}
function ylroom(){
    var rooms=getseldocs1();
    if (rooms==""){alert("请选择预留的房间！");return false;}
    var url="add_yl_rooms.jsp?rooms="+rooms+"&loft=<%=Loft %>&build=<%=strBuilding %>&secno=<%=strSection %>&secname=<%=SecName %>";
    var newWin = window.open(url,"roomfrm","height=350,width=510,left=150,top=50,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no");
    newWin.focus() ;
}
function choose(para){

  for (i=0;i<document.frm.elements.length;i++) {
 
 if((document.frm.elements[i].type=="checkbox")&&(document.frm.elements[i].value==para)&&(document.frm.elements[i].name=="yl"))
   document.frm.elements[i].checked=true;
   else document.frm.elements[i].checked=false;
}
}
function openwinzy(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"newwin","toolbar=no,location=no,directories=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
   var sendmess="";
function chhoseData1(){
sendmess="";
   for (var i=0;i<document.frm.chooseroom.length;i++){
 	 
	  if (document.frm.chooseroom[i].checked){
	    var aa=document.frm.chooseroom[i].value;
		
	    if (sendmess!="")
		 
		 sendmess+=","+aa;
	    else
		   sendmess=aa;
	    document.frm.chooseroom[i].checked=false;
	  }
    }
	 if (sendmess==""){alert("请选择需要试算的单位");}
	 else { openwinzy("zy1.jsp?code="+sendmess+"&yh="+document.frm.yh.value+"&hy="+document.frm.hy.value,550,450,100,100);}

}

function searcherdata(){

  if (frm.pxshow.value=='1')
  frm.action='searcher.jsp';
  else
  frm.action='searcher1.jsp'; 
 
  frm.submit();
}
function showfull(){
<%if (!getbyte1(request.getParameter("section_select")).equals("")){ %>
setSelectMad(document.frm.section_select,'<%=getbyte1(request.getParameter("section_select")) %>');
setSelectMad(document.frm.pxshow,'<%=getbyte1(request.getParameter("pxshow")) %>');
setSelectMad(document.frm.condi,'<%=getbyte1(request.getParameter("condi")) %>');
<%} %>
}
</script >	 
<body oncontextmenu="return false"  topmargin="1" onload="showfull();">

<form name=frm method="post" action="searcher1.jsp">
 
  <% 
 //String SectionS = setpopedom.getSectionlist(); //有权使用楼盘编码  
 out.print(saleshow.BeanshowLoft(getbyte1(request.getParameter("section_select")),request.getParameterValues("showLoft"),SectionS)); 
 strSection=getbyte1(request.getParameter("section_select"));
 String sql="";
 ResultSet rs2=null;
 String sec="";
 String no="";
 String Cortrol=checke_qx(InsertBean,(String)session.getAttribute("loginid"),"P004");
 if (Cortrol==null)Cortrol="";
 out.print(saleshow.BeanCodeShow(Cortrol,China.getParameter(request,"condi")));
  %> 
  </form> 
  <script>
  function opennewwin(url,para,wh,hg,lf,tp) {
    var today=new Date();
 var todayInMS=today.getTime();
   var newwin=window.open(url+para,"newwin1"+todayInMS,"toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
	
  } 
  </script>
   <%InsertBean.closeConn();
  InsertBean1.closeConn();
 InsertBean2.closeConn();
  %>
 

</body>
</html>
